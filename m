Received: from eggs.gnu.org ([2001:4830:134:3::10]:49576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ejo12-0002IF-VM
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 10:21:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ejo0y-0005rn-TD
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 10:21:36 -0500
Date: Thu, 8 Feb 2018 16:21:26 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180208162126.3426623b.cohuck@redhat.com>
In-Reply-To: <20180208090904.5a9c88df@redhat.com>
References: <1518083288-20410-1-git-send-email-mihajlov@linux.vnet.ibm.com>
	<20180208090904.5a9c88df@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] S390: Expose s390-specific CPU info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luiz Capitulino <lcapitulino@redhat.com>
Cc: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org

On Thu, 8 Feb 2018 09:09:04 -0500
Luiz Capitulino <lcapitulino@redhat.com> wrote:

> On Thu,  8 Feb 2018 10:48:08 +0100
> Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com> wrote:
>=20
> > Presently s390x is the only architecture not exposing specific
> > CPU information via QMP query-cpus. Upstream discussion has shown
> > that it could make sense to report the architecture specific CPU
> > state, e.g. to detect that a CPU has been stopped. =20
>=20
> I'd very strongly advise against extending query-cpus. Note that the
> latency problems with query-cpus exists in all archs, it's just a
> matter of time for it to pop up for s390 use-cases too.
>=20
> I think there's three options for this change:
>=20
>  1. If this doesn't require interrupting vCPU threads, then you
>     could rebase this on top of query-cpus-fast

=46rom my perspective, rebasing on top of query-cpus-fast looks like a
good idea. This would imply that we need architecture-specific fields
for the new interface as well, though.

>=20
>  2. If you plan to keep adding s390 state/registers to QMP commands,
>     then you could consider adding a query-s390-cpu-state or add
>     a query-cpu-state command that accepts the arch name as a parameter

Personally, I don't see a need for more fields. But maybe I'm just
unimaginative.

>=20
>  3. If you end up needing to expose state that actually needs an
>     ioctl, then we should consider porting info registers to QMP
>=20
> >=20
> > With this change the output of query-cpus will look like this on
> > s390:
> >=20
> >     [{"arch": "s390", "current": true,
> >       "props": {"core-id": 0}, "cpu_state": "operating", "CPU": 0,
> >       "qom_path": "/machine/unattached/device[0]",
> >       "halted": false, "thread_id": 63115},
> >      {"arch": "s390", "current": false,
> >       "props": {"core-id": 1}, "cpu_state": "stopped", "CPU": 1,
> >       "qom_path": "/machine/unattached/device[1]",
> >       "halted": true, "thread_id": 63116}]
> >=20
> > Signed-off-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
