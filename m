Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49A4C35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 13:35:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F46A21741
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 13:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ESsAio+m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F46A21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izKpq-0008E4-Hk
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 08:35:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39745)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <darren.kenny@oracle.com>) id 1izKoq-0006kw-KK
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:34:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <darren.kenny@oracle.com>) id 1izKol-0005sD-Bd
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:34:14 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:38766)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <darren.kenny@oracle.com>)
 id 1izKol-0005n8-0g
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:34:11 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015DO4pf105699;
 Wed, 5 Feb 2020 13:34:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to : content-transfer-encoding; s=corp-2019-08-05;
 bh=D8eIJcASggBxiUBNky+yzM6ZMGXo+jEEw3xCHm52rZk=;
 b=ESsAio+muFv2wvWV/9AN+DsmRRp4fO+tsrzZPZh0U4klVWXViUQk76EOO72z+kcAzAN8
 ysvljmGTom6zyqiX14zcggwwwtIf5vd0jNCSJUQCowljJgmeqKXjHYxP3dBRr4+hWxnY
 /XXuvIikGMEIS5NbYUiY8/+7dJuOdWqY1NJHm2RORhF4R8fFJYQVY99c254R73+R0SnH
 ojBw3I6X8t6LdvKZUtm+g934bgPXxocprAV3nT1yLMQTsuiZYzIXbl0rJyE5c3HCkd+z
 X6c3iTQCvP/2yX32TMhAT9+8uxGDYAb0ud2EDyCiSZr3kGnfBr/aCz3sOuoKed1IgS1O nQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 2xykbp30dv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2020 13:34:08 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015DT7Wg138597;
 Wed, 5 Feb 2020 13:34:08 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3030.oracle.com with ESMTP id 2xymusr8u3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2020 13:34:07 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 015DY7k5013845;
 Wed, 5 Feb 2020 13:34:07 GMT
Received: from starbug-mbp.localdomain (/10.169.111.17)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 05 Feb 2020 05:34:06 -0800
Received: from starbug-mbp (localhost [127.0.0.1])
 by starbug-mbp.localdomain (Postfix) with ESMTP id 0239D57DBD14;
 Wed,  5 Feb 2020 13:34:04 +0000 (GMT)
Date: Wed, 5 Feb 2020 13:34:03 +0000
From: Darren Kenny <darren.kenny@oracle.com>
To: "Bulekov, Alexander" <alxndr@bu.edu>
Subject: Re: [PATCH v8 10/21] libqos: move useful qos-test funcs to
 qos_external
Message-ID: <20200205133403.3dcbvoigtkevl3rb@starbug-mbp>
Mail-Followup-To: "Bulekov, Alexander" <alxndr@bu.edu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
References: <20200129053357.27454-1-alxndr@bu.edu>
 <20200129053357.27454-11-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200129053357.27454-11-alxndr@bu.edu>
User-Agent: NeoMutt/20180716
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002050109
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002050109
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.86
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "bsd@redhat.com" <bsd@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 29, 2020 at 05:34:19AM +0000, Bulekov, Alexander wrote:
>The moved functions are not specific to qos-test and might be useful
>elsewhere. For example the virtual-device fuzzer makes use of them for
>qos-assisted fuzz-targets.
>
>Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
>Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

