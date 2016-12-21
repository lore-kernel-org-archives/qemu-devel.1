Received: from eggs.gnu.org ([2001:4830:134:3::10]:48604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cJlDN-0005Ad-Dr
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 13:02:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cJlDH-0008OJ-Og
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 13:02:09 -0500
Date: Wed, 21 Dec 2016 16:01:55 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20161221180155.GI3808@thinpad.lan.raisama.net>
References: <20161201170624.26496-1-lersek@redhat.com>
	<148227487620.73.10055858460424473693@790289a7ca88>
	<20161221152226.GH3808@thinpad.lan.raisama.net>
	<70b42a58-381d-7011-7eef-2120af178f91@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70b42a58-381d-7011-7eef-2120af178f91@redhat.com>
Subject: Re: [Qemu-devel] checkpatch.pl false positive (was Re: [PATCH v4
 0/7] q35: add negotiable broadcast SMI)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, famz@redhat.com, mst@redhat.com, somlo@cmu.edu, Markus Armbruster <armbru@redhat.com>, michael@walle.cc, qemu-arm@nongnu.org, kraxel@redhat.com, zhaoshenglong@huawei.com, lersek@redhat.com, imammedo@redhat.com

On Wed, Dec 21, 2016 at 06:47:01PM +0100, Paolo Bonzini wrote:
> 
> 
> On 21/12/2016 16:22, Eduardo Habkost wrote:
> > On Tue, Dec 20, 2016 at 03:01:17PM -0800, no-reply@patchew.org wrote:
> > [...]
> >> Checking PATCH 4/7: hw/i386/pc: introduce 2.9 machine types with 0x20 fw_cfg file slots...
> >> ERROR: Macros with multiple statements should be enclosed in a do - while loop
> >> #126: FILE: include/hw/compat.h:4:
> >> +#define HW_COMPAT_2_8 \
> >> +    {\
> >> +        .driver   = "fw_cfg_mem",\
> >> +        .property = "file_slots",\
> >> +        .value    = stringify(0x10),\
> >> +    },{\
> >> +        .driver   = "fw_cfg_io",\
> >> +        .property = "file_slots",\
> >> +        .value    = stringify(0x10),\
> >> +    },
> >>
> >> total: 1 errors, 0 warnings, 119 lines checked
> >>
> >> Your patch has style problems, please review.  If any of these errors
> >> are false positives report them to the maintainer, see
> >> CHECKPATCH in MAINTAINERS.
> > 
> > It is a false positive, but how exactly can we fix it? Should it
> > become a warning instead of an error?
> 
> It should already be treated as an exception:
> 
>                         my $exceptions = qr{
>                                 $Declare|
>                                 module_param_named|
>                                 MODULE_PARAM_DESC|
>                                 DECLARE_PER_CPU|
>                                 DEFINE_PER_CPU|
>                                 __typeof__\(|
>                                 union|
>                                 struct|
>                                 \.$Ident\s*=\s*|       # <---- see here
>                                 ^\"|\"$
>                         }x;
>                         #print "REST<$rest> dstat<$dstat> ctx<$ctx>\n";
>                         if ($rest ne '' && $rest ne ',') {
>                                 if ($rest !~ /while\s*\(/ &&
>                                     $dstat !~ /$exceptions/)
>                                 {
>                                         ERROR("Macros with multiple statements should be enclosed in a do - while loop\n" . "$here\n$ctx\n");
>                                 }
> 
> 
> so I guess the first step is debugging it. :)

The following code replaces the whole "{ .driver = ... }" block
with "1":

	# Flatten any parentheses and braces
	while ($dstat =~ s/\([^\(\)]*\)/1/ ||
	       $dstat =~ s/\{[^\{\}]*\}/1/ ||
	       $dstat =~ s/\[[^\{\}]*\]/1/)
	{
	}

The following change fixes the bug, but I don't know if it has
unwanted side-effects:

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index f084542..0aab3ac 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2200,6 +2200,10 @@ sub process {
                        $dstat =~ s/^\s*//s;
                        $dstat =~ s/\s*$//s;
 
+                       # remove braces that cover the whole block, if any:
+                       $dstat =~ s/^\{//;
+                       $dstat =~ s/\}$//;
+
                        # Flatten any parentheses and braces
                        while ($dstat =~ s/\([^\(\)]*\)/1/ ||
                               $dstat =~ s/\{[^\{\}]*\}/1/ ||


-- 
Eduardo
