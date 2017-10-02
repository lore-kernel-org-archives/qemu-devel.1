Received: from eggs.gnu.org ([2001:4830:134:3::10]:40513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz1Jk-0005s1-Oi
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:03:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz1Jh-0004sn-VT
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:03:32 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Oct 2017 16:03:02 +0200
Message-Id: <20171002140307.5292-4-armbru@redhat.com>
In-Reply-To: <20171002140307.5292-1-armbru@redhat.com>
References: <20171002140307.5292-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 3/8] qemu-options qemu-doc: Move "Device URL
 Syntax" to qemu-doc
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
List-ID: <qemu-devel.nongnu.org>

Commit 0f5314a (v1.0) added section "Device URL Syntax" to
qemu-options.hx.  It's enclosed in STEXI..ETEXI, thus affects only
qemu-options.texi, not --help.  It appears as a subsection under
section "Invocation".  Similarly, qemu.1 has it as a subsection under
"OPTIONS".

Commit f9dadc9 (v1.1.0) dropped new option -iscsi into the middle of
this section.  No effect on qemu-options.texi.  It appears in --help
run together with the "Bluetooth(R) options:" header.

Commit c70a01e (v1.5.0) gives it is own heading in --help by moving
commit 0f5314a's DEFHEADING(Device URL Syntax:) outside STEXI..ETEXI.
Trouble is the heading makes no sense for -iscsi.

Move all of the "Device URL Syntax" Texinfo to qemu-doc.texi.  Mark it
for inclusion in qemu.1 with '@c man begin NOTES'.  This turns it into
a separate section outside the list of options both in qemu-doc and in
qemu.1.

There's substantial overlap with the existing qemu-doc section "Disk
Images".  Mark with a TODO comment.

Output of --help will be fixed next.

Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qemu-doc.texi   | 217 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 qemu-options.hx | 222 --------------------------------------------------------
 2 files changed, 217 insertions(+), 222 deletions(-)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index ecd186a159..848e49966a 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -245,6 +245,223 @@ targets do not need a disk image.
 
 @c man end
 
