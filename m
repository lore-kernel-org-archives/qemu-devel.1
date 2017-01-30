Received: from eggs.gnu.org ([2001:4830:134:3::10]:45840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jgross@suse.com>) id 1cYELn-0007CJ-QB
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 10:58:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jgross@suse.com>) id 1cYELk-0005Qg-MH
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 10:58:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:35143)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jgross@suse.com>) id 1cYELk-0005Q2-4d
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 10:58:36 -0500
References: <20170130151409.20444-1-jgross@suse.com>
	<CAFEAcA_LB-+O+eDKoj1=s7xi4OsCo1dhnw9Ao48XzqZaZ91PLg@mail.gmail.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <340fded9-a2ee-648c-63ee-6072467df6ad@suse.com>
Date: Mon, 30 Jan 2017 16:58:29 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_LB-+O+eDKoj1=s7xi4OsCo1dhnw9Ao48XzqZaZ91PLg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] xen: use qdev_unplug() insteda of g_free()
 in xen_pv_find_xendev()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, xen-devel@lists.xenproject.org, Anthony PERARD <anthony.perard@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>

On 30/01/17 16:46, Peter Maydell wrote:
> On 30 January 2017 at 15:14, Juergen Gross <jgross@suse.com> wrote:
>> The error exits of xen_pv_find_xendev() free the new xen-device via
>> g_free() which is wrong.
>>
>> As the xen-device has been initialized as qdev it must be removed
>> via qdev_unplug().
>>
>> This bug has been introduced with commit 3a6c9172ac5951e6dac2b3f6
>> ("xen: create qdev for each backend device").
>>
>> Reported-by: Roger Pau Monn=C3=A9 <roger.pau@citrix.com>
>> Tested-by: Roger Pau Monn=C3=A9 <roger.pau@citrix.com>
>> Signed-off-by: Juergen Gross <jgross@suse.com>
>> ---
>>  hw/xen/xen_backend.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/xen/xen_backend.c b/hw/xen/xen_backend.c
>> index d119004..030772b 100644
>> --- a/hw/xen/xen_backend.c
>> +++ b/hw/xen/xen_backend.c
>> @@ -145,7 +145,7 @@ static struct XenDevice *xen_be_get_xendev(const c=
har *type, int dom, int dev,
>>      xendev->evtchndev =3D xenevtchn_open(NULL, 0);
>>      if (xendev->evtchndev =3D=3D NULL) {
>>          xen_pv_printf(NULL, 0, "can't open evtchn device\n");
>> -        g_free(xendev);
>> +        qdev_unplug(&xendev->qdev, NULL);
>>          return NULL;
>>      }
>>      fcntl(xenevtchn_fd(xendev->evtchndev), F_SETFD, FD_CLOEXEC);
>> @@ -155,7 +155,7 @@ static struct XenDevice *xen_be_get_xendev(const c=
har *type, int dom, int dev,
>>          if (xendev->gnttabdev =3D=3D NULL) {
>>              xen_pv_printf(NULL, 0, "can't open gnttab device\n");
>>              xenevtchn_close(xendev->evtchndev);
>> -            g_free(xendev);
>> +            qdev_unplug(&xendev->qdev, NULL);
>>              return NULL;
>>          }
>>      } else {
>=20
> I think this will leak memory (and that we're already leaking
> memory), because the code is creating the xendev with
>     xendev =3D g_malloc0(ops->size);
>     object_initialize(&xendev->qdev, ops->size, TYPE_XENBACKEND);
>=20
> This is saying "I own and am responsible for freeing the memory
> that the device object lives in". If you want the object system
> to handle freeing the memory for you when the reference count
> goes to zero, then you need to create it with
>    xendev =3D object_new()
> which we can't do here because we're allocating ops->size bytes
> rather than just the size of the object type.
>=20
> Two options I think:
>  (1) have your code do
>     OBJECT(xendev)->free =3D g_free;
>  after the object_initialize (to tell the object system how
> to free this object)
>  (2) call both qdev_unplug and g_free
>=20
> I think (1) is better because it will definitely work even
> if the qdev bus system is holding on to an object reference
> after it returns from qdev_unplug() for some reason, and
> it will also mean we free the memory when we do a
> qdev_unplug in xen_pv_del_xendev(), rather than leaking it.

I agree. I'll send V2 with (1) included.

> Side note: Using DEVICE(xendev) is better QOM style than
> &xendev->qdev.

Okay. Will change.

Thanks for the very precise description.


Juergen
