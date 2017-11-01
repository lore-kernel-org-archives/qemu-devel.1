Received: from eggs.gnu.org ([2001:4830:134:3::10]:37729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=47103a974=ross.lagerwall@citrix.com>)
	id 1e9u1f-0005WQ-9f
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 10:29:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=47103a974=ross.lagerwall@citrix.com>)
	id 1e9u1a-00083y-SW
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 10:29:51 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:12847)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=47103a974=ross.lagerwall@citrix.com>)
	id 1e9u1a-00081x-KH
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 10:29:46 -0400
From: Ross Lagerwall <ross.lagerwall@citrix.com>
Date: Wed, 1 Nov 2017 14:25:23 +0000
Message-ID: <20171101142526.1006-2-ross.lagerwall@citrix.com>
In-Reply-To: <20171101142526.1006-1-ross.lagerwall@citrix.com>
References: <20171101142526.1006-1-ross.lagerwall@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 1/4] migration: Don't leak IO channels
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ross Lagerwall <ross.lagerwall@citrix.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Since qemu_fopen_channel_{in,out}put take references on the underlying
IO channels, make sure to release our references to them.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
---
New in v2.

 migration/savevm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/migration/savevm.c b/migration/savevm.c
index 4a88228..87557dd 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2259,6 +2259,7 @@ void qmp_xen_save_devices_state(const char *filename, Error **errp)
     }
     qio_channel_set_name(QIO_CHANNEL(ioc), "migration-xen-save-state");
     f = qemu_fopen_channel_output(QIO_CHANNEL(ioc));
+    object_unref(OBJECT(ioc));
     ret = qemu_save_device_state(f);
     qemu_fclose(f);
     if (ret < 0) {
@@ -2292,6 +2293,7 @@ void qmp_xen_load_devices_state(const char *filename, Error **errp)
     }
     qio_channel_set_name(QIO_CHANNEL(ioc), "migration-xen-load-state");
     f = qemu_fopen_channel_input(QIO_CHANNEL(ioc));
+    object_unref(OBJECT(ioc));
 
     ret = qemu_loadvm_state(f);
     qemu_fclose(f);
-- 
2.9.5
