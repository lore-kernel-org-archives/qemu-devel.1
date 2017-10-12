Received: from eggs.gnu.org ([2001:4830:134:3::10]:54390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e2arW-0006OW-MB
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 06:37:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e2arV-0007gz-KQ
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 06:37:10 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:46939)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e2arV-0007gc-DZ
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 06:37:09 -0400
Received: by mail-wm0-x235.google.com with SMTP id m72so11942925wmc.1
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 03:37:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <73b7916a-4bb3-3913-ed6f-23e5c3e4fa23@redhat.com>
References: <1506524205-20763-1-git-send-email-eric.auger@redhat.com>
	<CAFEAcA_UfXaO-KEgXb+GSUT=XhQar_gxshUV_GWO_axcZ0R4sA@mail.gmail.com>
	<73b7916a-4bb3-3913-ed6f-23e5c3e4fa23@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Oct 2017 11:36:47 +0100
Message-ID: <CAFEAcA8OcaNJ3ZU=LFeCP0A_Kd__OTb-svZL7_dqjaBH=uRtog@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 0/3] vITS Reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: Wei Huang <wei@redhat.com>, Andrew Jones <drjones@redhat.com>, Vijay Kilari <vijay.kilari@gmail.com>, Juan Quintela <quintela@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, wu.wubin@huawei.com, wanghaibin.wang@huawei.com, Christoffer Dall <christoffer.dall@linaro.org>, eric.auger.pro@gmail.com

On 11 October 2017 at 17:06, Auger Eric <eric.auger@redhat.com> wrote:
> On 09/10/2017 20:17, Peter Maydell wrote:
>> It's not clear to me why we need a new KVM device attribute
>> for doing ITS reset. The usual approach for this is:
>>  * system reset causes QEMU's device model reset code
>>    to reset state structure values to whatever their
>>    reset value is
>>  * we write those values up into the kernel, which is
>>    sufficient to reset it
>>
>> What goes wrong with that in the case of the ITS?
>> In particular, if GITS_CTLR.Enabled is 0 then I think the
>> kernel should not be trying to read guest memory tables.
>
> We discussed that on the kernel thread and Christoffer seemed to prefer
> an IOTCL instead of individual register writes
> (https://www.spinics.net/lists/kvm-arm/msg27211.html)
>
> The IOCTL empties the ITS cached data (list of collection, list of
> devices and list of LPIs) while it is not obvious the reset of BASER<n>
> would mandate that. Eventually in my kernel series I also voided the
> list on BASER<n>.valid toggling from 1 to 0.

OK, I guess that makes sense -- in hardware, the device
has extra internal state (the cached stuff) which isn't
visible in its register interface. So we want to provide
an API which is morally equivalent to the hardware reset line
to tell the ITS to drop that internal state.

> Spec also says:
> If a write to GITS.CTLR changes the Enabled field from 1 to 0, the
> Interrupt Translation Space must ensure
> that both:
> =E2=80=A2 Any caches containing mapping data are made consistent with ext=
ernal
> memory.
> =E2=80=A2 GITS_CTLR.Quiescent =3D=3D 0 until all caches are consistent wi=
th external
> memory.
>
> I aknowledge I don't really get at which moment we are supposed to void
> the caches.

This is the interface for a software controlled clean powerdown:
 * OS writes 0 to Enabled
 * ITS finishes anything it is currently in the middle of
 * ITS updates any info that it currently has only in its internal
   cache so that it is also reflected in the external memory
   data structures
 * ITS sets Quiescent to 1 to tell the OS it has finished this process
   (and may no longer access guest RAM after this point)
 * OS can now unmap the RAM that the ITS tables are in,
   tell the h/w to power off the GIC/ITS, etc

It's a multistep process where the ITS gets the opportunity to
write memory in the middle. I think in theory there's no obligation
to actually drop the cached data when you set Quiescent to 1,
provided that you validate that when the OS sets Enabled back to
1 all your cached data is still valid, because that's
indistinguishable from dropping the cache and then repopulating it.

For the unclean powerdown (yanking the cord out of the back of the
machine), which is what qemu's reset is, we don't give the ITS
the option to write memory, it just has to effectively drop
any internal data structures it was using. So it needs a KVM
API that's different from the register-access API.

thanks
-- PMM
