Received: from eggs.gnu.org ([2001:4830:134:3::10]:39308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen@that.guru>) id 1dLtNf-0007II-Ay
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 11:41:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen@that.guru>) id 1dLtNZ-0004U3-Tb
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 11:41:51 -0400
Message-ID: <1497627680.3289.1.camel@that.guru>
From: Stephen Finucane <stephen@that.guru>
Date: Fri, 16 Jun 2017 16:41:20 +0100
In-Reply-To: <1497624690-1156-2-git-send-email-kchamart@redhat.com>
References: <1497624690-1156-2-git-send-email-kchamart@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] live-block-ops.txt: Rename, rewrite,
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
Cc: eblake@redhat.com, armbru@redhat.com, kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org

On Fri, 2017-06-16 at 16:51 +0200, Kashyap Chamarthy wrote:
> This edition documents (including their QMP invocations) all four
> operations:
>=20
> =C2=A0 - `block-stream`
> =C2=A0 - `block-commit`
> =C2=A0 - `drive-mirror` (& `blockdev-mirror`)
> =C2=A0 - `drive-backup` (& `blockdev-backup`)
>=20
> Things considered while writing this document:
>=20
> =C2=A0 - Use reStructuredText as markup language (with the goal of gene=
rating
> =C2=A0=C2=A0=C2=A0=C2=A0the HTML output using the Sphinx Documentation =
Generator).=C2=A0=C2=A0It is
> =C2=A0=C2=A0=C2=A0=C2=A0gentler on the eye, and can be trivially conver=
ted to different
> =C2=A0=C2=A0=C2=A0=C2=A0formats.=C2=A0=C2=A0(Another reason: upstream Q=
EMU is considering to switch to
> =C2=A0=C2=A0=C2=A0=C2=A0Sphinx, which uses reStructuredText as its mark=
up language.)
>=20
> =C2=A0 - Raw QMP JSON output vs. 'qmp-shell'.=C2=A0=C2=A0I debated with=
 myself whether
> =C2=A0=C2=A0=C2=A0=C2=A0to only show raw QMP JSON output (as that is th=
e canonical
> =C2=A0=C2=A0=C2=A0=C2=A0representation), or use 'qmp-shell', which take=
s key-value pairs.=C2=A0=C2=A0I
> =C2=A0=C2=A0=C2=A0=C2=A0settled on the approach of: for the first occur=
ence of a command,
> =C2=A0=C2=A0=C2=A0=C2=A0use raw JSON; for subsequent occurences, use 'q=
mp-shell', with an
> =C2=A0=C2=A0=C2=A0=C2=A0occasional exception.
>=20
> =C2=A0 - Usage of `-blockdev` command-line.
>=20
> =C2=A0 - Usage of 'node-name' vs. file path to refer to disks.=C2=A0=C2=
=A0While we have
> =C2=A0=C2=A0=C2=A0=C2=A0`blockdev-{mirror, backup}` as 'node-name'-alte=
rnatives for
> =C2=A0=C2=A0=C2=A0=C2=A0`drive-{mirror, backup}`, the `block-commit` co=
mmand still operate
> =C2=A0=C2=A0=C2=A0=C2=A0on file names for parameters 'base' and 'top'.=C2=
=A0=C2=A0So I added a caveat
> =C2=A0=C2=A0=C2=A0=C2=A0at the beginning to that effect.
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0Refer this related thread that I started (where=
 I learnt
> =C2=A0=C2=A0=C2=A0=C2=A0`block-stream` was recently reworked to accept =
'node-name' for 'top'
> =C2=A0=C2=A0=C2=A0=C2=A0and 'base' parameters):
> =C2=A0=C2=A0=C2=A0=C2=A0https://lists.nongnu.org/archive/html/qemu-deve=
l/2017-05/msg06466.html
> =C2=A0=C2=A0=C2=A0=C2=A0"[RFC] Making 'block-stream', and 'block-commit=
' accept node-name"
>=20
> All commands showed in this document were tested while documenting.

As requested, a couple of rST pointers below that will help you if/when y=
ou
switch to Sphinx. I've only focused on the design aspect, not the content=
.

Stephen

