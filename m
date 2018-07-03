Received: from eggs.gnu.org ([2001:4830:134:3::10]:55964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1faHGC-0003H1-O9
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 05:06:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1faHG7-0007ri-UF
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 05:06:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52756 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1faHG7-0007rN-Om
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 05:06:03 -0400
References: <1530098844-236851-1-git-send-email-robert.hu@linux.intel.com>
	<1530098844-236851-2-git-send-email-robert.hu@linux.intel.com>
	<20180627170304.GD914@localhost.localdomain>
	<1530177956.22880.32.camel@linux.intel.com>
	<ce3282a7-310c-6c53-05b8-f00afb787279@redhat.com>
	<1530607697.22880.46.camel@linux.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b7c410af-ebc0-537c-84c4-588842fec111@redhat.com>
Date: Tue, 3 Jul 2018 11:06:00 +0200
MIME-Version: 1.0
In-Reply-To: <1530607697.22880.46.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/5] i386: Add support for IA32_PRED_CMD
 and IA32_ARCH_CAPABILITIES MSRs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Robert Hoo <robert.hu@linux.intel.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, wei.w.wang@intel.com

On 03/07/2018 10:48, Robert Hoo wrote:
>>
>> However, I suggest adding it to the FeatureWord enum, since everything
>> that handles FeatureWord applies to this new kind of MSR as well.
>> Currently FeatureWord is only for CPUID leaves, but it doesn't have to
>> be like that.
>>
> I think this will be changing struct FeatureWordInfo, which is designed
> for cpuid enumerations. You must not want to do that. May I know more
> details about your thought?

The simplest way is to put CPUIDs first and MSRs second in FeatureWord.
Then you can do

     FEAT_XSAVE_COMP_LO, /* CPUID[EAX=0xd,ECX=0].EAX */
     FEAT_XSAVE_COMP_HI, /* CPUID[EAX=0xd,ECX=0].EDX */
+    FEATURE_WORDS_NUM_CPUID,
+    FEATURE_WORDS_FIRST_MSR = FEATURE_WORDS_NUM_CPUID,
+    FEAT_MSR_ARCH_CAPABILITIES = FEATURE_WORDS_FIRST_MSR,
     FEATURE_WORDS,
};

#define FEATURE_WORDS_NUM_MSRS (FEATURE_WORDS - \
                                FEATURE_WORDS_FIRST_MSR)

Then the existing loops that use FeatureWordInfo can go up to
FEATURE_WORDS_NUM_CPUID.

Thanks,

Paolo

> And, if I implemented ARCH_CAPABILITIES-bits features in FeatureWord,
> then no necessity of having it in kvm_msr_entries, right?
