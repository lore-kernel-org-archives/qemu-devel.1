Received: from eggs.gnu.org ([2001:4830:134:3::10]:42695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fsWg9-0004Ve-R0
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 13:12:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fsWXK-0005Tl-OV
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 13:03:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37466 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fsWXK-0005TH-Bq
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 13:03:14 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0DC2B401EF02
	for <qemu-devel@nongnu.org>; Wed, 22 Aug 2018 17:03:14 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 22 Aug 2018 19:02:50 +0200
Message-Id: <20180822170250.29573-5-marcandre.lureau@redhat.com>
In-Reply-To: <20180822170250.29573-1-marcandre.lureau@redhat.com>
References: <20180822170250.29573-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 4/4] seccomp: set the seccomp filter to all
 threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pmoore@redhat.com, berrange@redhat.com, eblake@redhat.com, Eduardo Otubo <otubo@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

When using "-seccomp on", the seccomp policy is only applied to the
main thread, the vcpu worker thread and other worker threads created
after seccomp policy is applied; the seccomp policy is not applied to
e.g. the RCU thread because it is created before the seccomp policy is
applied and SECCOMP_FILTER_FLAG_TSYNC isn't used.

This can be verified with
for task in /proc/`pidof qemu`/task/*; do cat $task/status | grep Secc ; =
done
Seccomp:	2
Seccomp:	0
Seccomp:	0
Seccomp:	2
Seccomp:	2
Seccomp:	2

Starting with libseccomp 2.2.0 and kernel >=3D 3.17, we can use
seccomp_attr_set(ctx, > SCMP_FLTATR_CTL_TSYNC, 1) to update the policy
on all threads.

libseccomp requirement was bumped to 2.2.0 in previous patch.
libseccomp should fail to set the filter if it can't honour
SCMP_FLTATR_CTL_TSYNC (untested), and thus -sandbox will now fail on
kernel < 3.17.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qemu-seccomp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/qemu-seccomp.c b/qemu-seccomp.c
index f0c833f3ca..4729eb107f 100644
--- a/qemu-seccomp.c
+++ b/qemu-seccomp.c
@@ -149,6 +149,11 @@ static int seccomp_start(uint32_t seccomp_opts)
         goto seccomp_return;
     }
=20
+    rc =3D seccomp_attr_set(ctx, SCMP_FLTATR_CTL_TSYNC, 1);
+    if (rc !=3D 0) {
+        goto seccomp_return;
+    }
+
     for (i =3D 0; i < ARRAY_SIZE(blacklist); i++) {
         if (!(seccomp_opts & blacklist[i].set)) {
             continue;
--=20
2.18.0.547.g1d89318c48
