Received: from eggs.gnu.org ([209.51.188.92]:37253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gmyfG-0004jo-BI
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:24:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gmyfF-0004iy-CM
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:24:46 -0500
Date: Fri, 25 Jan 2019 11:24:37 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190125112437.2c06fac6.cohuck@redhat.com>
In-Reply-To: <5627cb78-22b3-0557-7972-256bc9560d86@linux.ibm.com>
References: <20190121110354.2247-1-cohuck@redhat.com>
	<20190121110354.2247-3-cohuck@redhat.com>
	<2dac6201-9e71-b188-0385-d09d05071a1c@linux.ibm.com>
	<5627cb78-22b3-0557-7972-256bc9560d86@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Halil Pasic <pasic@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Alex Williamson <alex.williamson@redhat.com>

On Thu, 24 Jan 2019 21:37:44 -0500
Eric Farman <farman@linux.ibm.com> wrote:

> On 01/24/2019 09:25 PM, Eric Farman wrote:
> >=20
> >=20
> > On 01/21/2019 06:03 AM, Cornelia Huck wrote: =20

> > [1] I think these changes are cool.=C2=A0 We end up going into (and sta=
ying=20
> > in) state=3DBUSY if we get cc=3D0 on the SSCH, rather than in/out as we=
=20
> > bumble along.
> >=20
> > But why can't these be separated out from this patch?=C2=A0 It does cha=
nge=20
> > the behavior of the state machine, and seem distinct from the addition=
=20
> > of the mutex you otherwise add here?=C2=A0 At the very least, this beha=
vior=20
> > change should be documented in the commit since it's otherwise lost in=
=20
> > the mutex/EAGAIN stuff.

That's a very good idea. I'll factor them out into a separate patch.

> >  =20
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_vfio_ccw_io_fctl(scsw->cmd.fctl, =
get_schid(private),
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 io_region->ret_code, er=
rstr);
> >> =C2=A0 }
> >> diff --git a/drivers/s390/cio/vfio_ccw_ops.c=20
> >> b/drivers/s390/cio/vfio_ccw_ops.c
> >> index f673e106c041..3fa9fc570400 100644
> >> --- a/drivers/s390/cio/vfio_ccw_ops.c
> >> +++ b/drivers/s390/cio/vfio_ccw_ops.c
> >> @@ -169,16 +169,20 @@ static ssize_t vfio_ccw_mdev_read(struct=20
> >> mdev_device *mdev,
> >> =C2=A0 {
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct vfio_ccw_private *private;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ccw_io_region *region;
> >> +=C2=A0=C2=A0=C2=A0 int ret;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (*ppos + count > sizeof(*region))
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 private =3D dev_get_drvdata(mdev_parent=
_dev(mdev));
> >> +=C2=A0=C2=A0=C2=A0 mutex_lock(&private->io_mutex);
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 region =3D private->io_region;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (copy_to_user(buf, (void *)region + =
*ppos, count))
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EFAULT;
> >> -
> >> -=C2=A0=C2=A0=C2=A0 return count;
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -EFAULT;
> >> +=C2=A0=C2=A0=C2=A0 else
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D count;
> >> +=C2=A0=C2=A0=C2=A0 mutex_unlock(&private->io_mutex);
> >> +=C2=A0=C2=A0=C2=A0 return ret;
> >> =C2=A0 }
> >> =C2=A0 static ssize_t vfio_ccw_mdev_write(struct mdev_device *mdev,
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

My idea behind the mutex was to make sure that we get consistent data
when reading/writing (e.g. if one user space thread is reading the I/O
region while another is writing to it).
