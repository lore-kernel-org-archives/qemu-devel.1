Received: from eggs.gnu.org ([2001:4830:134:3::10]:48336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ePt02-0003ss-1s
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:38:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ePszz-0000FZ-Ko
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:38:14 -0500
From: Max Reitz <mreitz@redhat.com>
Message-ID: <2cd24073-b6d9-6479-59b1-869db6c25103@redhat.com>
Date: Fri, 15 Dec 2017 17:38:00 +0100
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="njaiMA3KSNI40kMusQwrnEX1HBfvXJ7MH"
Subject: [Qemu-devel] Raw notes from a small block layer/QAPI/something
 pre-christmas meeting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu-block <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--njaiMA3KSNI40kMusQwrnEX1HBfvXJ7MH
From: Max Reitz <mreitz@redhat.com>
To: Qemu-block <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Message-ID: <2cd24073-b6d9-6479-59b1-869db6c25103@redhat.com>
Subject: Raw notes from a small block layer/QAPI/something pre-christmas
 meeting
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi everyone,

Kevin, Markus, and me had a small personal meeting over the last 1.5
days and discussed a couple of things about the block layer and its QAPI
entanglements.

Here's a rather rough sketch on what we talked about:


=3D=3D Quorum is broken =3D=3D

a) x-blockdev-change is broken.  When adding a new block device, you
   should always set a child name.  This cannot or at least should not
   be inferred automagically.

   Also, adding is just a special case of replacing: If there is no such
   child yet, it will just be added.

   So the new interface could look like this:
       x-blockdev-change(parent, child, node)
   Where nothing is optional, @parent is the node name of the parent,
   @child is the BdrvChild name of the edge to be changed (if it does
   not exist yet, it will be created), and @node is the node name of the
   child (null if the edge is to be removed).

   Note: (b) will say that x-blockdev-change can be replaced by a
   QMP-bdrv_reopen() anyway, so we should probably do so.

b) Quorum child list is pretty much broken right now; since it always
   tries to keep the list continuous from front to back, child names can
   change at any point and you don't have a say in how it's ordered.
   (And probably more things.)
   Needed:
   - Fixed child names for quorum
   - Way to reorder the children

   Ideally, the path to the child's BlockdevRef should be equivalent to
   the child's name (like it is now with "children.0" etc.).  There are
   at least three ways to achieve this (suggestions welcome):
   (Note from the next day: This may be obsolete.[1])
   - Put the child options either directly into the Quorum node's
     options (like it is done for all other block drivers) or in a dict
     under e.g. a "children" key.  This would probably require new QAPI
     infrastructure as we would want to be able to specify an arbitrary
     number of BlockdevRefs with arbitrary keys inside of
     BlockdevOptionsQuorum (or BlockdevOptionsQuorum.children).
     Also, Dicts generally do not have an order, so we would have to add
     a list to BlockdevOptionsQuorum that specifies the child order (by
     child name).

   - Same as the last, but introduce ordered Dicts and ditch the
     explicit ordering list.

   - Keep the current way, but do not keep the children list continuous
     at all cost.  Instead, whenever a child is deleted, replace it by
     QNull.

   The last would require the least QAPI work and the least
   modifications to Quorum (especially its interface) and may thus be
   what we want to do.

   In any case, if you want to change Quorum children and change their
   ordering at the same time, we would need a transaction of
   x-blockdev-change and bdrv_reopen.  Since x-blockdev-change is
   basically a special case of bdrv_reopen, we probably just want
   bdrv_reopen over QMP instead.

   [1] If we implement this through bdrv_reopen anyway, there is no need
       for any of the things mentioned above.  We can keep the current
       list and if you want to add or remove children, you just have to
       specify it from scratch, thus the user knows the new child names
       and they don't change implicitly.

   Other advantages of bdrv_reopen:
   - Allows you to keep state of nodes (instead of creating a new node
     and replacing the old one by the new one)
   - Is already a transaction

