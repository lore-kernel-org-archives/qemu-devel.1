Received: from eggs.gnu.org ([2001:4830:134:3::10]:48367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fujunkang@gmail.com>) id 1cMn8W-0006V0-Fu
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 21:41:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fujunkang@gmail.com>) id 1cMn8V-0000AI-0y
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 21:41:40 -0500
Received: from mail-wj0-x242.google.com ([2a00:1450:400c:c01::242]:36173)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fujunkang@gmail.com>) id 1cMn8U-00007w-LR
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 21:41:38 -0500
Received: by mail-wj0-x242.google.com with SMTP id j10so59427441wjb.3
	for <qemu-devel@nongnu.org>; Thu, 29 Dec 2016 18:41:36 -0800 (PST)
MIME-Version: 1.0
From: Junkang Fu <fujunkang@gmail.com>
Date: Fri, 30 Dec 2016 10:41:35 +0800
Message-ID: <CAP8dc_acqeqpio7fVK4XSAxoH8QaGp9L=S1h2OCCWgrj=Q7VCw@mail.gmail.com>
Content-Type: multipart/mixed; boundary=047d7bae4532faab460544d723f7
Subject: [Qemu-devel] [RFC]virtio-blk: add disk-name device property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@redhat.com
Cc: qemu-devel@nongnu.org

--047d7bae4532faab460544d723f7
Content-Type: text/plain; charset=UTF-8

>From 74e913fc41ea98d1dde692175f1e3fb6729342aa Mon Sep 17 00:00:00 2001
From: "junkang.fjk" <junkang.fjk@alibaba-inc.com>
Date: Wed, 24 Aug 2016 19:36:53 +0800
Subject: [PATCH] virtio-blk: add disk-name device property

Current virtio-blk disk name(ex. /dev/vdb) has nothing to do with the
target dev
name specified in libvirt xml file. For example, we may get disk name
/dev/vdb in
VM while target dev specified in libvirt xml is vdc. This may lead to a
little trouble
to find out the relationship between the disk name in VM and somewhere out
of
VM, for example in the control board of Public cloud service providers. I
suggest
if Qemu could add a VIRTIO_BLK_F_DISK_NAME feature, with
VIRTIO_BLK_F_DISK_NAME
capable Qemu and virtio-blk frontend drivers, disk name in the vm can be
specified
as follows:
        -device virtio-blk-pci,disk-name=vdabc

---
 hw/block/virtio-blk.c                       | 5 +++++
 include/hw/virtio/virtio-blk.h              | 1 +
 include/standard-headers/linux/virtio_blk.h | 6 ++++++
 3 files changed, 12 insertions(+)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 331d766..4039fb9 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -716,6 +716,8 @@ static void virtio_blk_update_config(VirtIODevice
*vdev, uint8_t *config)
     blkcfg.alignment_offset = 0;
     blkcfg.wce = blk_enable_write_cache(s->blk);
     virtio_stw_p(vdev, &blkcfg.num_queues, s->conf.num_queues);
+    if (s->disk_name)
+        strncpy((char *)blkcfg.disk_name, s->disk_name, DISK_NAME_LEN);
     memcpy(config, &blkcfg, sizeof(struct virtio_blk_config));
 }
