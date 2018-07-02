Received: from eggs.gnu.org ([2001:4830:134:3::10]:35654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fa8Xc-0008BC-Vp
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 19:47:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fa8Xb-0006iN-N5
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 19:47:33 -0400
From: John Snow <jsnow@redhat.com>
Message-ID: <3a5a035f-5997-b87f-0dde-c69fdcabee0f@redhat.com>
Date: Mon, 2 Jul 2018 19:47:24 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] 2018-07-02 Incremental Backup Status Report
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu-block <qemu-block@nongnu.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "Denis V. Lunev" <den@openvz.org>, Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>

I'm tracking the following series for Incremental Backup right now; if
it's not on this list, I don't know about it:

[Qemu-devel] [PATCH v4 0/2] block: formalize and test fleecing=E2=80=8B
[Qemu-devel] [PATCH v2 0/3] image fleecing
[Qemu-devel] [PATCH] migration: Appease coverity, skip empty block trees
[Qemu-devel] [PATCH v2 0/2] test NBD bitmap export
[Qemu-devel] [PATCH 0/6] fix persistent bitmaps migration logic=E2=80=8B
[Qemu-devel] [PATCH 0/2] dirty bitmap fixes=E2=80=8B
[Qemu-devel] [PATCH v2] qcow2: add overlap check for bitmap directory
[Qemu-devel] [PATCH 0/1] blockdev: implement n-ary bitmap merge
[Qemu-devel] [PATCH v2 00/10] qemu-img: add bitmap info output=E2=80=8B


Now, in a little more detail below;


# Image fleecing:

In order to support pull-model semantics for incremental backup, we need
working point in time NBD export of live disk images. This was thought
supported/finished for quite some time, but we've had no iotests.

There are two series in flight here:

- [Qemu-devel] [PATCH v4 0/2] block: formalize and test fleecing=E2=80=8B
- [Qemu-devel] [PATCH v2 0/3] image fleecing

The first listed there simply loosens restrictions on blockdev-backup
and adds an iotest that this approach works in the simple case.

The second series adds a fleecing filter to combat deficiencies in the
IO serialization that may allow the fleecing node to sometimes see new,
live data instead of the PIT data. See
https://lists.gnu.org/archive/html/qemu-devel/2018-07/msg00150.html for
details.

Our current plan is to merge the first series and to continue looking
into the fleecing filter during freeze as a potential bugfix.


# NBD:

- [Qemu-devel] [PATCH v2 0/2] test NBD bitmap export

Eric's series that adds a quick hack to our NBD client and an iotest 223
that demos that the bitmap support in our NBD server is working
correctly. Notably, we don't have an iotest that combines this with the
image fleecing workflow, so there's discussion there that I've started
for how to combine the two, comments appreciated:
https://lists.gnu.org/archive/html/qemu-devel/2018-07/msg00476.html


# Migration/Persistence:

- [Qemu-devel] [PATCH 0/6] fix persistent bitmaps migration logic=E2=80=8B

Needs review, but can go in after freeze as a fix.


# Bitmap manipulation:

- [Qemu-devel] [PATCH 0/1] blockdev: implement n-ary bitmap merge=E2=80=8B

Possibly important to have if we wish to add merge into transactions, as
this will greatly simplify the commands needed to be issued to QEMU. Not
yet reviewed, but I might submit a PR for this tomorrow in anticipation
of its usefulness over the 1-bitmap version.

- [Qemu-devel] [PATCH v2 00/10] qemu-img: add bitmap info output=E2=80=8B

On hold until persistence is settled, due to interactions with
attempting to cache the bitmap metadata. "offline" bitmap manipulation
will need to occur via QMP on QEMU with no running guest in the
meantime. We will still need a patch for `qemu-img check -r` that allows
us to delete corrupted bitmaps, however. That can be a bugfix for 3.0.

There is a follow-up series that's also on hold because it's blocked on
this series, that adds the actual add/delete/clear offline functionality.


# Miscellaneous:

- [Qemu-devel] [PATCH] migration: Appease coverity, skip empty block tree=
s

Needs a respin based on Stefan's feedback. Only important so that it
doesn't keep annoying Peter Maydell, does not actually fix a bug.

- [Qemu-devel] [PATCH 0/2] dirty bitmap fixes=E2=80=8B

Staged: https://github.com/jnsnow/qemu/commits/bitmaps

- [Qemu-devel] [PATCH v2] qcow2: add overlap check for bitmap directory

Needs a V3 after review from Max. Not crucial for release, but nice to ha=
ve.




So in order to put together a demo from QEMU's point-of-view that both
push and pull model are working, I think we still need:

- iotest 222 and 223 merged, with their respective enablement patches.
- A new iotest (224?) that combines functionality of both; which makes
use of perhaps some new features that allow us to tie bitmap
manipulation to the start of the node fleecing.
- All of the various bugfixes above reviewed and merged.



Please let me know if this roadmap is missing anything.

Thanks,
--js
