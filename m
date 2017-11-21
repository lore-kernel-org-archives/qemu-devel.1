Received: from eggs.gnu.org ([2001:4830:134:3::10]:55226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eHCGs-0008Ch-GF
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 12:23:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eHCGp-0004ls-7S
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 12:23:42 -0500
Date: Tue, 21 Nov 2017 18:23:24 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171121172324.GC11073@localhost.localdomain>
References: <20171113162053.58795-1-vsementsov@virtuozzo.com>
	<01108daa-fed3-c142-bbd6-0ecc4c8b795d@redhat.com>
	<cd0a2e5e-f788-0e5a-dec7-f428479f3b89@virtuozzo.com>
	<8c61f43c-5f56-8c1b-a2fe-f954d34dc687@redhat.com>
	<40392ab9-ec2a-30ed-ddab-a557682a4192@virtuozzo.com>
	<4e4e28d7-aebc-4a86-e691-99afdcca27f5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <4e4e28d7-aebc-4a86-e691-99afdcca27f5@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.12 0/4] qmp dirty bitmap API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, famz@redhat.com, armbru@redhat.com, mnestratov@virtuozzo.com, mreitz@redhat.com, nshirokovskiy@virtuozzo.com, stefanha@redhat.com, den@openvz.org, pbonzini@redhat.com

Am 17.11.2017 um 22:35 hat John Snow geschrieben:
> >>> usage is like this:
> >>>
> >>> 1. we have dirty bitmap bitmap0 for incremental backup.
> >>>
> >>> 2. prepare image fleecing (create temporary image with backing=3Dou=
r_disk)
> >>> 3. in qmp transaction:
> >>> =A0=A0=A0 - disable bitmap0
> >>> =A0=A0=A0 - create bitmap1
> >>> =A0=A0=A0 - start image fleecing (backup sync=3Dnone our_disk -> te=
mp_disk)
> >> This could probably just be its own command, though:
> >>
> >> block-job-fleece node=3Dfoobar bitmap=3Dbitmap0 etc=3Detera etc=3Det=
era
> >>
> >> Could handle forking the bitmap. I'm not sure what the arguments wou=
ld
> >> look like, but we could name the NBD export here, too. (Assuming the
> >> server is already started and we just need to create the share.)
> >>
> >> Then, we can basically do what mirror does:
> >>
> >> (1) Cancel
> >> (2) Complete
> >>
> >> Cancel would instruct QEMU to keep the bitmap changes (i.e. roll bac=
k),
> >> and Complete would instruct QEMU to discard the changes.
> >>
> >> This way we don't need to expose commands like split or merge that w=
ill
> >> almost always be dangerous to use over QMP.
> >>
> >> In fact, a fleecing job would be really convenient even without a
> >> bitmap, because it'd still be nice to have a convenience command for=
 it.
> >> Using an existing infrastructure and understood paradigm is just a b=
onus.
> >=20
> > 1. If I understand correctly, Kevin and Max said in their report in
> > Prague about new block-job approach,
> > =A0 using filter nodes, so I'm not sure that this is a good Idea to
> > introduce now new old-style block-job, where we can
> > =A0 do without it.
>=20
> We could do without it, but it might be a lot better to have everything
> wrapped up in a command that's easy to digest instead of releasing 10
> smaller commands that have to be executed in a very specific way in
> order to work correctly.
>=20
> I'm thinking about the complexity of error checking here with all the
> smaller commands, versus error checking on a larger workflow we
> understand and can quality test better.
>=20
> I'm not sure that filter nodes becoming the new normal for block jobs
> precludes our ability to use the job-management API as a handle for
> managing the lifetime of a long-running task like fleecing, but I'll
> check with Max and Kevin about this.

We have a general tendency at least in the block layer, but in fact I
think in qemu in general, to switch from exposing high-level
functionality to exposing lower-level operations via QAPI.

If we expose high-level commands, then every new use case will require a
change in both qemu and libvirt. With low-level commands, often libvirt
already has all of the required tools to implement what it needs.

So I do see good reasons for exposing low-level commands.


On another note, I would double check before adding a new block job type
that this is the right way to go. We have recently noticed that many, if
not all, of the existing block jobs (at least mirror, commit and backup)
are so similar that they implement the same things multiple times and
are just lacking different options and have different bugs. I'm
seriously considering merging all of them into a single job type
internally that just provides options that effectively turn it into one
of the existing job types.

So even if we want to tie the bitmap management to a block job, we
should consider adding it as an option to the existing backup job rather
than adding a completely new fourth job type that again does almost the
same except for some bitmap mangement stuff on completion.

Kevin
