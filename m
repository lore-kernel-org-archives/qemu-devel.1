Received: from eggs.gnu.org ([2001:4830:134:3::10]:41050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eJI9j-00049L-5W
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 07:05:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eJI9d-0000kH-8A
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 07:04:59 -0500
Date: Mon, 27 Nov 2017 13:04:28 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171127120428.GD4903@localhost.localdomain>
References: <20171113162053.58795-1-vsementsov@virtuozzo.com>
	<01108daa-fed3-c142-bbd6-0ecc4c8b795d@redhat.com>
	<cd0a2e5e-f788-0e5a-dec7-f428479f3b89@virtuozzo.com>
	<8c61f43c-5f56-8c1b-a2fe-f954d34dc687@redhat.com>
	<ef42121a-fe94-adef-2bda-7c5db14de0c7@openvz.org>
	<eafb7aee-d378-420e-6405-1a863b317723@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <eafb7aee-d378-420e-6405-1a863b317723@virtuozzo.com>
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
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: "Denis V. Lunev" <den@openvz.org>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, famz@redhat.com, armbru@redhat.com, mnestratov@virtuozzo.com, mreitz@redhat.com, nshirokovskiy@virtuozzo.com, stefanha@redhat.com, pbonzini@redhat.com

Am 24.11.2017 um 16:01 hat Vladimir Sementsov-Ogievskiy geschrieben:
> John, Kevin, do we reach a consensus? Can we go on with this?

I don't know the details of this, so I can't really offer a strong
opinion. I gave a high-level perspective of what we're doing in other
places and that's all I was planning to contribute at the moment. So I'm
deferring this to John.

If you guys can't find a decision or are uncertain about the approach,
please let me know and I can try to find the time to actually get into
the details and provide some more in-depth feedback.

Kevin

> 20.11.2017 19:00, Denis V. Lunev wrote:
> > On 11/17/2017 06:10 AM, John Snow wrote:
> > > On 11/16/2017 03:17 AM, Vladimir Sementsov-Ogievskiy wrote:
> > > > 16.11.2017 00:20, John Snow wrote:
> > > > > On 11/13/2017 11:20 AM, Vladimir Sementsov-Ogievskiy wrote:
> > > > > > Hi all.
> > > > > >=20
> > > > > > There are three qmp commands, needed to implement external ba=
ckup API.
> > > > > >=20
> > > > > > Using these three commands, client may do all needed bitmap
> > > > > > management by
> > > > > > hand:
> > > > > >=20
> > > > > > on backup start we need to do a transaction:
> > > > > >  =A0 {disable old bitmap, create new bitmap}
> > > > > >=20
> > > > > > on backup success:
> > > > > >  =A0 drop old bitmap
> > > > > >=20
> > > > > > on backup fail:
> > > > > >  =A0 enable old bitmap
> > > > > >  =A0 merge new bitmap to old bitmap
> > > > > >  =A0 drop new bitmap
> > > > > >=20
> > > > > Can you give me an example of how you expect these commands to =
be used,
> > > > > and why they're required?
> > > > >=20
> > > > > I'm a little weary about how error-prone these commands might b=
e and the
> > > > > potential for incorrect usage seems... high. Why do we require =
them?
> > > > It is needed for incremental backup. It looks like bad idea to ex=
port
> > > > abdicate/reclaim functionality, it is simpler
> > > > and clearer to allow user to merge/enable/disable bitmaps by hand=
.
> > > >=20
> > > > usage is like this:
> > > >=20
> > > > 1. we have dirty bitmap bitmap0 for incremental backup.
> > > >=20
> > > > 2. prepare image fleecing (create temporary image with backing=3D=
our_disk)
> > > > 3. in qmp transaction:
> > > >  =A0=A0=A0 - disable bitmap0
> > > >  =A0=A0=A0 - create bitmap1
> > > >  =A0=A0=A0 - start image fleecing (backup sync=3Dnone our_disk ->=
 temp_disk)
> > > This could probably just be its own command, though:
> > >=20
> > > block-job-fleece node=3Dfoobar bitmap=3Dbitmap0 etc=3Detera etc=3De=
tera
> > >=20
> > > Could handle forking the bitmap. I'm not sure what the arguments wo=
uld
> > > look like, but we could name the NBD export here, too. (Assuming th=
e
> > > server is already started and we just need to create the share.)
> > >=20
> > > Then, we can basically do what mirror does:
> > >=20
> > > (1) Cancel
> > > (2) Complete
> > >=20
> > > Cancel would instruct QEMU to keep the bitmap changes (i.e. roll ba=
ck),
> > > and Complete would instruct QEMU to discard the changes.
> > >=20
> > > This way we don't need to expose commands like split or merge that =
will
> > > almost always be dangerous to use over QMP.
> > >=20
> > > In fact, a fleecing job would be really convenient even without a
> > > bitmap, because it'd still be nice to have a convenience command fo=
r it.
> > > Using an existing infrastructure and understood paradigm is just a =
bonus.
> > >=20
> > actually this is a very good question about safety/simplicity...
> >=20
> > We actually have spent a bit of time on design and have not
> > come to a good solution. Yes, technically for now we can put
> > all into fleecing command and rely on its semantics. Though
> > I am not convinced with that approach. We can think that this
> > can be reused on snapshot operations (may be, may be not).
> > Also technically there are other cases.
> >=20
> > This is actually a matter that QEMU should provide low level
> > API while management software should make decisions.
> > Providing merge etc operations is done using exactly that
> > approach. We can also consider this in a similar way we have
> > recently fixed "revert to snapshot" operation. Management
> > can make and should make a decision.
> >=20
> > Den
> >=20
>=20
>=20
> --=20
> Best regards,
> Vladimir
>=20
