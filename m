Received: from eggs.gnu.org ([2001:4830:134:3::10]:54399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gPE5F-0007TQ-8F
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 17:01:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gPE55-0003aq-SC
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 17:01:23 -0500
References: <20181120203628.2367003-1-eblake@redhat.com>
	<cb5fbd50-0629-8afb-e1d4-cc3d1a94e057@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1671d82c-da21-de1e-58c4-dd22696f9a62@redhat.com>
Date: Tue, 20 Nov 2018 16:01:00 -0600
MIME-Version: 1.0
In-Reply-To: <cb5fbd50-0629-8afb-e1d4-cc3d1a94e057@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] misc: Avoid UTF-8 in error messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>

[adding Markus in CC, since git didn't do it automatically from the 
'Reported-by']

On 11/20/18 3:28 PM, John Snow wrote:
> 
> 
> On 11/20/18 3:36 PM, Eric Blake wrote:
>> While most developers are now using UTF-8 environments, it's
>> harder to guarantee that error messages will be output to
>> a multibyte locale. Rather than risking error messages that
>> get corrupted into mojibake when the user runs qemu in a
>> non-multibyte locale, let's stick to straight ASCII error
>> messages, rather than assuming that our use of UTF-8 in source
>> code string constants will work unchanged in other locales.
>>
>> Reported-by: Markus Armbruster <armbru@redhat.com>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>   hw/misc/tmp105.c | 2 +-
>>   hw/misc/tmp421.c | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)

> 
> Do we have any policy in place to prohibit this in the future?
> (Presumably a policy that is automatic and won't interfere with QEMU
> localization efforts which may rightly attempt to use UTF-8 for those
> locales.)

Not that I know of.

> 
> Do you have a script or trick to find utf-8 containing strings in our
> source?

Markus found these two, probably by reading over a list resulting from 
his claim of finding 217 out of 6455 files (53 of them binary, which 
don't count):
https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg04017.html

My quick and dirty attempt, which does not quite reproduce his numbers:

$ LC_ALL=C git grep -l $'[\x80-\xff]' | wc
     279     279    7490

Thus, by forcing a unibyte locale (where encoding errors are impossible) 
with sane range expressions (POSIX says only the C locale is required to 
interpret regex ranges according to byte value - all bets are off in 
other locales) and using $'' to type non-UTF-8 bytes into my search, I 
found 279 files with at least one byte outside of ASCII.  But the use of 
-l has no easy way to filter which of those files are binary; while 
dropping -l claims 2138 "lines" with non-ASCII, which gets tedious to 
scroll through, especially considering there ARE binary files in the mix.

Narrowing the search to a more specific pattern:

$ LC_ALL=C git grep $'".*[\x80-\xff].*"' | grep -v 'Binary file' | wc
     129     685    8808

is a bit more manageable, with MOST of the hits in pc-bios/qemu.rsrc 
(false positive hits, due to interesting? comments), in po/ (which 
doesn't count), or in scripts/ for python.  And the proof for THIS patch:

$ LC_ALL=C git grep -l $'".*[\x80-\xff].*"' origin -- '**/*.[ch]' | cat
origin:hw/misc/tmp105.c
origin:hw/misc/tmp421.c

> 
> Only curious, don't hold this patch up on my account. I'm not raising a
> challenge.

Maybe checkpatch.pl could be taught to do a similar check?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
