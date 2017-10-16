Received: from eggs.gnu.org ([2001:4830:134:3::10]:45119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <james.morse@arm.com>) id 1e48lb-0007Gd-IS
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:01:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <james.morse@arm.com>) id 1e48lX-00005C-34
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:01:27 -0400
Received: from foss.arm.com ([217.140.101.70]:39344)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <james.morse@arm.com>) id 1e48lW-0008VS-Pn
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:01:22 -0400
Message-ID: <59E4E57D.4040304@arm.com>
Date: Mon, 16 Oct 2017 17:59:41 +0100
From: James Morse <james.morse@arm.com>
MIME-Version: 1.0
References: <8ba7e693-4e32-7873-70bf-4efbf57f9cf5@huawei.com>	<20170928011407-mutt-send-email-mst@kernel.org>	<405bbc99-1a43-aa8b-37e9-9599480f4c06@huawei.com>	<20171001063010-mutt-send-email-mst@kernel.org>	<49d576f3-454f-05f4-7afd-9ca8b5fb0706@huawei.com>
	<20171016113324.14e549c9@nial.brq.redhat.com>
	<0184EA26B2509940AA629AE1405DD7F2016994E5@DGGEMA503-MBX.china.huawei.com>
In-Reply-To: <0184EA26B2509940AA629AE1405DD7F2016994E5@DGGEMA503-MBX.china.huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel]
 =?utf-8?b?562U5aSNOiAgdXNpbmcgd2hpY2ggbm90aWZpY2F0?=
 =?utf-8?q?ion_for_guest_about_GHES_error?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: gengdongjiu <gengdongjiu@huawei.com>
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Wuquanming <wuquanming@huawei.com>, Laszlo Ersek <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Huangshaoyu <huangshaoyu@huawei.com>, Andrew Jones <drjones@redhat.com>

Hi gengdongjiu, Igor,

On 16/10/17 15:33, gengdongjiu wrote:
>> On Mon, 16 Oct 2017 14:10:05 +0800
>> gengdongjiu <gengdongjiu@huawei.com> wrote:
>>> Now we use Qemu to create APEI table and record CPER for guest, After
>>> QEMU recorded a asynchronous CPER error, we needs to notify guest usi=
ng interrupt or Polled notification.
>>> For the asynchronous error. I think using GPIO-signaled notification =
may be better in the Qemu, and also which is suggested by APEI spec.
>>> James worried that old guest OS may not support GPIO or GSIV notifica=
tion for GHES, because GPIO or GSIV notification is supported in OS
>> since about kernel version 4.10.
>>
>> How APEI support is fairly new on ARM (kernel), isn't it still in stat=
e of development?

The NMI-like notifications, (SEA, SEI, SDEI) are still being worked on, b=
ut the
less exotic Polled and many-flavours-of-interrupt should have exactly the=
 same
meaning/behaviour as on x86. (it should be possible to emulate/configure =
these
with common user-space code too)


>> Do we really care about old guests in this case?

I think the scenario here is the host kernel has some RAS support, Qemu h=
as RAS
support and has advertised its CPER regions via the HEST, but the guest d=
oesn't
doesn't support RAS. (booted via DT, wasn't configured for APEI, the kern=
el
pre-dates the support etc).

What should Qemu do in response to 'action optional' memory errors?

My suggestion is whatever action Qemu takes, it shouldn't kill a guest th=
at
doesn't support RAS. Using NOTIFY_SEI for an action-optional memory error=
 will
do this. A guest that doesn't know about NOTIFY_SEI will take this as a f=
atal
SError.


> How APEI support is new feature on ARM64, because it mainly exists in A=
RMv8.2 architecture.

ARMv8.2 isn't relevant here: The host kernel has some RAS support.
(My ARMv8.0 AMD Seattle has a HEST with NOTIFY_POLL entries).


> May be we cannot very care about old guest.
> Because even we use the old notification(such as polled notification), =
the guest OS may still not
> have APEI support, so it is still not useless.

The aim is to not kill the guest with the notification. Writing CPER reco=
rds to
the polled buffer for action-optional signals will be found by a guest th=
at
supports RAS, and ignored by a guest that doesn't.

Similarly if we report Action-Required signals as Synchronous-External-Ab=
ort, we
could make these NOTIFY_SEA. A guest that has RAS support will find the C=
PER
records, a guest that doesn't will still do the right thing.
(I think we need more information from KVM to support this one)


> I checked the patches history, the APEI support is only enabled recent.=
=20
>=20
> As we can see APEI/GHES is only enabled in "2017-06-21 12:30:44 -0500",=
 the old version OS even does not have APEI support.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?h=3Dv4.14-rc5&id=3Dc792e5e644fd8cd38b963fd3b38f6bf57c530966
>=20
> James, what do you think about it?

I think you shouldn't expect host kernel, guest kernel and Qemu version t=
o all
pair up nicely.


>> We'd like to stick to ACPI spec as much as possible and also to
>> http://infocenter.arm.com/help/topic/com.arm.doc.den0044b/DEN0044B_Ser=
ver_Base_Boot_Requirements.pdf
>> which mandates GPIO in platform (QEMU)
>> "
>> 4.5 Hardware Requirements Imposed on the Platform by ACPI ...
>> Platforms compliant with this specification must provide the following=
 GPIO-Signaled platform events:
>> ...
>> "
>>
>>> and suggested using Polled notification. About above two notification=
s, do you think
>>> which is better? and could you give us some suggestion? thanks.

Which is better? Surely polled is simplest:

>> how polling is supposed to be implemented in QEMU?

(I'm not familiar with Qemu's internals, but,)
For any of the GHES notifications you must have to reserve memory for CPE=
R
records, advertise where they are to the guest via UEFI+ACPI and describe=
 which
regions are notified by which method.

When Qemu takes a RAS signal it generates CPER records and 'does' the
notification. NOTIFY_POLL is the simplest, you don't do anything for the
notification. The guest is expected to read the interval value from the H=
EST and
check the buffer that often. Qemu just needs to generate the CPER records=
 into
the appropriate location in guest memory.


Thanks,

James


>>>   Below is APEI spec, From the spec, it suggested using GPIO interrup=
t or GPIO-signaled events in ARM64 [1]. If using Polled notification
>> for GHES, I do not sure whether it is reasonable.
>>> In the Qemu, X86 does not using Polled notification. it mainly use
>>> SCI. Until now, I do not found there is peopled using Polled notifica=
tion in qemu. if implemented polled notification, I do not know how
>> much work effort need to do. Now I have already implemented the GPIO-S=
ignal notification using GPIO pin.

>>> [1]
>>> HW-reduced ACPI platforms signal the error using a GPIO interrupt or
>>> another interrupt declared under a generic event device (Section 5.6.=
9). In the case of GPIO-signaled events, an _AEI object lists the
>> appropriate GPIO pin, while for Interrupt-signaled events a _CRS objec=
t is used to list the interrupt:
>>> 	=E2=80=A2 The OSPM evaluates the control method associated with this=
 event as indicated in Section 5.6.5.3 and Section 5.6.9.3.
>>> 	=E2=80=A2 OSPM responds to this notification by checking the error s=
tatus block of all generic error sources with the GPIO-Signal notificatio=
n or
>> Interrupt-signaled notification types to identify the
>>> 	  source reporting the error.
>>>
