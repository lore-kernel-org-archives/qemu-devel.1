Received: from eggs.gnu.org ([2001:4830:134:3::10]:51012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cj7qB-0005FC-LC
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 12:15:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cj7q8-00023m-H0
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 12:15:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41354
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cj7q8-00023T-AX
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 12:15:00 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v21HE170062894
	for <qemu-devel@nongnu.org>; Wed, 1 Mar 2017 12:14:59 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28wxr8d10a-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 01 Mar 2017 12:14:59 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Wed, 1 Mar 2017 17:14:57 -0000
Date: Wed, 1 Mar 2017 18:14:52 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20170301190237-mutt-send-email-mst@kernel.org>
References: <20170228152411.81609-1-cornelia.huck@de.ibm.com>
	<20170301174738-mutt-send-email-mst@kernel.org>
	<20170301171554.1bd4107b.cornelia.huck@de.ibm.com>
	<20170301184527-mutt-send-email-mst@kernel.org>
	<20170301180044.507969c9.cornelia.huck@de.ibm.com>
	<20170301190237-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <20170301181452.0eee70dd.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] virtio: guard vring access when setting
 notification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, borntraeger@de.ibm.com

On Wed, 1 Mar 2017 19:04:56 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Mar 01, 2017 at 06:00:44PM +0100, Cornelia Huck wrote:
> > On Wed, 1 Mar 2017 18:50:34 +0200
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:

> > > Yes all these callbacks complicate code to the point it's barely
> > > readable. I really don't see why are we poking at device beforehand at
> > > all. IMHO this is closer to the root of the problem. Don't do it.  One
> > > way to look at it is to say that we start aio too early. Do it at
> > > driver_ok for virtio 1 and on kick for virtio 0 and problems will go
> > > away.
> >=20
> > The problem exists for the case where the guest sets up only the first
> > queue, but the host has more than one queue. The guest setting up other
> > queues later is probably patholotical, but not really forbidden by the
> > spec (I think).
>=20
> I think it's forbidden.  spec explains how queues are set up:
>=20
> 1. Reset the device.
> 2. Set the ACKNOWLEDGE status bit: the guest OS has notice the device.
> 3. Set the DRIVER status bit: the guest OS knows how to drive the device.
> 4. Read device feature bits, and write the subset of feature bits underst=
ood by the OS and driver to the
> device. During this step the driver MAY read (but MUST NOT write) the dev=
ice-specific configuration
> fields to check that it can support the device before accepting it.
> 5. Set the FEATURES_OK status bit. The driver MUST NOT accept new feature=
 bits after this step.
> 6. Re-read device status to ensure the FEATURES_OK bit is still set: othe=
rwise, the device does not
> support our subset of features and the device is unusable.
> 7. Perform device-specific setup, including discovery of virtqueues for t=
he device, optional per-bus setup,
> reading and possibly writing the device=E2=80=99s virtio configuration sp=
ace, and population of virtqueues.
> 8. Set the DRIVER_OK status bit. At this point the device is =E2=80=9Cliv=
e=E2=80=9D.

It seems I managed to read over this statement in step 7 several
times... So "make sure that we only start aio after DRIVER_OK, and
forbid any setup for !desc permanently" will take care of virtio-1
devices.

>=20
> And it goes on to mention a bug in legacy drivers:
> Legacy driver implementations often used the device before setting the DR=
IVER_OK bit, and sometimes
> even before writing the feature bits to the device.

I wonder whether we need to accommodate legacy drivers doing both that
_and_ setting up virtqueues between using the device for the first time
and setting DRIVER_OK? Just using the logic of "if there were no rings
setup when we first try to start aio, ignore that queue until reset"
would cover all but those very odd drivers, and I highly doubt anybody
cares about such broken setups.
