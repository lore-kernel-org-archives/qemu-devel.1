Received: from eggs.gnu.org ([2001:4830:134:3::10]:59304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dORLh-0000fx-KG
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:22:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dORLf-0007WB-UO
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:22:21 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 23 Jun 2017 18:21:06 +0200
Message-Id: <1498234919-27316-9-git-send-email-kwolf@redhat.com>
In-Reply-To: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
References: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 08/61] doc: Document generic -blockdev options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

This adds documentation for the -blockdev options that apply to all
nodes independent of the block driver used.

All options that are shared by -blockdev and -drive are now explained in
the section for -blockdev. The documentation of -drive mentions that all
-blockdev options are accepted as well.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 qemu-options.hx | 108 +++++++++++++++++++++++++++++++++++++++++---------=
------
 1 file changed, 79 insertions(+), 29 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 30c4f98..db20866 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -610,6 +610,53 @@ DEF("blockdev", HAS_ARG, QEMU_OPTION_blockdev,
     "          [,read-only=3Don|off][,detect-zeroes=3Don|off|unmap]\n"
     "          [,driver specific parameters...]\n"
     "                configure a block backend\n", QEMU_ARCH_ALL)
+STEXI
+@item -blockdev @var{option}[,@var{option}[,@var{option}[,...]]]
+@findex -blockdev
+
+Define a new block driver node.
+
+@table @option
+@item Valid options for any block driver node:
+
+@table @code
+@item driver
+Specifies the block driver to use for the given node.
+@item node-name
+This defines the name of the block driver node by which it will be refer=
enced
+later. The name must be unique, i.e. it must not match the name of a dif=
ferent
+block driver node, or (if you use @option{-drive} as well) the ID of a d=
rive.
+
+If no node name is specified, it is automatically generated. The generat=
ed node
+name is not intended to be predictable and changes between QEMU invocati=
ons.
+For the top level, an explicit node name must be specified.
+@item read-only
+Open the node read-only. Guest write attempts will fail.
+@item cache.direct
+The host page cache can be avoided with @option{cache.direct=3Don}. This=
 will
+attempt to do disk IO directly to the guest's memory. QEMU may still per=
form an
+internal copy of the data.
+@item cache.no-flush
+In case you don't care about data integrity over host failures, you can =
use
+@option{cache.no-flush=3Don}. This option tells QEMU that it never needs=
 to write
+any data to the disk but can instead keep things in cache. If anything g=
oes
+wrong, like your host losing power, the disk storage getting disconnecte=
d
+accidentally, etc. your image will most probably be rendered unusable.
+@item discard=3D@var{discard}
+@var{discard} is one of "ignore" (or "off") or "unmap" (or "on") and con=
trols
+whether @code{discard} (also known as @code{trim} or @code{unmap}) reque=
sts are
+ignored or passed to the filesystem. Some machine types may not support
+discard requests.
+@item detect-zeroes=3D@var{detect-zeroes}
+@var{detect-zeroes} is "off", "on" or "unmap" and enables the automatic
+conversion of plain zero writes by the OS to driver specific optimized
+zero write commands. You may even choose "unmap" if @var{discard} is set
+to "unmap" to allow a zero write to be converted to an @code{unmap} oper=
ation.
+@end table
+
+@end table
+
+ETEXI
=20
 DEF("drive", HAS_ARG, QEMU_OPTION_drive,
     "-drive [file=3Dfile][,if=3Dtype][,bus=3Dn][,unit=3Dm][,media=3Dd][,=
index=3Di]\n"
@@ -630,7 +677,12 @@ STEXI
 @item -drive @var{option}[,@var{option}[,@var{option}[,...]]]
 @findex -drive
=20
-Define a new drive. Valid options are:
+Define a new drive. This includes creating a block driver node (the back=
end) as
+well as a guest device, and is mostly a shortcut for defining the corres=
ponding
+@option{-blockdev} and @option{-device} options.
+
+@option{-drive} accepts all options that are accepted by @option{-blockd=
ev}. In
+addition, it knows the following options:
=20
 @table @option
 @item file=3D@var{file}
@@ -657,11 +709,31 @@ These options have the same definition as they have=
 in @option{-hdachs}.
 @var{snapshot} is "on" or "off" and controls snapshot mode for the given=
 drive
 (see @option{-snapshot}).
 @item cache=3D@var{cache}
-@var{cache} is "none", "writeback", "unsafe", "directsync" or "writethro=
ugh" and controls how the host cache is used to access block data.
+@var{cache} is "none", "writeback", "unsafe", "directsync" or "writethro=
ugh"
+and controls how the host cache is used to access block data. This is a
+shortcut that sets the @option{cache.direct} and @option{cache.no-flush}
+options (as in @option{-blockdev}), and additionally @option{cache.write=
back},
+which provides a default for the @option{write-cache} option of block gu=
est
+devices (as in @option{-device}). The modes correspond to the following
+settings:
+
+@c Our texi2pod.pl script doesn't support @multitable, so fall back to u=
sing
+@c plain ASCII art (well, UTF-8 art really). This looks okay both in the=
 manpage
