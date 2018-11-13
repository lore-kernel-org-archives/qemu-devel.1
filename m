Received: from eggs.gnu.org ([2001:4830:134:3::10]:39416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xiezhide@huawei.com>) id 1gMVUy-0004em-PO
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 05:00:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xiezhide@huawei.com>) id 1gMVUi-0004DF-C2
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 05:00:40 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2289 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <xiezhide@huawei.com>) id 1gMVUf-00048H-4Z
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 05:00:28 -0500
From: xiezhide <xiezhide@huawei.com>
Date: Tue, 13 Nov 2018 10:00:10 +0000
Message-ID: <A02D6AA901860840B46E751C5E9E38B43CC96FB1@DGGEML532-MBX.china.huawei.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v1 1/3] fsdev-throttle-qmp: refactor code for
 qmp interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Greg Kurz <groug@kaod.org>, "berto@igalia.com" <berto@igalia.com>, "armbru@redhat.com" <armbru@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "aneesh.kumar@linux.vnet.ibm.com" <aneesh.kumar@linux.vnet.ibm.com>

This patch includes two parts:
1. factor out throttle code to reuse code
2. use ThrottleLimits structure

Signed-off-by: x00390961 <xiezhide@huawei.com>
---
 Makefile                        |  20 +++-
 Makefile.objs                   |   8 ++
 block/throttle.c                |   6 +-
 blockdev.c                      |  96 +----------------
 include/qemu/throttle-options.h |   3 +-
 include/qemu/throttle.h         |   4 +-
 include/qemu/typedefs.h         |   1 +
 qapi/block-core.json            | 122 +---------------------
 qapi/fsdev.json                 |  20 ++++
 qapi/qapi-schema.json           |   1 +
 qapi/tlimits.json               |  89 ++++++++++++++++
 util/throttle.c                 | 224 ++++++++++++++++++++++++++----------=
----
 12 files changed, 298 insertions(+), 296 deletions(-)
 create mode 100644 qapi/fsdev.json
 create mode 100644 qapi/tlimits.json

diff --git a/Makefile b/Makefile
index f294718..9ae2460 100644
--- a/Makefile
+++ b/Makefile
@@ -94,6 +94,7 @@ GENERATED_FILES +=3D qapi/qapi-types-block-core.h qapi/qa=
pi-types-block-core.c
 GENERATED_FILES +=3D qapi/qapi-types-block.h qapi/qapi-types-block.c
 GENERATED_FILES +=3D qapi/qapi-types-char.h qapi/qapi-types-char.c
 GENERATED_FILES +=3D qapi/qapi-types-common.h qapi/qapi-types-common.c
+GENERATED_FILES +=3D qapi/qapi-types-tlimits.h qapi/qapi-types-tlimits.c
 GENERATED_FILES +=3D qapi/qapi-types-crypto.h qapi/qapi-types-crypto.c
 GENERATED_FILES +=3D qapi/qapi-types-introspect.h qapi/qapi-types-introspe=
ct.c
 GENERATED_FILES +=3D qapi/qapi-types-job.h qapi/qapi-types-job.c
@@ -107,12 +108,14 @@ GENERATED_FILES +=3D qapi/qapi-types-tpm.h qapi/qapi-=
types-tpm.c
 GENERATED_FILES +=3D qapi/qapi-types-trace.h qapi/qapi-types-trace.c
 GENERATED_FILES +=3D qapi/qapi-types-transaction.h qapi/qapi-types-transac=
tion.c
 GENERATED_FILES +=3D qapi/qapi-types-ui.h qapi/qapi-types-ui.c
+GENERATED_FILES +=3D qapi/qapi-types-fsdev.h qapi/qapi-types-fsdev.c
 GENERATED_FILES +=3D qapi/qapi-builtin-visit.h qapi/qapi-builtin-visit.c
 GENERATED_FILES +=3D qapi/qapi-visit.h qapi/qapi-visit.c
 GENERATED_FILES +=3D qapi/qapi-visit-block-core.h qapi/qapi-visit-block-co=
re.c
 GENERATED_FILES +=3D qapi/qapi-visit-block.h qapi/qapi-visit-block.c
 GENERATED_FILES +=3D qapi/qapi-visit-char.h qapi/qapi-visit-char.c
 GENERATED_FILES +=3D qapi/qapi-visit-common.h qapi/qapi-visit-common.c
+GENERATED_FILES +=3D qapi/qapi-visit-tlimits.h qapi/qapi-visit-tlimits.c
 GENERATED_FILES +=3D qapi/qapi-visit-crypto.h qapi/qapi-visit-crypto.c
 GENERATED_FILES +=3D qapi/qapi-visit-introspect.h qapi/qapi-visit-introspe=
ct.c
 GENERATED_FILES +=3D qapi/qapi-visit-job.h qapi/qapi-visit-job.c
@@ -126,11 +129,13 @@ GENERATED_FILES +=3D qapi/qapi-visit-tpm.h qapi/qapi-=
visit-tpm.c
 GENERATED_FILES +=3D qapi/qapi-visit-trace.h qapi/qapi-visit-trace.c
 GENERATED_FILES +=3D qapi/qapi-visit-transaction.h qapi/qapi-visit-transac=
tion.c
 GENERATED_FILES +=3D qapi/qapi-visit-ui.h qapi/qapi-visit-ui.c
+GENERATED_FILES +=3D qapi/qapi-visit-fsdev.h qapi/qapi-visit-fsdev.c
 GENERATED_FILES +=3D qapi/qapi-commands.h qapi/qapi-commands.c
 GENERATED_FILES +=3D qapi/qapi-commands-block-core.h qapi/qapi-commands-bl=
ock-core.c
 GENERATED_FILES +=3D qapi/qapi-commands-block.h qapi/qapi-commands-block.c
 GENERATED_FILES +=3D qapi/qapi-commands-char.h qapi/qapi-commands-char.c
 GENERATED_FILES +=3D qapi/qapi-commands-common.h qapi/qapi-commands-common=
.c
+GENERATED_FILES +=3D qapi/qapi-commands-tlimits.h qapi/qapi-commands-tlimi=
ts.c
 GENERATED_FILES +=3D qapi/qapi-commands-crypto.h qapi/qapi-commands-crypto=
.c
 GENERATED_FILES +=3D qapi/qapi-commands-introspect.h qapi/qapi-commands-in=
trospect.c
 GENERATED_FILES +=3D qapi/qapi-commands-job.h qapi/qapi-commands-job.c
@@ -144,11 +149,13 @@ GENERATED_FILES +=3D qapi/qapi-commands-tpm.h qapi/qa=
pi-commands-tpm.c
 GENERATED_FILES +=3D qapi/qapi-commands-trace.h qapi/qapi-commands-trace.c
 GENERATED_FILES +=3D qapi/qapi-commands-transaction.h qapi/qapi-commands-t=
ransaction.c
 GENERATED_FILES +=3D qapi/qapi-commands-ui.h qapi/qapi-commands-ui.c
+GENERATED_FILES +=3D qapi/qapi-commands-fsdev.h qapi/qapi-commands-fsdev.c
 GENERATED_FILES +=3D qapi/qapi-events.h qapi/qapi-events.c
 GENERATED_FILES +=3D qapi/qapi-events-block-core.h qapi/qapi-events-block-=