Most important conclusion: We should think very hard before removing the
x- before x-blockdev-change.  We probably don't want it at all.  It
breaks quorum in its current state (by implicitly changing its
children's names), and we want bdrv_reopen over it.


=3D=3D Automatically inserted filter nodes (includes stream/COR) =3D=3D

- backing_bs() should automatically skip all filter nodes; except when
  it should not (e.g. bdrv_query_info(): There we only want to skip
  implicitly created nodes).
  - We probably need different functions for different cases: Sometimes
    we want the actual backing child, filter or not; at other times, we
    want to skip implicitly created nodes (for legacy commands); and
    sometimes, we even want to skip all filter nodes (e.g. for the
    commit block job).
    For skipping nodes, we probably need some infrastructure so that
    each node can actually say what its filtered node is instead of
    trying to guess it generally.
    (Also, maybe the commit block job does not want to just skip all
     nodes; say there is a throttling node in the chain, then it will
     not have any effect on writing to the base, which may not be
     intuitively correct (at least).  We could make this an error and
     require the user to reinstate all filter nodes outside of the
     commit chain before we do the commit; or we simply implement
     blockdev-copy (see below) where it is clear that writing to the
     target will not go through any backing chain.)

- Stream node: Basically the same as a COR node, just with more
  functionality -- either add a stream_top node that can do generic COR
  ("sync=3Dnone"), or add a COR node that can do everything stream should=

  be able to do, or make both effectively the same driver but call them
  differently still (just in the interface) so that the stream driver
  can later be extended if so desired.
  - We need a COR node anyway, but just as with trottling, we will have
    to keep the current code around for -drive (until we either kill
    -drive or implement the -drive option with an automatically inserted
    COR node)

- backup_top node: Should just be done (would be obsoleted by
  blockdev-copy, but that is probably further in the future than we'd
  like)


=3D=3D 3.0 deprecation =3D=3D

- Remove drive-backup, drive-mirror, blockdev-snapshot-sync,
  block_passwd, block_set_io_throttle, block-job-set-speed
  - query-block and query-named-block-nodes need a replacement first
  - Along with block-job-set-speed: Remove block job throttling
- Rework block-commit and block-stream to only use sane options (no
  filenames except for the backing file string and no @device)
- -drive (at least explicitly mark it HMP-unstable)
  - In any case features such as throttling, COR, snapshots
    (COR needs to be a filter driver first)
  - Part of -blockdev, but: Maybe convert detect-zeroes to a filter
    driver and at some point (not necessarily 3.0) remove the generic
    node-level option
- Remove BB names (in QMP commands; but without -drive, they should be
  gone completely, then)
- Remove QMP change
  - Maybe QMP eject, too
- Visibly remove old block drivers, maybe moving them to nbdkit
  (either through completely removing them, or through disabling write
   support (only enabling it in qtest or something), or by using the
   whitelist and not adding them by default)
  Arguably things like bochs, dmg, qcow, qed, ...?
  (In ascending order of radicalness)
  ((vvfat is always a candidate, but some people actually like it))


=3D=3D Preparation for thorough internal block layer QAPIfication =3D=3D

- Blockdev options should always be able to reflect the actual internal
  state -- this is not always the case (e.g. x-image in blkdebug and
  blkverify, which stores the (fat) filename of the image that is
  tested).
  List of issues:
  - blkdebug's x-image
  - blkverify's x-image and x-raw
  - rbd's =3Dkeyvalue-pairs
  - ssh's host_key_check

  (A) Add these options to the QAPI schema.
      - Bad because we don't want fat filenames in that schema.
      - If adding =3Dkeyvalue-pairs was so easy, we'd have done so
        already.  (Same for ssh, but that doesn't look impossible.)

  (B) Drop x-image and x-raw, disallowing fat filenames for blkdebug and
      blkverify.
      - Basically an idea worth pursuing, but doesn't solve rbd's or
        ssh's issue.

  (C) QAPI options, but continue to give .bdrv_parse_filename() a way to
      store random stuff (that will then be handed to .bdrv_open()).
      - Results in another parameter for .bdrv_open(), but would solve
        the issue for the rest.
      - Holds us back from fixing the real issue, which is that
        everything you can do with a fat filename you should be able to
        do through QAPI, too.

   We can also do a combination: Drop x-image and x-raw, add
   host_key_check to the QAPI schema, and then think long and hard about
   =3Dkeyvalue-pairs.


=3D=3D Single block job for backup/commit/mirror (blockdev-copy) =3D=3D

- Special things:
  - mirror: Ready state and block-job-complete
  - mirror: Always replaces some node by the target
  - backup: copy before write and synchronous
    (mirror/commit are copy after write and asynchronous (except
     active-mirror))
  - backup: Has @compressed, that may not work with mirror right now
    (because block drivers assume you only write once)
  - commit: Resizes target if smaller than source
  - commit: Does not share write permissions, maybe because it doesn't
    want to use a dirty bitmap (a unified job would just use a dirty
    bitmap so then it could just generally share write permissions)
  - active commit: Can read from source even if the backing chain is
    garbage because of the ongoing commit (mirror) job
    - block_job_add_bdrv() on nearly whole backing chain so that
      READ_CONSISTENT is not being shared
  - non-active commit: Write target's (base's) filename into all of
    source's (top's) overlays as their backing filename

