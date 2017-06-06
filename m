Received: from eggs.gnu.org ([2001:4830:134:3::10]:42813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quwenruo@cn.fujitsu.com>) id 1dI94Y-0003DQ-Pt
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 03:38:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quwenruo@cn.fujitsu.com>) id 1dI94X-0003qi-Cg
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 03:38:38 -0400
From: Qu Wenruo <quwenruo@cn.fujitsu.com>
Date: Tue, 6 Jun 2017 15:38:05 +0800
Message-ID: <20170606073806.8180-1-quwenruo@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 1/2] nvme: Update header to include SGL related
 macros and members
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org, keith.busch@intel.com

Update nvme header to catch up with kernel.
Most of the newly added members are from 1.2 and 1.3 spec, while the
status code is only kept the same with kernel (around 1.1 spec).

The major update is to add Scatter Gather List related macros and
members, for later SGL support implementation.

Signed-off-by: Qu Wenruo <quwenruo@cn.fujitsu.com>
---
 hw/block/nvme.c |  16 ++++----
 hw/block/nvme.h | 122 +++++++++++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 111 insertions(+), 27 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 381dc7c5fb..fa1069160e 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -270,8 +270,8 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
     NvmeRwCmd *rw = (NvmeRwCmd *)cmd;
     uint32_t nlb  = le32_to_cpu(rw->nlb) + 1;
     uint64_t slba = le64_to_cpu(rw->slba);
-    uint64_t prp1 = le64_to_cpu(rw->prp1);
-    uint64_t prp2 = le64_to_cpu(rw->prp2);
+    uint64_t prp1 = le64_to_cpu(rw->dptr.prp1);
+    uint64_t prp2 = le64_to_cpu(rw->dptr.prp2);
 
     uint8_t lba_index  = NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas);
     uint8_t data_shift = ns->id_ns.lbaf[lba_index].ds;
