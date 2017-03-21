Received: from eggs.gnu.org ([2001:4830:134:3::10]:57697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cqKXT-00086Z-VG
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 10:13:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cqKXP-0002sg-VC
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 10:13:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49833
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cqKXP-0002sR-OZ
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 10:13:27 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2LE9523005777
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 10:13:27 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29ajffc4qy-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 10:13:26 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 21 Mar 2017 14:13:25 -0000
From: Greg Kurz <groug@kaod.org>
Date: Tue, 21 Mar 2017 15:13:00 +0100
In-Reply-To: <1490105580-5008-1-git-send-email-groug@kaod.org>
References: <1490105580-5008-1-git-send-email-groug@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1490105580-5008-3-git-send-email-groug@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/2] 9pfs: proxy: assert if unmarshal fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>

Replies from the virtfs proxy are made up of a fixed-size header (8 bytes=
)
and a payload of variable size (maximum 64kb). When receiving a reply,
the proxy backend first reads the whole header and then unmarshals it.
If the header is okay, it then does the same operation with the payload.

Since the proxy backend uses a pre-allocated buffer which has enough room
for a header and the maximum payload size, marshalling should never fail
with fixed size arguments. Any error here is likely to result from a more
serious corruption in QEMU and we'd better dump core right away.

This patch adds error checks where they are missing and converts the
associated error paths into assertions.

This should also address Coverity's complaints CID 1348519 and CID 134852=
0,
about not always checking the return value of proxy_unmarshal().

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 hw/9pfs/9p-proxy.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/9pfs/9p-proxy.c b/hw/9pfs/9p-proxy.c
index f4aa7a9d70f8..28b20a7c3dfa 100644
--- a/hw/9pfs/9p-proxy.c
+++ b/hw/9pfs/9p-proxy.c
@@ -165,7 +165,8 @@ static int v9fs_receive_response(V9fsProxy *proxy, in=
t type,
         return retval;
     }
     reply->iov_len =3D PROXY_HDR_SZ;
-    proxy_unmarshal(reply, 0, "dd", &header.type, &header.size);
+    retval =3D proxy_unmarshal(reply, 0, "dd", &header.type, &header.siz=
e);
+    assert(retval =3D=3D 4 * 2);
     /*
      * if response size > PROXY_MAX_IO_SZ, read the response but ignore =
it and
      * return -ENOBUFS
@@ -194,9 +195,7 @@ static int v9fs_receive_response(V9fsProxy *proxy, in=
t type,
     if (header.type =3D=3D T_ERROR) {
         int ret;
         ret =3D proxy_unmarshal(reply, PROXY_HDR_SZ, "d", status);
-        if (ret < 0) {
-            *status =3D ret;
-        }
+        assert(ret =3D=3D 4);
         return 0;
     }
=20
@@ -213,6 +212,7 @@ static int v9fs_receive_response(V9fsProxy *proxy, in=
t type,
                                  &prstat.st_atim_sec, &prstat.st_atim_ns=
ec,
                                  &prstat.st_mtim_sec, &prstat.st_mtim_ns=
ec,
                                  &prstat.st_ctim_sec, &prstat.st_ctim_ns=
ec);
+        assert(retval =3D=3D 8 * 3 + 4 * 3 + 8 * 10);
         prstat_to_stat(response, &prstat);
         break;
     }
@@ -225,6 +225,7 @@ static int v9fs_receive_response(V9fsProxy *proxy, in=
t type,
                                  &prstfs.f_files, &prstfs.f_ffree,
                                  &prstfs.f_fsid[0], &prstfs.f_fsid[1],
                                  &prstfs.f_namelen, &prstfs.f_frsize);
+        assert(retval =3D=3D 8 * 11);
         prstatfs_to_statfs(response, &prstfs);
         break;
     }
@@ -246,7 +247,8 @@ static int v9fs_receive_response(V9fsProxy *proxy, in=
t type,
         break;
     }
     case T_GETVERSION:
-        proxy_unmarshal(reply, PROXY_HDR_SZ, "q", response);
+        retval =3D proxy_unmarshal(reply, PROXY_HDR_SZ, "q", response);
+        assert(retval =3D=3D 8);
         break;
     default:
         return -1;
@@ -274,18 +276,16 @@ static int v9fs_receive_status(V9fsProxy *proxy,
         return retval;
     }
     reply->iov_len =3D PROXY_HDR_SZ;
-    proxy_unmarshal(reply, 0, "dd", &header.type, &header.size);
-    if (header.size !=3D sizeof(int)) {
-        *status =3D -ENOBUFS;
-        return 0;
-    }
+    retval =3D proxy_unmarshal(reply, 0, "dd", &header.type, &header.siz=
e);
+    assert(retval =3D=3D 4 * 2);
     retval =3D socket_read(proxy->sockfd,
                          reply->iov_base + PROXY_HDR_SZ, header.size);
     if (retval < 0) {
         return retval;
     }
     reply->iov_len +=3D header.size;
-    proxy_unmarshal(reply, PROXY_HDR_SZ, "d", status);
+    retval =3D proxy_unmarshal(reply, PROXY_HDR_SZ, "d", status);
+    assert(retval =3D=3D 4);
     return 0;
 }
=20
--=20
2.7.4
