Received: from eggs.gnu.org ([209.51.188.92]:60768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1goZEX-0002GW-0k
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 14:39:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1goZEV-0002jN-QC
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 14:39:44 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35126
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1goZEV-0002hg-Kv
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 14:39:43 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0TJcu0J083240
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 14:39:41 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qatgb026c-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 14:39:41 -0500
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Tue, 29 Jan 2019 19:39:39 -0000
Date: Tue, 29 Jan 2019 20:39:33 +0100
From: Halil Pasic <pasic@linux.ibm.com>
In-Reply-To: <20190129105840.1bf46c3b.cohuck@redhat.com>
References: <20190121110354.2247-1-cohuck@redhat.com>
	<20190121110354.2247-3-cohuck@redhat.com>
	<2dac6201-9e71-b188-0385-d09d05071a1c@linux.ibm.com>
	<5627cb78-22b3-0557-7972-256bc9560d86@linux.ibm.com>
	<20190125112437.2c06fac6.cohuck@redhat.com>
	<20190125135835.2d59b511.cohuck@redhat.com>
	<20190125150101.3b61f0a1@oc2783563651>
	<20190125152154.05120461.cohuck@redhat.com>
	<20190125170404.28c61eab@oc2783563651>
	<20190128181355.2d79cae7.cohuck@redhat.com>
	<20190128203000.6dbf7ba3@oc2783563651>
	<20190129105840.1bf46c3b.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <20190129203933.4e57cd91@oc2783563651>
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
Cc: linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>, Alex Williamson <alex.williamson@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org, Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org

On Tue, 29 Jan 2019 10:58:40 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> > > > The problem I see with the let the hardware sort it out is that, for
> > > > that to work, we need to juggle multiple translations simultaneously
> > > > (or am I wrong?). Doing that does not appear particularly simple to
> > > > me.   =20
> > >=20
> > > None in the first stage, at most two in the second stage, I guess.
> > >    =20
> >=20
> > Expected benefit of the second stage over the first stage? (I see none.=
) =20
>=20
> Making something possible that is allowed by the architecture. Not
> really important, though.
>=20

I had a chat with Farhan, and he suggested that by 'allowed by
architecture' you mean " You can submit a new request if the subchannel
is pending with primary, but not with secondary state." (from Message-ID:
<20190125152154.05120461.cohuck@redhat.com>).

So I re-read the PoP.

=46rom the description of the start subchannel instruction:
"""
Special Conditions

Condition code 1 is set, and no other action is
taken, when the subchannel is status pending when
START SUBCHANNEL is executed. On some mod-
els, condition code 1 is not set when the subchannel
is status pending with only secondary status; instead,
the status-pending condition is discarded.

Condition code 2 is set, and no other action is
taken, when a start, halt, or clear function is currently
in progress at the subchannel (see =E2=80=9CFunction Control
(FC)=E2=80=9D on page 13).

"""

So I guess you mixed primary and secondary up and wanted to say:
"You can submit a new request if the subchannel
is pending with _secondary_, but not with _primary_ _status_."

But does that really mean architecture allows the subchannel
to accept multiple ssch() instructions so that it ends up processing
two or more channel programs in parallel.

My answer to that question is: no it does not, and furthermore
it would not make sense.

So let me provide some quotes that explain how this ominous accepting
the ssch() with a status pending can occur.

"""
Conclusion of I/O Operations

The conclusion of an I/O operation normally is indi-
cated by two status conditions: channel end and
device end. The channel-end condition indicates that
the I/O device has received or provided all data asso-
ciated with the operation and no longer needs chan-
nel-subsystem facilities. This condition is called the
primary interruption condition, and the channel end
in this case is the primary status. Generally, the pri-
mary interruption condition is any interruption condi-
tion that relates to an I/O operation and that signals
the conclusion at the subchannel of the I/O operation
or chain of I/O operations.

The device-end signal indicates that the I/O device
has concluded execution and is ready to perform
another operation. This condition is called the sec-
ondary interruption condition, and the device end in
this case is the secondary status. Generally, the sec-
ondary interruption condition is any interruption con-
dition that relates to an I/O operation and that signals
the conclusion at the device of the I/O operation or
chain of operations. The secondary interruption con-
dition can occur concurrently with, or later than, the
primary interruption condition.
"""

In my reading this means that a device may lag with signaling
that it is done (with respect to the conclusion at the subchannel).

It that window between primary and secondary the driver could do the
proper driving of a ccw device stuff, do the store subchannel and clear
the primary status. See  And happily start the next ssch(). If that
ssch() now hit a subchannel thah just got the secondary status, for some
modes we apparently don't need to wait for the secondary status before
issuing the next ssch(), nor do we need to do we need to do the clear the
pending status dance because ssch() says cc =3D=3D 1. The subchannel will
discard the secondary status and process the second ssch(). But the
previous ssch() has long concluded. Because as the quoted text says
the primary status is either simultaneous with or precedes the secondary
status.

Also if the subchannel were to process more than one channel program
at the time, questions would arise like what happens if one of them fails
(does that affect the other one?). It's something I find very hard to
even thing about.

BTW we would have to deal with these problems as well, if we were
to implement your second stage.

> >  =20
> > > > Furthermore we would go through all that hassle knowingly that
> > > > the sole reason is working around bugs. We still expect our
> > > > Linux guests serializing it's ssch() stuff as it does today.
> > > > Thus I would except this code not getting the love nor the
> > > > coverage that would guard against bugs in that code.   =20
> > >=20
> > > So, we should have test code for that? (Any IBM-internal channel
> > > I/O exercisers that may help?)
> > >   =20
> >=20
> > None that I'm aware of. Anyone else?=20
> >=20
> > But the point I was trying to make is the following: I prefer keeping
> > the handling for the case "ssch()'s on top of each other" as trivial
> > as possible. (E.g. bail out if CP_PENDING without doing any
> > translation.)=20
> > > We should not rely on the guest being sane, although Linux
> > > probably is in that respect.
> > >    =20
> >=20
> > I agree 100%: we should not rely on either guest or userspace
> > emulator being sane. But IMHO we should handle insanity with the
> > least possible investment. =20
>=20
> We probably disagree what the least possible investment is.
>=20

Yes. IMHO making sure that we accept io_requests only if we are in
an appropriate state (currently the IDLE) and rejecting requests with
the appropriate error code is easy. And juggling parallel translations is
hard. My intuition. I can try to prove my point should anybody ever try
to submit patches that attempt this juggling parallel translations. But
I'm loosing my confidence in my ability to convince people.

Farhan, Eric any opinions?

Regards,
Halil
