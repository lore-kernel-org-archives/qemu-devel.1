Received: from eggs.gnu.org ([2001:4830:134:3::10]:48059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f0pYK-0004mr-GS
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:26:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f0pYH-0003j4-7o
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:26:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60390 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1f0pYH-0003iy-2Z
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:26:17 -0400
Date: Tue, 27 Mar 2018 15:26:13 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180327142610.GC2837@work-vm>
References: <20180327113452.19613-1-dgilbert@redhat.com>
	<0cb312f6-6c36-25ac-3c9a-0d9626abac56@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0cb312f6-6c36-25ac-3c9a-0d9626abac56@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] e1000 migration changes for 2.12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, eswierk@skyportsystems.com, quintela@redhat.com, peterx@redhat.com

* Jason Wang (jasowang@redhat.com) wrote:
>=20
>=20
> On 2018=E5=B9=B403=E6=9C=8827=E6=97=A5 19:34, Dr. David Alan Gilbert (g=
it) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >=20
> > Hi Ed, Jason,
> >    This set of patches change the e1000 migration code to make
> > it easier to keep with compatibility with older versions in backwards
> > migration;  but I do need some advice whether I need to do more as we=
ll.
> >=20
> > I think the first and second patch are fairly uncontrovercial and I
> > would like them for 2.12, since it'll make any future changes easier.
> > The third one changes the default behaviour, so again I'd prefer it b=
ut
> > lets see what you think.
>=20
> The patches looks good to me. So for the changes of default behavior, d=
id
> you mean we can make the migration to older versions work?

Right.

> > My question however, without knowing the internals of the e1000, is
> > whether when ommitting the subsection, should the code in 2.12 be
> > changing the data it sends back in the main section of data?
>=20
> I'm not sure I get the meaning here. But it looks to me turning it off =
for
> old machine types makes sense, otherwise, management need to set it
> explicitly.

OK, let me expand the question a bit.
If I understand correctly the d6244b description, there's two pieces of
state (TSO and non-TSO) where there used to be only one.
Now, with the new format we migrate both pieces of state, but lets think
about what happens if we have to migrate only one piece.

a) 2.11->2.11 migrated the only piece it knew about; so I guess the only
problem was really the UDP corruption mentioned in the commit.

b) 2.11->2.12 - it receives the wrongly merged piece of state and puts it
in - well which of the two states does it load it into?  What's the
effect of that?

c) 2.12(+my mod)->2.11 ok, so 2.12 will have filled in both sets of state
internally; but now it's only going to send one of them over to 2.11 -
which one gets sent to 2.11? Is it the one that 2.11 is expecting?

d) 2.12(+my mod)->2.12(+my mod) with an old machine type, again we're onl=
y
going to send one set of data (same as c) - but what's 2.12 going to
make of the one piece of state received?

(b) is an existing question.

Dave

> Thanks
>=20
> >=20
> > Dave
> >=20
> >=20
> > Dr. David Alan Gilbert (3):
> >    e1000: Convert v3 fields to subsection
> >    e1000: wire new subsection to property
> >    e1000: Old machine types, turn new subsection off
> >=20
> >   hw/net/e1000.c      | 46 ++++++++++++++++++++++++++++++++++--------=
----
> >   include/hw/compat.h |  4 ++++
> >   2 files changed, 38 insertions(+), 12 deletions(-)
> >=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
