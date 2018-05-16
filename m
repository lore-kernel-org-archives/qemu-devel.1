Received: from eggs.gnu.org ([2001:4830:134:3::10]:56633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1fIwY9-0002tu-3w
	for qemu-devel@nongnu.org; Wed, 16 May 2018 09:33:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1fIwY4-00011Z-OA
	for qemu-devel@nongnu.org; Wed, 16 May 2018 09:33:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45266)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1fIwY4-00011J-GY
	for qemu-devel@nongnu.org; Wed, 16 May 2018 09:32:56 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4GDT1MM049757
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 09:32:55 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2j0k3qqj87-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 09:32:54 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Wed, 16 May 2018 14:32:52 +0100
Reply-To: pmorel@linux.ibm.com
References: <20180509154822.23510-1-cohuck@redhat.com>
	<20180509154822.23510-3-cohuck@redhat.com>
	<c18f9b9f-da00-1a0b-8ef0-7ac223c73d1a@linux.ibm.com>
	<20180515181006.0cb1dfc2.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Wed, 16 May 2018 15:32:48 +0200
MIME-Version: 1.0
In-Reply-To: <20180515181006.0cb1dfc2.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <a5d08fb7-d9c1-b230-fe0c-acebbda2ba65@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC 2/2] vfio-ccw: support for halt/clear
 subchannel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On 15/05/2018 18:10, Cornelia Huck wrote:
> On Fri, 11 May 2018 11:33:35 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
>
>> On 09/05/2018 17:48, Cornelia Huck wrote:
>>> Currently, vfio-ccw only relays start subchannel requests to the real
>>> hardware, which is enough in many cases but falls short e.g. during
>>> error recovery.
>>>
>>> Fortunately, it is easy to add support for halt and clear subchannel
>>> requests to the existing infrastructure. User space can detect
>>> support for halt/clear subchannel easily, as we always returned
>>> -EOPNOTSUPP before and therefore we do not need any capability to
>>> make this support discoverable.
>>>
>>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>> ---
>>>    drivers/s390/cio/vfio_ccw_drv.c | 10 ++++-
>>>    drivers/s390/cio/vfio_ccw_fsm.c | 94 +++++++++++++++++++++++++++++=
+++++++-----
>>>    2 files changed, 92 insertions(+), 12 deletions(-)
>>> @@ -65,6 +67,70 @@ static int fsm_io_helper(struct vfio_ccw_private *=
private)
>>>    	return ret;
>>>    }
>>>   =20
>>> +static int fsm_halt_helper(struct vfio_ccw_private *private)
>>> +{
>>> +	struct subchannel *sch;
>>> +	int ccode;
>>> +	unsigned long flags;
>>> +	int ret;
>>> +
>>> +	sch =3D private->sch;
>>> +
>>> +	spin_lock_irqsave(sch->lock, flags);
>>> +	private->state =3D VFIO_CCW_STATE_BUSY;
>>> +
>>> +	/* Issue "Halt Subchannel" */
>>> +	ccode =3D hsch(sch->schid);
>>> +
>>> +	switch (ccode) {
>>> +	case 0:
>>> +		/*
>>> +		 * Initialize device status information
>>> +		 */
>>> +		sch->schib.scsw.cmd.actl |=3D SCSW_ACTL_HALT_PEND;
>>> +		ret =3D 0;
>>> +		break;
>>> +	case 1:		/* Status pending */
>> shouldn't we make a difference between status pending
>> and having halt in progress?
>>
>> The guest can examine the SCSW, but couldn't it introduce
>> a race condition?
> Yes, good point. Especially as the guest might want to do different
> things.
>
> Regarding race conditions: The scsw can already be outdated after the
> operation that stored it finished, which is true even on LPAR. That's
> especially true for tsch which clears some status at the subchannel.
> The guest must already be able to deal with this, the race window is
> just larger.

This is the kind of race I try to avoid with the mutex protected
state changes patch.

>
>>
>>> +	case 2:		/* Busy */
>>> +		ret =3D -EBUSY;
>>> +		break;
>>> +	default:	/* Device not operational */
>>> +		ret =3D -ENODEV;
>>> +	}
>>> +	spin_unlock_irqrestore(sch->lock, flags);
>>> +	return ret;
>>> +}
>>> +
>>> +static int fsm_clear_helper(struct vfio_ccw_private *private)
>>> +{
>>> +	struct subchannel *sch;
>>> +	int ccode;
>>> +	unsigned long flags;
>>> +	int ret;
>>> +
>>> +	sch =3D private->sch;
>>> +
>>> +	spin_lock_irqsave(sch->lock, flags);
>>> +	private->state =3D VFIO_CCW_STATE_BUSY;
>>> +
>>> +	/* Issue "Clear Subchannel" */
>>> +	ccode =3D csch(sch->schid);
>>> +
>>> +	switch (ccode) {
>>> +	case 0:
>>> +		/*
>>> +		 * Initialize device status information
>>> +		 */
>>> +		sch->schib.scsw.cmd.actl |=3D SCSW_ACTL_CLEAR_PEND;
>>> +		ret =3D 0;
>>> +		break;
>>> +	default:	/* Device not operational */
>>> +		ret =3D -ENODEV;
>>> +	}
>>> +	spin_unlock_irqrestore(sch->lock, flags);
>>> +	return ret;
>>> +}
>>> +
>>>    static void fsm_notoper(struct vfio_ccw_private *private,
>>>    			enum vfio_ccw_event event)
>>>    {
>>> @@ -126,7 +192,24 @@ static void fsm_io_request(struct vfio_ccw_priva=
te *private,
>>>   =20
>>>    	memcpy(scsw, io_region->scsw_area, sizeof(*scsw));
>>>   =20
>>> -	if (scsw->cmd.fctl & SCSW_FCTL_START_FUNC) {
>>> +	/*
>>> +	 * Start processing with the clear function, then halt, then start.
>>> +	 * We may still be start pending when the caller wants to clean
>>> +	 * up things via halt/clear.
>>> +	 */
>> hum. The scsw here does not reflect the hardware state but the
>> command passed from the user interface.
>> Can we and should we authorize multiple commands in one call?
>>
>> If not, the comment is not appropriate and a switch on cmd.fctl
>> would be a clearer.
> There may be multiple functions specified, but we need to process them
> in precedence order (and clear wins over the others, so to speak).
> Would adding a sentence like "we always process just one function" help=
?

Why should we allow multiple commands in a single call ?
It brings no added value.
Is there a use case?
Currently QEMU does not do this and since we only have the SCSH there
is no difference having the bit set alone or not alone.


--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
