Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDB0C4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 17:14:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54C982084D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 17:14:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54C982084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGRA7-0000Zz-JQ
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 13:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52772)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1iGR7s-0007n8-Hx
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 13:12:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1iGR7p-00015r-Ja
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 13:12:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52744)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1iGR7p-00014x-Bg
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 13:12:17 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 22F3C10C0311;
 Fri,  4 Oct 2019 17:12:15 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-117-64.ams2.redhat.com [10.36.117.64])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 260855D9DC;
 Fri,  4 Oct 2019 17:12:08 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, quintela@redhat.com
Subject: [PATCH] migration: Support QLIST migration
Date: Fri,  4 Oct 2019 19:12:04 +0200
Message-Id: <20191004171204.21040-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Fri, 04 Oct 2019 17:12:15 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

94869d5c52 ("migration: migrate QTAILQ") introduced support
for QTAILQ migration. Let's do the same for QLIST.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 include/migration/vmstate.h |  21 ++++++
 include/qemu/queue.h        |  30 ++++++++
 migration/vmstate-types.c   |  60 ++++++++++++++++
 tests/test-vmstate.c        | 133 ++++++++++++++++++++++++++++++++++++
 4 files changed, 244 insertions(+)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 1fbfd099dd..54ec9caeb0 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -224,6 +224,7 @@ extern const VMStateInfo vmstate_info_unused_buffer;
 extern const VMStateInfo vmstate_info_tmp;
 extern const VMStateInfo vmstate_info_bitmap;
 extern const VMStateInfo vmstate_info_qtailq;
+extern const VMStateInfo vmstate_info_qlist;
=20
 #define type_check_2darray(t1,t2,n,m) ((t1(*)[n][m])0 - (t2*)0)
 /*
@@ -754,6 +755,26 @@ extern const VMStateInfo vmstate_info_qtailq;
     .start        =3D offsetof(_type, _next),                           =
   \
 }
=20
+/*
+ * For migrating a QLIST
+ * Target QLIST needs be properly initialized.
+ * _type: type of QLIST element
+ * _next: name of QLIST_ENTRY entry field in QLIST element
+ * _vmsd: VMSD for QLIST element
+ * size: size of QLIST element
+ * start: offset of QLIST_ENTRY in QTAILQ element
+ */
+#define VMSTATE_QLIST_V(_field, _state, _version, _vmsd, _type, _next)  =
\
+{                                                                       =
 \
+    .name         =3D (stringify(_field)),                              =
   \
+    .version_id   =3D (_version),                                       =
   \
+    .vmsd         =3D &(_vmsd),                                         =
   \
+    .size         =3D sizeof(_type),                                    =
   \
+    .info         =3D &vmstate_info_qlist,                              =
   \
+    .offset       =3D offsetof(_state, _field),                         =
   \
+    .start        =3D offsetof(_type, _next),                           =
   \
+}
+
 /* _f : field name
    _f_n : num of elements field_name
    _n : num of elements
diff --git a/include/qemu/queue.h b/include/qemu/queue.h
index 73bf4a984d..e965b4d18d 100644
--- a/include/qemu/queue.h
+++ b/include/qemu/queue.h
@@ -491,4 +491,34 @@ union {                                             =
                    \
         QTAILQ_RAW_TQH_CIRC(head)->tql_prev =3D QTAILQ_RAW_TQE_CIRC(elm,=
 entry);  \
 } while (/*CONSTCOND*/0)
=20
+#define QLIST_RAW_FIRST(head)                                           =
       \
+        field_at_offset(head, 0, void *)
+
+#define QLIST_RAW_NEXT(elm, entry)                                      =
       \
+        field_at_offset(elm, entry, void *)
+
+#define QLIST_RAW_PREVIOUS(elm, entry)                                  =
       \
+        field_at_offset(elm, entry + sizeof(void *), void *)
+
+#define QLIST_RAW_FOREACH(elm, head, entry)                             =
       \
+        for ((elm) =3D *QLIST_RAW_FIRST(head);                          =
         \
+             (elm);                                                     =
       \
+             (elm) =3D *QLIST_RAW_NEXT(elm, entry))
+
+#define QLIST_RAW_INSERT_TAIL(head, elm, entry) do {                    =
       \
+        void *iter, *last =3D NULL;                                     =
         \
+        *QLIST_RAW_NEXT(elm, entry) =3D NULL;                           =
         \
