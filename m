Received: from eggs.gnu.org ([2001:4830:134:3::10]:60018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fOKPb-0008DK-JB
	for qemu-devel@nongnu.org; Thu, 31 May 2018 06:02:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fOKPa-0005JW-I2
	for qemu-devel@nongnu.org; Thu, 31 May 2018 06:02:27 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:36297)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fOKPa-0005Ir-CR
	for qemu-devel@nongnu.org; Thu, 31 May 2018 06:02:26 -0400
Received: by mail-ot0-x244.google.com with SMTP id m11-v6so24635359otf.3
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 03:02:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5B0E0194.3040102@huawei.com>
References: <1527247371-10592-1-git-send-email-zhaoshenglong@huawei.com>
	<1527247371-10592-3-git-send-email-zhaoshenglong@huawei.com>
	<CAFEAcA_ZqgGTxLM0BiUX2LOhszFs1z8t4jGF=wCj6ceh06r2nQ@mail.gmail.com>
	<5B0E0194.3040102@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 May 2018 11:02:05 +0100
Message-ID: <CAFEAcA9+7RYmEgCjk_BiYahYVf2+VXEorZDsEnA0LkBprE-H0g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v4 2/2] arm_gicv3_kvm:
 kvm_dist_get/put: skip the registers banked by GICR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shannon Zhao <zhaoshenglong@huawei.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, Eric Auger <eric.auger@redhat.com>, qemu-stable <qemu-stable@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Shannon Zhao <shannon.zhaosl@gmail.com>

On 30 May 2018 at 02:42, Shannon Zhao <zhaoshenglong@huawei.com> wrote:
>
>
> On 2018/5/29 22:44, Peter Maydell wrote:
>> This is where we should have a comment explaining the bug and
>> what the migration data from the old broken QEMU looks like; something
>> like:
>>
>>     /* Older versions of QEMU had a bug in the handling of state save/restore
>>      * to the KVM GICv3: they got the offset in the bitmap arrays wrong,
>>      * so that instead of the data for external interrupts 32 and up
>>      * starting at bit position 32 in the bitmap, it started at bit
>>      * position 0.
> Not right here. for_each_dist_irq_reg starts from 32 and if irq is 32
> and gic_bmp_ptr32(bmp, irq) points bit 32, while offset passed to KVM is
> 0, then it will get the GICR values for bit 32 ~ bit 63. So the data
> looks like below:
> [00...0 00..0 xx..x ...]
> So we need to move the data down by 32 bits.

Yes, you're right.

thanks
-- PMM
