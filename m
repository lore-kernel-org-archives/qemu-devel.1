Received: from eggs.gnu.org ([209.51.188.92]:39934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gliNq-0001Fb-08
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 17:49:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gliNl-00053e-Rx
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 17:49:32 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon, 21 Jan 2019 16:48:49 -0600
Message-Id: <20190121224907.26634-4-eblake@redhat.com>
In-Reply-To: <20190121224907.26634-1-eblake@redhat.com>
References: <20190121224907.26634-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 03/21] qemu-nbd: Enhance man page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Richard W . M . Jones" <rjones@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

Document some useful qemu-nbd command lines. Mention some restrictions
on particular options, like -p being only for MBR images, or -c/-d
being Linux-only.  Update some text given the recent change to no
longer serve oldstyle protocol (missed in commit 7f7dfe2a).  Also,
consistently use trailing '.' in describing options.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Richard W.M. Jones <rjones@redhat.com>
Message-Id: <20190117193658.16413-4-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qemu-nbd.texi | 94 ++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 75 insertions(+), 19 deletions(-)

diff --git a/qemu-nbd.texi b/qemu-nbd.texi
index 96b1546006a..f218291bf30 100644
--- a/qemu-nbd.texi
+++ b/qemu-nbd.texi
@@ -10,11 +10,17 @@

 Export a QEMU disk image using the NBD protocol.

+Other uses:
+@itemize
+@item
+Bind a /dev/nbdX block device to a QEMU server (on Linux).
+@end itemize
+
 @c man end

 @c man begin OPTIONS
 @var{filename} is a disk image filename, or a set of block
-driver options if @var{--image-opts} is specified.
+driver options if @option{--image-opts} is specified.

 @var{dev} is an NBD device.

@@ -27,24 +33,25 @@ supported. The common object types that it makes sens=
e to define are the
 keys, and the @code{tls-creds} object, which is used to supply TLS
 credentials for the qemu-nbd server.
 @item -p, --port=3D@var{port}
-The TCP port to listen on (default @samp{10809})
+The TCP port to listen on (default @samp{10809}).
 @item -o, --offset=3D@var{offset}
-The offset into the image
+The offset into the image.
 @item -b, --bind=3D@var{iface}
-The interface to bind to (default @samp{0.0.0.0})
+The interface to bind to (default @samp{0.0.0.0}).
 @item -k, --socket=3D@var{path}
-Use a unix socket with path @var{path}
+Use a unix socket with path @var{path}.
 @item --image-opts
 Treat @var{filename} as a set of image options, instead of a plain
 filename. If this flag is specified, the @var{-f} flag should
 not be used, instead the '@code{format=3D}' option should be set.
 @item -f, --format=3D@var{fmt}
 Force the use of the block driver for format @var{fmt} instead of
-auto-detecting
+auto-detecting.
 @item -r, --read-only
-Export the disk as read-only
+Export the disk as read-only.
 @item -P, --partition=3D@var{num}
-Only expose partition @var{num}
+Only expose MBR partition @var{num}.  Understands physical partitions
+1-4 and logical partitions 5-8.
 @item -B, --bitmap=3D@var{name}
 If @var{filename} has a qcow2 persistent bitmap @var{name}, expose
 that bitmap via the ``qemu:dirty-bitmap:@var{name}'' context
@@ -52,7 +59,7 @@ accessible through NBD_OPT_SET_META_CONTEXT.
 @item -s, --snapshot
 Use @var{filename} as an external snapshot, create a temporary
 file with backing_file=3D@var{filename}, redirect the write to
-the temporary one
+the temporary one.
 @item -l, --load-snapshot=3D@var{snapshot_param}
 Load an internal snapshot inside @var{filename} and export it
 as an read-only device, @var{snapshot_param} format is
@@ -76,19 +83,20 @@ driver-specific optimized zero write commands.  @var{=
detect-zeroes} is one of
 converts a zero write to an unmap operation and can only be used if
 @var{discard} is set to @samp{unmap}.  The default is @samp{off}.
 @item -c, --connect=3D@var{dev}
