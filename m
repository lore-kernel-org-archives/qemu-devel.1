Received: from eggs.gnu.org ([2001:4830:134:3::10]:35984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cil3B-0004es-5J
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:54:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cil36-0003Yj-Ey
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:54:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57234)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cil36-0003YS-8m
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:54:52 -0500
Date: Tue, 28 Feb 2017 16:54:46 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170228165445.GG2773@work-vm>
References: <20170220185020.774-1-dgilbert@redhat.com>
	<20170220185020.774-5-dgilbert@redhat.com>
	<8760k3od2r.fsf@emacs.mitica> <20170223105155.GA2383@work-vm>
	<20170223110433.GL10047@redhat.com> <20170223114045.GB2383@work-vm>
	<20170226203427.6xjmuvt6okc356e5@var.youpi.perso.aquilenet.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170226203427.6xjmuvt6okc356e5@var.youpi.perso.aquilenet.fr>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 4/5] slirp: VMStatify socket level
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, jan.kiszka@siemens.com, maethor@subiron.org

* Samuel Thibault (samuel.thibault@gnu.org) wrote:
> Hello,
>=20
> Dr. David Alan Gilbert, on jeu. 23 f=E9vr. 2017 11:40:45 +0000, wrote:
> > * Daniel P. Berrange (berrange@redhat.com) wrote:
> > > IOW if we transmit this data on the wire, we've effectively said th=
at
> > > our migration data format is *not* portable across different host O=
S
> > > platforms. At that point, sending different sized types on BSD vs
> > > Linux is no big deal since we're already incompatible semantically.
> >=20
> > This is a relatively recent error; it comes from eae303ff which added
> > ss_family to allow IPv6.
> >=20
> > I suspect the right fix here is to populate a temporary for ss_family
> > on the wire; if we make it conveniently match Linux's AF_INET6 values
> > it might work.
>=20
> So this issue is actually not new, so I asked to pull your patch series=
,
> thanks!

It is because the old non-vmstate code just truncated the value read,
where as the VMSTATE macros have strong type checks.

> Now we should indeed fix the issue. Making the values match Linux'
> AF_INET6, why not (better have some known values than arbitrary values)=
,
> but I don't think we'd want to rely on this: we'll have to introduce a
> versioned difference, since we'll want to change the size of the field
> as well as its value on other OSes (and I don't think we want to manage
> different versioning on different OSes).

> Ah, no, sorry, it was forced to be 16bit, so at least the size is fine.
>=20
> But I guess we don't want to change the values to have cross-OS
> compatibility without changing the version.

I'm thinking one way to do it without changing the version would
be to use the existing value for IPv4, and on reading allow any other
value for IPv6 (or just the ones we know about); that would make
it inwards migration compatible.  For writing we pick one for IPv6
and stick to it.

Dave

>=20
> Samuel
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
