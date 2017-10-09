Received: from eggs.gnu.org ([2001:4830:134:3::10]:37657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1ccL-00082k-Tb
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 14:17:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1ccK-0004ZH-Ml
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 14:17:29 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:55089)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e1ccK-0004Yd-Fw
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 14:17:28 -0400
Received: by mail-wm0-x236.google.com with SMTP id i124so25795444wmf.3
	for <qemu-devel@nongnu.org>; Mon, 09 Oct 2017 11:17:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1506524205-20763-1-git-send-email-eric.auger@redhat.com>
References: <1506524205-20763-1-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Oct 2017 19:17:06 +0100
Message-ID: <CAFEAcA_UfXaO-KEgXb+GSUT=XhQar_gxshUV_GWO_axcZ0R4sA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC 0/3] vITS Reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, wanghaibin.wang@huawei.com, Vijay Kilari <vijay.kilari@gmail.com>, Andrew Jones <drjones@redhat.com>, Wei Huang <wei@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, wu.wubin@huawei.com

On 27 September 2017 at 15:56, Eric Auger <eric.auger@redhat.com> wrote:
> At the moment the ITS is not properly reset. On System reset or
> reboot, previous ITS register values and caches are left
> unchanged. Some of the registers might point to some guest RAM
> tables which are not provisionned. This leads to state
> inconsistencies that are detected by the kernel save/restore
> code. And eventually this may cause qemu abort on source or
> destination.
>
> The 1st patch, suggested to be cc'ed stable proposes to remove
> the abort in case of table save/restore failure. This is
> definitively not ideal but looks the most reasonable until we
> get a proper way to reset the ITS. Still a message is emitted
> to report the save/restore did not happen correctly.
>
> Subsequent patches add the support of explicit reset using
> a new kvm device group/attribute combo. The associated kernel
> series is not upstream [1], hence the RFC.
>
> ITS specification is not very clear about reset. There is no
> reset wire. Some register fields are documented to have
> architecturally defined reset values and we use those here:
> Most importantly the Valid bit of GITS_CBASER and GITS_BASER
> are cleared and the GITS_CTLR.Enabled bit is cleared as well.

The ITS is a device, not part of the CPU, so its reset is
implementation-defined but typically via some signal that's
controlled by the SoC (this is no different to the other
parts of the GICv3 which aren't denoted as being in the
reset domain of the CPU). For instance if you look at the TRM
for the GIC-500 it has a single 'resetn' reset signal which
resets all of the GIC/ITS apart from the CPU interface parts:
http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.100336_0002_01_en/index.html

The GICv3 spec 6.6 indicates what is supposed to happen to
the ITS on powerup. For QEMU's purposes reset is generally
considered to be a cold reset and we should always reset our
state to the same thing it was when QEMU first started.

It's not clear to me why we need a new KVM device attribute
for doing ITS reset. The usual approach for this is:
 * system reset causes QEMU's device model reset code
   to reset state structure values to whatever their
   reset value is
 * we write those values up into the kernel, which is
   sufficient to reset it

What goes wrong with that in the case of the ITS?
In particular, if GITS_CTLR.Enabled is 0 then I think the
kernel should not be trying to read guest memory tables.

thanks
-- PMM