-Connect @var{filename} to NBD device @var{dev}
+Connect @var{filename} to NBD device @var{dev} (Linux only).
 @item -d, --disconnect
-Disconnect the device @var{dev}
+Disconnect the device @var{dev} (Linux only).
 @item -e, --shared=3D@var{num}
-Allow up to @var{num} clients to share the device (default @samp{1})
+Allow up to @var{num} clients to share the device (default
+@samp{1}). Safe for readers, but for now, consistency is not
+guaranteed between multiple writers.
 @item -t, --persistent
-Don't exit on the last connection
+Don't exit on the last connection.
 @item -x, --export-name=3D@var{name}
-Set the NBD volume export name. This switches the server to use
-the new style NBD protocol negotiation
+Set the NBD volume export name (default of a zero-length string).
 @item -D, --description=3D@var{description}
 Set the NBD volume export description, as a human-readable
-string. Requires the use of @option{-x}
+string.
 @item --tls-creds=3DID
 Enable mandatory TLS encryption for the server by setting the ID
 of the TLS credentials object previously created with the --object
@@ -96,11 +104,11 @@ option.
 @item --fork
 Fork off the server process and exit the parent once the server is runni=
ng.
 @item -v, --verbose
-Display extra debugging information
+Display extra debugging information.
 @item -h, --help
-Display this help and exit
+Display this help and exit.
 @item -V, --version
-Display version information and exit
+Display version information and exit.
 @item -T, --trace [[enable=3D]@var{pattern}][,events=3D@var{file}][,file=
=3D@var{file}]
 @findex --trace
 @include qemu-option-trace.texi
@@ -108,6 +116,54 @@ Display version information and exit

 @c man end

+@c man begin EXAMPLES
+Start a server listening on port 10809 that exposes only the
+guest-visible contents of a qcow2 file, with no TLS encryption, and
+with the default export name (an empty string). The command is
+one-shot, and will block until the first successful client
+disconnects:
+
+@example
+qemu-nbd -f qcow2 file.qcow2
+@end example
+
+Start a long-running server listening with encryption on port 10810,
+and require clients to have a correct X.509 certificate to connect to
+a 1 megabyte subset of a raw file, using the export name 'subset':
+
+@example
+qemu-nbd \
+  --object tls-creds-x509,id=3Dtls0,endpoint=3Dserver,dir=3D/path/to/qem=
utls \
+  --tls-creds tls0 -t -x subset -p 10810 \
+  --image-opts driver=3Draw,offset=3D1M,size=3D1M,file.driver=3Dfile,fil=
e.filename=3Dfile.raw
+@end example
+
+Serve a read-only copy of just the first MBR partition of a guest
+image over a Unix socket with as many as 5 simultaneous readers, with
+a persistent process forked as a daemon:
+
+@example
+qemu-nbd --fork --persistent --shared=3D5 --socket=3D/path/to/sock \
+  --partition=3D1 --read-only --format=3Dqcow2 file.qcow2
+@end example
+
+Expose the guest-visible contents of a qcow2 file via a block device
+/dev/nbd0 (and possibly creating /dev/nbd0p1 and friends for
+partitions found within), then disconnect the device when done.
+Access to bind qemu-nbd to an /dev/nbd device generally requires root
+privileges, and may also require the execution of @code{modprobe nbd}
+to enable the kernel NBD client module.  @emph{CAUTION}: Do not use
+this method to mount filesystems from an untrusted guest image - a
+malicious guest may have prepared the image to attempt to trigger
+kernel bugs in partition probing or file system mounting.
+
+@example
+qemu-nbd -c /dev/nbd0 -f qcow2 file.qcow2
+qemu-nbd -d /dev/nbd0
+@end example
+
+@c man end
+
 @ignore

 @setfilename qemu-nbd
--=20
2.20.1