At least some of these differences would require blockdev-copy runtime
options.

blockdev-copy runtime parameters:
- everything blockdev-mirror has, plus
- @compressed? -- could be done as a block filter that converts normal
  writes to compressed writes
- Some option to suppress node replacement
  (in theory you could put block-job-finalize and bdrv_reopen into a
   transaction to do that replacement yourself)
- Some option to suppress READY event and complete automatically
  (compatibility to backup and non-active commit)
- Options to control the exact copying behavior (before/after write,
  active/passive)
  (passive before-write is impossible)
- Option to resize target if smaller than source
  (maybe just internal and not visible in the interface)
  (compatibility to block-commit)
- Several other commit thingies (like permissions) which can be
  automatically deduced and set if the target is in source's backing
  chain
- Option to specify the target's filename (this is written into all
  overlays of @to_replace as their backing filename; if omitted, the
  filename QEMU knows will be used)


=3D=3D Image creation =3D=3D

Image creation and op blockers:
  At least for the time being, we probably just want file-posix to open
  the new file with O_CREAT | O_RDWR, then claim the appropriate op
  blockers (WRITE and RESIZE) and then invoke ftruncate().
  Alternatively, we could somehow do the truncation from the generic
  block layer, but this may not be possible with all protocols (and
  currently we support file locking only over file-posix anyway).

