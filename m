Received: from eggs.gnu.org ([2001:4830:134:3::10]:56657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fFYqU-0000K6-ME
	for qemu-devel@nongnu.org; Mon, 07 May 2018 01:37:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fFYqQ-00052Q-Kv
	for qemu-devel@nongnu.org; Mon, 07 May 2018 01:37:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48604 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fFYqQ-0004yt-GT
	for qemu-devel@nongnu.org; Mon, 07 May 2018 01:37:54 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D79CC406C76D
	for <qemu-devel@nongnu.org>; Mon,  7 May 2018 05:37:48 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1525453270-23074-1-git-send-email-thuth@redhat.com>
	<f7756c7c-338a-a719-7135-aa7a53a62c4c@redhat.com>
Date: Mon, 07 May 2018 07:37:47 +0200
In-Reply-To: <f7756c7c-338a-a719-7135-aa7a53a62c4c@redhat.com> (Paolo
	Bonzini's message of "Fri, 4 May 2018 23:57:53 +0200")
Message-ID: <87wowgyqj8.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 0/5] Removal of deprecated -no-kvm*
 options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 04/05/2018 19:01, Thomas Huth wrote:
>> The -no-kvm* options are a remainder of the ancient "qemu-kvm"
>> fork. They have never been officially documented in our qemu-doc,
>> they have been marked as deprecated in the sources since a very
>> long time, and we've marked them as deprecated in our qemu-doc
>> since QEMU v2.10. So far I haven't seen any complaints that we
>> should keep them, so it's time to remove these old parameters now.
>> 
>> While I'm at it, this patch series also removes a left-over from
>> the "-tdf" option (which has been removed with QEMU v2.12) and
>> fixes a deficiency in the option parsing code that has been
>> revealed by the remainder of the "-tdf" option.
>> 
>> Thomas Huth (5):
>>   qemu-options: Remove remainders of the -tdf option
>>   qemu-options: Bail out on unsupported options instead of silently
>>     ignoring them
>>   qemu-options: Remove deprecated -no-kvm-pit-reinjection
>>   qemu-options: Remove deprecated -no-kvm-irqchip
>>   qemu-options: Remove deprecated -no-kvm
>
> I'm not that sure anymore about -no-kvm.  It can come in handy for
> distros (*cough* RHEL *cough) that only ship a qemu-kvm binary with
> default accelerator "-machine accel=kvm:tcg".
>
> Yeah, "-accel tcg" is only a few characters later, but it is a
> relatively recent addition.

2012 is "relatively recent" in the alternate RHEL universe, perhaps :)


Author: Jan Kiszka <jan.kiszka@siemens.com>
Date:   Fri Oct 5 14:51:45 2012 -0300

    Emulate qemu-kvms -no-kvm option
    
    Releases of qemu-kvm will be interrupted at qemu 1.3.0.
    Users should switch to plain qemu releases.
    To avoid breaking scenarios which are setup with command line
    options specific to qemu-kvm, port these switches from qemu-kvm
    to qemu.git.
    
    Port -no-kvm option.
    
    Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

diff --git a/qemu-options.hx b/qemu-options.hx
index 628bd44591..fe8f15c541 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2888,6 +2888,9 @@ STEXI
 Enable FIPS 140-2 compliance mode.
 ETEXI
 
+HXCOMM Deprecated by -machine accel=tcg property
+DEF("no-kvm", HAS_ARG, QEMU_OPTION_no_kvm, "", QEMU_ARCH_I386)
+
 HXCOMM Deprecated by kvm-pit driver properties
 DEF("no-kvm-pit-reinjection", HAS_ARG, QEMU_OPTION_no_kvm_pit_reinjection,
     "", QEMU_ARCH_I386)
diff --git a/vl.c b/vl.c
index cd7c0fbd52..b39f22ed35 100644
--- a/vl.c
+++ b/vl.c
@@ -3171,6 +3171,10 @@ int main(int argc, char **argv, char **envp)
                     machine = machine_parse(optarg);
                 }
                 break;
+             case QEMU_OPTION_no_kvm:
+                olist = qemu_find_opts("machine");
+                qemu_opts_parse(olist, "accel=tcg", 0);
+                break;
             case QEMU_OPTION_no_kvm_pit: {
                 fprintf(stderr, "Warning: KVM PIT can no longer be disabled "
                                 "separately.\n");