> Thanks: Eric Blake for the section: "A note on points-in-time vs file
> names".=C2=A0=C2=A0This useful bit was originally articulated by Eric i=
n his
> KVMForum 2015 presentation, so I included that specific bit in this
> document.
>=20
> Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
> ---
> * A Sphinx-rendered HTML version is here:
> =C2=A0 https://kashyapc.fedorapeople.org/QEMU-docs/_build/html/docs/liv=
e-block-ope
> rations.html
>=20
> * Changes in v2 [address content feedback from Eric; styling changes
> =C2=A0 from Stephen Finucane]:
> =C2=A0=C2=A0=C2=A0- [Styling] Remove the ToC, as the Sphinx, ".. conten=
ts::" will take
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0auto-generate it as part of the rendered =
version
> =C2=A0=C2=A0=C2=A0- [Styling] Replace ".. code-block::" with "::" as it=
 depends on the
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0external 'pygments' library and the synta=
xes available vary between
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0different versions. [Thanks to Stephen Fi=
nucane, who this tip on
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0IRC, from experience of doing Sphinx docu=
mentation for the Open
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0vSwitch project]
> =C2=A0=C2=A0=C2=A0- [Styling] Remove all needless hyperlinks, since ToC=
 will take care
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0of them
> =C2=A0=C2=A0=C2=A0- Fix commit message typos
> =C2=A0=C2=A0=C2=A0- Add Copyright / License boilerplate text at the top
> =C2=A0=C2=A0=C2=A0- Reword sentences in "Disk image backing chain notat=
ion" section
> =C2=A0=C2=A0=C2=A0- Fix descriptions of `block-{stream, commit}`
> =C2=A0=C2=A0=C2=A0- Rework `block-stream` QMP invocations to take its '=
node-name'
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0parameter 'base-node'
> =C2=A0=C2=A0=C2=A0- Add 'file.node-name=3Dfile' to the '-blockdev' comm=
and-line
> =C2=A0=C2=A0=C2=A0- s/shall/will/g
> =C2=A0=C2=A0=C2=A0- Clarify throughout the document, where appropriate,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0that we're starting afresh with the origi=
nal disk image chain
> =C2=A0=C2=A0=C2=A0- Address mistakes in "Live block commit (`block-comm=
it`)" and
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"QMP invocation for `block-commit`" secti=
ons
> =C2=A0=C2=A0=C2=A0- Describe the case of "shallow mirroring" (synchroni=
ze only the
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0contents of the *top*-most disk image -- =
"sync": "top") for
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0`drive-mirror`, as it's part of an import=
ant use case: live storage
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0migration without shared storage setup.=C2=
=A0=C2=A0(Add a new section: "QMP
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0invocation for live storage migration wit=
h `drive-mirror` + NBD" as
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0part of this)
> =C2=A0=C2=A0=C2=A0- Add QMP invocation example for `blockdev-{mirror, b=
ackup}`
>=20
> * TODO (after feedback from John Snow):
> =C2=A0=C2=A0=C2=A0- Eric Blake suggested to consider documenting increm=
ental backup
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0policies as part of the section: "Live di=
sk backup ---
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0`drive-backup` and `blockdev-backup`"
> ---
> =C2=A0docs/live-block-operations.rst | 1105
> ++++++++++++++++++++++++++++++++++++++++
> =C2=A0docs/live-block-ops.txt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0|=C2=A0=C2=A0=C2=A072 ---
> =C2=A02 files changed, 1105 insertions(+), 72 deletions(-)
> =C2=A0create mode 100644 docs/live-block-operations.rst
> =C2=A0delete mode 100644 docs/live-block-ops.txt
>=20
> diff --git a/docs/live-block-operations.rst b/docs/live-block-operation=
s.rst
> new file mode 100644
> index 0000000..e1f5715
> --- /dev/null
> +++ b/docs/live-block-operations.rst
> @@ -0,0 +1,1105 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> +Live Block Device Operations
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> +Copyright (C) 2017 Red Hat Inc.
> +
> +This work is licensed under the terms of the GNU GPL, version 2 or
> +later.=C2=A0=C2=A0See the COPYING file in the top-level directory.
> +
> +---
> +

This information doesn't need to be output in the web version, IMO. If wr=
ite it
like a comment, it will only be visible in the source. See what we do in =
OVS
docs [1] for an example.

[1] https://raw.githubusercontent.com/openvswitch/ovs/master/Documentatio=
n/inde
x.rst

> +QEMU Block Layer currently (as of QEMU 2.9) supports four major kinds =
of
> +live block device jobs -- stream, commit, mirror, and backup.=C2=A0=C2=
=A0These can
> +be used to manipulate disk image chains to accomplish certain tasks,
> +namely: live copy data from backing files into overlays; shorten long
> +disk image chains by merging data from overlays into backing files; li=
ve
> +synchronize data from a disk image chain (including current active dis=
k)
> +to another target image; point-in-time (and incremental) backups of a
> +block device.=C2=A0=C2=A0Below is a description of the said block (QMP=
)
> +primitives, and some (non-exhaustive list of) examples to illustrate
> +their use.
> +
> +NB: The file ``qapi/block-core.json`` in the QEMU source tree has the
> +canonical QEMU API (QAPI) schema documentation for the QMP primitives
> +discussed here.
> +

You might consider using admonitions here and elsewhere. This would make =
sense
as a 'note' or 'important' directive:

  .. note::

      The file ``qapi/block-core.json`` ...

> +
> +.. contents::

This can probably go if/when Sphinx is integrated - Sphinx includes a ToC=
 in
the sidebar by default. Perhaps include a TODO to remove this?

  .. TODO(kashyap): Remove this when Sphinx is integrated

> +Disk image backing chain notation
> +---------------------------------
> +
> +A simple disk image chain.=C2=A0=C2=A0(This can be created live, using=
 QMP
> +``blockdev-snapshot-sync``, or offline, via ``qemu-img``):
> +
> +::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(Live QEMU)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0V
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
[A] <----- [B]
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0(backing file)=C2=A0=C2=A0=C2=A0=C2=A0(overlay=
)
> +
> +The arrow can be read as: Image [A] is the backing file of disk image
> +[B].=C2=A0=C2=A0And live QEMU is currently writing to image [B], conse=
quently, it
> +is also referred to as the "active layer".
> +
> +There are two kinds of terminology that are common when referring to
> +files in a disk image backing chain:
> +
> +(1) Directional: 'base' and 'top'.=C2=A0=C2=A0Given the simple disk im=
age chain
> +=C2=A0=C2=A0=C2=A0=C2=A0above, image [A] can be referred to as 'base',=
 and image [B] as
> +=C2=A0=C2=A0=C2=A0=C2=A0'top'.=C2=A0=C2=A0(This terminology can be see=
n in in QAPI schema file,
> +=C2=A0=C2=A0=C2=A0=C2=A0block-core.json.)

This looks really like a definition list, which is rST are written like s=
o:

  term

    Detailed description of the term here...

So this would become:

  Directional

    'base' and 'top'. Given...

> +
> +(2) Relational: 'backing file' and 'overlay'.=C2=A0=C2=A0Again, taking=
 the same
> +=C2=A0=C2=A0=C2=A0=C2=A0simple disk image chain from the above, disk i=
mage [A] is referred
> +=C2=A0=C2=A0=C2=A0=C2=A0to as the backing file, and image [B] as overl=
ay.
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0Throughout this document, we will use the rela=
tional terminology.
> +
> +NB: The base disk image can be raw format; however, all the overlay
> +files must be of QCOW2 format.

.. important::

> +
> +
> +Brief overview of live block QMP primitives
> +-------------------------------------------
> +
> +The following are the four different kinds of live block operations th=
at
> +QEMU block layer supports.
> +
> +- ``block-stream``: Live copy of data from backing files into overlay
> +=C2=A0=C2=A0files (with the optional goal of removing the backing file=
 from the
> +=C2=A0=C2=A0chain).
> +
> +- ``block-commit``: Live merge of data from overlay files into backing
> +=C2=A0=C2=A0files (with the optional goal of removing the overlay file=
 from the
> +=C2=A0=C2=A0chain).=C2=A0=C2=A0Since QEMU 2.0, this includes "active `=
`block-commit``" (i.e.
> +=C2=A0=C2=A0merge the current active layer into the base image).
> +
> +- ``drive-mirror`` (and ``blockdev-mirror``): Synchronize running disk
> +=C2=A0=C2=A0to another image.
> +
> +- ``drive-backup`` (and ``blockdev-backup``): Point-in-time (live) cop=
y
> +=C2=A0=C2=A0of a block device to a destination.

Definition list?

> +
> +
> +.. _`Interacting with a QEMU instance`:

If you're not linking to this, you don't need to include this. The 'conte=
nts'
directive will automatically insert an anchor for each heading.

> +
> +Interacting with a QEMU instance
> +--------------------------------
> +
> +To show some example invocations of command-line, we will use the
> +following invocation of QEMU, with a QMP server running over UNIX
> +socket:
> +
> +::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0$ ./x86_64-softmmu/qemu-system-x86_64 -display=
 none -nodefconfig \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-M q35 -nodefaults -m =
512 \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-blockdev node-name=3D=
node-A,driver=3Dqcow2,file.driver=3Dfile,file.node-
> name=3Dfile,file.filename=3D./a.qcow2 \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-device virtio-blk,dri=
ve=3Dnode-A,id=3Dvirtio0 \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-monitor stdio -qmp un=
ix:/tmp/qmp-sock,server,nowait
> +
> +The ``-blockdev`` command-line option, used above, is available from
> +QEMU 2.9 onwards.=C2=A0=C2=A0In the above invocation, notice the 'node=
-name'

``node-name``?

> +parameter that is used to refer to the disk image a.qcow2 ('node-A') -=
-

``a.qcow2``?

> +this is a cleaner way to refer to a disk image (as opposed to referrin=
g
> +to it by spelling out file paths).=C2=A0=C2=A0So, we will continue to =
designate a
> +'node-name' to each further disk image created (either via
> +``blockdev-snapshot-sync``, or ``blockdev-add``) as part of the disk
> +image chain, and continue to refer to the disks using their 'node-name=
'
> +(where possible, because ``block-stream``, and ``block-commit`` do not
> +yet, as of QEMU 2.9, take 'node-name' parameters) when performing
> +various block operations.
> +
> +To interact with the QEMU instance launched above, we will use the
> +``qmp-shell`` (located at: ``qemu/scripts/qmp``, as part of the QEMU
> +source directory) utility, which takes key-value pairs for QMP command=
s.
> +Invoke it as below (which will also print out the complete raw JSON
> +syntax for reference -- examples in the following sections).
> +
> +::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0$ ./qmp-shell -v -p /tmp/qmp-sock
> +=C2=A0=C2=A0=C2=A0=C2=A0(QEMU)
> +
> +NB: In the event we have to repeat a certain QMP command, we will: for
> +the first occurrence of it, show the the ``qmp-shell`` invocation,
> +*and* the corresponding raw JSON QMP syntax; but for subsequent
> +invocations, present just the ``qmp-shell`` syntax, and omit the
> +equivalent JSON output.

.. important::

> +
> +Example disk image chain
> +------------------------
> +
> +We will use the below disk image chain (and occasionally spelling it
> +out where appropriate) when discussing various primitives.
> +
> +::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0[A] <-- [B] <-- [C] <-- [D]
> +
> +Where [A] is the original base image; [B] and [C] are intermediate
> +overlay images; image [D] is the active layer -- i.e. live QEMU is
> +writing to it.=C2=A0=C2=A0(The rule of thumb is: live QEMU will always=
 be pointing
> +to the right-most image in a disk image chain.)
> +
> +The above image chain can be created by invoking
> +``blockdev-snapshot-sync`` command as following (which shows the
> +creation of overlay image [B]) using the ``qmp-shell`` (our invocation
> +also prints the raw JSON invocation of it):
> +
> +::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0(QEMU) blockdev-snapshot-sync node-name=3Dnode=
-A snapshot-file=3Db.qcow2
> snapshot-node-name=3Dnode-B format=3Dqcow2
> +=C2=A0=C2=A0=C2=A0=C2=A0{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"execute": "blockdev-s=
napshot-sync",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"arguments": {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
"node-name": "node-A",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
"snapshot-file": "b.qcow2",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
"format": "qcow2",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
"snapshot-node-name": "node-B"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> +=C2=A0=C2=A0=C2=A0=C2=A0}
> +
> +Here, "node-A" is the name QEMU internally uses to refer to the base
> +image [A] -- it is the backing file, based on which the overlay image,
> +[B], is created.

I guess you should probably use ``[A]`` here to preserve formatting

> +
> +To create the rest of the two overlay images, [C], and [D] (omitted th=
e
> +raw JSON output for brevity):
> +
> +::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0(QEMU) blockdev-snapshot-sync node-name=3Dnode=
-B snapshot-file=3Dc.qcow2
> snapshot-node-name=3Dnode-C format=3Dqcow2
> +=C2=A0=C2=A0=C2=A0=C2=A0(QEMU) blockdev-snapshot-sync node-name=3Dnode=
-C snapshot-file=3Dd.qcow2
> snapshot-node-name=3Dnode-D format=3Dqcow2
> +
> +
> +A note on points-in-time vs file names
> +--------------------------------------
> +
> +In our disk disk image chain:
> +
> +::

repeated word and no need for ':\n\n::' - you can just use '::'.

  In our disk image chain::

ditto for the rest of the file

> +
> +=C2=A0=C2=A0=C2=A0=C2=A0[A] <-- [B] <-- [C] <-- [D]
> +
> +We have *three* points in time and an active layer:
> +
> +- Point 1: Guest state when [B] was created is contained in file [A]
> +- Point 2: Guest state when [C] was created is contained in [A] + [B]
> +- Point 3: Guest state when [D] was created is contained in
> +=C2=A0=C2=A0[A] + [B] + [C]
> +- Active layer: Current guest state is contained in [A] + [B] + [C] +
> +=C2=A0=C2=A0[D]
> +
> +Therefore, be aware with naming choices:
> +
> +- Naming a file after the time it is created is misleading -- the
> +=C2=A0=C2=A0guest data for that point in time is *not* contained in th=
at file
> +=C2=A0=C2=A0(as explained earlier)
> +- Rather, think of files as a *delta* from the backing file
> +
> +
> +Live block streaming --- ``block-stream``
> +-----------------------------------------
> +
> +The ``block-stream`` command allows you to do live copy data from back=
ing
> +files into overlay images.
> +
> +Given our original example disk image chain from earlier:
> +
> +::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0[A] <-- [B] <-- [C] <-- [D]
> +
> +The disk image chain can be shortened in one of the following differen=
t
> +ways (not an exhaustive list).
> +

Maybe you should include an anchor here, so you can link to it below.

> +(1) Merge everything into the active layer: I.e. copy all contents fro=
m
> +=C2=A0=C2=A0=C2=A0=C2=A0the base image, [A], and overlay images, [B] a=
nd [C], into [D],
> +=C2=A0=C2=A0=C2=A0=C2=A0_while_ the guest is running.=C2=A0=C2=A0The r=
esulting chain will be a
> +=C2=A0=C2=A0=C2=A0=C2=A0standalone image, [D] -- with contents from [A=
], [B] and [C] merged
> +=C2=A0=C2=A0=C2=A0=C2=A0into it (where live QEMU writes go to):
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[D]
> +
> +(2) Taking the same example disk image chain mentioned earlier, merge
> +=C2=A0=C2=A0=C2=A0=C2=A0only images [B] and [C] into [D], the active l=
ayer.=C2=A0=C2=A0The result will
> +=C2=A0=C2=A0=C2=A0=C2=A0be contents of images [B] and [C] will be copi=
ed into [D], and the
> +=C2=A0=C2=A0=C2=A0=C2=A0backing file pointer of image [D] will be adju=
sted to point to image
> +=C2=A0=C2=A0=C2=A0=C2=A0[A].=C2=A0=C2=A0The resulting chain will be:
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[A] <-- [D]
> +
> +(3) Intermediate streaming (available since QEMU 2.8): Starting afresh
> +=C2=A0=C2=A0=C2=A0=C2=A0with the original example disk image chain, wi=
th a total of four
> +=C2=A0=C2=A0=C2=A0=C2=A0images, it is possible to copy contents from i=
mage [B] into image
> +=C2=A0=C2=A0=C2=A0=C2=A0[C].=C2=A0=C2=A0Once the copy is finished, ima=
ge [B] can now be (optionally)
> +=C2=A0=C2=A0=C2=A0=C2=A0discarded; and the backing file pointer of ima=
ge [C] will be
> +=C2=A0=C2=A0=C2=A0=C2=A0adjusted to point to [A].=C2=A0=C2=A0I.e. afte=
r performing "intermediate
> +=C2=A0=C2=A0=C2=A0=C2=A0streaming" of [B] into [C], the resulting imag=
e chain will be (where
> +=C2=A0=C2=A0=C2=A0=C2=A0live QEMU is writing to [D]):
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[A] <-- [C] <-- [D]
> +
> +
> +QMP invocation for ``block-stream``
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +For case (1), to merge contents of all the backing files into the acti=
ve
> +layer, where 'node-D' is the current active image (by default
> +``block-stream`` will flatten the entire chain); ``qmp-shell`` (and it=
s
> +corresponding JSON output):
> +
> +::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0(QEMU) block-stream device=3Dnode-D job-id=3Dj=
ob0
> +=C2=A0=C2=A0=C2=A0=C2=A0{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"execute": "block-stre=
am",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"arguments": {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
"device": "node-D",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
"job-id": "job0"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> +=C2=A0=C2=A0=C2=A0=C2=A0}
> +
> +For case (2), merge contents of the images [B] and [C] into [D], where
> +image [D] ends up referring to image [A] as its backing file:
> +
> +::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0(QEMU) block-stream device=3Dnode-D base-node=3D=
node-A job-id=3Djob0
> +
> +And for case (3), of "intermediate" streaming", merge contents of imag=
es
> +[B] into [C], where [C] ends up referring to [A] as its backing image:
> +
> +::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0(QEMU) block-stream device=3Dnode-C base-node=3D=
node-A job-id=3Djob0
> +
> +Progress of a ``block-stream`` operation can be monitored via the QMP
> +command:
> +
> +::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0(QEMU) query-block-jobs
> +=C2=A0=C2=A0=C2=A0=C2=A0{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"execute": "query-bloc=
k-jobs",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"arguments": {}
> +=C2=A0=C2=A0=C2=A0=C2=A0}
> +
> +
> +Once the ``block-stream`` operation has completed, QEMU will emit an
> +event, ``BLOCK_JOB_COMPLETED``.=C2=A0=C2=A0The intermediate overlays r=
emain valid,
> +and can now be (optionally) discarded, or retained to create further
> +overlays based on them.=C2=A0=C2=A0Finally, the ``block-stream`` jobs =
can be
> +restarted at anytime.
> +
> +
> +Live block commit --- ``block-commit``
> +--------------------------------------
> +
> +The ``block-commit`` command lets you to live merge data from overlay
> +images into backing file(s).=C2=A0=C2=A0Since QEMU 2.0, this includes =
"live active
> +commit" (i.e. it is possible to merge the "active layer", the right-mo=
st
> +image in a disk image chain where live QEMU will be writing to, into t=
he
> +base image).=C2=A0=C2=A0This is analogous to ``block-stream``, but in =
opposite
> +direction.
> +
> +Again, starting afresh with our example disk image chain, where live
> +QEMU is writing to the right-most image in the chain, [D]:
> +
> +::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0[A] <-- [B] <-- [C] <-- [D]
> +
> +The disk image chain can be shortened in one of the following ways:
> +
> +(1) Commit content from only image [B] into image [A].=C2=A0=C2=A0The =
resulting
> +=C2=A0=C2=A0=C2=A0=C2=A0chain is the following, where image [C] is adj=
usted to point at [A]
> +=C2=A0=C2=A0=C2=A0=C2=A0as its new backing file:
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[A] <-- [C] <-- [D]
> +
> +(2) Commit content from images [B] and [C] into image [A].=C2=A0=C2=A0=
The
> +=C2=A0=C2=A0=C2=A0=C2=A0resulting chain, where image [D] is adjusted t=
o point to image [A]
> +=C2=A0=C2=A0=C2=A0=C2=A0as its new backing file:
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[A] <-- [D]
> +
> +(3) Commit content from images [B], [C], and the active layer [D] into
> +=C2=A0=C2=A0=C2=A0=C2=A0image [A].=C2=A0=C2=A0The resulting chain (in =
this case, a consolidated single
> +=C2=A0=C2=A0=C2=A0=C2=A0image):
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[A]
> +
> +(4) Commit content from image only image [C] into image [B].=C2=A0=C2=A0=
The
> +=C2=A0=C2=A0=C2=A0=C2=A0resulting chain:
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0::
> +
> +	[A] <-- [B] <-- [D]
> +
> +(5) Commit content from image [C] and the active layer [D] into image
> +=C2=A0=C2=A0=C2=A0=C2=A0[B].=C2=A0=C2=A0The resulting chain:
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0::
> +
> +	[A] <-- [B]
> +
> +
> +QMP invocation for ``block-commit``
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +For case (1), from the previous section -- merge contents only from
> +image [B] into image [A], the invocation is as following:
> +
> +::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0(QEMU) block-commit device=3Dnode-D base=3Da.q=
cow2 top=3Db.qcow2 job-id=3Djob0
> +=C2=A0=C2=A0=C2=A0=C2=A0{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"execute": "block-comm=
it",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"arguments": {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
"device": "node-D",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
"job-id": "job0",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
"top": "b.qcow2",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
"base": "a.qcow2"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> +=C2=A0=C2=A0=C2=A0=C2=A0}
> +
> +Once the above ``block-commit`` operation has completed, a
> +``BLOCK_JOB_COMPLETED`` event will be issued, and no further action is
> +required.=C2=A0=C2=A0The end result being, the backing file of image [=
C] is
> +adjusted to point to image [A], and the original 4-image chain will en=
d
> +up being transformed to:
> +
> +::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0[A] <-- [C] <-- [D]
> +
> +NB: The intermdiate image [B] is invalid (as in: no more further
> +overlays based on it can be created) and, therefore, should be dropped=
.
> +
> +
> +However, case (3), the "active ``block-commit``", is a *two-phase*
> +operation: in the first phase, the content from the active overlay,
> +along with the intermediate overlays, is copied into the backing file
> +(also called, the base image); in the second phase, adjust the said
> +backing file as the current active image -- possible via issuing the
> +command ``block-job-complete``.=C2=A0=C2=A0[Optionally, the operation =
can be
> +cancelled, by issuing the command ``block-job-cancel``, but be careful
> +when doing this.]
> +
> +Once the 'commit' operation (started by ``block-commit``) has complete=
d,
> +the event ``BLOCK_JOB_READY`` is emitted, signalling the synchronizati=
on
> +has finished, and the job can be gracefully completed, by issuing
> +``block-job-complete``.=C2=A0=C2=A0(Until such a command is issued, th=
e 'commit'
> +operation remains active.)
> +
> +So, the following is the flow for case (3), "active ``block-commit``" =
--
> +-- to convert a disk image chain such as this:
> +
> +::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0[A] <-- [B] <-- [C] <-- [D]
> +
> +Into (where content from all the subsequent overlays, [B], and [C],
> +including the active layer, [D], is committed back to [A] -- which is
> +where live QEMU is performing all its current writes):
> +
> +::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0[A]
> +
> +Start the "active ``block-commit``" operation:
> +
> +::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0(QEMU) block-commit device=3Dnode-D base=3Da.q=
cow2 top=3Dd.qcow2 job-id=3Djob0
> +=C2=A0=C2=A0=C2=A0=C2=A0{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"execute": "block-comm=
it",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"arguments": {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
"device": "node-D",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
"job-id": "job0",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
"top": "d.qcow2",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
"base": "a.qcow2"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> +=C2=A0=C2=A0=C2=A0=C2=A0}
> +
> +
> +Once the synchronization has completed, the event ``BLOCK_JOB_READY`` =
will
> +be emitted.
> +
> +Then, (optionally) query for the status of the active block operations
> +(we can see the 'commit' job is now ready to be completed, as indicate=
d
> +by the line *"ready": true*):
> +
> +::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0(QEMU) query-block-jobs
> +=C2=A0=C2=A0=C2=A0=C2=A0{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"execute": "query-bloc=
k-jobs",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"arguments": {}
> +=C2=A0=C2=A0=C2=A0=C2=A0}
> +=C2=A0=C2=A0=C2=A0=C2=A0{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"return": [
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0"busy": false,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0"type": "commit",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0"len": 1376256,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0"paused": false,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0"ready": true,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0"io-status": "ok",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0"offset": 1376256,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0"device": "job0",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0"speed": 0
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
}
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0]
> +=C2=A0=C2=A0=C2=A0=C2=A0}
> +
> +Gracefully, complete the 'commit' block device job:
> +
> +::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0(QEMU) block-job-complete device=3Djob0
> +=C2=A0=C2=A0=C2=A0=C2=A0{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"execute": "block-job-=
complete",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"arguments": {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
"device": "job0"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> +=C2=A0=C2=A0=C2=A0=C2=A0}
> +=C2=A0=C2=A0=C2=A0=C2=A0{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"return": {}
> +=C2=A0=C2=A0=C2=A0=C2=A0}
> +
> +Finally, once the above job is completed, an event ``BLOCK_JOB_COMPLET=
ED``
> +will be emitted.
> +
> +[The invocation for rest of the cases, discussed in the previous
> +section, is omitted for brevity.]

This looks like a:

  .. note::

> +
> +
> +Live disk synchronization --- ``drive-mirror`` and ``blockdev-mirror``
> +----------------------------------------------------------------------
> +
> +Synchronize a running disk image chain (all or part of it) to a target
> +image.
> +
> +Again, given our familiar disk image chain:
> +
> +::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0[A] <-- [B] <-- [C] <-- [D]
> +
> +The ``drive-mirror`` (and its newer equivalent ``blockdev-mirror``) al=
lows
> +you to copy data from the entire chain into a single target image (whi=
ch
> +can be located on a different host).
> +
> +Once a 'mirror' job has started, there are two possible actions when a
> +``drive-mirror`` job is active:
> +
> +(1) Issuing the command ``block-job-cancel``: will -- after completing
> +=C2=A0=C2=A0=C2=A0=C2=A0synchronization of the content from the disk i=
mage chain to the
> +=C2=A0=C2=A0=C2=A0=C2=A0target image, [E] -- create a point-in-time (w=
hich is at the time of
> +=C2=A0=C2=A0=C2=A0=C2=A0*triggering* the cancel command) copy, contain=
ed in image [E], of
> +=C2=A0=C2=A0=C2=A0=C2=A0the backing file.
> +
> +(2) Issuing the command ``block-job-complete``: will, after completing
> +=C2=A0=C2=A0=C2=A0=C2=A0synchronization of the content, adjust the gue=
st device (i.e. live
> +=C2=A0=C2=A0=C2=A0=C2=A0QEMU) to point to the target image, and, causi=
ng all the new writes
> +=C2=A0=C2=A0=C2=A0=C2=A0from this point on to happen there.=C2=A0=C2=A0=
One use case for this is live
> +=C2=A0=C2=A0=C2=A0=C2=A0storage migration.
> +
> +
> +QMP invocation for ``drive-mirror``
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +To copy the contents of the entire disk image chain, from [A] all the
> +way to [D], to a new target (``drive-mirror`` will create the destinat=
ion
> +file, if it doesn't already exist), call it [E]:
> +
> +::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0(QEMU) drive-mirror device=3Dnode-D target=3De=
.qcow2 sync=3Dfull job-id=3Djob0
> +=C2=A0=C2=A0=C2=A0=C2=A0{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"execute": "drive-mirr=
or",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"arguments": {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
"device": "node-D",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
"job-id": "job0",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
"target": "e.qcow2",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
"sync": "full"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> +=C2=A0=C2=A0=C2=A0=C2=A0}
> +
> +The ``"sync": "full"``, from the above, means: copy the *entire* chain
> +to the destination.
> +
> +Following the above, querying for active block jobs will show that a
> +'mirror' job is "ready" to be completed (and QEMU will also emit an
> +event, ``BLOCK_JOB_READY``):
> +
> +::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0(QEMU) query-block-jobs
> +=C2=A0=C2=A0=C2=A0=C2=A0{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"execute": "query-bloc=
k-jobs",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"arguments": {}
> +=C2=A0=C2=A0=C2=A0=C2=A0}
> +=C2=A0=C2=A0=C2=A0=C2=A0{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"return": [
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0"busy": false,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0"type": "mirror",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0"len": 21757952,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0"paused": false,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0"ready": true,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0"io-status": "ok",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0"offset": 21757952,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0"device": "job0",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0"speed": 0
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
}
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0]
> +=C2=A0=C2=A0=C2=A0=C2=A0}
> +
> +And, as mentioned in the previous section, the two possible options ca=
n
> +be taken:
> +
> +(a) Create a point-in-time snapshot by ending the synchronization.=C2=A0=
=C2=A0The
> +=C2=A0=C2=A0=C2=A0=C2=A0point-in-time is at the time of *ending* the s=
ync.=C2=A0=C2=A0(The result of
> +=C2=A0=C2=A0=C2=A0=C2=A0the following being: the target image, [E], wi=
ll be populated with
> +=C2=A0=C2=A0=C2=A0=C2=A0content from the entire chain, [A] to [D].)
> +
> +::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0(QEMU) block-job-cancel device=3Djob0
> +=C2=A0=C2=A0=C2=A0=C2=A0{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"execute": "block-job-=
cancel",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"arguments": {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
"device": "job0"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> +=C2=A0=C2=A0=C2=A0=C2=A0}
> +
> +(b) Or, complete the operation and pivot the live QEMU to the target
> +=C2=A0=C2=A0=C2=A0=C2=A0copy:
> +
> +::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0(QEMU) block-job-complete device=3Djob0
> +
> +In either of the above cases, if you once again run the
> +`query-block-jobs` command, there should not be any active block
> +operation.
> +
> +Comparing 'commit' and 'mirror': In both then cases, the overlay image=
s
> +can be discarded.=C2=A0=C2=A0However, with 'commit', the *existing* ba=
se image
> +will be modified (by updating it with contents from overlays); while i=
n
> +the case of 'mirror', a *new* target image is populated with the data
> +from the disk image chain.
> +
> +
> +QMP invocation for live storage migration with ``drive-mirror`` + NBD
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Live storage migration (without shared storage setup) is one of the
> +common use-cases.=C2=A0=C2=A0I.e. given the disk image chain:
> +
> +::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0[A] <-- [B] <-- [C] <-- [D]
> +
> +Instead of copying content from the entire chain, synchronize *only* t=
he
> +contents of the *top*-most disk image (i.e. the active layer), [D], to=
 a
> +target, say, [TargetDisk]. (**NB**: The destination must already have
> +the contents of the backing chain (involving images [A], [B], and [C])
> +visible via other means, whether by ``cp``, or ``rsync`` or by some
> +storage-array-specific command.)=C2=A0=C2=A0Sometimes, this is also re=
ferred to as
> +"shallow copy" (because: only the "active layer", and not the rest of
> +the image chain, is copied to the destiniation).
> +
> +The following is the sequence of QMP commands to achieve this setup.
> +
> +On the destination (for the sake of simplicity, we're using the same
> +local host as both, source and destination), we expect the contents
> +
> +::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0$ qemu-img create -f qcow2 -b ./Contents-of-A-=
B-C.qcow2 \
> +=C2=A0=C2=A0=C2=A0=C2=A0-F qcow2 ./target-disk.qcow2
> +
> +We need a destination QEMU (we already have a source QEMU running, tha=
t
> +was discussed in the section: `Interacting with a QEMU instance`_)
> +instance, with the following invocation.=C2=A0=C2=A0(For the sake of s=
implicity
> +we're using a destination QEMU on the same host, but it could be locat=
ed
> +on a different host):
> +
> +::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0$ ./x86_64-softmmu/qemu-system-x86_64 -display=
 none -nodefconfig \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-M q35 -nodefaults -m =
512 \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-blockdev node-name=3D=
node-
> TargetDisk,driver=3Dqcow2,file.driver=3Dfile,file.node-
> name=3Dfile,file.filename=3D./target-disk.qcow2 \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-device virtio-blk,dri=
ve=3Dnode-TargetDisk,id=3Dvirtio0 \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-S -monitor stdio -qmp=
 unix:./qmp-sock2,server,nowait \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-incoming tcp:localhos=
t:6666
> +
> +Given the disk image chain on source QEMU:
> +
> +::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0[A] <-- [B] <-- [C] <-- [D]
> +
> +On the destination host, it is expected that the contents of the chain
> +"[A] <-- [B] <-- [C]" is *already* present, and therefore copy *only*
> +the contents of image [D].
> +
> +(1) [On *destination* QEMU] As part of the first step, start the built=
-in
> +=C2=A0=C2=A0=C2=A0=C2=A0NBD server on given host and port:
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(QEMU) nbd-server-star=
t
> addr=3D{"type":"inet","data":{"host":"::","port":"49153"}}
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
"execute": "nbd-server-start",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
"arguments": {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0"addr": {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"data": {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"=
host": "::",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"=
port": "49153"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0},
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"type": "inet"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0}
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
}
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> +
> +(2) [On *destination* QEMU] And export the destination disk image usin=
g
> +=C2=A0=C2=A0=C2=A0=C2=A0QEMU's built-in NBD server:
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(QEMU) nbd-server-add =
device=3Dnode-TargetDisk writable=3Dtrue
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
"execute": "nbd-server-add",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
"arguments": {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0"device": "node-TargetDisk"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
}
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> +
> +(3) [On *source* QEMU] Then, invoke ``drive-mirror`` (NB: since we're =
runing
> +=C2=A0=C2=A0=C2=A0=C2=A0``drive-mirror`` with ``mode=3Dexisting`` (mea=
ning: synchronize to a
> +=C2=A0=C2=A0=C2=A0=C2=A0pre-created file, therefore 'existing', file o=
n the target host),
> +=C2=A0=C2=A0=C2=A0=C2=A0with the synchronization mode as 'top' (``"syn=
c: "top"``):
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(QEMU) drive-mirror de=
vice=3Dnode-D
> target=3Dnbd:localhost:49153:exportname=3Dnode-TargetDisk sync=3Dtop mo=
de=3Dexisting
> job-id=3Djob0
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
"execute": "drive-mirror",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
"arguments": {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0"device": "node-D",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0"mode": "existing",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0"job-id": "job0",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0"target": "nbd:localhost:49153:exportname=3Dnode-=
TargetDisk",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0"sync": "top"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
}
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> +
> +(4) [On *source* QEMU] Once ``drive-mirror`` copies the entire data, a=
nd the
> +=C2=A0=C2=A0=C2=A0=C2=A0event ``BLOCK_JOB_READY`` is emitted, issue ``=
block-job-cancel`` to
> +=C2=A0=C2=A0=C2=A0=C2=A0gracefully end the synchronization, from sourc=
e QEMU:
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(QEMU) block-job-cance=
l device=3Djob0
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
"execute": "block-job-cancel",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
"arguments": {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0"device": "job0"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
}
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> +
> +(5) [On *destination* QEMU] Then, stop the NBD server:
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(QEMU) nbd-server-stop
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
"execute": "nbd-server-stop",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
"arguments": {}
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> +
> +(6) [On *destination* QEMU] Finally, resume the guest vCPUs by issuing=
 the
> +=C2=A0=C2=A0=C2=A0=C2=A0QMP command `cont`:
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(QEMU) cont
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
"execute": "cont",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
"arguments": {}
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> +
> +
> +NOTE: Higher-level libraries (e.g. libvirt) automate the entire above
> +process.
> +
> +
> +Notes on ``blockdev-mirror``
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The ``blockdev-mirror`` command is equivalent in core functionality to
> +``drive-mirror``, except that it operates at node-level in a BDS graph=
.
> +
> +Also: for ``blockdev-mirror``, the 'target' image needs to be explicit=
ly
> +created (using ``qemu-img``) and attach it to live QEMU via
> +``blockdev-add``, which assigns a name to the to-be created target nod=
e.
> +
> +E.g. the sequence of actions to create a point-in-time backup of an
> +entire disk image chain, to a target, using ``blockdev-mirror`` would =
be:
> +
> +(0) Create the QCOW2 overlays, to arrive at a backing chain of desired
> +=C2=A0=C2=A0=C2=A0=C2=A0depth
> +
> +(1) Create the target image (using ``qemu-img``), say, backup.qcow2
> +
> +(2) Attach the above created backup.qcow2 file, run-time, using
> +=C2=A0=C2=A0=C2=A0=C2=A0``blockdev-add`` to QEMU
> +
> +(3) Perform ``blockdev-mirror`` (use ``"sync": "full"`` to copy the
> +=C2=A0=C2=A0=C2=A0=C2=A0entire chain to the target).=C2=A0=C2=A0And ob=
serve for the event
> +=C2=A0=C2=A0=C2=A0=C2=A0``BLOCK_JOB_READY``
> +
> +(4) Optionally, query for active block jobs, there should be a 'mirror=
'
> +=C2=A0=C2=A0=C2=A0=C2=A0job ready to be completed
> +
> +(5) Gracefully complete the 'mirror' block device job, and observe for
> +=C2=A0=C2=A0=C2=A0=C2=A0the event ``BLOCK_JOB_COMPLETED``
> +
> +(6) Shutdown the guest, by issuing the QMP ``quit`` command, so that
> +=C2=A0=C2=A0=C2=A0=C2=A0caches are flushed
> +
> +(7) Then, finally, compare the contents of the disk image chain, and
> +=C2=A0=C2=A0=C2=A0=C2=A0the target copy with ``qemu-img compare``.=C2=A0=
=C2=A0You should notice:
> +=C2=A0=C2=A0=C2=A0=C2=A0"Images are identical"
> +
> +
> +QMP invocation for ``blockdev-mirror``
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Given the disk image chain:
> +
> +::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0[A] <-- [B] <-- [C] <-- [D]
> +
> +To copy the contents of the entire disk image chain, from [A] all the
> +way to [D], to a new target, call it [E].=C2=A0=C2=A0The following is =
the flow.
> +
> +Create the overlay images, [B], [C], and [D]:
> +
> +::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0(QEMU) blockdev-snapshot-sync node-name=3Dnode=
-A snapshot-file=3Db.qcow2
> snapshot-node-name=3Dnode-B format=3Dqcow2
> +=C2=A0=C2=A0=C2=A0=C2=A0(QEMU) blockdev-snapshot-sync node-name=3Dnode=
-B snapshot-file=3Dc.qcow2
> snapshot-node-name=3Dnode-C format=3Dqcow2
> +=C2=A0=C2=A0=C2=A0=C2=A0(QEMU) blockdev-snapshot-sync node-name=3Dnode=
-C snapshot-file=3Dd.qcow2
> snapshot-node-name=3Dnode-D format=3Dqcow2
> +
> +Create the target image, [E]:
> +
> +::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0$ qemu-img create -f qcow2 e.qcow2 39M
> +
> +Add the above created target image to QEMU, via ``blockdev-add``:
> +
> +::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0(QEMU) blockdev-add driver=3Dqcow2 node-name=3D=
node-E
> file=3D{"driver":"file","filename":"e.qcow2"}
> +=C2=A0=C2=A0=C2=A0=C2=A0{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"execute": "blockdev-a=
dd",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"arguments": {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
"node-name": "node-E",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
"driver": "qcow2",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
"file": {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0"driver": "file",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0"filename": "e.qcow2"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
}
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> +=C2=A0=C2=A0=C2=A0=C2=A0}
> +
> +Perform ``blockdev-mirror``, and observe for the event
> +``BLOCK_JOB_READY``:
> +
> +::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0(QEMU) blockdev-mirror device=3Dnode-B target=3D=
node-E sync=3Dfull job-id=3Djob0
> +=C2=A0=C2=A0=C2=A0=C2=A0{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"execute": "blockdev-m=
irror",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"arguments": {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
"device": "node-D",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
"job-id": "job0",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
"target": "node-E",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
"sync": "full"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> +=C2=A0=C2=A0=C2=A0=C2=A0}
> +
> +Query for active block jobs, there should be a 'mirror' job ready:
> +
> +::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0(QEMU) query-block-jobs
> +=C2=A0=C2=A0=C2=A0=C2=A0{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"execute": "query-bloc=
k-jobs",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"arguments": {}
> +=C2=A0=C2=A0=C2=A0=C2=A0}
> +=C2=A0=C2=A0=C2=A0=C2=A0{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"return": [
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0"busy": false,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0"type": "mirror",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0"len": 21561344,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0"paused": false,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0"ready": true,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0"io-status": "ok",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0"offset": 21561344,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0"device": "job0",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0"speed": 0
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
}
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0]
> +=C2=A0=C2=A0=C2=A0=C2=A0}
> +
> +Gracefully complete the block device job operation, and observe for th=
e
> +event ``BLOCK_JOB_COMPLETED``:
> +
> +::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0(QEMU) block-job-complete device=3Djob0
> +=C2=A0=C2=A0=C2=A0=C2=A0{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"execute": "block-job-=
complete",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"arguments": {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
"device": "job0"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> +=C2=A0=C2=A0=C2=A0=C2=A0}
> +=C2=A0=C2=A0=C2=A0=C2=A0{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"return": {}
> +=C2=A0=C2=A0=C2=A0=C2=A0}
> +
> +Shutdown the guest, by issuing the ``quit`` QMP command:
> +
> +::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0(QEMU) quit
> +=C2=A0=C2=A0=C2=A0=C2=A0{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"execute": "quit",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"arguments": {}
> +=C2=A0=C2=A0=C2=A0=C2=A0}
> +
> +
> +Live disk backup --- ``drive-backup`` and ``blockdev-backup``
> +-------------------------------------------------------------
> +
> +The ``drive-backup`` (and its newer equivalent ``blockdev-backup``) al=
lows
> +you to create a point-in-time snapshot.
> +
> +In this case, the point-in-time is when you *start* the ``drive-backup=
``
> +(or its newer equivalent ``blockdev-backup``) command.
> +
> +
> +QMP invocation for ``drive-backup``
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Yet again, starting afresh with our example disk image chain:
> +
> +::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0[A] <-- [B] <-- [C] <-- [D]
> +
> +To create a target image [E], with content populated from image [A] to
> +[D], from the above chain, the following is the syntax.=C2=A0=C2=A0(If=
 the target
> +image does not exist, ``drive-backup`` will create it.)
> +
> +::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0(QEMU) drive-backup device=3Dnode-D sync=3Dful=
l target=3De.qcow2 job-id=3Djob0
> +=C2=A0=C2=A0=C2=A0=C2=A0{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"execute": "drive-back=
up",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"arguments": {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
"device": "node-D",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
"job-id": "job0",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
"sync": "full",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
"target": "copy-drive-backup.qcow2"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> +=C2=A0=C2=A0=C2=A0=C2=A0}
> +
> +Once the above ``drive-backup`` has completed, a ``BLOCK_JOB_COMPLETED=
``
> event
> +will be issued, indicating the live block device job operation has
> +completed, and no further action is required.
> +
> +
> +Notes on ``blockdev-backup``
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The ``blockdev-backup`` command is equivalent in functionality to
> +``drive-backup``, except that it operates at node-level in a Block Dri=
ver
> +State (BDS) graph.
> +
> +E.g. the sequence of actions to create a point-in-time backup
> +of an entire disk image chain, to a target, using ``blockdev-backup``
> +would be:
> +
> +(0) Create the QCOW2 overlays, to arrive at a backing chain of desired
> +=C2=A0=C2=A0=C2=A0=C2=A0depth
> +
> +(1) Create the target image (using ``qemu-img``), say, backup.qcow2
> +
> +(2) Attach the above created backup.qcow2 file, run-time, using
> +=C2=A0=C2=A0=C2=A0=C2=A0``blockdev-add`` to QEMU
> +
> +(3) Perform ``blockdev-backup`` (use ``"sync": "full"`` to copy the
> +=C2=A0=C2=A0=C2=A0=C2=A0entire chain to the target).=C2=A0=C2=A0And ob=
serve for the event
> +=C2=A0=C2=A0=C2=A0=C2=A0``BLOCK_JOB_COMPLETED``
> +
> +(4) Shutdown the guest, by issuing the QMP ``quit`` command, so that
> +=C2=A0=C2=A0=C2=A0=C2=A0caches are flushed
> +
> +(5) Then, finally, compare the contents of the disk image chain, and
> +=C2=A0=C2=A0=C2=A0=C2=A0the target copy with ``qemu-img compare``.=C2=A0=
=C2=A0You should notice:
> +=C2=A0=C2=A0=C2=A0=C2=A0"Images are identical"
> +
> +The following section shows an example QMP invocation for
> +``blockdev-backup``.
> +
> +QMP invocation for ``blockdev-backup``
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Given, a disk image chain of depth 1, where image [B] is the active
> +overlay (live QEMU is writing to it):
> +
> +::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0[A] <-- [B]
> +
> +The following is the procedure to copy the content from the entire cha=
in
> +to a target image (say, [E]), which has the full content from [A] and
> +[B].
> +
> +Create the overlay, [B]:
> +
> +::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0(QEMU) blockdev-snapshot-sync node-name=3Dnode=
-A snapshot-file=3Db.qcow2
> snapshot-node-name=3Dnode-B format=3Dqcow2
> +=C2=A0=C2=A0=C2=A0=C2=A0{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"execute": "blockdev-s=
napshot-sync",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"arguments": {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
"node-name": "node-A",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
"snapshot-file": "b.qcow2",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
"format": "qcow2",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
"snapshot-node-name": "node-B"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> +=C2=A0=C2=A0=C2=A0=C2=A0}
> +
> +
> +Create a target image, that will contain the copy:
> +
> +::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0$ qemu-img create -f qcow2 e.qcow2 39M
> +
> +Then, add it to QEMU via ``blockdev-add``:
> +
> +::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0(QEMU) blockdev-add driver=3Dqcow2 node-name=3D=
node-E
> file=3D{"driver":"file","filename":"e.qcow2"}
> +=C2=A0=C2=A0=C2=A0=C2=A0{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"execute": "blockdev-a=
dd",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"arguments": {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
"node-name": "node-E",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
"driver": "qcow2",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
"file": {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0"driver": "file",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0"filename": "e.qcow2"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
}
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> +=C2=A0=C2=A0=C2=A0=C2=A0}
> +
> +Then, invoke ``blockdev-backup``, to copy the contents from the entire
> +image chain, consisting of images [A], and [B], to the target image
> +'e.qcow2':
> +
> +::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0(QEMU) blockdev-backup device=3Dnode-B target=3D=
node-E sync=3Dfull job-id=3Djob0
> +=C2=A0=C2=A0=C2=A0=C2=A0{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"execute": "blockdev-b=
ackup",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"arguments": {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
"device": "node-B",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
"job-id": "job0",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
"target": "node-E",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
"sync": "full"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> +=C2=A0=C2=A0=C2=A0=C2=A0}
> +
> +Once the above 'backup' operation has completed, an event,
> +``BLOCK_JOB_COMPLETED``, will be emitted, signalling successful
> +completion.
> +
> +Next, query for any active block device jobs (there should be none):
> +
> +::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0(QEMU) query-block-jobs
> +=C2=A0=C2=A0=C2=A0=C2=A0{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"execute": "query-bloc=
k-jobs",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"arguments": {}
> +=C2=A0=C2=A0=C2=A0=C2=A0}
> +
> +Shutdown the guest (**NB**: the following step is really important; if=
 not
> +done, an error, "Failed to get shared "write" lock on e.qcow2", will b=
e
> +thrown when you do ``qemu-img compare``):
> +
> +::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0(QEMU) quit
> +=C2=A0=C2=A0=C2=A0=C2=A0{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
"execute": "quit",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0"arguments": {}
> +=C2=A0=C2=A0=C2=A0=C2=A0}
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
"return": {}
> +=C2=A0=C2=A0=C2=A0=C2=A0}
> +=C2=A0=C2=A0=C2=A0=C2=A0(QEMU)
> +=C2=A0=C2=A0=C2=A0=C2=A0{u'timestamp': {u'seconds': 1496072942, u'micr=
oseconds': 685292},
> u'event': u'SHUTDOWN'}
> +
> +
> +The end result will be, the image 'e.qcow2' containing a
> +point-in-time backup of the disk image chain -- i.e. contents from
> +images [A], and [B] at the time the ``blockdev-backup`` command was
> +initiated.
> +
> +One way to confirm the backup disk image contains the identical conten=
t
> +with the disk image chain is to compare the backup, and the contents o=
f
> +the chain, you should see "Images are identical".=C2=A0=C2=A0(NB: this=
 is assuming
> +QEMU was launched with `-S` option, which will not start the CPUs at
> +guest boot up):
> +
> +::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0$ qemu-img compare b.qcow2 e.qcow2
> +=C2=A0=C2=A0=C2=A0=C2=A0Warning: Image size mismatch!
> +=C2=A0=C2=A0=C2=A0=C2=A0Images are identical.
> +
> +NOTE: The "Warning: Image size mismatch!" is expected, as we created t=
he
> +target image (e.qcow2) with 39M size.
> diff --git a/docs/live-block-ops.txt b/docs/live-block-ops.txt
> deleted file mode 100644
> index 2211d14..0000000
> --- a/docs/live-block-ops.txt
> +++ /dev/null
> @@ -1,72 +0,0 @@
> -LIVE BLOCK OPERATIONS
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -High level description of live block operations. Note these are not
> -supported for use with the raw format at the moment.
> -
> -Note also that this document is incomplete and it currently only
> -covers the 'stream' operation. Other operations supported by QEMU such
> -as 'commit', 'mirror' and 'backup' are not described here yet. Please
> -refer to the qapi/block-core.json file for an overview of those.
> -
> -Snapshot live merge
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -Given a snapshot chain, described in this document in the following
> -format:
> -
> -[A] <- [B] <- [C] <- [D] <- [E]
> -
> -Where the rightmost object ([E] in the example) described is the curre=
nt
> -image which the guest OS has write access to. To the left of it is its=
 base
> -image, and so on accordingly until the leftmost image, which has no
> -base.
> -
> -The snapshot live merge operation transforms such a chain into a
> -smaller one with fewer elements, such as this transformation relative
> -to the first example:
> -
> -[A] <- [E]
> -
> -Data is copied in the right direction with destination being the
> -rightmost image, but any other intermediate image can be specified
> -instead. In this example data is copied from [C] into [D], so [D] can
> -be backed by [B]:
> -
> -[A] <- [B] <- [D] <- [E]
> -
> -The operation is implemented in QEMU through image streaming facilitie=
s.
> -
> -The basic idea is to execute 'block_stream virtio0' while the guest is
> -running. Progress can be monitored using 'info block-jobs'. When the
> -streaming operation completes it raises a QMP event. 'block_stream'
> -copies data from the backing file(s) into the active image. When finis=
hed,
> -it adjusts the backing file pointer.
> -
> -The 'base' parameter specifies an image which data need not be
> -streamed from. This image will be used as the backing file for the
> -destination image when the operation is finished.
> -
> -In the first example above, the command would be:
> -
> -(qemu) block_stream virtio0 file-A.img
> -
> -In order to specify a destination image different from the active
> -(rightmost) one we can use its node name instead.
> -
> -In the second example above, the command would be:
> -
> -(qemu) block_stream node-D file-B.img
> -
> -Live block copy
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -To copy an in use image to another destination in the filesystem, one
> -should create a live snapshot in the desired destination, then stream
> -into that image. Example:
> -
> -(qemu) snapshot_blkdev ide0-hd0 /new-path/disk.img qcow2
> -
> -(qemu) block_stream ide0-hd0
> -
> -
