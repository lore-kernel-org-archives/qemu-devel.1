Received: from eggs.gnu.org ([2001:4830:134:3::10]:51487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dIHlY-0001Ww-5U
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 12:55:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dIHlU-0006Pm-8N
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 12:55:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54789)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dIHlT-0006PW-Ul
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 12:55:32 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v56GsBQq086568
	for <qemu-devel@nongnu.org>; Tue, 6 Jun 2017 12:55:30 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2awq37fg75-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 12:55:30 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 6 Jun 2017 17:55:28 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue,  6 Jun 2017 18:55:10 +0200
In-Reply-To: <20170606165510.33057-1-pasic@linux.vnet.ibm.com>
References: <20170606165510.33057-1-pasic@linux.vnet.ibm.com>
Message-Id: <20170606165510.33057-4-pasic@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH 3/3] s390x/css: add hint for devno
 missmatch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>

This one has to be fixed up to 's390x: vmstatify config migration for
virtio-ccw' provided we want to achieve the same as 's390x/css: catch
section mismatch on load' does.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
---

This is on tom of 's390x: vmstatify config migration for virtio-ccw'
which ain't on top of 's390x/css: catch section mismatch on load' but on
top of master.  I kind of have a circular dependency here. This is why
the series is RFC. 

Wanted to provide an usage example. Faked 'Re: ' so patchew does not
try to apply this on top of current master.
---
 hw/s390x/css.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 348129e1b2..de277d6a3d 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -134,6 +134,10 @@ static const VMStateDescription vmstate_sense_id = {
 static int subch_dev_post_load(void *opaque, int version_id);
 static void subch_dev_pre_save(void *opaque);
 
+const char err_hint_devno[] = "Devno mismatch, tried to load wrong section!"
+    " Likely reason: some sequences of plug and unplug  can break"
+    " migration for machine versions prior to  2.7 (known design flaw).";
+
 const VMStateDescription vmstate_subch_dev = {
     .name = "s390_subch_dev",
     .version_id = 1,
@@ -144,7 +148,7 @@ const VMStateDescription vmstate_subch_dev = {
         VMSTATE_UINT8_EQUAL(cssid, SubchDev),
         VMSTATE_UINT8_EQUAL(ssid, SubchDev),
         VMSTATE_UINT16(migrated_schid, SubchDev),
-        VMSTATE_UINT16(devno, SubchDev),
+        VMSTATE_UINT16_EQUAL_HINT(devno, SubchDev, err_hint_devno),
         VMSTATE_BOOL(thinint_active, SubchDev),
         VMSTATE_STRUCT(curr_status, SubchDev, 0, vmstate_schib, SCHIB),
         VMSTATE_UINT8_ARRAY(sense_data, SubchDev, 32),
-- 
2.11.2