Image creation job:
  We want to have this anyway (including QAPIfication of the creation
  options), but when, alas, we cannot say.
  Some ideas:
  - Do creation per driver, not automatic "pass-through".
    First, create the protocol file.  Then, format it using the format
    driver.
    So blockdev-create would take the same child BlockdevRefs as
    blockdev-add, and then format those.  For protocol drivers, you just
    don't pass any child and the file is thus created.
    (You then open it with blockdev-add or just use it inline in the
     format driver's blockdev-create to format the image.)

Image creation in qemu-system-* vs. qemu-img:
  In order to get proper introspection for qemu-img create, we need a
  QAPI schema.  If we have a QAPI schema, we might as well add
  blockdev-create to QMP.
  As long as we do not have a really-none (null, void, ...) machine type
  for qemu-system-*, launching such a process just for creating an image
  will bring quite a bit of overhead (e.g. with -M none -accel qtest).
  However, as for libvirt, this is not exactly a regression since
  libvirt currently cannot create images at all (apart from implicitly
  through drive-mirror etc.).  Further work on voidifying qemu-system-*
  will improve performance.
  On the other side, we can also add QAPI introspection to qemu-img.
  (qemu-img already links to QAPI, so this should not be too hard.)
  qemu-img will also need command-line introspection, though.

  Plan B:
    libvirt can use qemu-img now with the currently supported options,
    and as soon as libvirt needs anything better, we will have something
    better done.
    (Also, there is "qemu-img create -f $format -o help"!  Because
     parsing help texts has worked so well in the past.)


=3D=3D GRAPH_MOD =3D=3D

Why do we have this GRAPH_MOD comment in block/mirror.c?
- Do we need the replace_blocker at all?
  - Does it block the check_to_replace_node() information?
    - No, it does not really (anymore, broken 2.5 years ago).
    - Also, check_to_replace() seems to only have one function and that
      is to prevent data corruption (so the user can only replace nodes
      that show the same data as the source node, as there are only
      filters between the two).  But if the user is so inclined to get
      bad data, they should feel free to.
      (QEMU will never implicitly add non-filter nodes, so any
       non-filter node must have been added by the user and thus cannot
       catch them by surprise.)
    - Therefore, we can probably just drop check_to_replace_node()
      (now).
  - Then, the blocker does not seem to serve any useful purpose anymore,
    so we can drop that, too.
    - (Maybe the op blocker had something to do with bdrv_swap(), where
       a pointer to a BDS could point to a completely different BDS
       after a bit of time.  Now we no longer perform such criminal
       procedures and thus should be fine without.)
    - Action item: We should also resolve the to_replace node name only
      once, and that is at the beginning of the job.
- Ergo, nobody knows what the comment is supposed to mean.  In any case
  we don't need GRAPH_MOD there.

OK, so do we need it somewhere else?
- Maybe not?


=3D=3D Corrupted qcow2 nodes =3D=3D

(Note: The current idea was to replace a corrupted qcow2 node by e.g. a
 null-co node or another special node that would always return errors
 when accessed.)

Adding a new driver (or runtime options for null-co) is hard, because
this would require us to still keep the old node around (so that it
doesn't suddenly disappear) and to prevent attachment to it (so that you
cannot use it through a back door).

Therefore the easiest way might be to add a new flag BDS.corrupted that
is simply checked in functions that write to such a BDS (write, discard,
flush, ...) and that then return -ENOMEDIUM (or something, e.g. EIEIO)
in such a case.


=3D=3D Locking for graph changes =3D=3D

Currently, we just do graph changes at any point whenever we so desire.
This gives us nice breakage e.g. in the drain functions and everywhere
we don't expect it (even though drain should expect it...).

Therefore, graph changes should probably only happen whenever nobody
else is looking.

- bdrv_drained_begin()/_end() should be locks to prevent graph changes
  from anyone else
  (the caller can do changes, though)
- Maybe there are exceptions if you change your very own children,
  because if you do so, you already know that you yourself are
  effectively drained


=3D=3D Dirty bitmaps =3D=3D

Omniscient dirty bitmaps are mostly relevant for filter nodes.  In their
case, maybe they should not have their own bitmaps but just forward
bitmap accesses to their children.

Either the filter node itself decides how this forwarding is done;
because e.g. raw allows accessing a windowed portion of its filtered node=
=2E
Or we recognize this is a bit stupid (because we would have to add
callbacks for every bitmap access function there is, for rather little
gain) and we just implement a generic function that returns the bitmap
we want to access (and nodes can say whether skipping them is OK or not,
see the note somewhere above on how filter nodes should advertise their
filtered node).
Or we add a BlockDriver callback to let the driver decide which bitmap
to access (instead of generically hopping through the graph).

For all children where this is not implemented (e.g. "file" children of
format nodes), we can prevent this issue by requiring drivers not to
share PERM_WRITE for those children.
Note that we have to unshare PERM_WRITE whenever such pass-through is
impossible, for all children that influence the node's visible data, as
soon as you try to create a bitmap on that node.


--njaiMA3KSNI40kMusQwrnEX1HBfvXJ7MH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFFBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloz+mgSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AhCYH91miAmuUo3xoP8sKSwp0Lz1HNrjoJ4YE
XhHev9rZyFBs0AXq4pqm5cU+tGks7nNMDvpKcoaavYiozzohxyRVwTZGM/g7pA7F
QlHgNtgk+M+H0gxdnIQk8QNmNVKFeCWOnrAmvFSwsWuZBlExXvSiRdHrZmP4Z/bx
3+zNTG2SIyKqexQunJoGPPJxvGpK/giVaHV1DPkyUpDC1cGxceMNSOgV4DlaG9t7
sHlYAjZbyeHiQL3J7XezgzgzyE4qKFH0XgcTB5J4M+rSMqZDQysdHlwsVC86k2KQ
d1IyDtGgcX+zAHI3CE7P2WlAKVWd9B0hYQz0HyFG1z4UNl0SsGtNWw==
=gGZZ
-----END PGP SIGNATURE-----

--njaiMA3KSNI40kMusQwrnEX1HBfvXJ7MH--