@@ -740,6 +742,8 @@ static uint64_t virtio_blk_get_features(VirtIODevice
*vdev, uint64_t features,
     virtio_add_feature(&features, VIRTIO_BLK_F_GEOMETRY);
     virtio_add_feature(&features, VIRTIO_BLK_F_TOPOLOGY);
     virtio_add_feature(&features, VIRTIO_BLK_F_BLK_SIZE);
+    virtio_add_feature(&features, VIRTIO_BLK_F_DISK_NAME);
+
     if (virtio_has_feature(features, VIRTIO_F_VERSION_1)) {
         if (s->conf.scsi) {
             error_setg(errp, "Please set scsi=off for virtio-blk devices
in order to use virtio 1.0");
@@ -970,6 +974,7 @@ static Property virtio_blk_properties[] = {
     DEFINE_PROP_BIT("request-merging", VirtIOBlock, conf.request_merging,
0,
                     true),
     DEFINE_PROP_UINT16("num-queues", VirtIOBlock, conf.num_queues, 1),
+    DEFINE_PROP_STRING("disk-name", VirtIOBlock, disk_name),
     DEFINE_PROP_END_OF_LIST(),
 };

diff --git a/include/hw/virtio/virtio-blk.h b/include/hw/virtio/virtio-blk.h
index 180bd8d..003e810 100644
--- a/include/hw/virtio/virtio-blk.h
+++ b/include/hw/virtio/virtio-blk.h
@@ -56,6 +56,7 @@ typedef struct VirtIOBlock {
     bool dataplane_disabled;
     bool dataplane_started;
     struct VirtIOBlockDataPlane *dataplane;
+    char *disk_name;
 } VirtIOBlock;

 typedef struct VirtIOBlockReq {
diff --git a/include/standard-headers/linux/virtio_blk.h
b/include/standard-headers/linux/virtio_blk.h
index ab16ec5..1f5d89d 100644
--- a/include/standard-headers/linux/virtio_blk.h
+++ b/include/standard-headers/linux/virtio_blk.h
@@ -38,6 +38,7 @@
 #define VIRTIO_BLK_F_BLK_SIZE  6   /* Block size of disk is available*/
 #define VIRTIO_BLK_F_TOPOLOGY  10  /* Topology information is available */
 #define VIRTIO_BLK_F_MQ        12  /* support more than one vq */
+#define VIRTIO_BLK_F_DISK_NAME  13      /* specify /dev/xxx name */

 /* Legacy feature bits */
 #ifndef VIRTIO_BLK_NO_LEGACY
@@ -51,6 +52,9 @@

 #define VIRTIO_BLK_ID_BYTES    20  /* ID string length */

+/* micro defined in kernel genhd.h */
+#define DISK_NAME_LEN 32
+
 struct virtio_blk_config {
    /* The capacity (in 512-byte sectors). */
    uint64_t capacity;
@@ -84,6 +88,8 @@ struct virtio_blk_config {

    /* number of vqs, only available when VIRTIO_BLK_F_MQ is set */
    uint16_t num_queues;
+
+   uint8_t disk_name[DISK_NAME_LEN];
 } QEMU_PACKED;

 /*
--
1.9.4

--047d7bae4532faab460544d723f7
Content-Type: application/octet-stream;
	name="0001-virtio-blk-add-disk-name-device-property.patch"
Content-Disposition: attachment;
	filename="0001-virtio-blk-add-disk-name-device-property.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ixb6zhe00

RnJvbSA3NGU5MTNmYzQxZWE5OGQxZGRlNjkyMTc1ZjFlM2ZiNjcyOTM0MmFhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiAianVua2FuZy5mamsiIDxqdW5rYW5nLmZqa0BhbGliYWJhLWlu
Yy5jb20+CkRhdGU6IFdlZCwgMjQgQXVnIDIwMTYgMTk6MzY6NTMgKzA4MDAKU3ViamVjdDogW1BB
VENIXSB2aXJ0aW8tYmxrOiBhZGQgZGlzay1uYW1lIGRldmljZSBwcm9wZXJ0eQoKQ3VycmVudCB2
aXJ0aW8tYmxrIGRpc2sgbmFtZShleC4gL2Rldi92ZGIpIGhhcyBub3RoaW5nIHRvIGRvIHdpdGgg
dGhlIHRhcmdldCBkZXYKbmFtZSBzcGVjaWZpZWQgaW4gbGlidmlydCB4bWwgZmlsZS4gRm9yIGV4
YW1wbGUsIHdlIG1heSBnZXQgZGlzayBuYW1lIC9kZXYvdmRiCmluIFZNIHdoaWxlIHRhcmdldCBk
ZXYgc3BlY2lmaWVkIGluIGxpYnZpcnQgeG1sIGlzIHZkYy4gVGhpcyBtYXkgbGVhZCB0byBhIGxp
dHRsZQp0cm91YmxlIHRvIGZpbmQgb3V0IHRoZSByZWxhdGlvbnNoaXAgYmV0d2VlbiB0aGUgZGlz
ayBuYW1lIGluIFZNIGFuZCBzb21ld2hlcmUgb3V0Cm9mIFZNLCBmb3IgZXhhbXBsZSBpbiB0aGUg
Y29udHJvbCBib2FyZCBvZiBQdWJsaWMgY2xvdWQgc2VydmljZSBwcm92aWRlcnMuIEkgc3VnZ2Vz
dAppZiBRZW11IGNvdWxkIGFkZCBhIFZJUlRJT19CTEtfRl9ESVNLX05BTUUgZmVhdHVyZSwgd2l0
aCBWSVJUSU9fQkxLX0ZfRElTS19OQU1FCmNhcGFibGUgUWVtdSBhbmQgdmlydGlvLWJsayBmcm9u
dGVuZCBkcml2ZXJzLCBkaXNrIG5hbWUgaW4gdGhlIHZtIGNhbiBiZSBzcGVjaWZpZWQKYXMgZm9s
bG93czoKICAgICAgICAtZGV2aWNlIHZpcnRpby1ibGstcGNpLGRpc2stbmFtZT12ZGFiYwoKLS0t
CiBody9ibG9jay92aXJ0aW8tYmxrLmMgICAgICAgICAgICAgICAgICAgICAgIHwgNSArKysrKwog
aW5jbHVkZS9ody92aXJ0aW8vdmlydGlvLWJsay5oICAgICAgICAgICAgICB8IDEgKwogaW5jbHVk
ZS9zdGFuZGFyZC1oZWFkZXJzL2xpbnV4L3ZpcnRpb19ibGsuaCB8IDYgKysrKysrCiAzIGZpbGVz
IGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9ody9ibG9jay92aXJ0aW8t
YmxrLmMgYi9ody9ibG9jay92aXJ0aW8tYmxrLmMKaW5kZXggMzMxZDc2Ni4uNDAzOWZiOSAxMDA2
NDQKLS0tIGEvaHcvYmxvY2svdmlydGlvLWJsay5jCisrKyBiL2h3L2Jsb2NrL3ZpcnRpby1ibGsu
YwpAQCAtNzE2LDYgKzcxNiw4IEBAIHN0YXRpYyB2b2lkIHZpcnRpb19ibGtfdXBkYXRlX2NvbmZp
ZyhWaXJ0SU9EZXZpY2UgKnZkZXYsIHVpbnQ4X3QgKmNvbmZpZykKICAgICBibGtjZmcuYWxpZ25t
ZW50X29mZnNldCA9IDA7CiAgICAgYmxrY2ZnLndjZSA9IGJsa19lbmFibGVfd3JpdGVfY2FjaGUo
cy0+YmxrKTsKICAgICB2aXJ0aW9fc3R3X3AodmRldiwgJmJsa2NmZy5udW1fcXVldWVzLCBzLT5j
b25mLm51bV9xdWV1ZXMpOworICAgIGlmIChzLT5kaXNrX25hbWUpCisgICAgICAgIHN0cm5jcHko
KGNoYXIgKilibGtjZmcuZGlza19uYW1lLCBzLT5kaXNrX25hbWUsIERJU0tfTkFNRV9MRU4pOwog
ICAgIG1lbWNweShjb25maWcsICZibGtjZmcsIHNpemVvZihzdHJ1Y3QgdmlydGlvX2Jsa19jb25m
aWcpKTsKIH0KIApAQCAtNzQwLDYgKzc0Miw4IEBAIHN0YXRpYyB1aW50NjRfdCB2aXJ0aW9fYmxr
X2dldF9mZWF0dXJlcyhWaXJ0SU9EZXZpY2UgKnZkZXYsIHVpbnQ2NF90IGZlYXR1cmVzLAogICAg
IHZpcnRpb19hZGRfZmVhdHVyZSgmZmVhdHVyZXMsIFZJUlRJT19CTEtfRl9HRU9NRVRSWSk7CiAg
ICAgdmlydGlvX2FkZF9mZWF0dXJlKCZmZWF0dXJlcywgVklSVElPX0JMS19GX1RPUE9MT0dZKTsK
ICAgICB2aXJ0aW9fYWRkX2ZlYXR1cmUoJmZlYXR1cmVzLCBWSVJUSU9fQkxLX0ZfQkxLX1NJWkUp
OworICAgIHZpcnRpb19hZGRfZmVhdHVyZSgmZmVhdHVyZXMsIFZJUlRJT19CTEtfRl9ESVNLX05B
TUUpOworCiAgICAgaWYgKHZpcnRpb19oYXNfZmVhdHVyZShmZWF0dXJlcywgVklSVElPX0ZfVkVS
U0lPTl8xKSkgewogICAgICAgICBpZiAocy0+Y29uZi5zY3NpKSB7CiAgICAgICAgICAgICBlcnJv
cl9zZXRnKGVycnAsICJQbGVhc2Ugc2V0IHNjc2k9b2ZmIGZvciB2aXJ0aW8tYmxrIGRldmljZXMg
aW4gb3JkZXIgdG8gdXNlIHZpcnRpbyAxLjAiKTsKQEAgLTk3MCw2ICs5NzQsNyBAQCBzdGF0aWMg
UHJvcGVydHkgdmlydGlvX2Jsa19wcm9wZXJ0aWVzW10gPSB7CiAgICAgREVGSU5FX1BST1BfQklU
KCJyZXF1ZXN0LW1lcmdpbmciLCBWaXJ0SU9CbG9jaywgY29uZi5yZXF1ZXN0X21lcmdpbmcsIDAs
CiAgICAgICAgICAgICAgICAgICAgIHRydWUpLAogICAgIERFRklORV9QUk9QX1VJTlQxNigibnVt
LXF1ZXVlcyIsIFZpcnRJT0Jsb2NrLCBjb25mLm51bV9xdWV1ZXMsIDEpLAorICAgIERFRklORV9Q
Uk9QX1NUUklORygiZGlzay1uYW1lIiwgVmlydElPQmxvY2ssIGRpc2tfbmFtZSksCiAgICAgREVG
SU5FX1BST1BfRU5EX09GX0xJU1QoKSwKIH07CiAKZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvdmly
dGlvL3ZpcnRpby1ibGsuaCBiL2luY2x1ZGUvaHcvdmlydGlvL3ZpcnRpby1ibGsuaAppbmRleCAx
ODBiZDhkLi4wMDNlODEwIDEwMDY0NAotLS0gYS9pbmNsdWRlL2h3L3ZpcnRpby92aXJ0aW8tYmxr
LmgKKysrIGIvaW5jbHVkZS9ody92aXJ0aW8vdmlydGlvLWJsay5oCkBAIC01Niw2ICs1Niw3IEBA
IHR5cGVkZWYgc3RydWN0IFZpcnRJT0Jsb2NrIHsKICAgICBib29sIGRhdGFwbGFuZV9kaXNhYmxl
ZDsKICAgICBib29sIGRhdGFwbGFuZV9zdGFydGVkOwogICAgIHN0cnVjdCBWaXJ0SU9CbG9ja0Rh
dGFQbGFuZSAqZGF0YXBsYW5lOworICAgIGNoYXIgKmRpc2tfbmFtZTsKIH0gVmlydElPQmxvY2s7
CiAKIHR5cGVkZWYgc3RydWN0IFZpcnRJT0Jsb2NrUmVxIHsKZGlmZiAtLWdpdCBhL2luY2x1ZGUv
c3RhbmRhcmQtaGVhZGVycy9saW51eC92aXJ0aW9fYmxrLmggYi9pbmNsdWRlL3N0YW5kYXJkLWhl
YWRlcnMvbGludXgvdmlydGlvX2Jsay5oCmluZGV4IGFiMTZlYzUuLjFmNWQ4OWQgMTAwNjQ0Ci0t
LSBhL2luY2x1ZGUvc3RhbmRhcmQtaGVhZGVycy9saW51eC92aXJ0aW9fYmxrLmgKKysrIGIvaW5j
bHVkZS9zdGFuZGFyZC1oZWFkZXJzL2xpbnV4L3ZpcnRpb19ibGsuaApAQCAtMzgsNiArMzgsNyBA
QAogI2RlZmluZSBWSVJUSU9fQkxLX0ZfQkxLX1NJWkUJNgkvKiBCbG9jayBzaXplIG9mIGRpc2sg
aXMgYXZhaWxhYmxlKi8KICNkZWZpbmUgVklSVElPX0JMS19GX1RPUE9MT0dZCTEwCS8qIFRvcG9s
b2d5IGluZm9ybWF0aW9uIGlzIGF2YWlsYWJsZSAqLwogI2RlZmluZSBWSVJUSU9fQkxLX0ZfTVEJ
CTEyCS8qIHN1cHBvcnQgbW9yZSB0aGFuIG9uZSB2cSAqLworI2RlZmluZSBWSVJUSU9fQkxLX0Zf
RElTS19OQU1FICAxMyAgICAgIC8qIHNwZWNpZnkgL2Rldi94eHggbmFtZSAqLwogCiAvKiBMZWdh
Y3kgZmVhdHVyZSBiaXRzICovCiAjaWZuZGVmIFZJUlRJT19CTEtfTk9fTEVHQUNZCkBAIC01MSw2
ICs1Miw5IEBACiAKICNkZWZpbmUgVklSVElPX0JMS19JRF9CWVRFUwkyMAkvKiBJRCBzdHJpbmcg
bGVuZ3RoICovCiAKKy8qIG1pY3JvIGRlZmluZWQgaW4ga2VybmVsIGdlbmhkLmggKi8KKyNkZWZp
bmUgRElTS19OQU1FX0xFTiAzMgorCiBzdHJ1Y3QgdmlydGlvX2Jsa19jb25maWcgewogCS8qIFRo
ZSBjYXBhY2l0eSAoaW4gNTEyLWJ5dGUgc2VjdG9ycykuICovCiAJdWludDY0X3QgY2FwYWNpdHk7
CkBAIC04NCw2ICs4OCw4IEBAIHN0cnVjdCB2aXJ0aW9fYmxrX2NvbmZpZyB7CiAKIAkvKiBudW1i
ZXIgb2YgdnFzLCBvbmx5IGF2YWlsYWJsZSB3aGVuIFZJUlRJT19CTEtfRl9NUSBpcyBzZXQgKi8K
IAl1aW50MTZfdCBudW1fcXVldWVzOworCisJdWludDhfdCBkaXNrX25hbWVbRElTS19OQU1FX0xF
Tl07CiB9IFFFTVVfUEFDS0VEOwogCiAvKgotLSAKMS45LjQKCg==
--047d7bae4532faab460544d723f7--