+@node device_url
+@subsection Device URL Syntax
+@c TODO merge this with section Disk Images
+
+@c man begin NOTES
+
+In addition to using normal file images for the emulated storage devices,
+QEMU can also use networked resources such as iSCSI devices. These are
+specified using a special URL syntax.
+
+@table @option
+@item iSCSI
+iSCSI support allows QEMU to access iSCSI resources directly and use as
+images for the guest storage. Both disk and cdrom images are supported.
+
+Syntax for specifying iSCSI LUNs is
+``iscsi://<target-ip>[:<port>]/<target-iqn>/<lun>''
+
+By default qemu will use the iSCSI initiator-name
+'iqn.2008-11.org.linux-kvm[:<name>]' but this can also be set from the command
+line or a configuration file.
+
+Since version Qemu 2.4 it is possible to specify a iSCSI request timeout to detect
+stalled requests and force a reestablishment of the session. The timeout
+is specified in seconds. The default is 0 which means no timeout. Libiscsi
+1.15.0 or greater is required for this feature.
+
+Example (without authentication):
+@example
+qemu-system-i386 -iscsi initiator-name=iqn.2001-04.com.example:my-initiator \
+                 -cdrom iscsi://192.0.2.1/iqn.2001-04.com.example/2 \
+                 -drive file=iscsi://192.0.2.1/iqn.2001-04.com.example/1
+@end example
+
+Example (CHAP username/password via URL):
+@example
+qemu-system-i386 -drive file=iscsi://user%password@@192.0.2.1/iqn.2001-04.com.example/1
+@end example
+
+Example (CHAP username/password via environment variables):
+@example
+LIBISCSI_CHAP_USERNAME="user" \
+LIBISCSI_CHAP_PASSWORD="password" \
+qemu-system-i386 -drive file=iscsi://192.0.2.1/iqn.2001-04.com.example/1
+@end example
+
+@item NBD
+QEMU supports NBD (Network Block Devices) both using TCP protocol as well
+as Unix Domain Sockets.
+
+Syntax for specifying a NBD device using TCP
+``nbd:<server-ip>:<port>[:exportname=<export>]''
+
+Syntax for specifying a NBD device using Unix Domain Sockets
+``nbd:unix:<domain-socket>[:exportname=<export>]''
+
+Example for TCP
+@example
+qemu-system-i386 --drive file=nbd:192.0.2.1:30000
+@end example
+
+Example for Unix Domain Sockets
+@example
+qemu-system-i386 --drive file=nbd:unix:/tmp/nbd-socket
+@end example
+
+@item SSH
+QEMU supports SSH (Secure Shell) access to remote disks.
+
+Examples:
+@example
+qemu-system-i386 -drive file=ssh://user@@host/path/to/disk.img
+qemu-system-i386 -drive file.driver=ssh,file.user=user,file.host=host,file.port=22,file.path=/path/to/disk.img
+@end example
+
+Currently authentication must be done using ssh-agent.  Other
+authentication methods may be supported in future.
+
+@item Sheepdog
+Sheepdog is a distributed storage system for QEMU.
+QEMU supports using either local sheepdog devices or remote networked
+devices.
+
+Syntax for specifying a sheepdog device
+@example
+sheepdog[+tcp|+unix]://[host:port]/vdiname[?socket=path][#snapid|#tag]
+@end example
+
+Example
+@example
+qemu-system-i386 --drive file=sheepdog://192.0.2.1:30000/MyVirtualMachine
+@end example
+
+See also @url{https://sheepdog.github.io/sheepdog/}.
+
+@item GlusterFS
+GlusterFS is a user space distributed file system.
+QEMU supports the use of GlusterFS volumes for hosting VM disk images using
+TCP, Unix Domain Sockets and RDMA transport protocols.
+
+Syntax for specifying a VM disk image on GlusterFS volume is
+@example
+
+URI:
+gluster[+type]://[host[:port]]/volume/path[?socket=...][,debug=N][,logfile=...]
+
+JSON:
+'json:@{"driver":"qcow2","file":@{"driver":"gluster","volume":"testvol","path":"a.img","debug":N,"logfile":"...",
+@                                 "server":[@{"type":"tcp","host":"...","port":"..."@},
+@                                           @{"type":"unix","socket":"..."@}]@}@}'
+@end example
+
+
+Example
+@example
+URI:
+qemu-system-x86_64 --drive file=gluster://192.0.2.1/testvol/a.img,
+@                               file.debug=9,file.logfile=/var/log/qemu-gluster.log
+
+JSON:
+qemu-system-x86_64 'json:@{"driver":"qcow2",
+@                          "file":@{"driver":"gluster",
+@                                   "volume":"testvol","path":"a.img",
+@                                   "debug":9,"logfile":"/var/log/qemu-gluster.log",
+@                                   "server":[@{"type":"tcp","host":"1.2.3.4","port":24007@},
+@                                             @{"type":"unix","socket":"/var/run/glusterd.socket"@}]@}@}'
+qemu-system-x86_64 -drive driver=qcow2,file.driver=gluster,file.volume=testvol,file.path=/path/a.img,
+@                                      file.debug=9,file.logfile=/var/log/qemu-gluster.log,
+@                                      file.server.0.type=tcp,file.server.0.host=1.2.3.4,file.server.0.port=24007,
+@                                      file.server.1.type=unix,file.server.1.socket=/var/run/glusterd.socket
+@end example
+
+See also @url{http://www.gluster.org}.
+
+@item HTTP/HTTPS/FTP/FTPS
+QEMU supports read-only access to files accessed over http(s) and ftp(s).
+
+Syntax using a single filename:
+@example
+<protocol>://[<username>[:<password>]@@]<host>/<path>
+@end example
+
+where:
+@table @option
+@item protocol
+'http', 'https', 'ftp', or 'ftps'.
+
+@item username
+Optional username for authentication to the remote server.
+
+@item password
+Optional password for authentication to the remote server.
+
+@item host
+Address of the remote server.
+
+@item path
+Path on the remote server, including any query string.
+@end table
+
+The following options are also supported:
+@table @option
+@item url
+The full URL when passing options to the driver explicitly.
+
+@item readahead
+The amount of data to read ahead with each range request to the remote server.
+This value may optionally have the suffix 'T', 'G', 'M', 'K', 'k' or 'b'. If it
+does not have a suffix, it will be assumed to be in bytes. The value must be a
+multiple of 512 bytes. It defaults to 256k.
+
+@item sslverify
+Whether to verify the remote server's certificate when connecting over SSL. It
+can have the value 'on' or 'off'. It defaults to 'on'.
+
+@item cookie
+Send this cookie (it can also be a list of cookies separated by ';') with
+each outgoing request.  Only supported when using protocols such as HTTP
+which support cookies, otherwise ignored.
+
+@item timeout
+Set the timeout in seconds of the CURL connection. This timeout is the time
+that CURL waits for a response from the remote server to get the size of the
+image to be downloaded. If not set, the default timeout of 5 seconds is used.
+@end table
+
+Note that when passing options to qemu explicitly, @option{driver} is the value
+of <protocol>.
+
+Example: boot from a remote Fedora 20 live ISO image
+@example
+qemu-system-x86_64 --drive media=cdrom,file=http://dl.fedoraproject.org/pub/fedora/linux/releases/20/Live/x86_64/Fedora-Live-Desktop-x86_64-20-1.iso,readonly
+
+qemu-system-x86_64 --drive media=cdrom,file.driver=http,file.url=http://dl.fedoraproject.org/pub/fedora/linux/releases/20/Live/x86_64/Fedora-Live-Desktop-x86_64-20-1.iso,readonly
+@end example
+
+Example: boot from a remote Fedora 20 cloud image using a local overlay for
+writes, copy-on-read, and a readahead of 64k
+@example
+qemu-img create -f qcow2 -o backing_file='json:@{"file.driver":"http",, "file.url":"https://dl.fedoraproject.org/pub/fedora/linux/releases/20/Images/x86_64/Fedora-x86_64-20-20131211.1-sda.qcow2",, "file.readahead":"64k"@}' /tmp/Fedora-x86_64-20-20131211.1-sda.qcow2
+
+qemu-system-x86_64 -drive file=/tmp/Fedora-x86_64-20-20131211.1-sda.qcow2,copy-on-read=on
+@end example
+
+Example: boot from an image stored on a VMware vSphere server with a self-signed
+certificate using a local overlay for writes, a readahead of 64k and a timeout
+of 10 seconds.
+@example
+qemu-img create -f qcow2 -o backing_file='json:@{"file.driver":"https",, "file.url":"https://user:password@@vsphere.example.com/folder/test/test-flat.vmdk?dcPath=Datacenter&dsName=datastore1",, "file.sslverify":"off",, "file.readahead":"64k",, "file.timeout":10@}' /tmp/test.qcow2
+
+qemu-system-x86_64 -drive file=/tmp/test.qcow2
+@end example
+
+@end table
+
+@c man end
+
 @node pcsys_keys
 @section Keys in the graphical frontends
 
diff --git a/qemu-options.hx b/qemu-options.hx
index 39f0e1b990..f112281d37 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2812,234 +2812,12 @@ ETEXI
 DEFHEADING()
 
 DEFHEADING(Device URL Syntax:)
-STEXI
-
-In addition to using normal file images for the emulated storage devices,
-QEMU can also use networked resources such as iSCSI devices. These are
-specified using a special URL syntax.
-
-@table @option
-@item iSCSI
-iSCSI support allows QEMU to access iSCSI resources directly and use as
-images for the guest storage. Both disk and cdrom images are supported.
-
-Syntax for specifying iSCSI LUNs is
-``iscsi://<target-ip>[:<port>]/<target-iqn>/<lun>''
-
-By default qemu will use the iSCSI initiator-name
-'iqn.2008-11.org.linux-kvm[:<name>]' but this can also be set from the command
-line or a configuration file.
-
-Since version Qemu 2.4 it is possible to specify a iSCSI request timeout to detect
-stalled requests and force a reestablishment of the session. The timeout
-is specified in seconds. The default is 0 which means no timeout. Libiscsi
-1.15.0 or greater is required for this feature.
-
-Example (without authentication):
-@example
-qemu-system-i386 -iscsi initiator-name=iqn.2001-04.com.example:my-initiator \
-                 -cdrom iscsi://192.0.2.1/iqn.2001-04.com.example/2 \
-                 -drive file=iscsi://192.0.2.1/iqn.2001-04.com.example/1
-@end example
-
-Example (CHAP username/password via URL):
-@example
-qemu-system-i386 -drive file=iscsi://user%password@@192.0.2.1/iqn.2001-04.com.example/1
-@end example
-
-Example (CHAP username/password via environment variables):
-@example
-LIBISCSI_CHAP_USERNAME="user" \
-LIBISCSI_CHAP_PASSWORD="password" \
-qemu-system-i386 -drive file=iscsi://192.0.2.1/iqn.2001-04.com.example/1
-@end example
-
-iSCSI support is an optional feature of QEMU and only available when
-compiled and linked against libiscsi.
-ETEXI
 DEF("iscsi", HAS_ARG, QEMU_OPTION_iscsi,
     "-iscsi [user=user][,password=password]\n"
     "       [,header-digest=CRC32C|CR32C-NONE|NONE-CRC32C|NONE\n"
     "       [,initiator-name=initiator-iqn][,id=target-iqn]\n"
     "       [,timeout=timeout]\n"
     "                iSCSI session parameters\n", QEMU_ARCH_ALL)
-STEXI
-
-iSCSI parameters such as username and password can also be specified via
-a configuration file. See qemu-doc for more information and examples.
-
-@item NBD
-QEMU supports NBD (Network Block Devices) both using TCP protocol as well
-as Unix Domain Sockets.
-
-Syntax for specifying a NBD device using TCP
-``nbd:<server-ip>:<port>[:exportname=<export>]''
-
-Syntax for specifying a NBD device using Unix Domain Sockets
-``nbd:unix:<domain-socket>[:exportname=<export>]''
-
-
-Example for TCP
-@example
-qemu-system-i386 --drive file=nbd:192.0.2.1:30000
-@end example
-
-Example for Unix Domain Sockets
-@example
-qemu-system-i386 --drive file=nbd:unix:/tmp/nbd-socket
-@end example
-
-@item SSH
-QEMU supports SSH (Secure Shell) access to remote disks.
-
-Examples:
-@example
-qemu-system-i386 -drive file=ssh://user@@host/path/to/disk.img
-qemu-system-i386 -drive file.driver=ssh,file.user=user,file.host=host,file.port=22,file.path=/path/to/disk.img
-@end example
-
-Currently authentication must be done using ssh-agent.  Other
-authentication methods may be supported in future.
-
-@item Sheepdog
-Sheepdog is a distributed storage system for QEMU.
-QEMU supports using either local sheepdog devices or remote networked
-devices.
-
-Syntax for specifying a sheepdog device
-@example
-sheepdog[+tcp|+unix]://[host:port]/vdiname[?socket=path][#snapid|#tag]
-@end example
-
-Example
-@example
-qemu-system-i386 --drive file=sheepdog://192.0.2.1:30000/MyVirtualMachine
-@end example
-
-See also @url{https://sheepdog.github.io/sheepdog/}.
-
-@item GlusterFS
-GlusterFS is a user space distributed file system.
-QEMU supports the use of GlusterFS volumes for hosting VM disk images using
-TCP, Unix Domain Sockets and RDMA transport protocols.
-
-Syntax for specifying a VM disk image on GlusterFS volume is
-@example
-
-URI:
-gluster[+type]://[host[:port]]/volume/path[?socket=...][,debug=N][,logfile=...]
-
-JSON:
-'json:@{"driver":"qcow2","file":@{"driver":"gluster","volume":"testvol","path":"a.img","debug":N,"logfile":"...",
-@                                 "server":[@{"type":"tcp","host":"...","port":"..."@},
-@                                           @{"type":"unix","socket":"..."@}]@}@}'
-@end example
-
-
-Example
-@example
-URI:
-qemu-system-x86_64 --drive file=gluster://192.0.2.1/testvol/a.img,
-@                               file.debug=9,file.logfile=/var/log/qemu-gluster.log
-
-JSON:
-qemu-system-x86_64 'json:@{"driver":"qcow2",
-@                          "file":@{"driver":"gluster",
-@                                   "volume":"testvol","path":"a.img",
-@                                   "debug":9,"logfile":"/var/log/qemu-gluster.log",
-@                                   "server":[@{"type":"tcp","host":"1.2.3.4","port":24007@},
-@                                             @{"type":"unix","socket":"/var/run/glusterd.socket"@}]@}@}'
-qemu-system-x86_64 -drive driver=qcow2,file.driver=gluster,file.volume=testvol,file.path=/path/a.img,
-@                                      file.debug=9,file.logfile=/var/log/qemu-gluster.log,
-@                                      file.server.0.type=tcp,file.server.0.host=1.2.3.4,file.server.0.port=24007,
-@                                      file.server.1.type=unix,file.server.1.socket=/var/run/glusterd.socket
-@end example
-
-See also @url{http://www.gluster.org}.
-
-@item HTTP/HTTPS/FTP/FTPS
-QEMU supports read-only access to files accessed over http(s) and ftp(s).
-
-Syntax using a single filename:
-@example
-<protocol>://[<username>[:<password>]@@]<host>/<path>
-@end example
-
-where:
-@table @option
-@item protocol
-'http', 'https', 'ftp', or 'ftps'.
-
-@item username
-Optional username for authentication to the remote server.
-
-@item password
-Optional password for authentication to the remote server.
-
-@item host
-Address of the remote server.
-
-@item path
-Path on the remote server, including any query string.
-@end table
-
-The following options are also supported:
-@table @option
-@item url
-The full URL when passing options to the driver explicitly.
-
-@item readahead
-The amount of data to read ahead with each range request to the remote server.
-This value may optionally have the suffix 'T', 'G', 'M', 'K', 'k' or 'b'. If it
-does not have a suffix, it will be assumed to be in bytes. The value must be a
-multiple of 512 bytes. It defaults to 256k.
-
-@item sslverify
-Whether to verify the remote server's certificate when connecting over SSL. It
-can have the value 'on' or 'off'. It defaults to 'on'.
-
-@item cookie
-Send this cookie (it can also be a list of cookies separated by ';') with
-each outgoing request.  Only supported when using protocols such as HTTP
-which support cookies, otherwise ignored.
-
-@item timeout
-Set the timeout in seconds of the CURL connection. This timeout is the time
-that CURL waits for a response from the remote server to get the size of the
-image to be downloaded. If not set, the default timeout of 5 seconds is used.
-@end table
-
-Note that when passing options to qemu explicitly, @option{driver} is the value
-of <protocol>.
-
-Example: boot from a remote Fedora 20 live ISO image
-@example
-qemu-system-x86_64 --drive media=cdrom,file=http://dl.fedoraproject.org/pub/fedora/linux/releases/20/Live/x86_64/Fedora-Live-Desktop-x86_64-20-1.iso,readonly
-
-qemu-system-x86_64 --drive media=cdrom,file.driver=http,file.url=http://dl.fedoraproject.org/pub/fedora/linux/releases/20/Live/x86_64/Fedora-Live-Desktop-x86_64-20-1.iso,readonly
-@end example
-
-Example: boot from a remote Fedora 20 cloud image using a local overlay for
-writes, copy-on-read, and a readahead of 64k
-@example
-qemu-img create -f qcow2 -o backing_file='json:@{"file.driver":"http",, "file.url":"https://dl.fedoraproject.org/pub/fedora/linux/releases/20/Images/x86_64/Fedora-x86_64-20-20131211.1-sda.qcow2",, "file.readahead":"64k"@}' /tmp/Fedora-x86_64-20-20131211.1-sda.qcow2
-
-qemu-system-x86_64 -drive file=/tmp/Fedora-x86_64-20-20131211.1-sda.qcow2,copy-on-read=on
-@end example
-
-Example: boot from an image stored on a VMware vSphere server with a self-signed
-certificate using a local overlay for writes, a readahead of 64k and a timeout
-of 10 seconds.
-@example
-qemu-img create -f qcow2 -o backing_file='json:@{"file.driver":"https",, "file.url":"https://user:password@@vsphere.example.com/folder/test/test-flat.vmdk?dcPath=Datacenter&dsName=datastore1",, "file.sslverify":"off",, "file.readahead":"64k",, "file.timeout":10@}' /tmp/test.qcow2
-
-qemu-system-x86_64 -drive file=/tmp/test.qcow2
-@end example
-ETEXI
-
-STEXI
-@end table
-ETEXI
 
 DEFHEADING(Bluetooth(R) options:)
 STEXI
-- 
2.13.6
