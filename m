Received: from eggs.gnu.org ([2001:4830:134:3::10]:58867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cE0rx-0007aT-3V
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 16:32:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cE0rt-0005pj-UU
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 16:32:17 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Mon,  5 Dec 2016 16:32:01 -0500
Message-Id: <1480973521-28945-4-git-send-email-jcody@redhat.com>
In-Reply-To: <1480973521-28945-1-git-send-email-jcody@redhat.com>
References: <1480973521-28945-1-git-send-email-jcody@redhat.com>
Subject: [Qemu-devel] [PULL for-2.8 3/3] qemu-doc: update gluster protocol
 usage guide
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com

From: Prasanna Kumar Kalever <prasanna.kalever@redhat.com>

Document:
1. The new debug and logfile options with their usages
2. New json format and its usage and
3. update "GlusterFS, Device URL Syntax" section in "Invocation"

Signed-off-by: Prasanna Kumar Kalever <prasanna.kalever@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 qemu-doc.texi   | 59 +++++++++++++++++++++++++++++++++++++++++++--------------
 qemu-options.hx | 25 ++++++++++++++++++++++--
 2 files changed, 68 insertions(+), 16 deletions(-)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index 023c140..02cb39d 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -1041,35 +1041,55 @@ GlusterFS is an user space distributed file system.
 
 You can boot from the GlusterFS disk image with the command:
 @example
-qemu-system-x86_64 -drive file=gluster[+@var{transport}]://[@var{server}[:@var{port}]]/@var{volname}/@var{image}[?socket=...]
+URI:
+qemu-system-x86_64 -drive file=gluster[+@var{type}]://[@var{host}[:@var{port}]]/@var{volume}/@var{path}
+                               [?socket=...][,file.debug=9][,file.logfile=...]
+
+JSON:
+qemu-system-x86_64 'json:@{"driver":"qcow2",
+                           "file":@{"driver":"gluster",
+                                    "volume":"testvol","path":"a.img","debug":9,"logfile":"...",
+                                    "server":[@{"type":"tcp","host":"...","port":"..."@},
+                                              @{"type":"unix","socket":"..."@}]@}@}'
 @end example
 
 @var{gluster} is the protocol.
 
-@var{transport} specifies the transport type used to connect to gluster
+@var{type} specifies the transport type used to connect to gluster
 management daemon (glusterd). Valid transport types are
-tcp, unix and rdma. If a transport type isn't specified, then tcp
-type is assumed.
+tcp and unix. In the URI form, if a transport type isn't specified,
+then tcp type is assumed.
 
-@var{server} specifies the server where the volume file specification for
-the given volume resides. This can be either hostname, ipv4 address
-or ipv6 address. ipv6 address needs to be within square brackets [ ].
-If transport type is unix, then @var{server} field should not be specified.
+@var{host} specifies the server where the volume file specification for
+the given volume resides. This can be either a hostname or an ipv4 address.
+If transport type is unix, then @var{host} field should not be specified.
 Instead @var{socket} field needs to be populated with the path to unix domain
 socket.
 
 @var{port} is the port number on which glusterd is listening. This is optional
-and if not specified, QEMU will send 0 which will make gluster to use the
-default port. If the transport type is unix, then @var{port} should not be
-specified.
+and if not specified, it defaults to port 24007. If the transport type is unix,
+then @var{port} should not be specified.
+
+@var{volume} is the name of the gluster volume which contains the disk image.
+
+@var{path} is the path to the actual disk image that resides on gluster volume.
+
+@var{debug} is the logging level of the gluster protocol driver. Debug levels
+are 0-9, with 9 being the most verbose, and 0 representing no debugging output.
+The default level is 4. The current logging levels defined in the gluster source
+are 0 - None, 1 - Emergency, 2 - Alert, 3 - Critical, 4 - Error, 5 - Warning,
+6 - Notice, 7 - Info, 8 - Debug, 9 - Trace
+
+@var{logfile} is a commandline option to mention log file path which helps in
+logging to the specified file and also help in persisting the gfapi logs. The
+default is stderr.
+
 
-@var{volname} is the name of the gluster volume which contains the disk image.
 
-@var{image} is the path to the actual disk image that resides on gluster volume.
 
 You can create a GlusterFS disk image with the command:
 @example
-qemu-img create gluster://@var{server}/@var{volname}/@var{image} @var{size}
+qemu-img create gluster://@var{host}/@var{volume}/@var{path} @var{size}
 @end example
 
 Examples
@@ -1082,6 +1102,17 @@ qemu-system-x86_64 -drive file=gluster+tcp://[1:2:3:4:5:6:7:8]:24007/testvol/dir
 qemu-system-x86_64 -drive file=gluster+tcp://server.domain.com:24007/testvol/dir/a.img
 qemu-system-x86_64 -drive file=gluster+unix:///testvol/dir/a.img?socket=/tmp/glusterd.socket
 qemu-system-x86_64 -drive file=gluster+rdma://1.2.3.4:24007/testvol/a.img
+qemu-system-x86_64 -drive file=gluster://1.2.3.4/testvol/a.img,file.debug=9,file.logfile=/var/log/qemu-gluster.log
+qemu-system-x86_64 'json:@{"driver":"qcow2",
+                           "file":@{"driver":"gluster",
+                                    "volume":"testvol","path":"a.img",
+                                    "debug":9,"logfile":"/var/log/qemu-gluster.log",
+                                    "server":[@{"type":"tcp","host":"1.2.3.4","port":24007@},
+                                              @{"type":"unix","socket":"/var/run/glusterd.socket"@}]@}@}'
+qemu-system-x86_64 -drive driver=qcow2,file.driver=gluster,file.volume=testvol,file.path=/path/a.img,
+                                       file.debug=9,file.logfile=/var/log/qemu-gluster.log,
+                                       file.server.0.type=tcp,file.server.0.host=1.2.3.4,file.server.0.port=24007,
+                                       file.server.1.type=unix,file.server.1.socket=/var/run/glusterd.socket
 @end example
 
 @node disk_images_ssh
diff --git a/qemu-options.hx b/qemu-options.hx
index 4a5b29f..c534a2f 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2595,13 +2595,34 @@ TCP, Unix Domain Sockets and RDMA transport protocols.
 
 Syntax for specifying a VM disk image on GlusterFS volume is
 @example
-gluster[+transport]://[server[:port]]/volname/image[?socket=...]
+
+URI:
+gluster[+type]://[host[:port]]/volume/path[?socket=...][,debug=N][,logfile=...]
+
+JSON:
+'json:@{"driver":"qcow2","file":@{"driver":"gluster","volume":"testvol","path":"a.img","debug":N,"logfile":"...",
+@                                 "server":[@{"type":"tcp","host":"...","port":"..."@},
+@                                           @{"type":"unix","socket":"..."@}]@}@}'
 @end example
 
 
 Example
 @example
-qemu-system-x86_64 --drive file=gluster://192.0.2.1/testvol/a.img
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
 @end example
 
 See also @url{http://www.gluster.org}.
-- 
2.7.4
