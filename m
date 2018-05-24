Received: from eggs.gnu.org ([2001:4830:134:3::10]:39427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fLrhU-0006lz-VD
	for qemu-devel@nongnu.org; Thu, 24 May 2018 10:58:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fLrhP-000455-GB
	for qemu-devel@nongnu.org; Thu, 24 May 2018 10:58:45 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:36455)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fLrhP-00044a-BB
	for qemu-devel@nongnu.org; Thu, 24 May 2018 10:58:39 -0400
Received: by mail-oi0-x243.google.com with SMTP id v2-v6so1722236oif.3
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 07:58:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9oCppg2C32vd3YKKmvfO7n1KnFeXG14CV7UHcZpxcTqA@mail.gmail.com>
References: <1527047633-12368-1-git-send-email-zhaoshenglong@huawei.com>
	<1527047633-12368-2-git-send-email-zhaoshenglong@huawei.com>
	<acca5b80-f527-bc39-0b63-147e53affb4b@redhat.com>
	<CAFEAcA-xbHtxora5TU9psYnBgP0+N8_nznhVppEkg7fmmwip3w@mail.gmail.com>
	<10801e6c-5028-add6-b082-22c5dc9758ca@redhat.com>
	<CAFEAcA-eW_1M42c+Fjt98AgVsnbwjwWap3JZFHNU9f8S0H_qww@mail.gmail.com>
	<38aee779-1baf-ab96-7489-0f34bda2f8e6@redhat.com>
	<CAFEAcA9oCppg2C32vd3YKKmvfO7n1KnFeXG14CV7UHcZpxcTqA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 May 2018 15:58:18 +0100
Message-ID: <CAFEAcA-ffKgP30kPm=rWqMv4CewGRqu_WEcpwqGp+hqZzwhn-g@mail.gmail.com>
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
To: Auger Eric <eric.auger@redhat.com>
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Shannon Zhao <zhaoshenglong@huawei.com>

On 24 May 2018 at 15:56, Peter Maydell <peter.maydell@linaro.org> wrote:
> Oops, yes, you're right. My explanation applies to the
> various other bitmaps, where we are accessing the
> fields in the data structure using gic_bmp_ptr32(bmp, irq),
> but not to gicd_ipriority[], which we are directly accessing
> starting with the first word, not by indexing via bmp[irq].
>
> So we need to handle these two cases differently.
> You're correct that for gicd_ipriority[], the code in
> master reads and writes to that data structure as:
>  [0, 0, ..., 0, irq 32, irq 33, ..., 0, 0, ... 0]
> so all the values are in the right place but we:
>  (a) unnecessarily read/write zeroes for the PPI/SGI fields
>  (b) fail to transfer the last 32 interrupts
>
> We can fix the gicd_ipriority[] case simply by adding
>    bmp = GIC_INTERNAL;

Oops, I meant
 bmp += GIC_INTERNAL;

thanks
-- PMM
