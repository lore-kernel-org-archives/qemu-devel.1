Received: from eggs.gnu.org ([2001:4830:134:3::10]:47436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fM8b1-0002E0-J1
	for qemu-devel@nongnu.org; Fri, 25 May 2018 05:01:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fM8aw-0005Sn-3s
	for qemu-devel@nongnu.org; Fri, 25 May 2018 05:01:11 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:40516)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fM8av-0005SW-VC
	for qemu-devel@nongnu.org; Fri, 25 May 2018 05:01:06 -0400
Received: by mail-ot0-x244.google.com with SMTP id n1-v6so5258104otf.7
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 02:01:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5B07CC79.1070905@huawei.com>
References: <1527047633-12368-1-git-send-email-zhaoshenglong@huawei.com>
	<1527047633-12368-2-git-send-email-zhaoshenglong@huawei.com>
	<acca5b80-f527-bc39-0b63-147e53affb4b@redhat.com>
	<CAFEAcA-xbHtxora5TU9psYnBgP0+N8_nznhVppEkg7fmmwip3w@mail.gmail.com>
	<10801e6c-5028-add6-b082-22c5dc9758ca@redhat.com>
	<CAFEAcA-eW_1M42c+Fjt98AgVsnbwjwWap3JZFHNU9f8S0H_qww@mail.gmail.com>
	<38aee779-1baf-ab96-7489-0f34bda2f8e6@redhat.com>
	<CAFEAcA9oCppg2C32vd3YKKmvfO7n1KnFeXG14CV7UHcZpxcTqA@mail.gmail.com>
	<5B07CC79.1070905@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 May 2018 10:00:44 +0100
Message-ID: <CAFEAcA-k4Yz3bfXWsB1fGGoTMV_A016nasyagKrO9TuSObyW6A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH V3 2/2] arm_gicv3_kvm: kvm_dist_get/put:
 skip the registers banked by GICR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shannon Zhao <zhaoshenglong@huawei.com>
Cc: Auger Eric <eric.auger@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 25 May 2018 at 09:42, Shannon Zhao <zhaoshenglong@huawei.com> wrote:
> On 2018/5/24 22:56, Peter Maydell wrote:
>> We can fix the gicd_ipriority[] case simply by adding
>>    bmp = GIC_INTERNAL;
>> before the assignment to 'field' in both kvm_dist_get_priority()
>> and kvm_dist_put_priority(). This doesn't affect migration
>> compatibility. We should do this separately from fixing the
>> other bitmaps, because it's simpler.
>>
> If we do bmp += GIC_INTERNAL, we should also add this to offset,
> otherwise we will put the SGI/PPIs data to SPIs, right?

Yes. This code seems remarkably hard to get right, I think
because we effectively have three different things indexing
through the loop -- irq, field, offset -- and they're all
independently set to starting values in different places.

thanks
-- PMM
