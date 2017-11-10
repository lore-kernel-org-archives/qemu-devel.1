Received: from eggs.gnu.org ([2001:4830:134:3::10]:41276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jim.quigley@oracle.com>) id 1eD69b-0002no-Dl
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 05:03:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jim.quigley@oracle.com>) id 1eD69X-0000RK-D8
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 05:03:15 -0500
References: <1507630928-28307-1-git-send-email-Jim.Quigley@oracle.com>
	<78aed453-49b8-a9e4-ae7c-39c731158eaa@msgid.tls.msk.ru>
From: Jim Quigley <jim.quigley@oracle.com>
Message-ID: <1c3087f3-9019-26b3-b4be-df71da2033fc@oracle.com>
Date: Fri, 10 Nov 2017 10:03:07 +0000
MIME-Version: 1.0
In-Reply-To: <78aed453-49b8-a9e4-ae7c-39c731158eaa@msgid.tls.msk.ru>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, alex.williamson@redhat.com, laurent@vivier.eu, Jim Quigley <jim.quigley@oracle.com>



On 16/10/2017 19:07, Michael Tokarev wrote:
> 10.10.2017 13:22, Jim Quigley wrote:
>> More information is required to assist trouble-shooting when
>> QEMU fails to initialise the event notifications for devices
>> assigned with VFIO-PCI. Instead of supplying the user with a cryptic
>> error number only, print out a proper error message with strerror()
>> so that the user has a better way to figure out what the problem is.
>>
>> Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
>> Signed-off-by: Jim Quigley <Jim.Quigley@oracle.com>
>> ---
>> Cc: qemu-trivial@nongnu.org
>> Cc: mjt@tls.msk.ru
>> Cc: laurent@vivier.eu
>> Cc: alex.williamson@redhat.com
>> ---
>>   hw/vfio/pci.c | 35 ++++++++++++++++++++++++-----------
>>   1 file changed, 24 insertions(+), 11 deletions(-)
>>
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index 31e1edf..3bffb93 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -430,13 +430,16 @@ static int vfio_enable_vectors(VFIOPCIDevice *vd=
ev, bool msix)
>>   static void vfio_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector=
 *vector,
>>                                     int vector_n, bool msix)
>>   {
>> -    int virq;
>> +    int virq, ret;
>>  =20
>>       if ((msix && vdev->no_kvm_msix) || (!msix && vdev->no_kvm_msi)) =
{
>>           return;
>>       }
>>  =20
>> -    if (event_notifier_init(&vector->kvm_interrupt, 0)) {
>> +    ret =3D event_notifier_init(&vector->kvm_interrupt, 0);
>> +    if (ret) {
>> +        error_report("vfio (%s): Error: unable to init event notifier=
: %s (%d)",
>> +                     __func__, strerror(-ret), -ret);
> Since this pattern gets repeated again and again, maybe we can either
> use a common wrapper or move that eror reporting into event_notifier_in=
it()?
> Note there are other users of this function, besides hw/vfio, and maybe
> these, too, can benefit from better error reporting?

 =C2=A0=C2=A0=C2=A0 Ideally the strerror() would be included in the error=
_report()=20
function,
 =C2=A0=C2=A0=C2=A0 (as per the error_setg() function), which obviously w=
ould involve a=20
more
 =C2=A0=C2=A0=C2=A0 extensive change to the code base. Would that be an a=
cceptable=20
solution ?
 =C2=A0=C2=A0=C2=A0 Or I can move the reporting into theevent_notifier_in=
it() function=20
if that is
 =C2=A0=C2=A0=C2=A0 the preferred approach ?

 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 thanks

 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 regards

 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Jim Q.
>
> Thanks,
>
> /mjt
>
>
