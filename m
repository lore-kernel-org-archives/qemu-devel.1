Received: from eggs.gnu.org ([209.51.188.92]:43514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gn1Et-0006fP-W0
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 08:09:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gn1Er-0000vw-V9
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 08:09:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43770
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1gn1Ek-0000t8-H7
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 08:09:36 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0PD7KvR048606
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 08:09:27 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2q8328857b-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 08:09:27 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Fri, 25 Jan 2019 13:09:24 -0000
Date: Fri, 25 Jan 2019 14:09:18 +0100
From: Halil Pasic <pasic@linux.ibm.com>
In-Reply-To: <5627cb78-22b3-0557-7972-256bc9560d86@linux.ibm.com>
References: <20190121110354.2247-1-cohuck@redhat.com>
	<20190121110354.2247-3-cohuck@redhat.com>
	<2dac6201-9e71-b188-0385-d09d05071a1c@linux.ibm.com>
	<5627cb78-22b3-0557-7972-256bc9560d86@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <20190125140918.64686aaf@oc2783563651>
Subject: Re: [Qemu-devel] [PATCH v2 2/5] vfio-ccw: concurrent I/O handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Farman <farman@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Alex Williamson <alex.williamson@redhat.com>

On Thu, 24 Jan 2019 21:37:44 -0500
Eric Farman <farman@linux.ibm.com> wrote:

> >> @@ -188,25 +192,30 @@ static ssize_t vfio_ccw_mdev_write(struct=20
> >> mdev_device *mdev,
> >> =C2=A0 {
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct vfio_ccw_private *private;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ccw_io_region *region;
> >> +=C2=A0=C2=A0=C2=A0 int ret;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (*ppos + count > sizeof(*region))
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 private =3D dev_get_drvdata(mdev_parent=
_dev(mdev));
> >> -=C2=A0=C2=A0=C2=A0 if (private->state !=3D VFIO_CCW_STATE_IDLE)
> >> +=C2=A0=C2=A0=C2=A0 if (private->state =3D=3D VFIO_CCW_STATE_NOT_OPER =
||
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 private->state =3D=3D VFIO=
_CCW_STATE_STANDBY)
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EACCES;
> >> +=C2=A0=C2=A0=C2=A0 if (!mutex_trylock(&private->io_mutex))
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EAGAIN; =20
> >=20
> > Ah, I see Halil's difficulty here.
> >=20
> > It is true there is a race condition today, and that this doesn't=20
> > address it.=C2=A0 That's fine, add it to the todo list.=C2=A0 But even =
with that,=20
> > I don't see what the mutex is enforcing?=C2=A0 Two simultaneous SSCHs w=
ill be=20
> > serialized (one will get kicked out with a failed trylock() call), whil=
e=20
> > still leaving the window open between cc=3D0 on the SSCH and the=20
> > subsequent interrupt.=C2=A0 In the latter case, a second SSCH will come=
=20
> > through here, do the copy_from_user below, and then jump to fsm_io_busy=
=20
> > to return EAGAIN.=C2=A0 Do we really want to stomp on io_region in that=
 case?=20
> >  =C2=A0Why can't we simply return EAGAIN if state=3D=3DBUSY? =20
>=20
> (Answering my own questions as I skim patch 5...)
>=20
> Because of course this series is for async handling, while I was looking=
=20
> specifically at the synchronous code that exists today.  I guess then my=
=20
> question just remains on how the mutex is adding protection in the sync=20
> case, because that's still not apparent to me.  (Perhaps I missed it in=20
> a reply to Halil; if so I apologize, there were a lot when I returned.)

Careful, at the end we have vfio_ccw_mdev_write_io_region() and the
write callback for the capchain regions. We could return EAGAIN if
state=3D=3DBUSY in the vfio_ccw_mdev_write_io_region() (but I would prefer a
different error code -- see my other response).

I answered your mutex question as well. Just a small addendum the mutex
is not only for the cases the userspace acts sane (but also when it acts
insane;).

Halil