+        if (!*QLIST_RAW_FIRST(head)) {                                  =
       \
+            *QLIST_RAW_FIRST(head) =3D elm;                             =
         \
+            *QLIST_RAW_PREVIOUS(elm, entry) =3D head;                   =
         \
+            break;                                                      =
       \
+        }                                                               =
       \
+        for (iter =3D *QLIST_RAW_FIRST(head);                           =
         \
+             iter; last =3D iter, iter =3D *QLIST_RAW_NEXT(iter, entry))=
           \
+            { }                                                         =
       \
+        *QLIST_RAW_NEXT(last, entry) =3D elm;                           =
         \
+        *QLIST_RAW_PREVIOUS(elm, entry) =3D last;                       =
         \
+} while (0)
+
+
 #endif /* QEMU_SYS_QUEUE_H */
diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
index bee658a1b2..0eedc614f1 100644
--- a/migration/vmstate-types.c
+++ b/migration/vmstate-types.c
@@ -691,3 +691,63 @@ const VMStateInfo vmstate_info_qtailq =3D {
     .get  =3D get_qtailq,
     .put  =3D put_qtailq,
 };
+
+static int put_qlist(QEMUFile *f, void *pv, size_t unused_size,
+                     const VMStateField *field, QJSON *vmdesc)
+{
+    const VMStateDescription *vmsd =3D field->vmsd;
+    /* offset of the QTAILQ entry in a QTAILQ element*/
+    size_t entry_offset =3D field->start;
+    void *elm;
+    int ret;
+
+    QLIST_RAW_FOREACH(elm, pv, entry_offset) {
+        qemu_put_byte(f, true);
+        ret =3D vmstate_save_state(f, vmsd, elm, vmdesc);
+        if (ret) {
+            return ret;
+        }
+    }
+    qemu_put_byte(f, false);
+
+    return 0;
+}
+
+static int get_qlist(QEMUFile *f, void *pv, size_t unused_size,
+                     const VMStateField *field)
+{
+    int ret =3D 0;
+    const VMStateDescription *vmsd =3D field->vmsd;
+    /* size of a QLIST element */
+    size_t size =3D field->size;
+    /* offset of the QLIST entry in a QLIST element */
+    size_t entry_offset =3D field->start;
+    int version_id =3D field->version_id;
+    void *elm;
+
+    if (version_id > vmsd->version_id) {
+        error_report("%s %s",  vmsd->name, "too new");
+        return -EINVAL;
+    }
+    if (version_id < vmsd->minimum_version_id) {
+        error_report("%s %s",  vmsd->name, "too old");
+        return -EINVAL;
+    }
+
+    while (qemu_get_byte(f)) {
+        elm =3D g_malloc(size);
+        ret =3D vmstate_load_state(f, vmsd, elm, version_id);
+        if (ret) {
+            return ret;
+        }
+        QLIST_RAW_INSERT_TAIL(pv, elm, entry_offset);
+    }
+
+    return ret;
+}
+
+const VMStateInfo vmstate_info_qlist =3D {
+    .name =3D "qlist",
+    .get  =3D get_qlist,
+    .put  =3D put_qlist,
+};
diff --git a/tests/test-vmstate.c b/tests/test-vmstate.c
index e80c4c6143..017eab4c8a 100644
--- a/tests/test-vmstate.c
+++ b/tests/test-vmstate.c
@@ -812,6 +812,137 @@ static void test_load_q(void)
     qemu_fclose(fload);
 }
