Received: from eggs.gnu.org ([209.51.188.92]:43908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h1Uxa-0006mM-AE
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 06:43:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h1UxZ-0005f6-Kr
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 06:43:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33588)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1h1UxZ-0005aa-EF
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 06:43:41 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed,  6 Mar 2019 11:42:25 +0000
Message-Id: <20190306114227.9125-21-dgilbert@redhat.com>
In-Reply-To: <20190306114227.9125-1-dgilbert@redhat.com>
References: <20190306114227.9125-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 20/22] Migration/colo.c: Fix double close bug
 when occur COLO failover
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, marcel.apfelbaum@gmail.com, wei.w.wang@intel.com, yury-kotov@yandex-team.ru, chen.zhang@intel.com
Cc: eblake@redhat.com, armbru@redhat.com

From: Zhang Chen <chen.zhang@intel.com>

In migration_incoming_state_destroy(void) will check the mis->to_src_file
to double close the mis->to_src_file when occur COLO failover.

Signed-off-by: Zhang Chen <chen.zhang@intel.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20190303145021.2962-2-chen.zhang@intel.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/colo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/migration/colo.c b/migration/colo.c
index 398b239d1c..a916dc178c 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -872,6 +872,7 @@ out:
     /* Must be called after failover BH is completed */
     if (mis->to_src_file) {
         qemu_fclose(mis->to_src_file);
+        mis->to_src_file =3D NULL;
     }
     migration_incoming_disable_colo();
=20
--=20
2.20.1
