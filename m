Received: from eggs.gnu.org ([209.51.188.92]:35401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1goCO3-0000Jg-8L
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 14:16:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1goCO1-0000CH-MP
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 14:16:03 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55430)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1goCO1-0000B8-BM
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 14:16:01 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0SJCcaU050208
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 14:15:59 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qa4j9j19h-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 14:15:58 -0500
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Mon, 28 Jan 2019 19:15:55 -0000
Date: Mon, 28 Jan 2019 20:15:48 +0100
From: Halil Pasic <pasic@linux.ibm.com>
In-Reply-To: <20190128180948.506a9695.cohuck@redhat.com>
References: <20190121110354.2247-1-cohuck@redhat.com>
	<20190121110354.2247-3-cohuck@redhat.com>
	<2dac6201-9e71-b188-0385-d09d05071a1c@linux.ibm.com>
	<5627cb78-22b3-0557-7972-256bc9560d86@linux.ibm.com>
	<20190125112437.2c06fac6.cohuck@redhat.com>
	<20190125135835.2d59b511.cohuck@redhat.com>
	<20190125150101.3b61f0a1@oc2783563651>
	<20190128180948.506a9695.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Message-Id: <20190128201548.1ecfb84f@oc2783563651>
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
Cc: Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Alex Williamson <alex.williamson@redhat.com>

On Mon, 28 Jan 2019 18:09:48 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On Fri, 25 Jan 2019 15:01:01 +0100
> Halil Pasic <pasic@linux.ibm.com> wrote:
>=20
> > On Fri, 25 Jan 2019 13:58:35 +0100
> > Cornelia Huck <cohuck@redhat.com> wrote:
>=20
> > > - The code should not be interrupted while we process the channel
> > >   program, do the ssch etc. We want the caller to try again later (i.=
e.
> > >   return -EAGAIN) =20
>=20
> (...)
>=20
> > > - With the async interface, we want user space to be able to submit a
> > >   halt/clear while a start request is still in flight, but not while
> > >   we're processing a start request with translation etc. We probably
> > >   want to do -EAGAIN in that case. =20
> >=20
> > This reads very similar to your first point.
>=20
> Not quite. ssch() means that we have a cp around; for hsch()/csch() we
> don't have such a thing. So we want to protect the process of
> translating the cp etc., but we don't need such protection for the
> halt/clear processing.
>=20

What does this don't 'need such protection' mean in terms of code,
moving the unlock of the io_mutex upward (in
vfio_ccw_async_region_write())?

Here the function in question for reference:

+static ssize_t vfio_ccw_async_region_write(struct vfio_ccw_private
*private,
+					   const char __user *buf,
size_t count,
+					   loff_t *ppos)
+{
+	unsigned int i =3D VFIO_CCW_OFFSET_TO_INDEX(*ppos) -
VFIO_CCW_NUM_REGIONS;
+	loff_t pos =3D *ppos & VFIO_CCW_OFFSET_MASK;
+	struct ccw_cmd_region *region;
+	int ret;
+
+	if (pos + count > sizeof(*region))
+		return -EINVAL;
+
+	if (private->state =3D=3D VFIO_CCW_STATE_NOT_OPER ||
+	    private->state =3D=3D VFIO_CCW_STATE_STANDBY)
+		return -EACCES;
+	if (!mutex_trylock(&private->io_mutex))
+		return -EAGAIN;
+
+	region =3D private->region[i].data;
+	if (copy_from_user((void *)region + pos, buf, count)) {
+		ret =3D -EFAULT;
+		goto out_unlock;
+	}
+
+	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_ASYNC_REQ);
+
+	ret =3D region->ret_code ? region->ret_code : count;
+
+out_unlock:
+	mutex_unlock(&private->io_mutex);
+	return ret;
+}

That does not make much sense to me at the moment (so I guess I
misunderstood again).

> >=20
> > >=20
> > > My idea would be:
> > >=20
> > > - The BUSY state denotes "I'm busy processing a request right now, try
> > >   again". We hold it while processing the cp and doing the ssch and
> > >   leave it afterwards (i.e., while the start request is processed by
> > >   the hardware). I/O requests and async requests get -EAGAIN in that
> > >   state.
> > > - A new state (CP_PENDING?) is entered after ssch returned with cc 0
> > >   (from the BUSY state). We stay in there as long as no final state f=
or
> > >   that request has been received and delivered. (This may be final
> > >   interrupt for that request, a deferred cc, or successful halt/clear=
.)
> > >   I/O requests get -EBUSY, async requests are processed. This state c=
an
> > >   be removed again once we are able to handle more than one outstandi=
ng
> > >   cp.
> > >=20
> > > Does that make sense?
> > >  =20
> >=20
> > AFAIU your idea is to split up the busy state into two states: CP_PENDI=
NG
> > and of busy without CP_PENDING called BUSY. I like the idea of having a
> > separate state for CP_PENDING but I don't like the new semantic of BUSY.
> >=20
> > Hm mashing a conceptual state machine and the jumptabe stuff ain't
> > making reasoning about this simpler either. I'm taking about the
> > conceptual state machine. It would be nice to have a picture of it and
> > then think about how to express that in code.
>=20
> Sorry, I'm having a hard time parsing your comments. Are you looking
> for something like the below?

I had more something like this=20
https://en.wikipedia.org/wiki/UML_state_machine,
in mind but the lists of state transitions are also useful.

>=20
> IDLE --- IO_REQ --> BUSY ---> CP_PENDING --- IRQ ---> IDLE (if final

There ain't no trigger/action list  between BUSY and CP_PENDING.
I'm also in the  dark about where the issuing of the ssch() happen
here (is it an internal transition within CP_PENDING?). I guess if
the ssch() returns with non cc =3D=3D 0 the CP_PENDING ---IRQ---> IDLE
transition
won't take place. And I guess the IRQ is a final one.

Sorry abstraction is not a concept unknown to me. But this is too much
abstraction for me in this context. The devil is in the details, and
AFAIU we are discussing these details right now.
=20

> state for I/O)
> (normal ssch)
>=20
> BUSY --- IO_REQ ---> return -EAGAIN, stay in BUSY
> (user space is supposed to retry, as we'll eventually progress from
> BUSY)
>=20
> CP_PENDING --- IO_REQ ---> return -EBUSY, stay in CP_PENDING
> (user space is supposed to map this to the appropriate cc for the guest)

=46rom this it seems you don't intend to issue the second  requested ssch()
any more (and don't want to do any translation). Is that right? (If it
is, that what I was asking for for a while, but then it's a pity for the
retries.)

>=20
> IDLE --- ASYNC_REQ ---> IDLE
> (user space is welcome to do anything else right away)

Your idea is to not issue a requested hsch() if we think we are IDLE
it seems. Do I understand this right? We would end up with a different
semantic for hsch()/and csch() (compared to PoP) in the guest with this
(AFAICT).

>=20
> BUSY --- ASYNC_REQ ---> return -EAGAIN, stay in BUSY
> (user space is supposed to retry, as above)
>=20
> CP_PENDING --- ASYNC_REQ ---> return success, stay in CP_PENDING
> (the interrupt will get us out of CP_PENDING eventually)

Issue (c|h)sch() is an action that is done on this internal=20
transition (within CP_PENDING).

Thank you very much for investing into this description of the state
machine. I'm afraid I'm acting like a not so nice person (self censored)
at the moment. I can't help myself, sorry. Maybe Farhan and Eric can take
this as a starting point and come up with something that we can integrate
into our documentation. Maybe not...

Regards,
Halil
