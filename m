Received: from eggs.gnu.org ([2001:4830:134:3::10]:46987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fLq4m-0006oQ-NO
	for qemu-devel@nongnu.org; Thu, 24 May 2018 09:14:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fLq4l-0006e3-SD
	for qemu-devel@nongnu.org; Thu, 24 May 2018 09:14:40 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:45351)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fLq4l-0006dR-NK
	for qemu-devel@nongnu.org; Thu, 24 May 2018 09:14:39 -0400
Received: by mail-oi0-x244.google.com with SMTP id b130-v6so1358500oif.12
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 06:14:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <acca5b80-f527-bc39-0b63-147e53affb4b@redhat.com>
References: <1527047633-12368-1-git-send-email-zhaoshenglong@huawei.com>
	<1527047633-12368-2-git-send-email-zhaoshenglong@huawei.com>
	<acca5b80-f527-bc39-0b63-147e53affb4b@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 May 2018 14:14:18 +0100
Message-ID: <CAFEAcA-xbHtxora5TU9psYnBgP0+N8_nznhVppEkg7fmmwip3w@mail.gmail.com>
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
Cc: Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Shannon Zhao <shannon.zhaosl@gmail.com>

On 24 May 2018 at 10:04, Auger Eric <eric.auger@redhat.com> wrote:
> Now I am unclear about the semantics of the s->gicd_ipriority & friends.
> With that change, is it supposed to contain only the states of SPIs or
> contain the RAZ states of PPI/SGIs + states of SPIs. The array is
> dimensionned to contain states for PPI/SGI+SPIs, right? In other words,
> shouldn't we also shift field?

The semantics of the gicd_ipriority and other data structures are
set by the TCG GIC implementation, and include blank space at
the start where the PPI/SGI bits would live. See this comment
from arm_gicv3_common.h:

 * Each bitmap contains a bit for each interrupt. Although there is
 * space for the PPIs and SGIs, those bits (the first 32) are never
 * used as that state lives in the redistributor. The unused bits are
 * provided purely so that interrupt X's state is always in bit X; this
 * avoids bugs where we forget to subtract GIC_INTERNAL from an
 * interrupt number.

thanks
-- PMM