+@c and the HTML output.
+@example
+@             =E2=94=82 cache.writeback   cache.direct   cache.no-flush
+=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
+writeback    =E2=94=82 on                off            off
+none         =E2=94=82 on                on             off
+writethrough =E2=94=82 off               off            off
+directsync   =E2=94=82 off               on             off
+unsafe       =E2=94=82 on                off            on
+@end example
+
+The default mode is @option{cache=3Dwriteback}.
+
 @item aio=3D@var{aio}
 @var{aio} is "threads", or "native" and selects between pthread based di=
sk I/O and native Linux AIO.
-@item discard=3D@var{discard}
-@var{discard} is one of "ignore" (or "off") or "unmap" (or "on") and con=
trols whether @dfn{discard} (also known as @dfn{trim} or @dfn{unmap}) req=
uests are ignored or passed to the filesystem.  Some machine types may no=
t support discard requests.
 @item format=3D@var{format}
 Specify which disk @var{format} will be used rather than detecting
 the format.  Can be used to specify format=3Draw to avoid interpreting
@@ -676,16 +748,9 @@ Specify which @var{action} to take on write and read=
 errors. Valid actions are:
 "report" (report the error to the guest), "enospc" (pause QEMU only if t=
he
 host disk is full; report the error to the guest otherwise).
 The default setting is @option{werror=3Denospc} and @option{rerror=3Drep=
ort}.
-@item readonly
-Open drive @option{file} as read-only. Guest write attempts will fail.
 @item copy-on-read=3D@var{copy-on-read}
 @var{copy-on-read} is "on" or "off" and enables whether to copy read bac=
king
 file sectors into the image file.
-@item detect-zeroes=3D@var{detect-zeroes}
-@var{detect-zeroes} is "off", "on" or "unmap" and enables the automatic
-conversion of plain zero writes by the OS to driver specific optimized
-zero write commands. You may even choose "unmap" if @var{discard} is set
-to "unmap" to allow a zero write to be converted to an UNMAP operation.
 @item bps=3D@var{b},bps_rd=3D@var{r},bps_wr=3D@var{w}
 Specify bandwidth throttling limits in bytes per second, either for all =
request
 types or for reads or writes only.  Small values can lead to timeouts or=
 hangs
@@ -712,34 +777,19 @@ prevent guests from circumventing throttling limits=
 by using many small disks
 instead of a single larger disk.
 @end table
=20
-By default, the @option{cache=3Dwriteback} mode is used. It will report =
data
+By default, the @option{cache.writeback=3Don} mode is used. It will repo=
rt data
 writes as completed as soon as the data is present in the host page cach=
e.
 This is safe as long as your guest OS makes sure to correctly flush disk=
 caches
 where needed. If your guest OS does not handle volatile disk write cache=
s
 correctly and your host crashes or loses power, then the guest may exper=
ience
 data corruption.
=20
-For such guests, you should consider using @option{cache=3Dwritethrough}=
. This
+For such guests, you should consider using @option{cache.writeback=3Doff=
}. This
 means that the host page cache will be used to read and write data, but =
write
 notification will be sent to the guest only after QEMU has made sure to =
flush
 each write to the disk. Be aware that this has a major impact on perform=
ance.
=20
-The host page cache can be avoided entirely with @option{cache=3Dnone}. =
 This will
-attempt to do disk IO directly to the guest's memory.  QEMU may still pe=
rform
-an internal copy of the data. Note that this is considered a writeback m=
ode and
-the guest OS must handle the disk write cache correctly in order to avoi=
d data
-corruption on host crashes.
-
-The host page cache can be avoided while only sending write notification=
s to
-the guest when the data has been flushed to the disk using
-@option{cache=3Ddirectsync}.
-
-In case you don't care about data integrity over host failures, use
-@option{cache=3Dunsafe}. This option tells QEMU that it never needs to w=
rite any
-data to the disk but can instead keep things in cache. If anything goes =
wrong,
-like your host losing power, the disk storage getting disconnected accid=
entally,
-etc. your image will most probably be rendered unusable.   When using
-the @option{-snapshot} option, unsafe caching is always used.
+When using the @option{-snapshot} option, unsafe caching is always used.
=20
 Copy-on-read avoids accessing the same backing file sectors repeatedly a=
nd is
 useful when the backing file is over a slow network.  By default copy-on=
-read
--=20
1.8.3.1
