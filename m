Received: from eggs.gnu.org ([2001:4830:134:3::10]:51474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cPBCT-0002BG-4u
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:47:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cPBCP-0000Tk-3b
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:47:37 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:36419)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cPBCO-0000TR-T0
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:47:33 -0500
Received: by mail-wm0-x242.google.com with SMTP id m203so97518619wma.3
	for <qemu-devel@nongnu.org>; Thu, 05 Jan 2017 08:47:32 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <CAFEAcA8ff=cEz-MrWFAFm2=8zWkJy=cbRpErQEBkwigaoVm67g@mail.gmail.com>
	<CAFEAcA9q5PDj8CHp6naCbJN926nbHk_mt0E5uVmPGkkkCEWv3w@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ab13f4a8-a2de-ac4f-5b01-c9948b027e36@redhat.com>
Date: Thu, 5 Jan 2017 17:47:30 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9q5PDj8CHp6naCbJN926nbHk_mt0E5uVmPGkkkCEWv3w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Sphinx for QEMU docs? (and a doc-comment format
 question)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>



On 07/11/2016 16:03, Peter Maydell wrote:
> 2) some of the doc-comment format differences are irritating:
>    . "function - short description" not "function: short description"
>    . "&struct.fieldname" not ".@fieldname"
>    . "&typename" not "#typename"
> 3) the most awkward part of kernel-doc syntax is that it bakes
>    in the kernel's style choice of always using "struct foo"
>    for types -- I don't think there's any way to document
>    'MemoryRegion' and 'AddressSpace' without the 'struct'
>    coming out in the documentation output.
> 
> We could fix (2) by loosening the kernel-doc script's
> parsing if we were happy to carry around a forked version
> of it. Fixing (3) requires more serious surgery on kernel-doc
> I suspect.

I've sent some changes to kernel-doc to simplify the implementation of
these changes (http://www.spinics.net/lists/linux-doc/msg42354.html) and
they were accepted.  So with 4.10 + those patches, the local changes to
kernel-doc for QEMU would be limited to the following:

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 4c9ada36fe6b..c43ac038398d 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -215,18 +215,18 @@ my $type_func = '(\w+)\(\)';
 my $type_param = '\@(\w+(\.\.\.)?)';
 my $type_fp_param = '\@(\w+)\(\)';  # Special RST handling for func ptr params
 my $type_env = '(\$\w+)';
-my $type_enum = '\&(enum\s*([_\w]+))';
-my $type_struct = '\&(struct\s*([_\w]+))';
-my $type_typedef = '\&(typedef\s*([_\w]+))';
-my $type_union = '\&(union\s*([_\w]+))';
-my $type_member = '\&([_\w]+)(\.|->)([_\w]+)';
-my $type_fallback = '\&([_\w]+)';
-my $type_enum_xml = '\&amp;(enum\s*([_\w]+))';
-my $type_struct_xml = '\&amp;(struct\s*([_\w]+))';
-my $type_typedef_xml = '\&amp;(typedef\s*([_\w]+))';
-my $type_union_xml = '\&amp;(union\s*([_\w]+))';
-my $type_member_xml = '\&amp;([_\w]+)(\.|-\&gt;)([_\w]+)';
-my $type_fallback_xml = '\&amp([_\w]+)';
+my $type_enum = '#(enum\s*([_\w]+))';
+my $type_struct = '#(struct\s*([_\w]+))';
+my $type_typedef = '#(([A-Z][_\w]*))';
+my $type_union = '#(union\s*([_\w]+))';
+my $type_member = '#([_\w]+)(\.|->)([_\w]+)';
+my $type_fallback = '(?!)';    # this never matches
+my $type_enum_xml = $type_enum;
+my $type_struct_xml = $type_struct;
+my $type_typedef_xml = $type_typedef;
+my $type_union_xml = $type_union;
+my $type_member_xml = $type_member;
+my $type_fallback_xml = $type_fallback;
 my $type_member_func = $type_member . '\(\)';
 
 # Output conversion substitutions.
@@ -2143,6 +2143,14 @@ sub output_blockhead {
 sub dump_declaration($$) {
     no strict 'refs';
     my ($prototype, $file) = @_;
+    if ($decl_type eq 'type name') {
+	if ($prototype =~ /^(enum|struct|union)\s+/) {
+	    $decl_type = $1;
+        } else {
+	    return;
+	}
+    }
+
     my $func = "dump_" . $decl_type;
     &$func(@_);
 }
@@ -2893,7 +2901,7 @@ sub process_file($) {
 	    }
 	    elsif (/$doc_decl/o) {
 		$identifier = $1;
-		if (/\s*([\w\s]+?)\s*-/) {
+		if (/\s*([\w\s]+?)(\s*-|:)/) {
 		    $identifier = $1;
 		}
 
@@ -2903,7 +2911,7 @@ sub process_file($) {
 		$contents = "";
 		$section = $section_default;
 		$new_start_line = $. + 1;
-		if (/-(.*)/) {
+		if (/[-:](.*)/) {
 		    # strip leading/trailing/multiple spaces
 		    $descr= $1;
 		    $descr =~ s/^\s*//;
@@ -2921,7 +2929,9 @@ sub process_file($) {
 			++$warnings;
 		}
 
-		if ($identifier =~ m/^struct/) {
+		if ($identifier =~ m/^[A-Z]/) {
+		    $decl_type = 'type name';
+	        } elsif ($identifier =~ m/^struct/) {
 		    $decl_type = 'struct';
 		} elsif ($identifier =~ m/^union/) {
 		    $decl_type = 'union';

which should be maintainable as a fork of Linux's kernel-doc.

I also worked a bit on support for Texinfo manuals in Sphinx.  My
current attempt is at http://people.redhat.com/pbonzini/qemu-test-doc/_build/.
Because this uses a Texinfo->Docbook->Sphinx pipeline, I also tried some
tools with native Docbook support (Publican), but despite Sphinx's quirks
the output was less usable, and the tools were slower and harder to use.

http://wiki.qemu-project.org/Features/Documentation is another place to
brainstorm ideas on this.

Paolo