core.c
 GENERATED_FILES +=3D qapi/qapi-events-block.h qapi/qapi-events-block.c
 GENERATED_FILES +=3D qapi/qapi-events-char.h qapi/qapi-events-char.c
 GENERATED_FILES +=3D qapi/qapi-events-common.h qapi/qapi-events-common.c
+GENERATED_FILES +=3D qapi/qapi-events-tlimits.h qapi/qapi-events-tlimits.c
 GENERATED_FILES +=3D qapi/qapi-events-crypto.h qapi/qapi-events-crypto.c
 GENERATED_FILES +=3D qapi/qapi-events-introspect.h qapi/qapi-events-intros=
pect.c
 GENERATED_FILES +=3D qapi/qapi-events-job.h qapi/qapi-events-job.c
@@ -162,6 +169,7 @@ GENERATED_FILES +=3D qapi/qapi-events-tpm.h qapi/qapi-e=
vents-tpm.c
 GENERATED_FILES +=3D qapi/qapi-events-trace.h qapi/qapi-events-trace.c
 GENERATED_FILES +=3D qapi/qapi-events-transaction.h qapi/qapi-events-trans=
action.c
 GENERATED_FILES +=3D qapi/qapi-events-ui.h qapi/qapi-events-ui.c
+GENERATED_FILES +=3D qapi/qapi-events-fsdev.h qapi/qapi-events-fsdev.c
 GENERATED_FILES +=3D qapi/qapi-introspect.c qapi/qapi-introspect.h
 GENERATED_FILES +=3D qapi/qapi-doc.texi

@@ -598,7 +606,9 @@ qapi-modules =3D $(SRC_PATH)/qapi/qapi-schema.json $(SR=
C_PATH)/qapi/common.json \
                $(SRC_PATH)/qapi/tpm.json \
                $(SRC_PATH)/qapi/trace.json \
                $(SRC_PATH)/qapi/transaction.json \
-               $(SRC_PATH)/qapi/ui.json
+               $(SRC_PATH)/qapi/ui.json \
+               $(SRC_PATH)/qapi/fsdev.json \
+               $(SRC_PATH)/qapi/tlimits.json

 qapi/qapi-builtin-types.c qapi/qapi-builtin-types.h \
 qapi/qapi-types.c qapi/qapi-types.h \
@@ -606,6 +616,7 @@ qapi/qapi-types-block-core.c qapi/qapi-types-block-core=
.h \
 qapi/qapi-types-block.c qapi/qapi-types-block.h \
 qapi/qapi-types-char.c qapi/qapi-types-char.h \
 qapi/qapi-types-common.c qapi/qapi-types-common.h \
+qapi/qapi-types-tlimits.c qapi/qapi-types-tlimits.h \
 qapi/qapi-types-crypto.c qapi/qapi-types-crypto.h \
 qapi/qapi-types-introspect.c qapi/qapi-types-introspect.h \
 qapi/qapi-types-job.c qapi/qapi-types-job.h \
@@ -619,12 +630,14 @@ qapi/qapi-types-tpm.c qapi/qapi-types-tpm.h \
 qapi/qapi-types-trace.c qapi/qapi-types-trace.h \
 qapi/qapi-types-transaction.c qapi/qapi-types-transaction.h \
 qapi/qapi-types-ui.c qapi/qapi-types-ui.h \
+qapi/qapi-types-fsdev.c qapi/qapi-types-fsdev.h \
 qapi/qapi-builtin-visit.c qapi/qapi-builtin-visit.h \
 qapi/qapi-visit.c qapi/qapi-visit.h \
 qapi/qapi-visit-block-core.c qapi/qapi-visit-block-core.h \
 qapi/qapi-visit-block.c qapi/qapi-visit-block.h \
 qapi/qapi-visit-char.c qapi/qapi-visit-char.h \
 qapi/qapi-visit-common.c qapi/qapi-visit-common.h \
+qapi/qapi-visit-tlimits.c qapi/qapi-visit-tlimits.h \
 qapi/qapi-visit-crypto.c qapi/qapi-visit-crypto.h \
 qapi/qapi-visit-introspect.c qapi/qapi-visit-introspect.h \
 qapi/qapi-visit-job.c qapi/qapi-visit-job.h \
@@ -638,11 +651,13 @@ qapi/qapi-visit-tpm.c qapi/qapi-visit-tpm.h \
 qapi/qapi-visit-trace.c qapi/qapi-visit-trace.h \
 qapi/qapi-visit-transaction.c qapi/qapi-visit-transaction.h \
 qapi/qapi-visit-ui.c qapi/qapi-visit-ui.h \
+qapi/qapi-visit-fsdev.c qapi/qapi-visit-fsdev.h \
 qapi/qapi-commands.h qapi/qapi-commands.c \
 qapi/qapi-commands-block-core.c qapi/qapi-commands-block-core.h \
 qapi/qapi-commands-block.c qapi/qapi-commands-block.h \
 qapi/qapi-commands-char.c qapi/qapi-commands-char.h \
 qapi/qapi-commands-common.c qapi/qapi-commands-common.h \
+qapi/qapi-commands-tlimits.c qapi/qapi-commands-tlimits.h \
 qapi/qapi-commands-crypto.c qapi/qapi-commands-crypto.h \
 qapi/qapi-commands-introspect.c qapi/qapi-commands-introspect.h \
 qapi/qapi-commands-job.c qapi/qapi-commands-job.h \
@@ -656,11 +671,13 @@ qapi/qapi-commands-tpm.c qapi/qapi-commands-tpm.h \
 qapi/qapi-commands-trace.c qapi/qapi-commands-trace.h \
 qapi/qapi-commands-transaction.c qapi/qapi-commands-transaction.h \
 qapi/qapi-commands-ui.c qapi/qapi-commands-ui.h \
+qapi/qapi-commands-fsdev.c qapi/qapi-commands-fsdev.h \
 qapi/qapi-events.c qapi/qapi-events.h \
 qapi/qapi-events-block-core.c qapi/qapi-events-block-core.h \
 qapi/qapi-events-block.c qapi/qapi-events-block.h \
 qapi/qapi-events-char.c qapi/qapi-events-char.h \
 qapi/qapi-events-common.c qapi/qapi-events-common.h \
+qapi/qapi-events-tlimits.c qapi/qapi-events-tlimits.h \
 qapi/qapi-events-crypto.c qapi/qapi-events-crypto.h \
 qapi/qapi-events-introspect.c qapi/qapi-events-introspect.h \
 qapi/qapi-events-job.c qapi/qapi-events-job.h \
@@ -674,6 +691,7 @@ qapi/qapi-events-tpm.c qapi/qapi-events-tpm.h \
 qapi/qapi-events-trace.c qapi/qapi-events-trace.h \
 qapi/qapi-events-transaction.c qapi/qapi-events-transaction.h \
 qapi/qapi-events-ui.c qapi/qapi-events-ui.h \
+qapi/qapi-events-fsdev.c qapi/qapi-events-fsdev.h \
 qapi/qapi-introspect.h qapi/qapi-introspect.c \
 qapi/qapi-doc.texi: \
 qapi-gen-timestamp ;