=20
+/* test QLIST Migration */
+
+typedef struct TestQListElement {
+    uint32_t  id;
+    QLIST_ENTRY(TestQListElement) next;
+} TestQListElement;
+
+typedef struct TestQListContainer {
+    uint32_t  id;
+    QLIST_HEAD(, TestQListElement) list;
+} TestQListContainer;
+
+static const VMStateDescription vmstate_qlist_element =3D {
+    .name =3D "test/queue list",
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT32(id, TestQListElement),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_container =3D {
+    .name =3D "test/container/qlist",
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT32(id, TestQListContainer),
+        VMSTATE_QLIST_V(list, TestQListContainer, 1, vmstate_qlist_eleme=
nt,
+                        TestQListElement, next),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static uint8_t qlist_dump[] =3D {
+    0x00, 0x00, 0x00, 0x01, /* container id */
+    0x1, /* start of a */
+    0x00, 0x00, 0x00, 0x0a,
+    0x1, /* start of b */
+    0x00, 0x00, 0x0b, 0x00,
+    0x1, /* start of c */
+    0x00, 0x0c, 0x00, 0x00,
+    0x1, /* start of d */
+    0x0d, 0x00, 0x00, 0x00,
+    0x0, /* end of list */
+    QEMU_VM_EOF, /* just to ensure we won't get EOF reported prematurely=
 */
+};
+
+static TestQListContainer *alloc_container(void)
+{
+    TestQListElement *a =3D g_malloc(sizeof(TestQListElement));
+    TestQListElement *b =3D g_malloc(sizeof(TestQListElement));
+    TestQListElement *c =3D g_malloc(sizeof(TestQListElement));
+    TestQListElement *d =3D g_malloc(sizeof(TestQListElement));
+    TestQListContainer *container =3D g_malloc(sizeof(TestQListContainer=
));
+
+    a->id =3D 0x0a;
+    b->id =3D 0x0b00;
+    c->id =3D 0xc0000;
+    d->id =3D 0xd000000;
+    container->id =3D 1;
+
+    QLIST_INIT(&container->list);
+    QLIST_INSERT_HEAD(&container->list, d, next);
+    QLIST_INSERT_HEAD(&container->list, c, next);
+    QLIST_INSERT_HEAD(&container->list, b, next);
+    QLIST_INSERT_HEAD(&container->list, a, next);
+    return container;
+}
+
+static void free_container(TestQListContainer *container)
+{
+    TestQListElement *iter, *tmp;
+
+    QLIST_FOREACH_SAFE(iter, &container->list, next, tmp) {
+        QLIST_REMOVE(iter, next);
+        g_free(iter);
+    }
+    g_free(container);
+}
+
+static void compare_containers(TestQListContainer *c1, TestQListContaine=
r *c2)
+{
+    TestQListElement *first_item_c1, *first_item_c2;
+
+    while (!QLIST_EMPTY(&c1->list)) {
+        first_item_c1 =3D QLIST_FIRST(&c1->list);
+        first_item_c2 =3D QLIST_FIRST(&c2->list);
+        assert(first_item_c2);
+        assert(first_item_c1->id =3D=3D first_item_c2->id);
+        QLIST_REMOVE(first_item_c1, next);
+        QLIST_REMOVE(first_item_c2, next);
+        g_free(first_item_c1);
+        g_free(first_item_c2);
+    }
+    assert(QLIST_EMPTY(&c2->list));
+}
+
+static void test_save_qlist(void)
+{
+    TestQListContainer *container =3D alloc_container();
+
+    save_vmstate(&vmstate_container, container);
+    compare_vmstate(qlist_dump, sizeof(qlist_dump));
+    free_container(container);
+}
+
+static void test_load_qlist(void)
+{
+    QEMUFile *fsave, *fload;
+    TestQListContainer *orig_container =3D alloc_container();
+    TestQListContainer *dest_container =3D g_malloc0(sizeof(TestQListCon=
tainer));
+    char eof;
+
+    QLIST_INIT(&dest_container->list);
+
+    fsave =3D open_test_file(true);
+    qemu_put_buffer(fsave, qlist_dump, sizeof(qlist_dump));
+    g_assert(!qemu_file_get_error(fsave));
+    qemu_fclose(fsave);
+
+    fload =3D open_test_file(false);
+    vmstate_load_state(fload, &vmstate_container, dest_container, 1);
+    eof =3D qemu_get_byte(fload);
+    g_assert(!qemu_file_get_error(fload));
+    g_assert_cmpint(eof, =3D=3D, QEMU_VM_EOF);
+    compare_containers(orig_container, dest_container);
+    free_container(orig_container);
+    free_container(dest_container);
+}
+
 typedef struct TmpTestStruct {
     TestStruct *parent;
     int64_t diff;
@@ -932,6 +1063,8 @@ int main(int argc, char **argv)
                     test_arr_ptr_prim_0_load);
     g_test_add_func("/vmstate/qtailq/save/saveq", test_save_q);
     g_test_add_func("/vmstate/qtailq/load/loadq", test_load_q);
+    g_test_add_func("/vmstate/qlist/save/saveqlist", test_save_qlist);
+    g_test_add_func("/vmstate/qlist/load/loadqlist", test_load_qlist);
     g_test_add_func("/vmstate/tmp_struct", test_tmp_struct);
     g_test_run();
=20
--=20
2.20.1


