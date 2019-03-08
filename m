Received: from eggs.gnu.org ([209.51.188.92]:50788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h2CUE-0006Hw-AK
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 05:12:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h2CUD-0005m9-Hm
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 05:12:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50074)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1h2CUD-0005ko-B1
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 05:12:17 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9D62530718CD
	for <qemu-devel@nongnu.org>; Fri,  8 Mar 2019 10:12:16 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri,  8 Mar 2019 10:12:10 +0000
Message-Id: <20190308101210.28038-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] migration/postcopy: Update the bandwidth
 during postcopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peterx@redhat.com, quintela@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The recently added max-postcopy-bandwidth parameter is only read
at the transition from precopy->postcopy where as the older
max-bandwidth parameter updates the migration bandwidth when changed
even if the migration is already running.

Fix this discrepency so that:
  a) You can change the bandwidth during postcopy by setting
     max-postcopy-bandwidth

  b) Changing max-bandwidth during postcopy has no effect
     (it currently changes the postcopy bandwidth which isn't
     expected).

Fixes: 7e555c6c
bz: https://bugzilla.redhat.com/show_bug.cgi?id=3D1686321
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index df6fd8e0e5..221f1b9ced 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1347,7 +1347,7 @@ static void migrate_params_apply(MigrateSetParamete=
rs *params, Error **errp)
=20
     if (params->has_max_bandwidth) {
         s->parameters.max_bandwidth =3D params->max_bandwidth;
-        if (s->to_dst_file) {
+        if (s->to_dst_file && !migration_in_postcopy()) {
             qemu_file_set_rate_limit(s->to_dst_file,
                                 s->parameters.max_bandwidth / XFER_LIMIT=
_RATIO);
         }
@@ -1379,6 +1379,10 @@ static void migrate_params_apply(MigrateSetParamet=
ers *params, Error **errp)
     }
     if (params->has_max_postcopy_bandwidth) {
         s->parameters.max_postcopy_bandwidth =3D params->max_postcopy_ba=
ndwidth;
+        if (s->to_dst_file && migration_in_postcopy()) {
+            qemu_file_set_rate_limit(s->to_dst_file,
+                    s->parameters.max_postcopy_bandwidth / XFER_LIMIT_RA=
TIO);
+        }
     }
     if (params->has_max_cpu_throttle) {
         s->parameters.max_cpu_throttle =3D params->max_cpu_throttle;
--=20
2.20.1
