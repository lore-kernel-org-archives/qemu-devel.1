Received: from eggs.gnu.org ([2001:4830:134:3::10]:32841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1d88Zv-0008Mc-H9
	for qemu-devel@nongnu.org; Tue, 09 May 2017 13:05:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1d88Zr-0004Xf-FE
	for qemu-devel@nongnu.org; Tue, 09 May 2017 13:05:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35141
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1d88Zr-0004XV-84
	for qemu-devel@nongnu.org; Tue, 09 May 2017 13:05:35 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v49GrwK6064237
	for <qemu-devel@nongnu.org>; Tue, 9 May 2017 13:05:34 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2abatwkykv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 09 May 2017 13:05:34 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 9 May 2017 18:05:32 +0100
References: <20170505173507.74077-1-pasic@linux.vnet.ibm.com>
	<20170505173507.74077-7-pasic@linux.vnet.ibm.com>
	<20170508165501.GH2120@work-vm>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue, 9 May 2017 19:05:28 +0200
MIME-Version: 1.0
In-Reply-To: <20170508165501.GH2120@work-vm>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Message-Id: <52177e87-8d46-e1f6-49cf-397f296dd366@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 06/10] virtio-ccw: use vmstate way for
 config migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>



On 05/08/2017 06:55 PM, Dr. David Alan Gilbert wrote:
> * Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
>> Let us use the freshly introduced vmstate migration helpers instead of
>> saving/loading the config manually.
>>
>> To achieve this we need to hack the config_vector which is a common
>> VirtIO state in the middle of the VirtioCcwDevice state representation.
>> This somewhat ugly but we have no choice because the stream format needs
>> to be preserved.
>>
>> Still no changes in behavior, but the dead code we added previously is
>> finally awakening to life.
>>
>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>> ---
>> ---
>>  hw/s390x/virtio-ccw.c | 116 +++++++++++++++++++-------------------------------
>>  1 file changed, 44 insertions(+), 72 deletions(-)
>>
>> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
>> index c2badfe..8ab655c 100644
>> --- a/hw/s390x/virtio-ccw.c
>> +++ b/hw/s390x/virtio-ccw.c
>> @@ -57,6 +57,32 @@ static int virtio_ccw_dev_post_load(void *opaque, int version_id)
>>      return 0;
>>  }
>>  
>> +static int get_config_vector(QEMUFile *f, void *pv, size_t size,
>> +                             VMStateField *field)
>> +{
>> +    VirtioCcwDevice *dev = pv;
>> +    VirtIODevice *vdev = virtio_bus_get_device(&dev->bus);
>> +
>> +    qemu_get_be16s(f, &vdev->config_vector);
>> +    return 0;
>> +}
>> +
>> +static int put_config_vector(QEMUFile *f, void *pv, size_t size,
>> +                             VMStateField *field, QJSON *vmdesc)
>> +{
>> +    VirtioCcwDevice *dev = pv;
>> +    VirtIODevice *vdev = virtio_bus_get_device(&dev->bus);
>> +
>> +    qemu_put_be16(f, vdev->config_vector);
>> +    return 0;
>> +}
> Again that should be doable using WITH_TMP.
> (I do wonder if we need a macro for cases where it's just a casting
> operation to another type).
> 

Yeah this one can be done with WITH_TMP. Below is the patch on top of
this patch set. It's a bit more verbose (+6 lines) but it looks a bit
nicer and probably also safer in (terms of symmetric read and write).

If you think its the way to go I will squash it into this patch for
the next version.

-----------------------------8<-----------------------------------------


>From e92135590ab95cc565b37913de77a9ed17012933 Mon Sep 17 00:00:00 2001
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue, 9 May 2017 16:01:50 +0200
Subject: [PATCH 1/2] virtio-ccw: replace info with VMSTATE_WITH_TMP

Convert s VMSatateInfo based solution manipulating the migration stream
directly to VMSTATE_WITH_TMP witch keeps IO and transformation logic
separate. 


Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
---
 hw/s390x/virtio-ccw.c | 40 +++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index c611b6f..6ebc78a 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -57,30 +57,38 @@ static int virtio_ccw_dev_post_load(void *opaque, int version_id)
     return 0;
 }
 
-static int get_config_vector(QEMUFile *f, void *pv, size_t size,
-                             VMStateField *field)
+typedef struct VirtioCcwDeviceTmp {
+    VirtioCcwDevice *parent;
+    uint16_t config_vector;
+} VirtioCcwDeviceTmp;
+
+static void virtio_ccw_dev_tmp_pre_save(void *opaque)
 {
-    VirtioCcwDevice *dev = pv;
+    VirtioCcwDeviceTmp *tmp = opaque;
+    VirtioCcwDevice *dev = tmp->parent;
     VirtIODevice *vdev = virtio_bus_get_device(&dev->bus);
 
-    qemu_get_be16s(f, &vdev->config_vector);
-    return 0;
+    tmp->config_vector = vdev->config_vector;
 }
 
-static int put_config_vector(QEMUFile *f, void *pv, size_t size,
-                             VMStateField *field, QJSON *vmdesc)
+static int virtio_ccw_dev_tmp_post_load(void *opaque, int version_id)
 {
-    VirtioCcwDevice *dev = pv;
+    VirtioCcwDeviceTmp *tmp = opaque;
+    VirtioCcwDevice *dev = tmp->parent;
     VirtIODevice *vdev = virtio_bus_get_device(&dev->bus);
 
-    qemu_put_be16(f, vdev->config_vector);
+    vdev->config_vector = tmp->config_vector;
     return 0;
 }
 
-const VMStateInfo vmstate_info_config_vector = {
-    .name = "config_vector",
-    .get = get_config_vector,
-    .put = put_config_vector,
+const VMStateDescription vmstate_virtio_ccw_dev_tmp = {
+    .name = "s390_virtio_ccw_dev_tmp",
+    .pre_save = virtio_ccw_dev_tmp_pre_save,
+    .post_load = virtio_ccw_dev_tmp_post_load,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT16(config_vector, VirtioCcwDeviceTmp),
+        VMSTATE_END_OF_LIST()
+    }
 };
 
 const VMStateDescription vmstate_virtio_ccw_dev = {
@@ -93,14 +101,12 @@ const VMStateDescription vmstate_virtio_ccw_dev = {
         VMSTATE_PTR_TO_IND_ADDR(indicators, VirtioCcwDevice),
         VMSTATE_PTR_TO_IND_ADDR(indicators2, VirtioCcwDevice),
         VMSTATE_PTR_TO_IND_ADDR(summary_indicator, VirtioCcwDevice),
-        {
         /*
          * Ugly hack because VirtIODevice does not migrate itself.
          * This also makes legacy via vmstate_save_state possible.
          */
-            .name         = "virtio/config_vector",
-            .info         = &vmstate_info_config_vector,
-        },
+        VMSTATE_WITH_TMP(VirtioCcwDevice, VirtioCcwDeviceTmp,
+                         vmstate_virtio_ccw_dev_tmp),
         VMSTATE_STRUCT(routes, VirtioCcwDevice, 1, vmstate_adapter_routes, \
                        AdapterRoutes),
         VMSTATE_UINT8(thinint_isc, VirtioCcwDevice),
-- 
2.10.2