@@ -512,8 +512,8 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeCmd *cmd)
 
 static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeIdentify *c)
 {
-    uint64_t prp1 = le64_to_cpu(c->prp1);
-    uint64_t prp2 = le64_to_cpu(c->prp2);
+    uint64_t prp1 = le64_to_cpu(c->dptr.prp1);
+    uint64_t prp2 = le64_to_cpu(c->dptr.prp2);
 
     return nvme_dma_read_prp(n, (uint8_t *)&n->id_ctrl, sizeof(n->id_ctrl),
         prp1, prp2);
@@ -523,8 +523,8 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeIdentify *c)
 {
     NvmeNamespace *ns;
     uint32_t nsid = le32_to_cpu(c->nsid);
-    uint64_t prp1 = le64_to_cpu(c->prp1);
-    uint64_t prp2 = le64_to_cpu(c->prp2);
+    uint64_t prp1 = le64_to_cpu(c->dptr.prp1);
+    uint64_t prp2 = le64_to_cpu(c->dptr.prp2);
 
     if (nsid == 0 || nsid > n->num_namespaces) {
         return NVME_INVALID_NSID | NVME_DNR;
@@ -539,8 +539,8 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeIdentify *c)
 {
     static const int data_len = 4096;
     uint32_t min_nsid = le32_to_cpu(c->nsid);
-    uint64_t prp1 = le64_to_cpu(c->prp1);
-    uint64_t prp2 = le64_to_cpu(c->prp2);
+    uint64_t prp1 = le64_to_cpu(c->dptr.prp1);
+    uint64_t prp2 = le64_to_cpu(c->dptr.prp2);
     uint32_t *list;
     uint16_t ret;
     int i, j = 0;
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index b4961d2547..26be663d2d 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -206,6 +206,29 @@ enum NvmeCmbszMask {
 #define NVME_CMBSZ_GETSIZE(cmbsz) \
     (NVME_CMBSZ_SZ(cmbsz) * (1 << (12 + 4 * NVME_CMBSZ_SZU(cmbsz))))
 
+typedef struct NvmeSGLDesc {
+    uint64_t    addr;
+    uint32_t    length;
+    uint8_t     rsvd[3];
+    uint8_t     type;
+} NvmeSGLDesc;
+
+typedef struct NvmeKeyedSGLDesc {
+    uint64_t    addr;
+    uint8_t     length[3];
+    uint8_t     key[4];
+    uint8_t     type;
+} NvmeKeyedSGLDesc;
+
+typedef union NvmeDataPtr{
+    struct {
+        uint64_t        prp1;
+        uint64_t        prp2;
+    };
+    NvmeSGLDesc         sgl;
+    NvmeKeyedSGLDesc    ksgl;
+} NvmeDataPtr;
+
 typedef struct NvmeCmd {
     uint8_t     opcode;
     uint8_t     fuse;
@@ -213,8 +236,7 @@ typedef struct NvmeCmd {
     uint32_t    nsid;
     uint64_t    res1;
     uint64_t    mptr;
-    uint64_t    prp1;
-    uint64_t    prp2;
+    NvmeDataPtr dptr;
     uint32_t    cdw10;
     uint32_t    cdw11;
     uint32_t    cdw12;
@@ -309,9 +331,10 @@ typedef struct NvmeIdentify {
     uint16_t    cid;
     uint32_t    nsid;
     uint64_t    rsvd2[2];
-    uint64_t    prp1;
-    uint64_t    prp2;
-    uint32_t    cns;
+    NvmeDataPtr dptr;
+    uint8_t     cns;
+    uint8_t     rsvd3;
+    uint16_t    ctrlid;
     uint32_t    rsvd11[5];
 } NvmeIdentify;
 
@@ -322,8 +345,7 @@ typedef struct NvmeRwCmd {
     uint32_t    nsid;
     uint64_t    rsvd2;
     uint64_t    mptr;
-    uint64_t    prp1;
-    uint64_t    prp2;
+    NvmeDataPtr dptr;
     uint64_t    slba;
     uint16_t    nlb;
     uint16_t    control;
@@ -363,8 +385,7 @@ typedef struct NvmeDsmCmd {
     uint16_t    cid;
     uint32_t    nsid;
     uint64_t    rsvd2[2];
-    uint64_t    prp1;
-    uint64_t    prp2;
+    NvmeDataPtr dptr;
     uint32_t    nr;
     uint32_t    attributes;
     uint32_t    rsvd12[4];
@@ -428,6 +449,13 @@ enum NvmeStatusCodes {
     NVME_CMD_ABORT_MISSING_FUSE = 0x000a,
     NVME_INVALID_NSID           = 0x000b,
     NVME_CMD_SEQ_ERROR          = 0x000c,
+    NVME_SGL_INVALID_LAST       = 0x000d,
+    NVME_SGL_INVALID_COUNT      = 0x000e,
+    NVME_SGL_INVALID_DATA       = 0x000f,
+    NVME_SGL_INVALID_METADATA   = 0x0010,
+    NVME_SGL_INVALID_TYPE       = 0x0011,
+    NVME_SGL_INVALID_OFFSET     = 0x0016,
+    NVME_SGL_INVALID_SUBTYPE    = 0x0017,
     NVME_LBA_RANGE              = 0x0080,
     NVME_CAP_EXCEEDED           = 0x0081,
     NVME_NS_NOT_READY           = 0x0082,
@@ -485,7 +513,9 @@ typedef struct NvmeErrorLog {
     uint64_t    lba;
     uint32_t    nsid;
     uint8_t     vs;
-    uint8_t     resv[35];
+    uint8_t     rsvd29[3];
+    uint8_t     cmd_specific_info;
+    uint8_t     rsvd40[24];
 } NvmeErrorLog;
 
 typedef struct NvmeSmartLog {
@@ -505,7 +535,10 @@ typedef struct NvmeSmartLog {
     uint64_t    unsafe_shutdowns[2];
     uint64_t    media_errors[2];
     uint64_t    number_of_error_log_entries[2];
-    uint8_t     reserved2[320];
+    uint32_t    warning_temp_time;
+    uint32_t    critical_comp_time;
+    uint16_t    temp_sensor[8];
+    uint8_t     rsvd216[296];
 } NvmeSmartLog;
 
 enum NvmeSmartWarn {
@@ -524,14 +557,20 @@ enum LogIdentifier {
 
 typedef struct NvmePSD {
     uint16_t    mp;
-    uint16_t    reserved;
+    uint8_t     rsvd2;
+    uint8_t     flags;
     uint32_t    enlat;
     uint32_t    exlat;
     uint8_t     rrt;
     uint8_t     rrl;
     uint8_t     rwt;
     uint8_t     rwl;
-    uint8_t     resv[16];
+    uint16_t    idlp;
+    uint8_t     ips;
+    uint8_t     rsvd19;
+    uint16_t    actp;
+    uint8_t     aps;
+    uint8_t     rsvd23[9];
 } NvmePSD;
 
 typedef struct NvmeIdCtrl {
@@ -544,7 +583,13 @@ typedef struct NvmeIdCtrl {
     uint8_t     ieee[3];
     uint8_t     cmic;
     uint8_t     mdts;
-    uint8_t     rsvd255[178];
+    uint16_t    cntlid;
+    uint32_t    ver;
+    uint32_t    rtd3r;
+    uint32_t    rtd3e;
+    uint32_t    oaes;
+    uint32_t    ctratt;
+    uint8_t     rsvd100[156];
     uint16_t    oacs;
     uint8_t     acl;
     uint8_t     aerl;
@@ -552,10 +597,22 @@ typedef struct NvmeIdCtrl {
     uint8_t     lpa;
     uint8_t     elpe;
     uint8_t     npss;
-    uint8_t     rsvd511[248];
+    uint8_t     avscc;
+    uint8_t     apsta;
+    uint16_t    wctemp;
+    uint16_t    cctemp;
+    uint16_t    mtfa;
+    uint32_t    hmpre;
+    uint32_t    hmmin;
+    uint8_t     tnvmcap[16];
+    uint8_t     unvmcap[16];
+    uint32_t    rpmbs;
+    uint8_t     rsvd316[4];
+    uint16_t    kas;
+    uint8_t     rsvd322[190];
     uint8_t     sqes;
     uint8_t     cqes;
-    uint16_t    rsvd515;
+    uint16_t    maxcmd;
     uint32_t    nn;
     uint16_t    oncs;
     uint16_t    fuses;
@@ -563,8 +620,20 @@ typedef struct NvmeIdCtrl {
     uint8_t     vwc;
     uint16_t    awun;
     uint16_t    awupf;
-    uint8_t     rsvd703[174];
-    uint8_t     rsvd2047[1344];
+    uint8_t     nvscc;
+    uint8_t     rsvd531;
+    uint16_t    acwu;
+    uint8_t     rsvd534[2];
+    uint32_t    sgls;
+    uint8_t     rsvd540[228];
+    uint8_t     subnqn[256];
+    uint8_t     rsvd1024[768];
+    uint32_t    ioccsz;
+    uint32_t    iorcsz;
+    uint16_t    icdoff;
+    uint8_t     ctrattr;
+    uint8_t     msdbd;
+    uint8_t     rsvd1804[244];
     NvmePSD     psd[32];
     uint8_t     vs[1024];
 } NvmeIdCtrl;
@@ -652,7 +721,21 @@ typedef struct NvmeIdNs {
     uint8_t     mc;
     uint8_t     dpc;
     uint8_t     dps;
-    uint8_t     res30[98];
+    uint8_t     nmic;
+    uint8_t     rescap;
+    uint8_t     fpi;
+    uint8_t     rsvd33;
+    uint16_t    nawun;
+    uint16_t    nawupf;
+    uint16_t    nacwu;
+    uint16_t    nabsn;
+    uint16_t    nabo;
+    uint16_t    nabspf;
+    uint16_t    rsvd46;
+    uint8_t     nvmcap[16];
+    uint8_t     rsvd64[40];
+    uint8_t     nguid[16];
+    uint8_t     eui64[8];
     NvmeLBAF    lbaf[16];
     uint8_t     res192[192];
     uint8_t     vs[3712];
@@ -682,6 +765,7 @@ enum NvmeIdNsDps {
 static inline void _nvme_check_size(void)
 {
     QEMU_BUILD_BUG_ON(sizeof(NvmeAerResult) != 4);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeDataPtr) != 16);
     QEMU_BUILD_BUG_ON(sizeof(NvmeCqe) != 16);
     QEMU_BUILD_BUG_ON(sizeof(NvmeDsmRange) != 16);
     QEMU_BUILD_BUG_ON(sizeof(NvmeCmd) != 64);
-- 
2.13.0
