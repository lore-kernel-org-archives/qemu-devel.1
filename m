Received: from eggs.gnu.org ([209.51.188.92]:48668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farman@linux.ibm.com>) id 1gn80K-0001sA-IP
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 15:23:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farman@linux.ibm.com>) id 1gn80J-0000yH-Fe
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 15:23:08 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41350)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farman@linux.ibm.com>)
	id 1gn80J-0000xL-52
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 15:23:07 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0PKDgFQ076260
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 15:23:05 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2q86bug69e-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 15:23:04 -0500
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farman@linux.ibm.com>;
	Fri, 25 Jan 2019 20:23:03 -0000
References: <20190121110354.2247-1-cohuck@redhat.com>
	<20190121110354.2247-3-cohuck@redhat.com>
	<2dac6201-9e71-b188-0385-d09d05071a1c@linux.ibm.com>
	<5627cb78-22b3-0557-7972-256bc9560d86@linux.ibm.com>
	<20190125112437.2c06fac6.cohuck@redhat.com>
From: Eric Farman <farman@linux.ibm.com>
Date: Fri, 25 Jan 2019 15:22:56 -0500
MIME-Version: 1.0
In-Reply-To: <20190125112437.2c06fac6.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <d1f84cbc-2caf-1bd8-8607-79d5a3f9eb6d@linux.ibm.com>
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
To: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Alex Williamson <alex.williamson@redhat.com>



On 01/25/2019 05:24 AM, Cornelia Huck wrote:
> On Thu, 24 Jan 2019 21:37:44 -0500
> Eric Farman <farman@linux.ibm.com> wrote:
>=20
>> On 01/24/2019 09:25 PM, Eric Farman wrote:
>>>
>>>
>>> On 01/21/2019 06:03 AM, Cornelia Huck wrote:
>=20
>>> [1] I think these changes are cool.=C2=A0 We end up going into (and s=
taying
>>> in) state=3DBUSY if we get cc=3D0 on the SSCH, rather than in/out as =
we
>>> bumble along.
>>>
>>> But why can't these be separated out from this patch?=C2=A0 It does c=
hange
>>> the behavior of the state machine, and seem distinct from the additio=
n
>>> of the mutex you otherwise add here?=C2=A0 At the very least, this be=
havior
>>> change should be documented in the commit since it's otherwise lost i=
n
>>> the mutex/EAGAIN stuff.
>=20
> That's a very good idea. I'll factor them out into a separate patch.
>=20
>>>   =20
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_vfio_ccw_io_fctl(scsw->cmd.fct=
l, get_schid(private),
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 io_region->ret_code, =
errstr);
>>>>  =C2=A0 }
>>>> diff --git a/drivers/s390/cio/vfio_ccw_ops.c
>>>> b/drivers/s390/cio/vfio_ccw_ops.c
>>>> index f673e106c041..3fa9fc570400 100644
>>>> --- a/drivers/s390/cio/vfio_ccw_ops.c
>>>> +++ b/drivers/s390/cio/vfio_ccw_ops.c
>>>> @@ -169,16 +169,20 @@ static ssize_t vfio_ccw_mdev_read(struct
>>>> mdev_device *mdev,
>>>>  =C2=A0 {
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct vfio_ccw_private *private;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ccw_io_region *region;
>>>> +=C2=A0=C2=A0=C2=A0 int ret;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (*ppos + count > sizeof(*region))
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINV=
AL;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 private =3D dev_get_drvdata(mdev_par=
ent_dev(mdev));
>>>> +=C2=A0=C2=A0=C2=A0 mutex_lock(&private->io_mutex);
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 region =3D private->io_region;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (copy_to_user(buf, (void *)region=
 + *ppos, count))
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EFAULT;
>>>> -
>>>> -=C2=A0=C2=A0=C2=A0 return count;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -EFAULT;
>>>> +=C2=A0=C2=A0=C2=A0 else
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D count;
>>>> +=C2=A0=C2=A0=C2=A0 mutex_unlock(&private->io_mutex);
>>>> +=C2=A0=C2=A0=C2=A0 return ret;
>>>>  =C2=A0 }
>>>>  =C2=A0 static ssize_t vfio_ccw_mdev_write(struct mdev_device *mdev,
>>>> @@ -188,25 +192,30 @@ static ssize_t vfio_ccw_mdev_write(struct
>>>> mdev_device *mdev,
>>>>  =C2=A0 {
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct vfio_ccw_private *private;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ccw_io_region *region;
>>>> +=C2=A0=C2=A0=C2=A0 int ret;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (*ppos + count > sizeof(*region))
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINV=
AL;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 private =3D dev_get_drvdata(mdev_par=
ent_dev(mdev));
>>>> -=C2=A0=C2=A0=C2=A0 if (private->state !=3D VFIO_CCW_STATE_IDLE)
>>>> +=C2=A0=C2=A0=C2=A0 if (private->state =3D=3D VFIO_CCW_STATE_NOT_OPE=
R ||
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 private->state =3D=3D VF=
IO_CCW_STATE_STANDBY)
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EACC=
ES;
>>>> +=C2=A0=C2=A0=C2=A0 if (!mutex_trylock(&private->io_mutex))
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EAGAIN;
>>>
>>> Ah, I see Halil's difficulty here.
>>>
>>> It is true there is a race condition today, and that this doesn't
>>> address it.=C2=A0 That's fine, add it to the todo list.=C2=A0 But eve=
n with that,
>>> I don't see what the mutex is enforcing?=C2=A0 Two simultaneous SSCHs=
 will be
>>> serialized (one will get kicked out with a failed trylock() call), wh=
ile
>>> still leaving the window open between cc=3D0 on the SSCH and the
>>> subsequent interrupt.=C2=A0 In the latter case, a second SSCH will co=
me
>>> through here, do the copy_from_user below, and then jump to fsm_io_bu=
sy
>>> to return EAGAIN.=C2=A0 Do we really want to stomp on io_region in th=
at case?
>>>   =C2=A0Why can't we simply return EAGAIN if state=3D=3DBUSY?
>>
>> (Answering my own questions as I skim patch 5...)
>>
>> Because of course this series is for async handling, while I was looki=
ng
>> specifically at the synchronous code that exists today.  I guess then =
my
>> question just remains on how the mutex is adding protection in the syn=
c
>> case, because that's still not apparent to me.  (Perhaps I missed it i=
n
>> a reply to Halil; if so I apologize, there were a lot when I returned.=
)
>=20
> My idea behind the mutex was to make sure that we get consistent data
> when reading/writing (e.g. if one user space thread is reading the I/O
> region while another is writing to it).
>=20

And from that angle, this accomplishes that.  It just wasn't apparent to=20
me at first.

I'm still not certain of how we handle mdev_write when state=3DBUSY, so=20
let me ask my question a different way...

If we come into mdev_write with state=3DBUSY and we get the lock,=20
copy_from_user, and do our jump table we go to fsm_io_busy to set=20
ret_code and return -EAGAIN.  Why then don't we set the jump table for=20
state=3DNOT_OPER||STANDBY to do something that will return -EACCES instea=
d=20
of how we currently do a direct return of -EACCES before all the=20
lock/copy stuff (and the jump table that would take us to fsm_io_error=20
and an error message before returning -EIO)?
