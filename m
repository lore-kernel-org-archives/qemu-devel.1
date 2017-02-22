Received: from eggs.gnu.org ([2001:4830:134:3::10]:42166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cgWE9-0004tW-Jw
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 07:41:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cgWE8-0001id-Ty
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 07:41:01 -0500
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:34826)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cgWE8-0001iJ-NR
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 07:41:00 -0500
Received: by mail-wr0-x234.google.com with SMTP id s27so1013786wrb.2
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 04:41:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8sTEtJGpvrL3qCQ7OfUaQ5Ym0siQfGMnTpaUQw+Uzh_A@mail.gmail.com>
References: <1487313115-9510-1-git-send-email-vijay.kilari@gmail.com>
	<1487313115-9510-3-git-send-email-vijay.kilari@gmail.com>
	<CAFEAcA8618+LGejFq6SpBEwGrNpfamBBX3MFWjss-ZxJ7Xk8mg@mail.gmail.com>
	<CALicx6tqxXZxBTxYvF55ydBg5CB1to3MsEkhaohucx4EAZcEJA@mail.gmail.com>
	<CAFEAcA_NbQNzrUUCAS2e5Xso0rg6H3+nzDjTc9i8Tc+GLpXvLw@mail.gmail.com>
	<CALicx6uiFYXsOMaiCH9HYW_jxbMSg+QSCrbVr0D-UKWwtf+TwA@mail.gmail.com>
	<CAFEAcA8sTEtJGpvrL3qCQ7OfUaQ5Ym0siQfGMnTpaUQw+Uzh_A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 22 Feb 2017 12:40:38 +0000
Message-ID: <CAFEAcA_U_8tJqa7U8vKqrZJYkyJcdcCGBV4E8ou9psqu=GS2Ow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v8 2/5] hw/intc/arm_gicv3_kvm: Add
 ICC_SRE_EL1 register to vmstate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vijay Kilari <vijay.kilari@gmail.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, Eric Auger <eric.auger@redhat.com>, Pavel Fedin <p.fedin@samsung.com>, Marc Zyngier <marc.zyngier@arm.com>, QEMU Developers <qemu-devel@nongnu.org>, Vijaya Kumar K <Vijaya.Kumar@cavium.com>

On 22 February 2017 at 12:05, Peter Maydell <peter.maydell@linaro.org> wrote:
> I talked to Marc Z who agreed this is a KVM bug -- the kernel
> should have these bits be RAO/WI like TCG. I think Marc
> was going to write a patch...

...so given that, what we want on the QEMU side is:
 * in a migration preload function:
   /* if the sre_el1 subsection is not transferred this
    * means SRE_EL1 is 0x7 (which might not be the same as
    * our reset value).
    */
   cs->icc_sre_el1 = 0x7;

 * the reg_needed function should be
   return cs->icc_sre_el1 != 0x7;

and the rest of this patch is OK I think.

thanks
-- PMM