diff --git a/Makefile.objs b/Makefile.objs
index 1e1ff38..b0e438e 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -8,6 +8,7 @@ util-obj-y +=3D qapi/qapi-types-block-core.o
 util-obj-y +=3D qapi/qapi-types-block.o
 util-obj-y +=3D qapi/qapi-types-char.o
 util-obj-y +=3D qapi/qapi-types-common.o
+util-obj-y +=3D qapi/qapi-types-tlimits.o
 util-obj-y +=3D qapi/qapi-types-crypto.o
 util-obj-y +=3D qapi/qapi-types-introspect.o
 util-obj-y +=3D qapi/qapi-types-job.o
@@ -21,12 +22,14 @@ util-obj-y +=3D qapi/qapi-types-tpm.o
 util-obj-y +=3D qapi/qapi-types-trace.o
 util-obj-y +=3D qapi/qapi-types-transaction.o
 util-obj-y +=3D qapi/qapi-types-ui.o
+util-obj-y +=3D qapi/qapi-types-fsdev.o
 util-obj-y +=3D qapi/qapi-builtin-visit.o
 util-obj-y +=3D qapi/qapi-visit.o
 util-obj-y +=3D qapi/qapi-visit-block-core.o
 util-obj-y +=3D qapi/qapi-visit-block.o
 util-obj-y +=3D qapi/qapi-visit-char.o
 util-obj-y +=3D qapi/qapi-visit-common.o
+util-obj-y +=3D qapi/qapi-visit-tlimits.o
 util-obj-y +=3D qapi/qapi-visit-crypto.o
 util-obj-y +=3D qapi/qapi-visit-introspect.o
 util-obj-y +=3D qapi/qapi-visit-job.o
@@ -40,11 +43,13 @@ util-obj-y +=3D qapi/qapi-visit-tpm.o
 util-obj-y +=3D qapi/qapi-visit-trace.o
 util-obj-y +=3D qapi/qapi-visit-transaction.o
 util-obj-y +=3D qapi/qapi-visit-ui.o
+util-obj-y +=3D qapi/qapi-visit-fsdev.o
 util-obj-y +=3D qapi/qapi-events.o
 util-obj-y +=3D qapi/qapi-events-block-core.o
 util-obj-y +=3D qapi/qapi-events-block.o
 util-obj-y +=3D qapi/qapi-events-char.o
 util-obj-y +=3D qapi/qapi-events-common.o
+util-obj-y +=3D qapi/qapi-events-tlimits.o
 util-obj-y +=3D qapi/qapi-events-crypto.o
 util-obj-y +=3D qapi/qapi-events-introspect.o
 util-obj-y +=3D qapi/qapi-events-job.o
@@ -58,6 +63,7 @@ util-obj-y +=3D qapi/qapi-events-tpm.o
 util-obj-y +=3D qapi/qapi-events-trace.o
 util-obj-y +=3D qapi/qapi-events-transaction.o
 util-obj-y +=3D qapi/qapi-events-ui.o
+util-obj-y +=3D qapi/qapi-visit-fsdev.o
 util-obj-y +=3D qapi/qapi-introspect.o

 chardev-obj-y =3D chardev/
@@ -142,6 +148,7 @@ common-obj-y +=3D qapi/qapi-commands-block-core.o
 common-obj-y +=3D qapi/qapi-commands-block.o
 common-obj-y +=3D qapi/qapi-commands-char.o
 common-obj-y +=3D qapi/qapi-commands-common.o
+common-obj-y +=3D qapi/qapi-commands-tlimits.o
 common-obj-y +=3D qapi/qapi-commands-crypto.o
 common-obj-y +=3D qapi/qapi-commands-introspect.o
 common-obj-y +=3D qapi/qapi-commands-job.o
@@ -155,6 +162,7 @@ common-obj-y +=3D qapi/qapi-commands-tpm.o
 common-obj-y +=3D qapi/qapi-commands-trace.o
 common-obj-y +=3D qapi/qapi-commands-transaction.o
 common-obj-y +=3D qapi/qapi-commands-ui.o
+common-obj-y +=3D qapi/qapi-commands-fsdev.o
 common-obj-y +=3D qapi/qapi-introspect.o
 common-obj-y +=3D qmp.o hmp.o
 endif
