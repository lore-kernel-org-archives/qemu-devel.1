Received: from eggs.gnu.org ([2001:4830:134:3::10]:33853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fNfQy-0006dI-Jx
	for qemu-devel@nongnu.org; Tue, 29 May 2018 10:17:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fNfQx-0005AA-OG
	for qemu-devel@nongnu.org; Tue, 29 May 2018 10:17:08 -0400
Received: from mail-oi0-x22b.google.com ([2607:f8b0:4003:c06::22b]:43872)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fNfQx-00059S-4S
	for qemu-devel@nongnu.org; Tue, 29 May 2018 10:17:07 -0400
Received: by mail-oi0-x22b.google.com with SMTP id t133-v6so9572932oif.10
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 07:17:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <9f0bcfee-31ee-1f2d-1949-6cf986f22ac6@redhat.com>
References: <1526222114-5324-1-git-send-email-eric.auger@redhat.com>
	<1526222114-5324-8-git-send-email-eric.auger@redhat.com>
	<CAFEAcA9772Q3OG-YfzLwGWcZ_L5evC7qP_PXqSi8bVr-p-PhJA@mail.gmail.com>
	<9f0bcfee-31ee-1f2d-1949-6cf986f22ac6@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 May 2018 15:16:46 +0100
Message-ID: <CAFEAcA9eimPuvBP8fo7sPDTMtV4p0thnPfPce3PyyLmoO0RGXQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC v2 7/7] hw/arm/virt: Register two
 redistributor regions when necessary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: Eric Auger <eric.auger.pro@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Shannon Zhao <zhaoshenglong@huawei.com>, Christoffer Dall <christoffer.dall@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Andrew Jones <drjones@redhat.com>, Wei Huang <wei@redhat.com>

On 29 May 2018 at 14:43, Auger Eric <eric.auger@redhat.com> wrote:
> I just noticed virt_machine_class_init still clamps the max_cpus to 255.
> This is checked in vl.c
>
> Do we want the 3.0 machine expose more than 255 vcpus, 512 for instance?
> I understand this mc->max_cpus is something rather static, that is
> refined afterwards.

Mmm. It's mostly used by the option checking code in vl.c, which
runs before the board init function. So really what we're doing by
setting it to some high number is disabling those checks; we then
have to mess around with checking manually later. Unfortunately
I don't think we have enough info to set the real maximum early
enough to avoid this.

We should probably set max_cpus here to whatever is the maximum the
board can handle in any configuration.

> Note the comment in virt_machine_class_init suggest 255 is the max QEMU
> supports but I can see that pc_q35.c sets the max_cpus to 288 already.

I think that's out of date, yes -- probably when the code was written
255 was the maximum.

thanks
-- PMM
