Received: from eggs.gnu.org ([2001:4830:134:3::10]:50469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dUwhZ-0008D3-7O
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:03:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dUwhX-0000Xj-11
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:03:49 -0400
References: <1499674503-21551-1-git-send-email-kchamart@redhat.com>
	<1499674503-21551-3-git-send-email-kchamart@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0bb4f016-989a-04cf-4bb2-e28ae5c74820@redhat.com>
Date: Tue, 11 Jul 2017 10:03:29 -0500
MIME-Version: 1.0
In-Reply-To: <1499674503-21551-3-git-send-email-kchamart@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="RvQBtSEitNw7hn6fXRQNcBO9HoMNh7ri6"
Subject: Re: [Qemu-devel] [PATCH v6 2/2] live-block-ops.txt: Rename, rewrite,
 and improve it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, berto@igalia.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RvQBtSEitNw7hn6fXRQNcBO9HoMNh7ri6
From: Eric Blake <eblake@redhat.com>
To: Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com,
 jsnow@redhat.com, berto@igalia.com
Message-ID: <0bb4f016-989a-04cf-4bb2-e28ae5c74820@redhat.com>
Subject: Re: [PATCH v6 2/2] live-block-ops.txt: Rename, rewrite, and improve
 it
References: <1499674503-21551-1-git-send-email-kchamart@redhat.com>
 <1499674503-21551-3-git-send-email-kchamart@redhat.com>
In-Reply-To: <1499674503-21551-3-git-send-email-kchamart@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/10/2017 03:15 AM, Kashyap Chamarthy wrote:
> This patch documents (including their QMP invocations) all the four
> major kinds of live block operations:
>=20
>   - `block-stream`
>   - `block-commit`
>   - `drive-mirror` (& `blockdev-mirror`)
>   - `drive-backup` (& `blockdev-backup`)
>=20
> Things considered while writing this document:
>=20
>   - Use reStructuredText as markup language (with the goal of generatin=
g
>     the HTML output using the Sphinx Documentation Generator).  It is
>     gentler on the eye, and can be trivially converted to different
>     formats.  (Another reason: upstream QEMU is considering to switch t=
o
>     Sphinx, which uses reStructuredText as its markup language.)
>=20
>   - Raw QMP JSON output vs. 'qmp-shell'.  I debated with myself whether=

>     to only show raw QMP JSON output (as that is the canonical
>     representation), or use 'qmp-shell', which takes key-value pairs.  =
I
>     settled on the approach of: for the first occurence of a command,

s/occurence/occurrence/

>     use raw JSON; for subsequent occurences, use 'qmp-shell', with an

and again

>     occasional exception.
>=20
>   - Usage of `-blockdev` command-line.
>=20
>   - Usage of 'node-name' vs. file path to refer to disks.  While we hav=
e
>     `blockdev-{mirror, backup}` as 'node-name'-alternatives for
>     `drive-{mirror, backup}`, the `block-commit` command still operate

s/operate/operates/

>     on file names for parameters 'base' and 'top'.  So I added a caveat=

>     at the beginning to that effect.
>=20
>     Refer this related thread that I started (where I learnt
>     `block-stream` was recently reworked to accept 'node-name' for 'top=
'
>     and 'base' parameters):
>     https://lists.nongnu.org/archive/html/qemu-devel/2017-05/msg06466.h=
tml
>     "[RFC] Making 'block-stream', and 'block-commit' accept node-name"
>=20
> All commands showed in this document were tested while documenting.
>=20
> Thanks: Eric Blake for the section: "A note on points-in-time vs file
> names".  This useful bit was originally articulated by Eric in his
> KVMForum 2015 presentation, so I included that specific bit in this
> document.
>=20
> Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
> ---

>=20
> diff --git a/docs/interop/live-block-operations.rst b/docs/interop/live=
-block-operations.rst
> new file mode 100644
> index 0000000..6580f85
> --- /dev/null
> +++ b/docs/interop/live-block-operations.rst
> @@ -0,0 +1,1088 @@
> +..
> +    Copyright (C) 2017 Red Hat Inc.
> +
> +    This work is licensed under the terms of the GNU GPL, version 2 or=

> +    later.  See the COPYING file in the top-level directory.

Does this paragraph get rendered in such a way that someone reading an
=2Ehtml site will wonder where the top-level directory lives?  I'm not
sure if it should be a comment local to this file, or if the final
rendered text should mention the license.  Hmm, reading further, it
looks like the '..' followed by indentation serves as a multi-line
comment that does not appear in the rendering; so I think that means I
have no recommended change.

> +Disk image backing chain notation
> +---------------------------------
> +
> +A simple disk image chain.  (This can be created live using QMP
> +``blockdev-snapshot-sync``, or offline via ``qemu-img``)::

Do we want to go into details about the command-line arguments to
qemu-img used for offline creation/manipulation of an image in a chain?
I guess it's okay to not worry about it; your focus here is QMP commands
(what can we do while qemu is running) rather than offline commands.

> +
> +Brief overview of live block QMP primitives
> +-------------------------------------------
> +
> +The following are the four different kinds of live block operations th=
at
> +QEMU block layer supports.
> +
> +(1) ``block-stream``: Live copy of data from backing files into overla=
y
> +    files.
> +
> +    .. note:: Once the 'stream' operation has finished, three things t=
o
> +              note:
> +
> +                (a) QEMU rewrites the backing chain to remove
> +                    reference to the now-streamed and redundant backin=
g
> +                    file;
> +
> +                (b) the streamed file *itself* won't be removed by QEM=
U,
> +                    and must be explicitly discarded by the user;
> +
> +                (c) the streamed file remains valid -- i.e. further
> +                    overlays can be created based on it.  Refer the
> +                    ``block-stream`` section further below for more
> +                    details.
> +
> +(2) ``block-commit``: Live merge of data from overlay files into backi=
ng
> +    files (with the optional goal of removing the overlay file from th=
e
> +    chain).  Since QEMU 2.0, this includes "active ``block-commit``"
> +    (i.e. merge the current active layer into the base image).
> +
> +    .. note:: Once the 'commit' operation has finished, there are thre=
e
> +              things to note here as well:
> +
> +                (a) QEMU rewrites the backing chain to remove referenc=
e
> +                    to now-redundant overlay images that have been
> +                    commited into a backing file;

s/commited/committed/ (several places in the document, I'll just point
it out here)

> +
> +                (b) the commited file *itself* won't be removed by QEM=
U
> +                    -- it ought to be manually removed;
> +
> +                (c) however, unlike in the case of ``block-stream``, t=
he
> +                    intermediate images will be rendered invalid -- i.=
e.
> +                    no more further overlays can be created based on
> +                    them.  Refer the ``block-commit`` section further
> +                    below for more details.
> +
> +(3) ``drive-mirror`` (and ``blockdev-mirror``): Synchronize running di=
sk

s/running/a running/

> +    to another image.
> +
> +(4) ``drive-backup`` (and ``blockdev-backup``): Point-in-time (live) c=
opy
> +    of a block device to a destination.
> +
> +
> +.. _`Interacting with a QEMU instance`:
> +
> +Interacting with a QEMU instance
> +--------------------------------
> +
> +To show some example invocations of command-line, we will use the
> +following invocation of QEMU, with a QMP server running over UNIX
> +socket::
> +
> +    $ ./x86_64-softmmu/qemu-system-x86_64 -display none -nodefconfig \=

> +        -M q35 -nodefaults -m 512 \
> +        -blockdev node-name=3Dnode-A,driver=3Dqcow2,file.driver=3Dfile=
,file.node-name=3Dfile,file.filename=3D./a.qcow2 \
> +        -device virtio-blk,drive=3Dnode-A,id=3Dvirtio0 \
> +        -monitor stdio -qmp unix:/tmp/qmp-sock,server,nowait
> +
> +The ``-blockdev`` command-line option, used above, is available from
> +QEMU 2.9 onwards.  In the above invocation, notice the ``node-name``
> +parameter that is used to refer to the disk image a.qcow2 ('node-A') -=
-
> +this is a cleaner way to refer to a disk image (as opposed to referrin=
g
> +to it by spelling out file paths).  So, we will continue to designate =
a
> +``node-name`` to each further disk image created (either via
> +``blockdev-snapshot-sync``, or ``blockdev-add``) as part of the disk
> +image chain, and continue to refer to the disks using their
> +``node-name`` (where possible, because ``block-commit`` does not yet, =
as
> +of QEMU 2.9, accept ``node-name`` parameter) when performing various
> +block operations.
> +
> +To interact with the QEMU instance launched above, we will use the
> +``qmp-shell`` (located at: ``qemu/scripts/qmp``, as part of the QEMU
> +source directory) utility, which takes key-value pairs for QMP command=
s.

s/qmp-shell (...) utility/qmp-shell utility (...)/

> +Invoke it as below (which will also print out the complete raw JSON
> +syntax for reference -- examples in the following sections)::
> +
> +    $ ./qmp-shell -v -p /tmp/qmp-sock
> +    (QEMU)
> +
> +.. note::
> +    In the event we have to repeat a certain QMP command, we will: for=

> +    the first occurrence of it, show the ``qmp-shell`` invocation, *an=
d*
> +    the corresponding raw JSON QMP syntax; but for subsequent
> +    invocations, present just the ``qmp-shell`` syntax, and omit the
> +    equivalent JSON output.
> +
> +
> +Example disk image chain
> +------------------------
> +
> +We will use the below disk image chain (and occasionally spelling it
> +out where appropriate) when discussing various primitives::
> +
> +    [A] <-- [B] <-- [C] <-- [D]
> +
> +Where [A] is the original base image; [B] and [C] are intermediate
> +overlay images; image [D] is the active layer -- i.e. live QEMU is
> +writing to it.  (The rule of thumb is: live QEMU will always be pointi=
ng
> +to the rightmost image in a disk image chain.)
> +
> +The above image chain can be created by invoking
> +``blockdev-snapshot-sync`` commands as following (which shows the
> +creation of overlay image [B]) using the ``qmp-shell`` (our invocation=

> +also prints the raw JSON invocation of it)::
> +
> +    (QEMU) blockdev-snapshot-sync node-name=3Dnode-A snapshot-file=3Db=
=2Eqcow2 snapshot-node-name=3Dnode-B format=3Dqcow2
> +    {
> +        "execute": "blockdev-snapshot-sync",
> +        "arguments": {
> +            "node-name": "node-A",
> +            "snapshot-file": "b.qcow2",
> +            "format": "qcow2",
> +            "snapshot-node-name": "node-B"
> +        }
> +    }
> +
> +Here, "node-A" is the name QEMU internally uses to refer to the base
> +image [A] -- it is the backing file, based on which the overlay image,=

> +[B], is created.
> +
> +To create the rest of the overlay images, [C], and [D] (omitted the ra=
w

s/omitted/omitting/

> +JSON output for brevity)::
> +
> +    (QEMU) blockdev-snapshot-sync node-name=3Dnode-B snapshot-file=3Dc=
=2Eqcow2 snapshot-node-name=3Dnode-C format=3Dqcow2
> +    (QEMU) blockdev-snapshot-sync node-name=3Dnode-C snapshot-file=3Dd=
=2Eqcow2 snapshot-node-name=3Dnode-D format=3Dqcow2
> +

> +QMP invocation for ``block-commit``
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +For :ref:`Case-1 <block-commit_Case-1>`, to merge contents only from
> +image [B] into image [A], the invocation is as following::

s/following/follows/

> +
> +    (QEMU) block-commit device=3Dnode-D base=3Da.qcow2 top=3Db.qcow2 j=
ob-id=3Djob0
> +    {
> +        "execute": "block-commit",
> +        "arguments": {
> +            "device": "node-D",
> +            "job-id": "job0",
> +            "top": "b.qcow2",
> +            "base": "a.qcow2"
> +        }
> +    }
> +
> +Once the above ``block-commit`` operation has completed, a
> +``BLOCK_JOB_COMPLETED`` event will be issued, and no further action is=

> +required.  The end result being, the backing file of image [C] is

Comes off awkwardly to me, but I'm debating on the best fix.  Perhaps:

s/The end result being,/As the end result,/

> +adjusted to point to image [A], and the original 4-image chain will en=
d
> +up being transformed to::
> +

> +
> +Live disk synchronization --- ``drive-mirror`` and ``blockdev-mirror``=

> +----------------------------------------------------------------------=

> +
> +Synchronize a running disk image chain (all or part of it) to a target=

> +image.
> +
> +Again, given our familiar disk image chain::
> +
> +    [A] <-- [B] <-- [C] <-- [D]
> +
> +The ``drive-mirror`` (and its newer equivalent ``blockdev-mirror``) al=
lows
> +you to copy data from the entire chain into a single target image (whi=
ch
> +can be located on a different host).
> +
> +Once a 'mirror' job has started, there are two possible actions when a=


maybe s/when/while/

> +``drive-mirror`` job is active:
> +
> +(1) Issuing the command ``block-job-cancel`` after it emits the event
> +    ``BLOCK_JOB_CANCELLED``: will (after completing synchronization of=

> +    the content from the disk image chain to the target image, [E])
> +    create a point-in-time (which is at the time of *triggering* the
> +    cancel command) copy, contained in image [E], of the the entire di=
sk
> +    image chain (or only the top-most image, depending on the ``sync``=

> +    mode).
> +
> +(2) Issuing the command ``block-job-complete`` after it emits the even=
t
> +    ``BLOCK_JOB_COMPLETED``: will, after completing synchronization of=

> +    the content, adjust the guest device (i.e. live QEMU) to point to
> +    the target image, and, causing all the new writes from this point =
on
> +    to happen there.  One use case for this is live storage migration.=

> +
> +About synchronization modes: The synchronization mode determines
> +*which* part of the disk image chain will be copied to the target.
> +Currently, there are four different kinds:
> +
> +(1) ``full`` -- Synchronize the content of entire disk image chain to
> +    the target
> +
> +(2) ``top`` -- Synchronize only the contents of the top-most disk imag=
e
> +    in the chain to the target
> +
> +(3) ``none`` -- Synchronize only the new writes from this point on.
> +
> +    .. note:: In the case of ``drive-backup`` (or ``blockdev-backup``)=
,
> +              the behavior of ``none`` sychronization mode is differen=
t.

s/sychronization/synchronization/

> +              Normally, a ``backup`` job consists of two parts: Anythi=
ng
> +              that is overwritten by the guest is first copied out to
> +              the backup, and in the background the whole image is
> +              copied from start to end. With ``sync=3Dnone``, it's onl=
y
> +              the first part.
> +
> +(4) ``incremental`` -- Synchronize content that is described by the
> +    dirty bitmap
> +
> +.. note::
> +    Refer to the :doc:`bitmaps` document in the QEMU source
> +    tree to learn about the detailed workings of the ``incremental``
> +    synchronization mode.
> +
> +
> +QMP invocation for ``drive-mirror``
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +

> +.. important::
> +    The destination host must already have the contents of the backing=

> +    chain, involving images [A], [B], and [C], visible via other means=

> +    -- whether by ``cp``, ``rsync``, or by some storage array-specific=

> +    command.)
> +
> +Sometimes, this is also referred to as "shallow copy" -- because: only=


