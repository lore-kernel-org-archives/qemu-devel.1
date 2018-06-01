Received: from eggs.gnu.org ([2001:4830:134:3::10]:60693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fOmTC-0002rk-H2
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:00:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fOmTB-0007Iy-Ha
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:00:02 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:43511)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fOmTB-0007I8-Cs
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:00:01 -0400
Received: by mail-oi0-x242.google.com with SMTP id t133-v6so19304161oif.10
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 09:00:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180601153423.GB12424@codeaurora.org>
References: <1521232280-13089-1-git-send-email-alindsay@codeaurora.org>
	<1521232280-13089-16-git-send-email-alindsay@codeaurora.org>
	<CAFEAcA9bYdwByseqCMKSVtWV59mNruT3jJfWWLju1koCnwSb=Q@mail.gmail.com>
	<20180417142318.GO24561@codeaurora.org>
	<CAFEAcA8RwC7DSbo+mMqYUS6tL5UwfQGMa_r5AnAkJqm7v63HWw@mail.gmail.com>
	<20180517193104.GB4771@codeaurora.org>
	<CAFEAcA-+sO3oUqfQXHcHRBu2i-WFzvFKObcBz26qeLS_0+3s2Q@mail.gmail.com>
	<20180531203906.GA12424@codeaurora.org>
	<CAFEAcA_2z-2utCiPQM0DtZGXgiE2qbVsB=Nn81j9DP7Z8keRqw@mail.gmail.com>
	<20180601153423.GB12424@codeaurora.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Jun 2018 16:59:39 +0100
Message-ID: <CAFEAcA-A824jUKK1bTg4-fVs10iotYu0wMkSk-tUfj+tZkpbug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 15/22] target/arm: Add ARM_FEATURE_V7VE
 for v7 Virtualization Extensions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <alindsay@codeaurora.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>

On 1 June 2018 at 16:34, Aaron Lindsay <alindsay@codeaurora.org> wrote:
> On Jun 01 09:57, Peter Maydell wrote:
>> No; V7VE always implies ARM_DIV. (ARM_DIV doesn't imply V7VE,
>> though, which is why it is a separate feature bit.)
>
> Okay, then I'm confused about some of the preexisting logic in
> kvm_arm_get_host_cpu_features. The preexisting code in that function
> sets ARM_DIV and THUMB_DIV based on the appropriate bits in ID_ISAR0. If
> we already knew that
>>    (by definition a host CPU which supports KVM has v7VE.)
> and that all V7VE CPUs have ARM_DIV, why did the code there bother
> checking ID_ISAR0 to begin with?

Good question. I suspect I'd just forgotten that at the point
when I wrote that KVM code.

>> switch (extract32(id_isar0, 24, 4)) {
>> case 1:
>>     set_feature(&features, ARM_FEATURE_THUMB_DIV);
>>     break;
>> case 2:
>>     set_feature(&features, ARM_FEATURE_ARM_DIV);
>>     set_feature(&features, ARM_FEATURE_THUMB_DIV);
>>     break;
>> default:
>>     break;
>> }
>
> Should this switch/case be removed entirely?

Yes, I think so (and also the id_isar0 variable and the
idregs[] entry which arranges to initialize it). We should
just set the THUMB_DIV and ARM_DIV features explicitly.

thanks
-- PMM
