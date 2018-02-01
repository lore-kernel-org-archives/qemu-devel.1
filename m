Received: from eggs.gnu.org ([2001:4830:134:3::10]:40965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eh92Z-00074p-OY
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 02:12:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eh92U-0003QS-Pb
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 02:12:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36464)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eh92U-0003Q4-Hc
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 02:12:06 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180131144846.31697-1-armbru@redhat.com>
	<20180131144846.31697-2-armbru@redhat.com>
	<fd604c0a-bf97-edba-f648-820294447fa5@redhat.com>
Date: Thu, 01 Feb 2018 08:12:03 +0100
In-Reply-To: <fd604c0a-bf97-edba-f648-820294447fa5@redhat.com> (Eric Blake's
	message of "Wed, 31 Jan 2018 08:59:00 -0600")
Message-ID: <87fu6lrxoc.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 01/19] Use #include "..." for our own
 headers, <...> for others
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, f4bug@amsat.org

Eric Blake <eblake@redhat.com> writes:

> On 01/31/2018 08:48 AM, Markus Armbruster wrote:
>> System headers should be included with <...>, our own headers with
>> "...".  Offenders tracked down with an ugly, brittle and probably
>> buggy Perl script.  Previous iteration was commit a9c94277f0.
>> 
>> Put the cleaned up system header includes first, except for the ones
>> the next commit will delete.
>> 
>> While there, separate #include from file comment with a blank line,
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>
>> +++ b/target/i386/hvf/x86_mmu.c
>> @@ -15,18 +15,17 @@
>>   * You should have received a copy of the GNU Lesser General Public
>>   * License along with this program; if not, see <http://www.gnu.org/licenses/>.
>>   */
>> +
>>  #include "qemu/osdep.h"
>> +#include <memory.h>
>
> <memory.h> is an obsolete spelling for the now-universal <string.h>.  We
> should NEVER need to include it; scripts/clean-includes should be taught
> to blacklist this one.

"Programming today is a race between software engineers striving to
build bigger and better idiot-proof programs, and the Universe trying to
produce bigger and better idiots.  So far, the Universe is winning."

My point is: if we extended our tooling every time we see a mistake,
we'll drown in tooling.  I think we should limit ourselves to *common*
mistakes.  Is this one common?

> But that's a matter for another patch; this one does exactly what it
> promises, and was mechanical (even if the brittle perl script isn't
> published), so it's best to keep it as-is.

I append my Perl script.

Its simpleminded approach to locating headers in the source tree fails
frequently.  It should really use the compiler to find them.

I reviewed inclusions of headers the script flags as "(included
inconsistently)".  I also reviewed "(included with <>)" where the script
can find a header in the tree.  I patched only obvious mistakes.  There
are a few unobvious cases: headers in tree with the same name as a
system header, e.g. elf.h, io.h.

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!


#!/usr/bin/perl -w

use strict;

my %ihdr = ();
my %idir = ();
my @sall = ();
my @sinc = ();

open(my $fh, "-|", "git grep '^[ \t]*#[ \t]*include[ \t]'")
    or die "can't run git grep: $!";
while (<$fh>) {
    m,^(([^:]*)/)?[^:/]*:[ \t]*\#[ \t]*include[ \t]*(["<])([^">]*), or next;
    my $dir = $2 // ".";
    my $delim = $3;
    my $h = $4;
    $ihdr{$h} |= 1 << ($delim eq "<");
    if (exists $idir{$h}) {
	my $aref = $idir{$h};
	push @$aref, $dir unless grep($_ eq $dir, @$aref);
    } else {
	$idir{$h} = [$dir];
    }
}
close ($fh);

open($fh, "-|", "git ls-tree -r --name-only HEAD")
    or die "can't run git ls-tree: $!";
while (<$fh>) {
    chomp;
    push @sall, $_;
}
close ($fh);

@sinc = grep(/^include\//, @sall);

sub pr {
    my ($h, $fn, $src) = @_;

    print "$h -> $fn";
    if ($ihdr{$h} == 3) {
	print " (included inconsistently)";
    } elsif ($src) {
	print " (included with <>)" if ($ihdr{$h} != 1);
    } else {
	print " (included with \"\")" if ($ihdr{$h} != 2);
    }
    print "\n";
}

for my $h (keys %ihdr) {
    $h =~ m,^(\.\./)*(include/)?(.*), or die;
    my $hh = $3;
    my @fn = grep(/^include\/\Q$hh\E$/, @sinc);
    if (@fn) {
	pr($h, $fn[0], 1);
	next;
    }
    @fn = grep(/^\Q$hh\E$/, @sall);
    if (@fn) {
	pr($h, $fn[0], 1);
	next;
    }
    for my $dir (@{$idir{$h}}) {
	next if $dir eq ".";
	print "## $dir/$hh\n";
	@fn = grep(/^\Q$dir\/$hh\E$/, @sall);
	if (@fn) {
	    pr($h, $fn[0], 1);
	} else {
	    pr($h, "? (in $dir)", 0);
	}
    }
}
