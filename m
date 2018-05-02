Received: from eggs.gnu.org ([2001:4830:134:3::10]:41002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fDphi-0002np-3X
	for qemu-devel@nongnu.org; Wed, 02 May 2018 07:13:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fDphe-0005jr-5T
	for qemu-devel@nongnu.org; Wed, 02 May 2018 07:13:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54014
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fDphe-0005hr-0I
	for qemu-devel@nongnu.org; Wed, 02 May 2018 07:13:42 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w42BADWP067490
	for <qemu-devel@nongnu.org>; Wed, 2 May 2018 07:13:35 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2hq6syne7t-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 02 May 2018 07:13:34 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Wed, 2 May 2018 12:13:33 +0100
From: Greg Kurz <groug@kaod.org>
Date: Wed,  2 May 2018 13:13:18 +0200
In-Reply-To: <20180502111318.129888-1-groug@kaod.org>
References: <20180502111318.129888-1-groug@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20180502111318.129888-2-groug@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/1] 9p: add trace event for v9fs_setattr()
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

Don't print the tv_nsec part of atime and mtime, to stay below the 10
argument limit of trace events.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 hw/9pfs/9p.c         | 5 +++++
 hw/9pfs/trace-events | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 48fa48e72074..d74302deeba5 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -1195,6 +1195,10 @@ static void coroutine_fn v9fs_setattr(void *opaque=
)
         goto out_nofid;
     }
=20
+    trace_v9fs_setattr(pdu->tag, pdu->id, fid,
+                       v9iattr.valid, v9iattr.mode, v9iattr.uid, v9iattr=
.gid,
+                       v9iattr.size, v9iattr.atime_sec, v9iattr.mtime_se=
c);
+
     fidp =3D get_fid(pdu, fid);
     if (fidp =3D=3D NULL) {
         err =3D -EINVAL;
@@ -1259,6 +1263,7 @@ static void coroutine_fn v9fs_setattr(void *opaque)
         }
     }
     err =3D offset;
+    trace_v9fs_setattr_return(pdu->tag, pdu->id);
 out:
     put_fid(pdu, fidp);
 out_nofid:
diff --git a/hw/9pfs/trace-events b/hw/9pfs/trace-events
index 1aee350c42f1..881e4c4dd80b 100644
--- a/hw/9pfs/trace-events
+++ b/hw/9pfs/trace-events
@@ -46,3 +46,5 @@ v9fs_xattrwalk_return(uint16_t tag, uint8_t id, int64_t=
 size) "tag %d id %d size
 v9fs_xattrcreate(uint16_t tag, uint8_t id, int32_t fid, char* name, uint=
64_t size, int flags) "tag %d id %d fid %d name %s size %"PRIu64" flags %=
d"
 v9fs_readlink(uint16_t tag, uint8_t id, int32_t fid) "tag %d id %d fid %=
d"
 v9fs_readlink_return(uint16_t tag, uint8_t id, char* target) "tag %d id =
%d name %s"
+v9fs_setattr(uint16_t tag, uint8_t id, int32_t fid, int32_t valid, int32=
_t mode, int32_t uid, int32_t gid, int64_t size, int64_t atime_sec, int64=
_t mtime_sec) "tag %u id %u fid %d iattr=3D{valid %d mode %d uid %d gid %=
d size %"PRId64" atime=3D%"PRId64" mtime=3D%"PRId64" }"
+v9fs_setattr_return(uint16_t tag, uint8_t id) "tag %u id %u"
--=20
2.14.3