>---
> tests/qtest/Makefile.include      |   1 +
> tests/qtest/libqos/qos_external.c | 168 ++++++++++++++++++++++++++++++
> tests/qtest/libqos/qos_external.h |  28 +++++
> tests/qtest/qos-test.c            | 132 +----------------------
> 4 files changed, 198 insertions(+), 131 deletions(-)
> create mode 100644 tests/qtest/libqos/qos_external.c
> create mode 100644 tests/qtest/libqos/qos_external.h
>
>diff --git a/tests/qtest/Makefile.include b/tests/qtest/Makefile.include
>index 08a48c1252..bdc93d3866 100644
>--- a/tests/qtest/Makefile.include
>+++ b/tests/qtest/Makefile.include
>@@ -172,6 +172,7 @@ libqos-usb-obj-y =3D $(libqos-spapr-obj-y) $(libqos-=
pc-obj-y) tests/qtest/libqos/u
> # qos devices:
> libqos-obj-y =3D  $(libqgraph-obj-y)
> libqos-obj-y +=3D $(libqos-pc-obj-y) $(libqos-spapr-obj-y)
>+libqos-obj-y +=3D tests/qtest/libqos/qos_external.o
> libqos-obj-y +=3D tests/qtest/libqos/e1000e.o
> libqos-obj-y +=3D tests/qtest/libqos/i2c.o
> libqos-obj-y +=3D tests/qtest/libqos/i2c-imx.o
>diff --git a/tests/qtest/libqos/qos_external.c b/tests/qtest/libqos/qos_=
external.c
>new file mode 100644
>index 0000000000..398556dde0
>--- /dev/null
>+++ b/tests/qtest/libqos/qos_external.c
>@@ -0,0 +1,168 @@
>+/*
>+ * libqos driver framework
>+ *
>+ * Copyright (c) 2018 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gm=
ail.com>
>+ *
>+ * This library is free software; you can redistribute it and/or
>+ * modify it under the terms of the GNU Lesser General Public
>+ * License version 2 as published by the Free Software Foundation.
>+ *
>+ * This library is distributed in the hope that it will be useful,
>+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
>+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>+ * Lesser General Public License for more details.
>+ *
>+ * You should have received a copy of the GNU Lesser General Public
>+ * License along with this library; if not, see <http://www.gnu.org/lic=
enses/>
>+ */
>+
>+#include "qemu/osdep.h"
>+#include <getopt.h>
>+#include "libqtest.h"
>+#include "qapi/qmp/qdict.h"
>+#include "qapi/qmp/qbool.h"
>+#include "qapi/qmp/qstring.h"
>+#include "qemu/module.h"
>+#include "qapi/qmp/qlist.h"
>+#include "libqos/malloc.h"
>+#include "libqos/qgraph.h"
>+#include "libqos/qgraph_internal.h"
>+#include "libqos/qos_external.h"
>+
>+
>+
>+void apply_to_node(const char *name, bool is_machine, bool is_abstract)
>+{
>+    char *machine_name =3D NULL;
>+    if (is_machine) {
>+        const char *arch =3D qtest_get_arch();
>+        machine_name =3D g_strconcat(arch, "/", name, NULL);
>+        name =3D machine_name;
>+    }
>+    qos_graph_node_set_availability(name, true);
>+    if (is_abstract) {
>+        qos_delete_cmd_line(name);
>+    }
>+    g_free(machine_name);
>+}
>+
>+/**
>+ * apply_to_qlist(): using QMP queries QEMU for a list of
>+ * machines and devices available, and sets the respective node
>+ * as true. If a node is found, also all its produced and contained
>+ * child are marked available.
>+ *
>+ * See qos_graph_node_set_availability() for more info
>+ */
>+void apply_to_qlist(QList *list, bool is_machine)
>+{
>+    const QListEntry *p;
>+    const char *name;
>+    bool abstract;
>+    QDict *minfo;
>+    QObject *qobj;
>+    QString *qstr;
>+    QBool *qbool;
>+
>+    for (p =3D qlist_first(list); p; p =3D qlist_next(p)) {
>+        minfo =3D qobject_to(QDict, qlist_entry_obj(p));
>+        qobj =3D qdict_get(minfo, "name");
>+        qstr =3D qobject_to(QString, qobj);
>+        name =3D qstring_get_str(qstr);
>+
>+        qobj =3D qdict_get(minfo, "abstract");
>+        if (qobj) {
>+            qbool =3D qobject_to(QBool, qobj);
>+            abstract =3D qbool_get_bool(qbool);
>+        } else {
>+            abstract =3D false;
>+        }
>+
>+        apply_to_node(name, is_machine, abstract);
>+        qobj =3D qdict_get(minfo, "alias");
>+        if (qobj) {
>+            qstr =3D qobject_to(QString, qobj);
>+            name =3D qstring_get_str(qstr);
>+            apply_to_node(name, is_machine, abstract);
>+        }
>+    }
>+}
>+
>+QGuestAllocator *get_machine_allocator(QOSGraphObject *obj)
>+{
>+    return obj->get_driver(obj, "memory");
>+}
>+
>+/**
>+ * allocate_objects(): given an array of nodes @arg,
>+ * walks the path invoking all constructors and
>+ * passing the corresponding parameter in order to
>+ * continue the objects allocation.
>+ * Once the test is reached, return the object it consumes.
>+ *
>+ * Since the machine and QEDGE_CONSUMED_BY nodes allocate
>+ * memory in the constructor, g_test_queue_destroy is used so
>+ * that after execution they can be safely free'd.  (The test's
>+ * ->before callback is also welcome to use g_test_queue_destroy).
>+ *
>+ * Note: as specified in walk_path() too, @arg is an array of
>+ * char *, where arg[0] is a pointer to the command line
>+ * string that will be used to properly start QEMU when executing
>+ * the test, and the remaining elements represent the actual objects
>+ * that will be allocated.
>+ */
>+void *allocate_objects(QTestState *qts, char **path, QGuestAllocator **=
p_alloc)
>+{
>+    int current =3D 0;
>+    QGuestAllocator *alloc;
>+    QOSGraphObject *parent =3D NULL;
>+    QOSGraphEdge *edge;
>+    QOSGraphNode *node;
>+    void *edge_arg;
>+    void *obj;
>+
>+    node =3D qos_graph_get_node(path[current]);
>+    g_assert(node->type =3D=3D QNODE_MACHINE);
>+
>+    obj =3D qos_machine_new(node, qts);
>+    qos_object_queue_destroy(obj);
>+
>+    alloc =3D get_machine_allocator(obj);
>+    if (p_alloc) {
>+        *p_alloc =3D alloc;
>+    }
>+
>+    for (;;) {
>+        if (node->type !=3D QNODE_INTERFACE) {
>+            qos_object_start_hw(obj);
>+            parent =3D obj;
>+        }
>+
>+        /* follow edge and get object for next node constructor */
>+        current++;
>+        edge =3D qos_graph_get_edge(path[current - 1], path[current]);
>+        node =3D qos_graph_get_node(path[current]);
>+
>+        if (node->type =3D=3D QNODE_TEST) {
>+            g_assert(qos_graph_edge_get_type(edge) =3D=3D QEDGE_CONSUME=
D_BY);
>+            return obj;
>+        }
>+
>+        switch (qos_graph_edge_get_type(edge)) {
>+        case QEDGE_PRODUCES:
>+            obj =3D parent->get_driver(parent, path[current]);
>+            break;
>+
>+        case QEDGE_CONSUMED_BY:
>+            edge_arg =3D qos_graph_edge_get_arg(edge);
>+            obj =3D qos_driver_new(node, obj, alloc, edge_arg);
>+            qos_object_queue_destroy(obj);
>+            break;
>+
>+        case QEDGE_CONTAINS:
>+            obj =3D parent->get_device(parent, path[current]);
>+            break;
>+        }
>+    }
>+}
>+
>diff --git a/tests/qtest/libqos/qos_external.h b/tests/qtest/libqos/qos_=
external.h
>new file mode 100644
>index 0000000000..7b44930c55
>--- /dev/null
>+++ b/tests/qtest/libqos/qos_external.h
>@@ -0,0 +1,28 @@
>+/*
>+ * libqos driver framework
>+ *
>+ * Copyright (c) 2018 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gm=
ail.com>
>+ *
>+ * This library is free software; you can redistribute it and/or
>+ * modify it under the terms of the GNU Lesser General Public
>+ * License version 2 as published by the Free Software Foundation.
>+ *
>+ * This library is distributed in the hope that it will be useful,
>+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
>+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>+ * Lesser General Public License for more details.
>+ *
>+ * You should have received a copy of the GNU Lesser General Public
>+ * License along with this library; if not, see <http://www.gnu.org/lic=
enses/>
>+ */
>+
>+#ifndef QOS_EXTERNAL_H
>+#define QOS_EXTERNAL_H
>+#include "libqos/qgraph.h"
>+
>+void apply_to_node(const char *name, bool is_machine, bool is_abstract)=
;
>+void apply_to_qlist(QList *list, bool is_machine);
>+QGuestAllocator *get_machine_allocator(QOSGraphObject *obj);
>+void *allocate_objects(QTestState *qts, char **path, QGuestAllocator **=
p_alloc);
>+
>+#endif
>diff --git a/tests/qtest/qos-test.c b/tests/qtest/qos-test.c
>index fd70d73ea5..ad193f43a5 100644
>--- a/tests/qtest/qos-test.c
>+++ b/tests/qtest/qos-test.c
>@@ -27,65 +27,11 @@
> #include "libqos/malloc.h"
> #include "libqos/qgraph.h"
> #include "libqos/qgraph_internal.h"
>+#include "libqos/qos_external.h"
>
> static char *old_path;
>
>-static void apply_to_node(const char *name, bool is_machine, bool is_ab=
stract)
>-{
>-    char *machine_name =3D NULL;
>-    if (is_machine) {
>-        const char *arch =3D qtest_get_arch();
>-        machine_name =3D g_strconcat(arch, "/", name, NULL);
>-        name =3D machine_name;
>-    }
>-    qos_graph_node_set_availability(name, true);
>-    if (is_abstract) {
>-        qos_delete_cmd_line(name);
>-    }
>-    g_free(machine_name);
>-}
>
>-/**
>- * apply_to_qlist(): using QMP queries QEMU for a list of
>- * machines and devices available, and sets the respective node
>- * as true. If a node is found, also all its produced and contained
>- * child are marked available.
>- *
>- * See qos_graph_node_set_availability() for more info
>- */
>-static void apply_to_qlist(QList *list, bool is_machine)
>-{
>-    const QListEntry *p;
>-    const char *name;
>-    bool abstract;
>-    QDict *minfo;
>-    QObject *qobj;
>-    QString *qstr;
>-    QBool *qbool;
>-
>-    for (p =3D qlist_first(list); p; p =3D qlist_next(p)) {
>-        minfo =3D qobject_to(QDict, qlist_entry_obj(p));
>-        qobj =3D qdict_get(minfo, "name");
>-        qstr =3D qobject_to(QString, qobj);
>-        name =3D qstring_get_str(qstr);
>-
>-        qobj =3D qdict_get(minfo, "abstract");
>-        if (qobj) {
>-            qbool =3D qobject_to(QBool, qobj);
>-            abstract =3D qbool_get_bool(qbool);
>-        } else {
>-            abstract =3D false;
>-        }
>-
>-        apply_to_node(name, is_machine, abstract);
>-        qobj =3D qdict_get(minfo, "alias");
>-        if (qobj) {
>-            qstr =3D qobject_to(QString, qobj);
>-            name =3D qstring_get_str(qstr);
>-            apply_to_node(name, is_machine, abstract);
>-        }
>-    }
>-}
>
> /**
>  * qos_set_machines_devices_available(): sets availability of qgraph
>@@ -129,10 +75,6 @@ static void qos_set_machines_devices_available(void)
>     qobject_unref(response);
> }
>
>-static QGuestAllocator *get_machine_allocator(QOSGraphObject *obj)
>-{
>-    return obj->get_driver(obj, "memory");
>-}
>
> static void restart_qemu_or_continue(char *path)
> {
>@@ -159,78 +101,6 @@ void qos_invalidate_command_line(void)
>     old_path =3D NULL;
> }
>
>-/**
>- * allocate_objects(): given an array of nodes @arg,
>- * walks the path invoking all constructors and
>- * passing the corresponding parameter in order to
>- * continue the objects allocation.
>- * Once the test is reached, return the object it consumes.
>- *
>- * Since the machine and QEDGE_CONSUMED_BY nodes allocate
>- * memory in the constructor, g_test_queue_destroy is used so
>- * that after execution they can be safely free'd.  (The test's
>- * ->before callback is also welcome to use g_test_queue_destroy).
>- *
>- * Note: as specified in walk_path() too, @arg is an array of
>- * char *, where arg[0] is a pointer to the command line
>- * string that will be used to properly start QEMU when executing
>- * the test, and the remaining elements represent the actual objects
>- * that will be allocated.
>- */
>-static void *allocate_objects(QTestState *qts, char **path, QGuestAlloc=
ator **p_alloc)
>-{
>-    int current =3D 0;
>-    QGuestAllocator *alloc;
>-    QOSGraphObject *parent =3D NULL;
>-    QOSGraphEdge *edge;
>-    QOSGraphNode *node;
>-    void *edge_arg;
>-    void *obj;
>-
>-    node =3D qos_graph_get_node(path[current]);
>-    g_assert(node->type =3D=3D QNODE_MACHINE);
>-
>-    obj =3D qos_machine_new(node, qts);
>-    qos_object_queue_destroy(obj);
>-
>-    alloc =3D get_machine_allocator(obj);
>-    if (p_alloc) {
>-        *p_alloc =3D alloc;
>-    }
>-
>-    for (;;) {
>-        if (node->type !=3D QNODE_INTERFACE) {
>-            qos_object_start_hw(obj);
>-            parent =3D obj;
>-        }
>-
>-        /* follow edge and get object for next node constructor */
>-        current++;
>-        edge =3D qos_graph_get_edge(path[current - 1], path[current]);
>-        node =3D qos_graph_get_node(path[current]);
>-
>-        if (node->type =3D=3D QNODE_TEST) {
>-            g_assert(qos_graph_edge_get_type(edge) =3D=3D QEDGE_CONSUME=
D_BY);
>-            return obj;
>-        }
>-
>-        switch (qos_graph_edge_get_type(edge)) {
>-        case QEDGE_PRODUCES:
>-            obj =3D parent->get_driver(parent, path[current]);
>-            break;
>-
>-        case QEDGE_CONSUMED_BY:
>-            edge_arg =3D qos_graph_edge_get_arg(edge);
>-            obj =3D qos_driver_new(node, obj, alloc, edge_arg);
>-            qos_object_queue_destroy(obj);
>-            break;
>-
>-        case QEDGE_CONTAINS:
>-            obj =3D parent->get_device(parent, path[current]);
>-            break;
>-        }
>-    }
>-}
>
> /* The argument to run_one_test, which is the test function that is reg=
istered
>  * with GTest, is a vector of strings.  The first item is the initial c=
ommand
>--=20
>2.23.0
>