s/because:/because/

> +the "active layer", and not the rest of the image chain, is copied to
> +the destination.
> +
> +.. note::
> +    In this example, for the sake of simplicity, we'll be using the sa=
me
> +    ``localhost`` as both, source and destination.

s/both,/both/

> +
> +As noted earlier, on the destination host the contents of the backing
> +chain -- from images [A] to [C] -- are already expected to exist in so=
me
> +form (e.g. in a file called, ``Contents-of-A-B-C.qcow2``).  Now, on th=
e
> +destination host, let's create a target overlay image (with the image
> +``Contents-of-A-B-C.qcow2`` as its backing file), to which the content=
s
> +of image [D] (from the source QEMU) will be mirrored to::
> +
> +    $ qemu-img create -f qcow2 -b ./Contents-of-A-B-C.qcow2 \
> +        -F qcow2 ./target-disk.qcow2

Ah, so you DO have one example of an offline use of qemu-img for
manipulating backing chain relationships.

> +
> +And start the destination QEMU (we already have the source QEMU runnin=
g
> +-- discussed in the section: `Interacting with a QEMU instance`_)
> +instance, with the following invocation.  (As noted earlier, for
> +simplicity's sake, the destination QEMU is started on the same host, b=
ut
> +it could be located elsewhere)::

