Received: from eggs.gnu.org ([2001:4830:134:3::10]:35383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eE8MW-0005D6-E2
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 01:36:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eE8MT-00029N-Ay
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 01:36:52 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1507630928-28307-1-git-send-email-Jim.Quigley@oracle.com>
	<78aed453-49b8-a9e4-ae7c-39c731158eaa@msgid.tls.msk.ru>
	<1c3087f3-9019-26b3-b4be-df71da2033fc@oracle.com>
Date: Mon, 13 Nov 2017 07:36:41 +0100
In-Reply-To: <1c3087f3-9019-26b3-b4be-df71da2033fc@oracle.com> (Jim Quigley's
	message of "Fri, 10 Nov 2017 10:03:07 +0000")
Message-ID: <8760aey9ae.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/vfio: improve error message when cannot
 init vfio event notifiers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jim Quigley <jim.quigley@oracle.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, alex.williamson@redhat.com, laurent@vivier.eu

Jim Quigley <jim.quigley@oracle.com> writes:

> On 16/10/2017 19:07, Michael Tokarev wrote:
>> 10.10.2017 13:22, Jim Quigley wrote:
>>> More information is required to assist trouble-shooting when
>>> QEMU fails to initialise the event notifications for devices
>>> assigned with VFIO-PCI. Instead of supplying the user with a cryptic
>>> error number only, print out a proper error message with strerror()
>>> so that the user has a better way to figure out what the problem is.
>>>
>>> Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
>>> Signed-off-by: Jim Quigley <Jim.Quigley@oracle.com>
>>> ---
>>> Cc: qemu-trivial@nongnu.org
>>> Cc: mjt@tls.msk.ru
>>> Cc: laurent@vivier.eu
>>> Cc: alex.williamson@redhat.com
>>> ---
>>>   hw/vfio/pci.c | 35 ++++++++++++++++++++++++-----------
>>>   1 file changed, 24 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>> index 31e1edf..3bffb93 100644
>>> --- a/hw/vfio/pci.c
>>> +++ b/hw/vfio/pci.c
>>> @@ -430,13 +430,16 @@ static int vfio_enable_vectors(VFIOPCIDevice *vde=
v, bool msix)
>>>   static void vfio_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector =
*vector,
>>>                                     int vector_n, bool msix)
>>>   {
>>> -    int virq;
>>> +    int virq, ret;
>>>         if ((msix && vdev->no_kvm_msix) || (!msix &&
>>> vdev->no_kvm_msi)) {
>>>           return;
>>>       }
>>>   -    if (event_notifier_init(&vector->kvm_interrupt, 0)) {
>>> +    ret =3D event_notifier_init(&vector->kvm_interrupt, 0);
>>> +    if (ret) {
>>> +        error_report("vfio (%s): Error: unable to init event notifier:=
 %s (%d)",
>>> +                     __func__, strerror(-ret), -ret);
>> Since this pattern gets repeated again and again, maybe we can either

Parts of it are anti-patterns:

* Error messages are by definition meant for the user.  If you feel you
  need to include __func__ so it makes sense, you're obviously failing
  to address the end user.

* Likewise for the numeric encoding of errno.

* Printing "Error: " or similar is error_report()'s job.

That leaves printing strerror().

>> use a common wrapper or move that eror reporting into event_notifier_ini=
t()?
>> Note there are other users of this function, besides hw/vfio, and maybe
>> these, too, can benefit from better error reporting?
>
> =C2=A0=C2=A0=C2=A0 Ideally the strerror() would be included in the error_=
report()
> function,
> =C2=A0=C2=A0=C2=A0 (as per the error_setg() function), which obviously wo=
uld involve
> a more
> =C2=A0=C2=A0=C2=A0 extensive change to the code base. Would that be an ac=
ceptable
> solution ?

All existing uses error_report() that print strerror() would have to be
converted to the new function.  Same for error_vreport(), warn_report(),
...  Whether that's worthwhile is not obvious until we see patches.

> =C2=A0=C2=A0=C2=A0 Or I can move the reporting into theevent_notifier_ini=
t() function
> if that is
> =C2=A0=C2=A0=C2=A0 the preferred approach ?

Moving error_report() into event_notifier_init() makes it unusable in
contexts where error_report() is unwanted or wrong.
