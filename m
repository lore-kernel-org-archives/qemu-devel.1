Received: from eggs.gnu.org ([2001:4830:134:3::10]:34328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gYAO4-0004hO-Cd
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 08:53:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gYAO2-00084I-Vq
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 08:53:48 -0500
From: Eric Blake <eblake@redhat.com>
Date: Sat, 15 Dec 2018 07:53:06 -0600
Message-Id: <20181215135324.152629-5-eblake@redhat.com>
In-Reply-To: <20181215135324.152629-1-eblake@redhat.com>
References: <20181215135324.152629-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 04/22] qemu-nbd: Enhance man page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: nsoffer@redhat.com, jsnow@redhat.com, rjones@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org

Document some useful qemu-nbd command lines. Mention some restrictions
on particular options, like -p being only for MBR images, or -c/-d
being Linux-only.  Update some text given the recent change to no
longer serve oldstyle protocol (missed in commit 7f7dfe2a).  Also,
consistently use trailing '.' in describing options.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v2: new patch
---
 qemu-nbd.texi | 85 +++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 66 insertions(+), 19 deletions(-)

diff --git a/qemu-nbd.texi b/qemu-nbd.texi
index 9a84e81eed9..0e24c2801ee 100644
--- a/qemu-nbd.texi
+++ b/qemu-nbd.texi
@@ -8,7 +8,10 @@

 @c man begin DESCRIPTION

-Export a QEMU disk image using the NBD protocol.
+Provide access to various QEMU NBD features.  Most commonly used to
+export a QEMU disk image using the NBD protocol as a server, but can
+also be used (on Linux) to manage kernel bindings of a /dev/nbdX
+block device to a QEMU server.

 @c man end

@@ -27,28 +30,29 @@ supported. The common object types that it makes sense to define are the
 keys, and the @code{tls-creds} object, which is used to supply TLS
 credentials for the qemu-nbd server.
 @item -p, --port=@var{port}
-The TCP port to listen on (default @samp{10809})
+The TCP port to listen on (default @samp{10809}).
 @item -o, --offset=@var{offset}
-The offset into the image
+The offset into the image.
 @item -b, --bind=@var{iface}
-The interface to bind to (default @samp{0.0.0.0})
+The interface to bind to (default @samp{0.0.0.0}).
 @item -k, --socket=@var{path}
-Use a unix socket with path @var{path}
+Use a unix socket with path @var{path}.
 @item --image-opts
 Treat @var{filename} as a set of image options, instead of a plain
 filename. If this flag is specified, the @var{-f} flag should
 not be used, instead the '@code{format=}' option should be set.
 @item -f, --format=@var{fmt}
 Force the use of the block driver for format @var{fmt} instead of
-auto-detecting
+auto-detecting.
 @item -r, --read-only
-Export the disk as read-only
+Export the disk as read-only.
 @item -P, --partition=@var{num}
-Only expose partition @var{num}
+Only expose MBR partition @var{num}.  Understands physical partitions
+1-4 and logical partitions 5-8.
 @item -s, --snapshot
 Use @var{filename} as an external snapshot, create a temporary
 file with backing_file=@var{filename}, redirect the write to
-the temporary one
+the temporary one.
 @item -l, --load-snapshot=@var{snapshot_param}
 Load an internal snapshot inside @var{filename} and export it
 as an read-only device, @var{snapshot_param} format is
@@ -72,19 +76,18 @@ driver-specific optimized zero write commands.  @var{detect-zeroes} is one of
 converts a zero write to an unmap operation and can only be used if
 @var{discard} is set to @samp{unmap}.  The default is @samp{off}.
 @item -c, --connect=@var{dev}
-Connect @var{filename} to NBD device @var{dev}
+Connect @var{filename} to NBD device @var{dev} (Linux only).
 @item -d, --disconnect
-Disconnect the device @var{dev}
+Disconnect the device @var{dev} (Linux only).
 @item -e, --shared=@var{num}
-Allow up to @var{num} clients to share the device (default @samp{1})
+Allow up to @var{num} clients to share the device (default @samp{1}).
 @item -t, --persistent
-Don't exit on the last connection
+Don't exit on the last connection.
 @item -x, --export-name=@var{name}
-Set the NBD volume export name. This switches the server to use
-the new style NBD protocol negotiation
+Set the NBD volume export name (default of a zero-length string).
 @item -D, --description=@var{description}
 Set the NBD volume export description, as a human-readable
-string. Requires the use of @option{-x}
+string.
 @item --tls-creds=ID
 Enable mandatory TLS encryption for the server by setting the ID
 of the TLS credentials object previously created with the --object
@@ -92,11 +95,11 @@ option.
 @item --fork
 Fork off the server process and exit the parent once the server is running.
 @item -v, --verbose
-Display extra debugging information
+Display extra debugging information.
 @item -h, --help
-Display this help and exit
+Display this help and exit.
 @item -V, --version
-Display version information and exit
+Display version information and exit.
 @item -T, --trace [[enable=]@var{pattern}][,events=@var{file}][,file=@var{file}]
 @findex --trace
 @include qemu-option-trace.texi
@@ -104,6 +107,50 @@ Display version information and exit

 @c man end

+@c man begin EXAMPLES
+Start a server listening on port 10809 that exposes only the
+guest-visible contents of a qcow2 file, with no TLS encryption, and
+with the default export name (an empty string). The command will block
+until the first successful client disconnects:
+
+@example
+qemu-nbd -f qcow2 file.qcow2
+@end example
+
+Start a server listening with encryption on port 10810, and require
+the client to have a correct X.509 certificate to connect to a 1
+megabyte subset of a raw file, using the export name 'subset':
+
+@example
+qemu-nbd \
+  --object tls-creds-x509,id=tls0,endpoint=server,dir=/path/to/qemutls \
+  --tls-creds tls0 -x subset -p 10810 \
+  --image-opts driver=raw,offset=1M,length=1M,file.driver=file,file.filename=file.raw
+@end example
+
+Serve a read-only copy of just the first MBR partition of a guest
+image over a Unix socket with as many as 5 simultaneous readers, with
+a persistent process forked as a daemon:
+
+@example
+qemu-nbd --fork -t -e 5 -s /path/to/sock -p 1 -r -f qcow2 file.qcow2
+@end example
+
+Expose the guest-visible contents of a qcow2 file via a block device
+/dev/nbd0 (and possibly creating /dev/nbd0p1 and friends for
+partitions found within), then disconnect the device when done.
+@emph{CAUTION}: Do not use this method to mount filesystems from an
+untrusted guest image - a malicious guest may have prepared the image
+to attempt to trigger kernel bugs in partition probing or file system
+mounting.
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
-- 
2.17.2