diff --git a/block/throttle.c b/block/throttle.c
index 636c976..bd23c58 100644
--- a/block/throttle.c
+++ b/block/throttle.c
@@ -41,7 +41,7 @@ static QemuOptsList throttle_opts =3D {
  * @group and must be freed by the caller.
  * If there's an error then @group remains unmodified.
  */
-static int throttle_parse_options(QDict *options, char **group, Error **er=
rp)
+static int throttle_parse_group(QDict *options, char **group, Error **errp=
)
 {
     int ret;
     const char *group_name;
@@ -90,7 +90,7 @@ static int throttle_open(BlockDriverState *bs, QDict *opt=
ions,
     bs->supported_zero_flags =3D bs->file->bs->supported_zero_flags |
                                BDRV_REQ_WRITE_UNCHANGED;

-    ret =3D throttle_parse_options(options, &group, errp);
+    ret =3D throttle_parse_group(options, &group, errp);
     if (ret =3D=3D 0) {
         /* Register membership to group with name group_name */
         throttle_group_register_tgm(tgm, group, bdrv_get_aio_context(bs));
@@ -179,7 +179,7 @@ static int throttle_reopen_prepare(BDRVReopenState *reo=
pen_state,
     assert(reopen_state !=3D NULL);
     assert(reopen_state->bs !=3D NULL);

-    ret =3D throttle_parse_options(reopen_state->options, &group, errp);
+    ret =3D throttle_parse_group(reopen_state->options, &group, errp);
     reopen_state->opaque =3D group;
     return ret;
 }
diff --git a/blockdev.c b/blockdev.c
index e5b5eb4..5c7a236 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -400,48 +400,7 @@ static void extract_common_blockdev_options(QemuOpts *=
opts, int *bdrv_flags,
     }

     if (throttle_cfg) {
-        throttle_config_init(throttle_cfg);
-        throttle_cfg->buckets[THROTTLE_BPS_TOTAL].avg =3D
-            qemu_opt_get_number(opts, "throttling.bps-total", 0);
-        throttle_cfg->buckets[THROTTLE_BPS_READ].avg  =3D
-            qemu_opt_get_number(opts, "throttling.bps-read", 0);
-        throttle_cfg->buckets[THROTTLE_BPS_WRITE].avg =3D
-            qemu_opt_get_number(opts, "throttling.bps-write", 0);
-        throttle_cfg->buckets[THROTTLE_OPS_TOTAL].avg =3D
-            qemu_opt_get_number(opts, "throttling.iops-total", 0);
-        throttle_cfg->buckets[THROTTLE_OPS_READ].avg =3D
-            qemu_opt_get_number(opts, "throttling.iops-read", 0);
-        throttle_cfg->buckets[THROTTLE_OPS_WRITE].avg =3D
-            qemu_opt_get_number(opts, "throttling.iops-write", 0);
-
-        throttle_cfg->buckets[THROTTLE_BPS_TOTAL].max =3D
-            qemu_opt_get_number(opts, "throttling.bps-total-max", 0);
-        throttle_cfg->buckets[THROTTLE_BPS_READ].max  =3D
-            qemu_opt_get_number(opts, "throttling.bps-read-max", 0);
-        throttle_cfg->buckets[THROTTLE_BPS_WRITE].max =3D
-            qemu_opt_get_number(opts, "throttling.bps-write-max", 0);
-        throttle_cfg->buckets[THROTTLE_OPS_TOTAL].max =3D
-            qemu_opt_get_number(opts, "throttling.iops-total-max", 0);
-        throttle_cfg->buckets[THROTTLE_OPS_READ].max =3D
-            qemu_opt_get_number(opts, "throttling.iops-read-max", 0);
-        throttle_cfg->buckets[THROTTLE_OPS_WRITE].max =3D
-            qemu_opt_get_number(opts, "throttling.iops-write-max", 0);
-
-        throttle_cfg->buckets[THROTTLE_BPS_TOTAL].burst_length =3D
-            qemu_opt_get_number(opts, "throttling.bps-total-max-length", 1=
);
-        throttle_cfg->buckets[THROTTLE_BPS_READ].burst_length  =3D
-            qemu_opt_get_number(opts, "throttling.bps-read-max-length", 1)=
;
-        throttle_cfg->buckets[THROTTLE_BPS_WRITE].burst_length =3D
-            qemu_opt_get_number(opts, "throttling.bps-write-max-length", 1=
);
-        throttle_cfg->buckets[THROTTLE_OPS_TOTAL].burst_length =3D
-            qemu_opt_get_number(opts, "throttling.iops-total-max-length", =
1);
-        throttle_cfg->buckets[THROTTLE_OPS_READ].burst_length =3D
-            qemu_opt_get_number(opts, "throttling.iops-read-max-length", 1=
);
-        throttle_cfg->buckets[THROTTLE_OPS_WRITE].burst_length =3D
-            qemu_opt_get_number(opts, "throttling.iops-write-max-length", =
1);
-
-        throttle_cfg->op_size =3D
-            qemu_opt_get_number(opts, "throttling.iops-size", 0);
+        throttle_parse_options(throttle_cfg, opts);

         if (!throttle_is_valid(throttle_cfg, errp)) {
             return;
@@ -2725,6 +2684,7 @@ void qmp_block_set_io_throttle(BlockIOThrottle *arg, =
Error **errp)
     BlockDriverState *bs;
     BlockBackend *blk;
     AioContext *aio_context;
+    ThrottleLimits *tlimits;

     blk =3D qmp_get_blk(arg->has_device ? arg->device : NULL,
                       arg->has_id ? arg->id : NULL,
@@ -2742,56 +2702,8 @@ void qmp_block_set_io_throttle(BlockIOThrottle *arg,=
 Error **errp)
         goto out;
     }

-    throttle_config_init(&cfg);
-    cfg.buckets[THROTTLE_BPS_TOTAL].avg =3D arg->bps;
-    cfg.buckets[THROTTLE_BPS_READ].avg  =3D arg->bps_rd;
-    cfg.buckets[THROTTLE_BPS_WRITE].avg =3D arg->bps_wr;
-
-    cfg.buckets[THROTTLE_OPS_TOTAL].avg =3D arg->iops;
-    cfg.buckets[THROTTLE_OPS_READ].avg  =3D arg->iops_rd;
-    cfg.buckets[THROTTLE_OPS_WRITE].avg =3D arg->iops_wr;
-
-    if (arg->has_bps_max) {
-        cfg.buckets[THROTTLE_BPS_TOTAL].max =3D arg->bps_max;
-    }
-    if (arg->has_bps_rd_max) {
-        cfg.buckets[THROTTLE_BPS_READ].max =3D arg->bps_rd_max;
-    }
-    if (arg->has_bps_wr_max) {
-        cfg.buckets[THROTTLE_BPS_WRITE].max =3D arg->bps_wr_max;
-    }
-    if (arg->has_iops_max) {
-        cfg.buckets[THROTTLE_OPS_TOTAL].max =3D arg->iops_max;
-    }
-    if (arg->has_iops_rd_max) {
-        cfg.buckets[THROTTLE_OPS_READ].max =3D arg->iops_rd_max;
-    }
-    if (arg->has_iops_wr_max) {
-        cfg.buckets[THROTTLE_OPS_WRITE].max =3D arg->iops_wr_max;
-    }
-
-    if (arg->has_bps_max_length) {
-        cfg.buckets[THROTTLE_BPS_TOTAL].burst_length =3D arg->bps_max_leng=
th;
-    }
-    if (arg->has_bps_rd_max_length) {
-        cfg.buckets[THROTTLE_BPS_READ].burst_length =3D arg->bps_rd_max_le=
ngth;
-    }
-    if (arg->has_bps_wr_max_length) {
-        cfg.buckets[THROTTLE_BPS_WRITE].burst_length =3D arg->bps_wr_max_l=
ength;
-    }
-    if (arg->has_iops_max_length) {
-        cfg.buckets[THROTTLE_OPS_TOTAL].burst_length =3D arg->iops_max_len=
gth;
-    }
-    if (arg->has_iops_rd_max_length) {
-        cfg.buckets[THROTTLE_OPS_READ].burst_length =3D arg->iops_rd_max_l=
ength;
-    }
-    if (arg->has_iops_wr_max_length) {
-        cfg.buckets[THROTTLE_OPS_WRITE].burst_length =3D arg->iops_wr_max_=
length;
-    }
-
-    if (arg->has_iops_size) {
-        cfg.op_size =3D arg->iops_size;
-    }
+    tlimits =3D qapi_BlockIOThrottle_base(arg);
+    throttle_limits_to_config(tlimits, &cfg, errp);

     if (!throttle_is_valid(&cfg, errp)) {
         goto out;
diff --git a/include/qemu/throttle-options.h b/include/qemu/throttle-option=
s.h
index 3528a8f..3eb1825 100644
--- a/include/qemu/throttle-options.h
+++ b/include/qemu/throttle-options.h
@@ -9,6 +9,7 @@
  */
 #ifndef THROTTLE_OPTIONS_H
 #define THROTTLE_OPTIONS_H
+#include "typedefs.h"

 #define QEMU_OPT_IOPS_TOTAL "iops-total"
 #define QEMU_OPT_IOPS_TOTAL_MAX "iops-total-max"
@@ -110,5 +111,5 @@
             .type =3D QEMU_OPT_NUMBER,\
             .help =3D "when limiting by iops max size of an I/O in bytes",=
\
         }
-
+    void throttle_parse_options(ThrottleConfig *, QemuOpts *);
 #endif
diff --git a/include/qemu/throttle.h b/include/qemu/throttle.h
index abeb886..f379d91 100644
--- a/include/qemu/throttle.h
+++ b/include/qemu/throttle.h
@@ -90,10 +90,10 @@ typedef struct LeakyBucket {
  * However it allows to keep the code clean and the bucket field is reset =
to
  * zero at the right time.
  */
-typedef struct ThrottleConfig {
+struct ThrottleConfig {
     LeakyBucket buckets[BUCKETS_COUNT]; /* leaky buckets */
     uint64_t op_size;         /* size of an operation in bytes */
-} ThrottleConfig;
+};

 typedef struct ThrottleState {
     ThrottleConfig cfg;       /* configuration */
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 3ec0e13..1d335aa 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -113,6 +113,7 @@ typedef struct uWireSlave uWireSlave;
 typedef struct VirtIODevice VirtIODevice;
 typedef struct Visitor Visitor;
 typedef struct node_info NodeInfo;
+typedef struct ThrottleConfig ThrottleConfig;
 typedef void SaveStateHandler(QEMUFile *f, void *opaque);
 typedef int LoadStateHandler(QEMUFile *f, void *opaque, int version_id);

diff --git a/qapi/block-core.json b/qapi/block-core.json
index d4fe710..05296b0 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -8,6 +8,7 @@
 { 'include': 'crypto.json' }
 { 'include': 'job.json' }
 { 'include': 'sockets.json' }
+{ 'include': 'tlimits.json' }

 ##
 # @SnapshotInfo:
@@ -2155,130 +2156,13 @@
 #
 # @id: The name or QOM path of the guest device (since: 2.8)
 #
-# @bps: total throughput limit in bytes per second
-#
-# @bps_rd: read throughput limit in bytes per second
-#
-# @bps_wr: write throughput limit in bytes per second
-#
-# @iops: total I/O operations per second
-#
-# @iops_rd: read I/O operations per second
-#
-# @iops_wr: write I/O operations per second
-#
-# @bps_max: total throughput limit during bursts,
-#                     in bytes (Since 1.7)
-#
-# @bps_rd_max: read throughput limit during bursts,
-#                        in bytes (Since 1.7)
-#
-# @bps_wr_max: write throughput limit during bursts,
-#                        in bytes (Since 1.7)
-#
-# @iops_max: total I/O operations per second during bursts,
-#                      in bytes (Since 1.7)
-#
-# @iops_rd_max: read I/O operations per second during bursts,
-#                         in bytes (Since 1.7)
-#
-# @iops_wr_max: write I/O operations per second during bursts,
-#                         in bytes (Since 1.7)
-#
-# @bps_max_length: maximum length of the @bps_max burst
-#                            period, in seconds. It must only
-#                            be set if @bps_max is set as well.
-#                            Defaults to 1. (Since 2.6)
-#
-# @bps_rd_max_length: maximum length of the @bps_rd_max
-#                               burst period, in seconds. It must only
-#                               be set if @bps_rd_max is set as well.
-#                               Defaults to 1. (Since 2.6)
-#
-# @bps_wr_max_length: maximum length of the @bps_wr_max
-#                               burst period, in seconds. It must only
-#                               be set if @bps_wr_max is set as well.
-#                               Defaults to 1. (Since 2.6)
-#
-# @iops_max_length: maximum length of the @iops burst
-#                             period, in seconds. It must only
-#                             be set if @iops_max is set as well.
-#                             Defaults to 1. (Since 2.6)
-#
-# @iops_rd_max_length: maximum length of the @iops_rd_max
-#                                burst period, in seconds. It must only
-#                                be set if @iops_rd_max is set as well.
-#                                Defaults to 1. (Since 2.6)
-#
-# @iops_wr_max_length: maximum length of the @iops_wr_max
-#                                burst period, in seconds. It must only
-#                                be set if @iops_wr_max is set as well.
-#                                Defaults to 1. (Since 2.6)
-#
-# @iops_size: an I/O size in bytes (Since 1.7)
-#
 # @group: throttle group name (Since 2.4)
 #
 # Since: 1.1
 ##
 { 'struct': 'BlockIOThrottle',
-  'data': { '*device': 'str', '*id': 'str', 'bps': 'int', 'bps_rd': 'int',
-            'bps_wr': 'int', 'iops': 'int', 'iops_rd': 'int', 'iops_wr': '=
int',
-            '*bps_max': 'int', '*bps_rd_max': 'int',
-            '*bps_wr_max': 'int', '*iops_max': 'int',
-            '*iops_rd_max': 'int', '*iops_wr_max': 'int',
-            '*bps_max_length': 'int', '*bps_rd_max_length': 'int',
-            '*bps_wr_max_length': 'int', '*iops_max_length': 'int',
-            '*iops_rd_max_length': 'int', '*iops_wr_max_length': 'int',
-            '*iops_size': 'int', '*group': 'str' } }
-
-##
-# @ThrottleLimits:
-#
-# Limit parameters for throttling.
-# Since some limit combinations are illegal, limits should always be set i=
n one
-# transaction. All fields are optional. When setting limits, if a field is
-# missing the current value is not changed.
-#
-# @iops-total:             limit total I/O operations per second
-# @iops-total-max:         I/O operations burst
-# @iops-total-max-length:  length of the iops-total-max burst period, in s=
econds
-#                          It must only be set if @iops-total-max is set a=
s well.
-# @iops-read:              limit read operations per second
-# @iops-read-max:          I/O operations read burst
-# @iops-read-max-length:   length of the iops-read-max burst period, in se=
conds
-#                          It must only be set if @iops-read-max is set as=
 well.
-# @iops-write:             limit write operations per second
-# @iops-write-max:         I/O operations write burst
-# @iops-write-max-length:  length of the iops-write-max burst period, in s=
econds
-#                          It must only be set if @iops-write-max is set a=
s well.
-# @bps-total:              limit total bytes per second
-# @bps-total-max:          total bytes burst
-# @bps-total-max-length:   length of the bps-total-max burst period, in se=
conds.
-#                          It must only be set if @bps-total-max is set as=
 well.
-# @bps-read:               limit read bytes per second
-# @bps-read-max:           total bytes read burst
-# @bps-read-max-length:    length of the bps-read-max burst period, in sec=
onds
-#                          It must only be set if @bps-read-max is set as =
well.
-# @bps-write:              limit write bytes per second
-# @bps-write-max:          total bytes write burst
-# @bps-write-max-length:   length of the bps-write-max burst period, in se=
conds
-#                          It must only be set if @bps-write-max is set as=
 well.
-# @iops-size:              when limiting by iops max size of an I/O in byt=
es
-#
-# Since: 2.11
-##
-{ 'struct': 'ThrottleLimits',
-  'data': { '*iops-total' : 'int', '*iops-total-max' : 'int',
-            '*iops-total-max-length' : 'int', '*iops-read' : 'int',
-            '*iops-read-max' : 'int', '*iops-read-max-length' : 'int',
-            '*iops-write' : 'int', '*iops-write-max' : 'int',
-            '*iops-write-max-length' : 'int', '*bps-total' : 'int',
-            '*bps-total-max' : 'int', '*bps-total-max-length' : 'int',
-            '*bps-read' : 'int', '*bps-read-max' : 'int',
-            '*bps-read-max-length' : 'int', '*bps-write' : 'int',
-            '*bps-write-max' : 'int', '*bps-write-max-length' : 'int',
-            '*iops-size' : 'int' } }
+  'base': 'ThrottleLimits',
+  'data': { '*device': 'str', '*id': 'str', '*group': 'str' } }

 ##
 # @block-stream:
diff --git a/qapi/fsdev.json b/qapi/fsdev.json
new file mode 100644
index 0000000..c5559bb
--- /dev/null
+++ b/qapi/fsdev.json
@@ -0,0 +1,20 @@
+# -*- Mode: Python -*-
+
+##
+# =3D=3D QAPI fsdev definitions
+##
+
+{ 'include': 'tlimits.json' }
+
+##
+# @FsdevIOThrottle:
+#
+# A set of parameters describing fsdev throttling.
+#
+# @id: device id
+#
+# Since: 3.2
+##
+{ 'struct': 'FsdevIOThrottle',
+  'base': 'ThrottleLimits',
+  'data': { '*id': 'str' } }
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index 65b6dc2..f653e7d 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -94,3 +94,4 @@
 { 'include': 'trace.json' }
 { 'include': 'introspect.json' }
 { 'include': 'misc.json' }
+{ 'include': 'fsdev.json' }
diff --git a/qapi/tlimits.json b/qapi/tlimits.json
new file mode 100644
index 0000000..1916726
--- /dev/null
+++ b/qapi/tlimits.json
@@ -0,0 +1,89 @@
+# -*- Mode: Python -*-
+
+##
+# =3D=3D Throttle limits
+##
+
+##
+# @ThrottleLimits:
+#
+# Limit parameters for throttling.
+# Since some limit combinations are illegal, limits should always be set i=
n one
+# transaction. All fields are optional. When setting limits, if a field is
+# missing the current value is not changed.
+#
+# @bps: total throughput limit in bytes per second
+#
+# @bps_rd: read throughput limit in bytes per second
+#
+# @bps_wr: write throughput limit in bytes per second
+#
+# @iops: total I/O operations per second
+#
+# @iops_rd: read I/O operations per second
+#
+# @iops_wr: write I/O operations per second
+#
+# @bps_max: total throughput limit during bursts,
+#                     in bytes (Since 1.7)
+#
+# @bps_rd_max: read throughput limit during bursts,
+#                        in bytes (Since 1.7)
+#
+# @bps_wr_max: write throughput limit during bursts,
+#                        in bytes (Since 1.7)
+#
+# @iops_max: total I/O operations per second during bursts,
+#                      in bytes (Since 1.7)
+#
+# @iops_rd_max: read I/O operations per second during bursts,
+#                         in bytes (Since 1.7)
+#
+# @iops_wr_max: write I/O operations per second during bursts,
+#                         in bytes (Since 1.7)
+#
+# @bps_max_length: maximum length of the @bps_max burst
+#                            period, in seconds. It must only
+#                            be set if @bps_max is set as well.
+#                            Defaults to 1. (Since 2.6)
+#
+# @bps_rd_max_length: maximum length of the @bps_rd_max
+#                               burst period, in seconds. It must only
+#                               be set if @bps_rd_max is set as well.
+#                               Defaults to 1. (Since 2.6)
+#
+# @bps_wr_max_length: maximum length of the @bps_wr_max
+#                               burst period, in seconds. It must only
+#                               be set if @bps_wr_max is set as well.
+#                               Defaults to 1. (Since 2.6)
+#
+# @iops_max_length: maximum length of the @iops burst
+#                             period, in seconds. It must only
+#                             be set if @iops_max is set as well.
+#                             Defaults to 1. (Since 2.6)
+#
+# @iops_rd_max_length: maximum length of the @iops_rd_max
+#                                burst period, in seconds. It must only
+#                                be set if @iops_rd_max is set as well.
+#                                Defaults to 1. (Since 2.6)
+#
+# @iops_wr_max_length: maximum length of the @iops_wr_max
+#                                burst period, in seconds. It must only
+#                                be set if @iops_wr_max is set as well.
+#                                Defaults to 1. (Since 2.6)
+#
+# @iops_size: an I/O size in bytes (Since 1.7)
+#
+# Since: 3.2
+#
+##
+{ 'struct': 'ThrottleLimits',
+  'data': { '*bps': 'int', '*bps_rd': 'int',
+            '*bps_wr': 'int', '*iops': 'int', '*iops_rd': 'int', '*iops_wr=
': 'int',
+            '*bps_max': 'int', '*bps_rd_max': 'int',
+            '*bps_wr_max': 'int', '*iops_max': 'int',
+            '*iops_rd_max': 'int', '*iops_wr_max': 'int',
+            '*bps_max_length': 'int', '*bps_rd_max_length': 'int',
+            '*bps_wr_max_length': 'int', '*iops_max_length': 'int',
+            '*iops_rd_max_length': 'int', '*iops_wr_max_length': 'int',
+            '*iops_size': 'int' } }
diff --git a/util/throttle.c b/util/throttle.c
index b38e742..cea30f5 100644
--- a/util/throttle.c
+++ b/util/throttle.c
@@ -27,6 +27,8 @@
 #include "qemu/throttle.h"
 #include "qemu/timer.h"
 #include "block/aio.h"
+#include "qemu/option.h"
+#include "qemu/throttle-options.h"

 /* This function make a bucket leak
  *
@@ -494,92 +496,92 @@ void throttle_account(ThrottleState *ts, bool is_writ=
e, uint64_t size)
 void throttle_limits_to_config(ThrottleLimits *arg, ThrottleConfig *cfg,
                                Error **errp)
 {
-    if (arg->has_bps_total) {
-        cfg->buckets[THROTTLE_BPS_TOTAL].avg =3D arg->bps_total;
+    if (arg->has_bps) {
+        cfg->buckets[THROTTLE_BPS_TOTAL].avg =3D arg->bps;
     }
-    if (arg->has_bps_read) {
-        cfg->buckets[THROTTLE_BPS_READ].avg  =3D arg->bps_read;
+    if (arg->has_bps_rd) {
+        cfg->buckets[THROTTLE_BPS_READ].avg  =3D arg->bps_rd;
     }
-    if (arg->has_bps_write) {
-        cfg->buckets[THROTTLE_BPS_WRITE].avg =3D arg->bps_write;
+    if (arg->has_bps_wr) {
+        cfg->buckets[THROTTLE_BPS_WRITE].avg =3D arg->bps_wr;
     }

-    if (arg->has_iops_total) {
-        cfg->buckets[THROTTLE_OPS_TOTAL].avg =3D arg->iops_total;
+    if (arg->has_iops) {
+        cfg->buckets[THROTTLE_OPS_TOTAL].avg =3D arg->iops;
     }
-    if (arg->has_iops_read) {
-        cfg->buckets[THROTTLE_OPS_READ].avg  =3D arg->iops_read;
+    if (arg->has_iops_rd) {
+        cfg->buckets[THROTTLE_OPS_READ].avg  =3D arg->iops_rd;
     }
-    if (arg->has_iops_write) {
-        cfg->buckets[THROTTLE_OPS_WRITE].avg =3D arg->iops_write;
+    if (arg->has_iops_wr) {
+        cfg->buckets[THROTTLE_OPS_WRITE].avg =3D arg->iops_wr;
     }

-    if (arg->has_bps_total_max) {
-        cfg->buckets[THROTTLE_BPS_TOTAL].max =3D arg->bps_total_max;
+    if (arg->has_bps_max) {
+        cfg->buckets[THROTTLE_BPS_TOTAL].max =3D arg->bps_max;
     }
-    if (arg->has_bps_read_max) {
-        cfg->buckets[THROTTLE_BPS_READ].max =3D arg->bps_read_max;
+    if (arg->has_bps_rd_max) {
+        cfg->buckets[THROTTLE_BPS_READ].max =3D arg->bps_rd_max;
     }
-    if (arg->has_bps_write_max) {
-        cfg->buckets[THROTTLE_BPS_WRITE].max =3D arg->bps_write_max;
+    if (arg->has_bps_wr_max) {
+        cfg->buckets[THROTTLE_BPS_WRITE].max =3D arg->bps_wr_max;
     }
-    if (arg->has_iops_total_max) {
-        cfg->buckets[THROTTLE_OPS_TOTAL].max =3D arg->iops_total_max;
+    if (arg->has_iops_max) {
+        cfg->buckets[THROTTLE_OPS_TOTAL].max =3D arg->iops_max;
     }
-    if (arg->has_iops_read_max) {
-        cfg->buckets[THROTTLE_OPS_READ].max =3D arg->iops_read_max;
+    if (arg->has_iops_rd_max) {
+        cfg->buckets[THROTTLE_OPS_READ].max =3D arg->iops_rd_max;
     }
-    if (arg->has_iops_write_max) {
-        cfg->buckets[THROTTLE_OPS_WRITE].max =3D arg->iops_write_max;
+    if (arg->has_iops_wr_max) {
+        cfg->buckets[THROTTLE_OPS_WRITE].max =3D arg->iops_wr_max;
     }

-    if (arg->has_bps_total_max_length) {
-        if (arg->bps_total_max_length > UINT_MAX) {
+    if (arg->has_bps_max_length) {
+        if (arg->bps_max_length > UINT_MAX) {
             error_setg(errp, "bps-total-max-length value must be in"
                              " the range [0, %u]", UINT_MAX);
             return;
         }
-        cfg->buckets[THROTTLE_BPS_TOTAL].burst_length =3D arg->bps_total_m=
ax_length;
+        cfg->buckets[THROTTLE_BPS_TOTAL].burst_length =3D arg->bps_max_len=
gth;
     }
-    if (arg->has_bps_read_max_length) {
-        if (arg->bps_read_max_length > UINT_MAX) {
+    if (arg->has_bps_rd_max_length) {
+        if (arg->bps_rd_max_length > UINT_MAX) {
             error_setg(errp, "bps-read-max-length value must be in"
                              " the range [0, %u]", UINT_MAX);
             return;
         }
-        cfg->buckets[THROTTLE_BPS_READ].burst_length =3D arg->bps_read_max=
_length;
+        cfg->buckets[THROTTLE_BPS_READ].burst_length =3D arg->bps_rd_max_l=
ength;
     }
-    if (arg->has_bps_write_max_length) {
-        if (arg->bps_write_max_length > UINT_MAX) {
+    if (arg->has_bps_wr_max_length) {
+        if (arg->bps_wr_max_length > UINT_MAX) {
             error_setg(errp, "bps-write-max-length value must be in"
                              " the range [0, %u]", UINT_MAX);
             return;
         }
-        cfg->buckets[THROTTLE_BPS_WRITE].burst_length =3D arg->bps_write_m=
ax_length;
+        cfg->buckets[THROTTLE_BPS_WRITE].burst_length =3D arg->bps_wr_max_=
length;
     }
-    if (arg->has_iops_total_max_length) {
-        if (arg->iops_total_max_length > UINT_MAX) {
+    if (arg->has_iops_max_length) {
+        if (arg->iops_max_length > UINT_MAX) {
             error_setg(errp, "iops-total-max-length value must be in"
                              " the range [0, %u]", UINT_MAX);
             return;
         }
-        cfg->buckets[THROTTLE_OPS_TOTAL].burst_length =3D arg->iops_total_=
max_length;
+        cfg->buckets[THROTTLE_OPS_TOTAL].burst_length =3D arg->iops_max_le=
ngth;
     }
-    if (arg->has_iops_read_max_length) {
-        if (arg->iops_read_max_length > UINT_MAX) {
+    if (arg->has_iops_rd_max_length) {
+        if (arg->iops_rd_max_length > UINT_MAX) {
             error_setg(errp, "iops-read-max-length value must be in"
                              " the range [0, %u]", UINT_MAX);
             return;
         }
-        cfg->buckets[THROTTLE_OPS_READ].burst_length =3D arg->iops_read_ma=
x_length;
+        cfg->buckets[THROTTLE_OPS_READ].burst_length =3D arg->iops_rd_max_=
length;
     }
-    if (arg->has_iops_write_max_length) {
-        if (arg->iops_write_max_length > UINT_MAX) {
+    if (arg->has_iops_wr_max_length) {
+        if (arg->iops_wr_max_length > UINT_MAX) {
             error_setg(errp, "iops-write-max-length value must be in"
                              " the range [0, %u]", UINT_MAX);
             return;
         }
-        cfg->buckets[THROTTLE_OPS_WRITE].burst_length =3D arg->iops_write_=
max_length;
+        cfg->buckets[THROTTLE_OPS_WRITE].burst_length =3D arg->iops_wr_max=
_length;
     }

     if (arg->has_iops_size) {
@@ -596,43 +598,109 @@ void throttle_limits_to_config(ThrottleLimits *arg, =
ThrottleConfig *cfg,
  */
 void throttle_config_to_limits(ThrottleConfig *cfg, ThrottleLimits *var)
 {
-    var->bps_total               =3D cfg->buckets[THROTTLE_BPS_TOTAL].avg;
-    var->bps_read                =3D cfg->buckets[THROTTLE_BPS_READ].avg;
-    var->bps_write               =3D cfg->buckets[THROTTLE_BPS_WRITE].avg;
-    var->iops_total              =3D cfg->buckets[THROTTLE_OPS_TOTAL].avg;
-    var->iops_read               =3D cfg->buckets[THROTTLE_OPS_READ].avg;
-    var->iops_write              =3D cfg->buckets[THROTTLE_OPS_WRITE].avg;
-    var->bps_total_max           =3D cfg->buckets[THROTTLE_BPS_TOTAL].max;
-    var->bps_read_max            =3D cfg->buckets[THROTTLE_BPS_READ].max;
-    var->bps_write_max           =3D cfg->buckets[THROTTLE_BPS_WRITE].max;
-    var->iops_total_max          =3D cfg->buckets[THROTTLE_OPS_TOTAL].max;
-    var->iops_read_max           =3D cfg->buckets[THROTTLE_OPS_READ].max;
-    var->iops_write_max          =3D cfg->buckets[THROTTLE_OPS_WRITE].max;
-    var->bps_total_max_length    =3D cfg->buckets[THROTTLE_BPS_TOTAL].burs=
t_length;
-    var->bps_read_max_length     =3D cfg->buckets[THROTTLE_BPS_READ].burst=
_length;
-    var->bps_write_max_length    =3D cfg->buckets[THROTTLE_BPS_WRITE].burs=
t_length;
-    var->iops_total_max_length   =3D cfg->buckets[THROTTLE_OPS_TOTAL].burs=
t_length;
-    var->iops_read_max_length    =3D cfg->buckets[THROTTLE_OPS_READ].burst=
_length;
-    var->iops_write_max_length   =3D cfg->buckets[THROTTLE_OPS_WRITE].burs=
t_length;
+    var->bps               =3D cfg->buckets[THROTTLE_BPS_TOTAL].avg;
+    var->bps_rd                =3D cfg->buckets[THROTTLE_BPS_READ].avg;
+    var->bps_wr               =3D cfg->buckets[THROTTLE_BPS_WRITE].avg;
+    var->iops              =3D cfg->buckets[THROTTLE_OPS_TOTAL].avg;
+    var->iops_rd               =3D cfg->buckets[THROTTLE_OPS_READ].avg;
+    var->iops_wr              =3D cfg->buckets[THROTTLE_OPS_WRITE].avg;
+    var->bps_max           =3D cfg->buckets[THROTTLE_BPS_TOTAL].max;
+    var->bps_rd_max            =3D cfg->buckets[THROTTLE_BPS_READ].max;
+    var->bps_wr_max           =3D cfg->buckets[THROTTLE_BPS_WRITE].max;
+    var->iops_max          =3D cfg->buckets[THROTTLE_OPS_TOTAL].max;
+    var->iops_rd_max           =3D cfg->buckets[THROTTLE_OPS_READ].max;
+    var->iops_wr_max          =3D cfg->buckets[THROTTLE_OPS_WRITE].max;
+    var->bps_max_length    =3D cfg->buckets[THROTTLE_BPS_TOTAL].burst_leng=
th;
+    var->bps_rd_max_length     =3D cfg->buckets[THROTTLE_BPS_READ].burst_l=
ength;
+    var->bps_wr_max_length    =3D cfg->buckets[THROTTLE_BPS_WRITE].burst_l=
ength;
+    var->iops_max_length   =3D cfg->buckets[THROTTLE_OPS_TOTAL].burst_leng=
th;
+    var->iops_rd_max_length    =3D cfg->buckets[THROTTLE_OPS_READ].burst_l=
ength;
+    var->iops_wr_max_length   =3D cfg->buckets[THROTTLE_OPS_WRITE].burst_l=
ength;
     var->iops_size               =3D cfg->op_size;

-    var->has_bps_total =3D true;
-    var->has_bps_read =3D true;
-    var->has_bps_write =3D true;
-    var->has_iops_total =3D true;
-    var->has_iops_read =3D true;
-    var->has_iops_write =3D true;
-    var->has_bps_total_max =3D true;
-    var->has_bps_read_max =3D true;
-    var->has_bps_write_max =3D true;
-    var->has_iops_total_max =3D true;
-    var->has_iops_read_max =3D true;
-    var->has_iops_write_max =3D true;
-    var->has_bps_read_max_length =3D true;
-    var->has_bps_total_max_length =3D true;
-    var->has_bps_write_max_length =3D true;
-    var->has_iops_total_max_length =3D true;
-    var->has_iops_read_max_length =3D true;
-    var->has_iops_write_max_length =3D true;
+    var->has_bps =3D true;
+    var->has_bps_rd =3D true;
+    var->has_bps_wr =3D true;
+    var->has_iops =3D true;
+    var->has_iops_rd =3D true;
+    var->has_iops_wr =3D true;
+    var->has_bps_max =3D true;
+    var->has_bps_rd_max =3D true;
+    var->has_bps_wr_max =3D true;
+    var->has_iops_max =3D true;
+    var->has_iops_rd_max =3D true;
+    var->has_iops_wr_max =3D true;
+    var->has_bps_rd_max_length =3D true;
+    var->has_bps_max_length =3D true;
+    var->has_bps_wr_max_length =3D true;
+    var->has_iops_max_length =3D true;
+    var->has_iops_rd_max_length =3D true;
+    var->has_iops_wr_max_length =3D true;
     var->has_iops_size =3D true;
 }
+
+/* parse the throttle options
+ *
+ * @opts: qemu options
+ * @throttle_cfg: throttle configuration
+ */
+void throttle_parse_options(ThrottleConfig *throttle_cfg, QemuOpts *opts)
+{
+    throttle_config_init(throttle_cfg);
+    throttle_cfg->buckets[THROTTLE_BPS_TOTAL].avg =3D
+        qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
+                            QEMU_OPT_BPS_TOTAL, 0);
+    throttle_cfg->buckets[THROTTLE_BPS_READ].avg  =3D
+        qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
+                            QEMU_OPT_BPS_READ, 0);
+    throttle_cfg->buckets[THROTTLE_BPS_WRITE].avg =3D
+        qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
+                            QEMU_OPT_BPS_WRITE, 0);
+    throttle_cfg->buckets[THROTTLE_OPS_TOTAL].avg =3D
+        qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
+                            QEMU_OPT_IOPS_TOTAL, 0);
+    throttle_cfg->buckets[THROTTLE_OPS_READ].avg =3D
+        qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
+                            QEMU_OPT_IOPS_READ, 0);
+    throttle_cfg->buckets[THROTTLE_OPS_WRITE].avg =3D
+        qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
+                            QEMU_OPT_IOPS_WRITE, 0);
+    throttle_cfg->buckets[THROTTLE_BPS_TOTAL].max =3D
+        qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
+                            QEMU_OPT_BPS_TOTAL_MAX, 0);
+    throttle_cfg->buckets[THROTTLE_BPS_READ].max  =3D
+        qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
+                            QEMU_OPT_BPS_READ_MAX, 0);
+    throttle_cfg->buckets[THROTTLE_BPS_WRITE].max =3D
+        qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
+                            QEMU_OPT_BPS_WRITE_MAX, 0);
+    throttle_cfg->buckets[THROTTLE_OPS_TOTAL].max =3D
+        qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
+                            QEMU_OPT_IOPS_TOTAL_MAX, 0);
+    throttle_cfg->buckets[THROTTLE_OPS_READ].max =3D
+        qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
+                            QEMU_OPT_IOPS_READ_MAX, 0);
+    throttle_cfg->buckets[THROTTLE_OPS_WRITE].max =3D
+        qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
+                            QEMU_OPT_IOPS_WRITE_MAX, 0);
+    throttle_cfg->buckets[THROTTLE_BPS_TOTAL].burst_length =3D
+        qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
+                            QEMU_OPT_BPS_TOTAL_MAX_LENGTH, 1);
+    throttle_cfg->buckets[THROTTLE_BPS_READ].burst_length  =3D
+        qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
+                            QEMU_OPT_BPS_READ_MAX_LENGTH, 1);
+    throttle_cfg->buckets[THROTTLE_BPS_WRITE].burst_length =3D
+        qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
+                            QEMU_OPT_BPS_WRITE_MAX_LENGTH, 1);
+    throttle_cfg->buckets[THROTTLE_OPS_TOTAL].burst_length =3D
+        qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
+                            QEMU_OPT_IOPS_TOTAL_MAX_LENGTH, 1);
+    throttle_cfg->buckets[THROTTLE_OPS_READ].burst_length =3D
+        qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
+                            QEMU_OPT_IOPS_READ_MAX_LENGTH, 1);
+    throttle_cfg->buckets[THROTTLE_OPS_WRITE].burst_length =3D
+        qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
+                            QEMU_OPT_IOPS_WRITE_MAX_LENGTH, 1);
+    throttle_cfg->op_size =3D
+        qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_SIZE, =
0);
+}
--
1.8.3.1
