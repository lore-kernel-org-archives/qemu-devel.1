Received: from eggs.gnu.org ([2001:4830:134:3::10]:44617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ej5Zb-00061E-2x
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 10:54:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ej5ZV-0000aa-FY
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 10:54:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55216)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ej5ZV-0000Zy-A7
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 10:54:13 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue,  6 Feb 2018 15:49:35 +0000
Message-Id: <20180206154936.13565-14-dgilbert@redhat.com>
In-Reply-To: <20180206154936.13565-1-dgilbert@redhat.com>
References: <20180206154936.13565-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 13/14] migration: Don't leak IO channels
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com
Cc: peterx@redhat.com, lvivier@redhat.com, groug@kaod.org, ross.lagerwall@citrix.com, wei.w.wang@intel.com, danielhb@linux.vnet.ibm.com

From: Ross Lagerwall <ross.lagerwall@citrix.com>

Since qemu_fopen_channel_{in,out}put take references on the underlying
IO channels, make sure to release our references to them.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Message-Id: <20171101142526.1006-2-ross.lagerwall@citrix.com>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/savevm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/migration/savevm.c b/migration/savevm.c
index b8e9c532af..b024ee3b22 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2266,6 +2266,7 @@ void qmp_xen_save_devices_state(const char *filename, bool has_live, bool live,
     }
     qio_channel_set_name(QIO_CHANNEL(ioc), "migration-xen-save-state");
     f = qemu_fopen_channel_output(QIO_CHANNEL(ioc));
+    object_unref(OBJECT(ioc));
     ret = qemu_save_device_state(f);
     qemu_fclose(f);
     if (ret < 0) {
@@ -2313,6 +2314,7 @@ void qmp_xen_load_devices_state(const char *filename, Error **errp)
     }
     qio_channel_set_name(QIO_CHANNEL(ioc), "migration-xen-load-state");
     f = qemu_fopen_channel_input(QIO_CHANNEL(ioc));
+    object_unref(OBJECT(ioc));
 
     ret = qemu_loadvm_state(f);
     qemu_fclose(f);
-- 
2.14.3
