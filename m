Received: from eggs.gnu.org ([209.51.188.92]:49638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farman@linux.ibm.com>) id 1gmrNT-0007zx-JA
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 21:37:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farman@linux.ibm.com>) id 1gmrNS-0006Kp-6j
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 21:37:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33324)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farman@linux.ibm.com>)
	id 1gmrNR-0006KR-RZ
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 21:37:54 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0P2Vsck127795
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 21:37:51 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2q7pfv03xp-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 21:37:51 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farman@linux.ibm.com>;
	Fri, 25 Jan 2019 02:37:50 -0000
From: Eric Farman <farman@linux.ibm.com>
References: <20190121110354.2247-1-cohuck@redhat.com>
	<20190121110354.2247-3-cohuck@redhat.com>
	<2dac6201-9e71-b188-0385-d09d05071a1c@linux.ibm.com>
Date: Thu, 24 Jan 2019 21:37:44 -0500
MIME-Version: 1.0
In-Reply-To: <2dac6201-9e71-b188-0385-d09d05071a1c@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <5627cb78-22b3-0557-7972-256bc9560d86@linux.ibm.com>
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
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Alex Williamson <alex.williamson@redhat.com>



On 01/24/2019 09:25 PM, Eric Farman wrote:
>=20
>=20
> On 01/21/2019 06:03 AM, Cornelia Huck wrote:
>> Rework handling of multiple I/O requests to return -EAGAIN if
>> we are already processing an I/O request. Introduce a mutex
>> to disallow concurrent writes to the I/O region.
>>
>> The expectation is that userspace simply retries the operation
>> if it gets -EAGAIN.
>>
>> We currently don't allow multiple ssch requests at the same
>> time, as we don't have support for keeping channel programs
>> around for more than one request.
>>
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>> ---
>> =C2=A0 drivers/s390/cio/vfio_ccw_drv.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 1 +
>> =C2=A0 drivers/s390/cio/vfio_ccw_fsm.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 8 +++-----
>> =C2=A0 drivers/s390/cio/vfio_ccw_ops.c=C2=A0=C2=A0=C2=A0=C2=A0 | 31 ++=
+++++++++++++++++----------
>> =C2=A0 drivers/s390/cio/vfio_ccw_private.h |=C2=A0 2 ++
>> =C2=A0 4 files changed, 26 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/s390/cio/vfio_ccw_drv.c=20
>> b/drivers/s390/cio/vfio_ccw_drv.c
>> index a10cec0e86eb..2ef189fe45ed 100644
>> --- a/drivers/s390/cio/vfio_ccw_drv.c
>> +++ b/drivers/s390/cio/vfio_ccw_drv.c
>> @@ -125,6 +125,7 @@ static int vfio_ccw_sch_probe(struct subchannel *s=
ch)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 private->sch =3D sch;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_set_drvdata(&sch->dev, private);
>> +=C2=A0=C2=A0=C2=A0 mutex_init(&private->io_mutex);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock_irq(sch->lock);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 private->state =3D VFIO_CCW_STATE_NOT_O=
PER;
>> diff --git a/drivers/s390/cio/vfio_ccw_fsm.c=20
>> b/drivers/s390/cio/vfio_ccw_fsm.c
>> index cab17865aafe..f6ed934cc565 100644
>> --- a/drivers/s390/cio/vfio_ccw_fsm.c
>> +++ b/drivers/s390/cio/vfio_ccw_fsm.c
>> @@ -28,7 +28,6 @@ static int fsm_io_helper(struct vfio_ccw_private=20
>> *private)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sch =3D private->sch;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock_irqsave(sch->lock, flags);
>> -=C2=A0=C2=A0=C2=A0 private->state =3D VFIO_CCW_STATE_BUSY;
>=20
> [1]
>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 orb =3D cp_get_orb(&private->cp, (u32)(=
addr_t)sch, sch->lpm);
>> @@ -42,6 +41,8 @@ static int fsm_io_helper(struct vfio_ccw_private=20
>> *private)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sch->schib.scsw=
.cmd.actl |=3D SCSW_ACTL_START_PEND;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D 0;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Don't allow another ssc=
h for now */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 private->state =3D VFIO_CC=
W_STATE_BUSY;
>=20
> [1]
>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 1:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 /* Status pending */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 2:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 /* Busy */
>> @@ -99,7 +100,7 @@ static void fsm_io_error(struct vfio_ccw_private=20
>> *private,
>> =C2=A0 static void fsm_io_busy(struct vfio_ccw_private *private,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 enum vfio_ccw_event event)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 private->io_region->ret_code =3D -EBUSY;
>> +=C2=A0=C2=A0=C2=A0 private->io_region->ret_code =3D -EAGAIN;
>> =C2=A0 }
>> =C2=A0 static void fsm_disabled_irq(struct vfio_ccw_private *private,
>> @@ -130,8 +131,6 @@ static void fsm_io_request(struct vfio_ccw_private=
=20
>> *private,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct mdev_device *mdev =3D private->m=
dev;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *errstr =3D "request";
>> -=C2=A0=C2=A0=C2=A0 private->state =3D VFIO_CCW_STATE_BUSY;
>> -
>=20
> [1]
>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memcpy(scsw, io_region->scsw_area, size=
of(*scsw));
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (scsw->cmd.fctl & SCSW_FCTL_START_FU=
NC) {
>> @@ -176,7 +175,6 @@ static void fsm_io_request(struct vfio_ccw_private=
=20
>> *private,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 err_out:
>> -=C2=A0=C2=A0=C2=A0 private->state =3D VFIO_CCW_STATE_IDLE;
>=20
> [1] I think these changes are cool.=C2=A0 We end up going into (and sta=
ying=20
> in) state=3DBUSY if we get cc=3D0 on the SSCH, rather than in/out as we=
=20
> bumble along.
>=20
> But why can't these be separated out from this patch?=C2=A0 It does cha=
nge=20
> the behavior of the state machine, and seem distinct from the addition=20
> of the mutex you otherwise add here?=C2=A0 At the very least, this beha=
vior=20
> change should be documented in the commit since it's otherwise lost in=20
> the mutex/EAGAIN stuff.
>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_vfio_ccw_io_fctl(scsw->cmd.fctl, =
get_schid(private),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 io_region->ret_code, err=
str);
>> =C2=A0 }
>> diff --git a/drivers/s390/cio/vfio_ccw_ops.c=20
>> b/drivers/s390/cio/vfio_ccw_ops.c
>> index f673e106c041..3fa9fc570400 100644
>> --- a/drivers/s390/cio/vfio_ccw_ops.c
>> +++ b/drivers/s390/cio/vfio_ccw_ops.c
>> @@ -169,16 +169,20 @@ static ssize_t vfio_ccw_mdev_read(struct=20
>> mdev_device *mdev,
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct vfio_ccw_private *private;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ccw_io_region *region;
>> +=C2=A0=C2=A0=C2=A0 int ret;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (*ppos + count > sizeof(*region))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 private =3D dev_get_drvdata(mdev_parent=
_dev(mdev));
>> +=C2=A0=C2=A0=C2=A0 mutex_lock(&private->io_mutex);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 region =3D private->io_region;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (copy_to_user(buf, (void *)region + =
*ppos, count))
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EFAULT;
>> -
>> -=C2=A0=C2=A0=C2=A0 return count;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -EFAULT;
>> +=C2=A0=C2=A0=C2=A0 else
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D count;
>> +=C2=A0=C2=A0=C2=A0 mutex_unlock(&private->io_mutex);
>> +=C2=A0=C2=A0=C2=A0 return ret;
>> =C2=A0 }
>> =C2=A0 static ssize_t vfio_ccw_mdev_write(struct mdev_device *mdev,
>> @@ -188,25 +192,30 @@ static ssize_t vfio_ccw_mdev_write(struct=20
>> mdev_device *mdev,
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct vfio_ccw_private *private;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ccw_io_region *region;
>> +=C2=A0=C2=A0=C2=A0 int ret;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (*ppos + count > sizeof(*region))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 private =3D dev_get_drvdata(mdev_parent=
_dev(mdev));
>> -=C2=A0=C2=A0=C2=A0 if (private->state !=3D VFIO_CCW_STATE_IDLE)
>> +=C2=A0=C2=A0=C2=A0 if (private->state =3D=3D VFIO_CCW_STATE_NOT_OPER =
||
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 private->state =3D=3D VFIO=
_CCW_STATE_STANDBY)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EACCES;
>> +=C2=A0=C2=A0=C2=A0 if (!mutex_trylock(&private->io_mutex))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EAGAIN;
>=20
> Ah, I see Halil's difficulty here.
>=20
> It is true there is a race condition today, and that this doesn't=20
> address it.=C2=A0 That's fine, add it to the todo list.=C2=A0 But even =
with that,=20
> I don't see what the mutex is enforcing?=C2=A0 Two simultaneous SSCHs w=
ill be=20
> serialized (one will get kicked out with a failed trylock() call), whil=
e=20
> still leaving the window open between cc=3D0 on the SSCH and the=20
> subsequent interrupt.=C2=A0 In the latter case, a second SSCH will come=
=20
> through here, do the copy_from_user below, and then jump to fsm_io_busy=
=20
> to return EAGAIN.=C2=A0 Do we really want to stomp on io_region in that=
 case?=20
>  =C2=A0Why can't we simply return EAGAIN if state=3D=3DBUSY?

(Answering my own questions as I skim patch 5...)

Because of course this series is for async handling, while I was looking=20
specifically at the synchronous code that exists today.  I guess then my=20
question just remains on how the mutex is adding protection in the sync=20
case, because that's still not apparent to me.  (Perhaps I missed it in=20
a reply to Halil; if so I apologize, there were a lot when I returned.)

>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 region =3D private->io_region;
>> -=C2=A0=C2=A0=C2=A0 if (copy_from_user((void *)region + *ppos, buf, co=
unt))
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EFAULT;
>> +=C2=A0=C2=A0=C2=A0 if (copy_from_user((void *)region + *ppos, buf, co=
unt)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -EFAULT;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out_unlock;
>> +=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vfio_ccw_fsm_event(private, VFIO_CCW_EV=
ENT_IO_REQ)
>> -=C2=A0=C2=A0=C2=A0 if (region->ret_code !=3D 0) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 private->state =3D VFIO_CC=
W_STATE_IDLE;
>=20
> [1] (above)
>=20
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return region->ret_code;
>> -=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 ret =3D (region->ret_code !=3D 0) ? region->ret_co=
de : count;
>> -=C2=A0=C2=A0=C2=A0 return count;
>> +out_unlock:
>> +=C2=A0=C2=A0=C2=A0 mutex_unlock(&private->io_mutex);
>> +=C2=A0=C2=A0=C2=A0 return ret;
>> =C2=A0 }
>> =C2=A0 static int vfio_ccw_mdev_get_device_info(struct vfio_device_inf=
o *info)
>> diff --git a/drivers/s390/cio/vfio_ccw_private.h=20
>> b/drivers/s390/cio/vfio_ccw_private.h
>> index 08e9a7dc9176..e88237697f83 100644
>> --- a/drivers/s390/cio/vfio_ccw_private.h
>> +++ b/drivers/s390/cio/vfio_ccw_private.h
>> @@ -28,6 +28,7 @@
>> =C2=A0=C2=A0 * @mdev: pointer to the mediated device
>> =C2=A0=C2=A0 * @nb: notifier for vfio events
>> =C2=A0=C2=A0 * @io_region: MMIO region to input/output I/O arguments/r=
esults
>> + * @io_mutex: protect against concurrent update of I/O structures
>> =C2=A0=C2=A0 * @cp: channel program for the current I/O operation
>> =C2=A0=C2=A0 * @irb: irb info received from interrupt
>> =C2=A0=C2=A0 * @scsw: scsw info
>> @@ -42,6 +43,7 @@ struct vfio_ccw_private {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct mdev_device=C2=A0=C2=A0=C2=A0 *m=
dev;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct notifier_block=C2=A0=C2=A0=C2=A0=
 nb;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ccw_io_region=C2=A0=C2=A0=C2=A0 =
*io_region;
>> +=C2=A0=C2=A0=C2=A0 struct mutex=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 io_mutex;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct channel_program=C2=A0=C2=A0=C2=A0=
 cp;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct irb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 irb;
>>