libvirt doesn't allow migration to localhost - but that doesn't affect
your example...

> +(6) [On *destination* QEMU] Finally, resume the guest vCPUs by issuing=
 the
> +    QMP command `cont`::
> +
> +        (QEMU) cont
> +        {
> +            "execute": "cont",
> +            "arguments": {}
> +        }
> +
> +
> +.. note::
> +    Higher-level libraries (e.g. libvirt) automate the entire above
> +    process.

=2E..other than this note. Maybe s/process./process (although note that
libvirt does not allow same-host migrations to localhost for other reason=
s).

Overall, looking good!  Content-wise, I think we have a good document,
and it was just a few spelling errors and grammar suggestions, minor
enough that I'm comfortable with you adding:
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--RvQBtSEitNw7hn6fXRQNcBO9HoMNh7ri6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZZOjBAAoJEKeha0olJ0Nqq/EIAIdmYxJEnlGzjQOC/sXz6yYR
IXAWqGVAgIbfY45xzykQZxEhl6VBuQnrHo4Qdv2B6ObxqrzMsiDWiI6vFnwajx84
FjFiMLfD1vxa3z8sU3Xzu7/EnFpA7C9uTOA3KfhtvBV5S2dO8GCFw9KEcR4h/1tc
eu0md/yXruCjiab3UzWrZ1T53B+yStxiNjDAhGbclvoWAELkpnn5DJSgy+eNEbOR
jslDq7rI1uM+WILY4r5QWC/Em5BHC7BvzSy2AB6gK7kEvPTJKI5Roo9TTR/Itv9Z
bKrQOnMh1F5FV1hVujT/3Fdnc5NrIeSGflUrjL6zLbxSrW62uFPjhnAm+/93EM0=
=xTUL
-----END PGP SIGNATURE-----

--RvQBtSEitNw7hn6fXRQNcBO9HoMNh7ri6--
