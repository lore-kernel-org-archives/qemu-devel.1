Received: from eggs.gnu.org ([2001:4830:134:3::10]:58010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fcfck-0003Sg-TW
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 19:31:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fcfcj-0007Af-9l
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 19:31:18 -0400
From: John Snow <jsnow@redhat.com>
References: <3a5a035f-5997-b87f-0dde-c69fdcabee0f@redhat.com>
Message-ID: <1353f0a8-1837-7502-83b1-27c2573906e5@redhat.com>
Date: Mon, 9 Jul 2018 19:31:11 -0400
MIME-Version: 1.0
In-Reply-To: <3a5a035f-5997-b87f-0dde-c69fdcabee0f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [Qemu-block] 2018-07-09 Incremental Backup Status
 Report
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu-block <qemu-block@nongnu.org>
Cc: "Denis V. Lunev" <den@openvz.org>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel <qemu-devel@nongnu.org>, Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>



On 07/02/2018 07:47 PM, John Snow wrote:
> I'm tracking the following series for Incremental Backup right now; if
> it's not on this list, I don't know about it:
>=20
> [Qemu-devel] [PATCH v4 0/2] block: formalize and test fleecing=E2=80=8B

Merged.

> [Qemu-devel] [PATCH v2 0/3] image fleecing

Dropped in favor of the above, but we've then added:

[Qemu-devel] [PATCH v5 0/4] fix image fleecing

Which should have the same effect as preventing race conditions between
serializations that exist across two nodes.

> [Qemu-devel] [PATCH] migration: Appease coverity, skip empty block tree=
s

I need to spin a v2.

> [Qemu-devel] [PATCH v2 0/2] test NBD bitmap export

Merged.

> [Qemu-devel] [PATCH 0/6] fix persistent bitmaps migration logic=E2=80=8B

Needs review.

> [Qemu-devel] [PATCH 0/2] dirty bitmap fixes=E2=80=8B

Merged.

> [Qemu-devel] [PATCH v2] qcow2: add overlap check for bitmap directory

Merged.

> [Qemu-devel] [PATCH 0/1] blockdev: implement n-ary bitmap merge

Needs review; it's not essential but I suspect it's likely nice to have
for libvirt.

> [Qemu-devel] [PATCH v2 00/10] qemu-img: add bitmap info output=E2=80=8B
>=20

On hold pending "fix persistent bitmaps migration logic."


New series:
- [PATCH v2 0/4] transaction support for bitmap merge



New status list looks like this, then:

[Qemu-devel] [PATCH] migration: Appease coverity, skip empty block trees
[Qemu-devel] [PATCH v5 0/4] fix image fleecing
[Qemu-devel] [PATCH 0/6] fix persistent bitmaps migration logic=E2=80=8B
[Qemu-devel] [PATCH 0/1] blockdev: implement n-ary bitmap merge
[Qemu-devel] [PATCH v2 00/10] qemu-img: add bitmap info output=E2=80=8B
[Qemu-devel] [PATCH v2 0/4] transaction support for bitmap merge

I'll be looking at #3, #6 and #1 tomorrow.

Thanks,
--js


>=20
> Now, in a little more detail below;
>=20
>=20
> # Image fleecing:
>=20
> In order to support pull-model semantics for incremental backup, we nee=
d
> working point in time NBD export of live disk images. This was thought
> supported/finished for quite some time, but we've had no iotests.
>=20
> There are two series in flight here:
>=20
> - [Qemu-devel] [PATCH v4 0/2] block: formalize and test fleecing=E2=80=8B
> - [Qemu-devel] [PATCH v2 0/3] image fleecing
>=20
> The first listed there simply loosens restrictions on blockdev-backup
> and adds an iotest that this approach works in the simple case.
>=20
> The second series adds a fleecing filter to combat deficiencies in the
> IO serialization that may allow the fleecing node to sometimes see new,
> live data instead of the PIT data. See
> https://lists.gnu.org/archive/html/qemu-devel/2018-07/msg00150.html for
> details.
>=20
> Our current plan is to merge the first series and to continue looking
> into the fleecing filter during freeze as a potential bugfix.
>=20
>=20
> # NBD:
>=20
> - [Qemu-devel] [PATCH v2 0/2] test NBD bitmap export
>=20
> Eric's series that adds a quick hack to our NBD client and an iotest 22=
3
> that demos that the bitmap support in our NBD server is working
> correctly. Notably, we don't have an iotest that combines this with the
> image fleecing workflow, so there's discussion there that I've started
> for how to combine the two, comments appreciated:
> https://lists.gnu.org/archive/html/qemu-devel/2018-07/msg00476.html
>=20
>=20
> # Migration/Persistence:
>=20
> - [Qemu-devel] [PATCH 0/6] fix persistent bitmaps migration logic=E2=80=
=8B
>=20
> Needs review, but can go in after freeze as a fix.
>=20
>=20
> # Bitmap manipulation:
>=20
> - [Qemu-devel] [PATCH 0/1] blockdev: implement n-ary bitmap merge=E2=80=
=8B
>=20
> Possibly important to have if we wish to add merge into transactions, a=
s
> this will greatly simplify the commands needed to be issued to QEMU. No=
t
> yet reviewed, but I might submit a PR for this tomorrow in anticipation
> of its usefulness over the 1-bitmap version.
>=20
> - [Qemu-devel] [PATCH v2 00/10] qemu-img: add bitmap info output=E2=80=8B
>=20
> On hold until persistence is settled, due to interactions with
> attempting to cache the bitmap metadata. "offline" bitmap manipulation
> will need to occur via QMP on QEMU with no running guest in the
> meantime. We will still need a patch for `qemu-img check -r` that allow=
s
> us to delete corrupted bitmaps, however. That can be a bugfix for 3.0.
>=20
> There is a follow-up series that's also on hold because it's blocked on
> this series, that adds the actual add/delete/clear offline functionalit=
y.
>=20
>=20
> # Miscellaneous:
>=20
> - [Qemu-devel] [PATCH] migration: Appease coverity, skip empty block tr=
ees
>=20
> Needs a respin based on Stefan's feedback. Only important so that it
> doesn't keep annoying Peter Maydell, does not actually fix a bug.
>=20
> - [Qemu-devel] [PATCH 0/2] dirty bitmap fixes=E2=80=8B
>=20
> Staged: https://github.com/jnsnow/qemu/commits/bitmaps
>=20
> - [Qemu-devel] [PATCH v2] qcow2: add overlap check for bitmap directory
>=20
> Needs a V3 after review from Max. Not crucial for release, but nice to =
have.
>=20
>=20
>=20
>=20
> So in order to put together a demo from QEMU's point-of-view that both
> push and pull model are working, I think we still need:
>=20
> - iotest 222 and 223 merged, with their respective enablement patches.
> - A new iotest (224?) that combines functionality of both; which makes
> use of perhaps some new features that allow us to tie bitmap
> manipulation to the start of the node fleecing.
> - All of the various bugfixes above reviewed and merged.
>=20
>=20
>=20
> Please let me know if this roadmap is missing anything.
>=20
> Thanks,
> --js
>=20
