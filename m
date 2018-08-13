Received: from eggs.gnu.org ([2001:4830:134:3::10]:41518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fpFkD-0007kt-1T
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 12:31:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fpFkB-0006E7-LK
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 12:31:01 -0400
Date: Mon, 13 Aug 2018 18:30:48 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180813163048.GO4323@localhost.localdomain>
References: <20180629124052.331406-1-dplotnikov@virtuozzo.com>
	<4eca96cf-5520-fb82-2e23-afff3ba35077@virtuozzo.com>
	<c6f924f2-b70d-a460-f96c-7d40b9d06e22@redhat.com>
	<7da20590-58d7-4ef0-92b9-fcb955f28c9b@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <7da20590-58d7-4ef0-92b9-fcb955f28c9b@virtuozzo.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block]  [PATCH v0 0/2] Postponed actions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Cc: John Snow <jsnow@redhat.com>, mreitz@redhat.com, stefanha@redhat.com, famz@redhat.com, qemu-stable@nongnu.org, qemu-devel@nongnu.org, qemu-block@nongnu.org

Am 13.08.2018 um 10:32 hat Denis Plotnikov geschrieben:
> Ping ping!
>=20
> On 16.07.2018 21:59, John Snow wrote:
> >=20
> >=20
> > On 07/16/2018 11:01 AM, Denis Plotnikov wrote:
> > > Ping!
> > >=20
> >=20
> > I never saw a reply to Stefan's question on July 2nd, did you reply
> > off-list?
> >=20
> > --js
> Yes, I did. I talked to Stefan why the patch set appeared.

The rest of us still don't know the answer. I had the same question.

Kevin

> > > On 29.06.2018 15:40, Denis Plotnikov wrote:
> > > > There are cases when a request to a block driver state shouldn't =
have
> > > > appeared producing dangerous race conditions.
> > > > This misbehaviour is usually happens with storage devices emulate=
d
> > > > without eventfd for guest to host notifications like IDE.
> > > >=20
> > > > The issue arises when the context is in the "drained" section
> > > > and doesn't expect the request to come, but request comes from th=
e
> > > > device not using iothread and which context is processed by the m=
ain
> > > > loop.
> > > >=20
> > > > The main loop apart of the iothread event loop isn't blocked by t=
he
> > > > "drained" section.
> > > > The request coming and processing while in "drained" section can =
spoil
> > > > the
> > > > block driver state consistency.
> > > >=20
> > > > This behavior can be observed in the following KVM-based case:
> > > >=20
> > > > 1. Setup a VM with an IDE disk.
> > > > 2. Inside a VM start a disk writing load for the IDE device
> > > >  =A0=A0 e.g: dd if=3D<file> of=3D<file> bs=3DX count=3DY oflag=3D=
direct
> > > > 3. On the host create a mirroring block job for the IDE device
> > > >  =A0=A0 e.g: drive_mirror <your_IDE> <your_path>
> > > > 4. On the host finish the block job
> > > >  =A0=A0 e.g: block_job_complete <your_IDE>
> > > >  =A0 Having done the 4th action, you could get an assert:
> > > > assert(QLIST_EMPTY(&bs->tracked_requests)) from mirror_run.
> > > > On my setup, the assert is 1/3 reproducible.
> > > >=20
> > > > The patch series introduces the mechanism to postpone the request=
s
> > > > until the BDS leaves "drained" section for the devices not using
> > > > iothreads.
> > > > Also, it modifies the asynchronous block backend infrastructure t=
o use
> > > > that mechanism to release the assert bug for IDE devices.
> > > >=20
> > > > Denis Plotnikov (2):
> > > >  =A0=A0 async: add infrastructure for postponed actions
> > > >  =A0=A0 block: postpone the coroutine executing if the BDS's is d=
rained
> > > >=20
> > > >  =A0 block/block-backend.c | 58 ++++++++++++++++++++++++++++++---=
------
> > > >  =A0 include/block/aio.h=A0=A0 | 63 +++++++++++++++++++++++++++++=
++++++++++++++
> > > >  =A0 util/async.c=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 33 +++++++++++++++=
++++++++
> > > >  =A0 3 files changed, 142 insertions(+), 12 deletions(-)
> > > >=20
> > >=20
>=20
> --=20
> Best,
> Denis
