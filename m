Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2AFC35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 13:19:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27A33217BA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 13:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OKVY0WUT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27A33217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izKau-0002ew-Bv
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 08:19:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60230)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <darren.kenny@oracle.com>) id 1izKZi-0001NR-5e
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:18:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <darren.kenny@oracle.com>) id 1izKZf-0003i4-Tk
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:18:37 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:51990)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <darren.kenny@oracle.com>)
 id 1izKZe-0003Ts-RU
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:18:35 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015D86Yw092637;
 Wed, 5 Feb 2020 13:18:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=ApWQSB6ejUjmBlnej0vlav3jYsvme/ZANk021w5hObY=;
 b=OKVY0WUTLM/6r8uhAY3mN1Hn5SSpEUDRdpiBW25odIdKVMOrzYbJ2Fd/yN5Jy3TtAwnl
 yk6eaAWOjV8ECrVSAWB72tKBIhbMD3YYpnRNxZz3m0k9f9NqxutZph51qfG8NFYECj1P
 ka/pjLPejNfYffs5SdmV2FQ2CgcsAdKEhnfte3Egf8e2FV56Ut/sYWNDqOojc305QoYL
 YJwFOl3falnLalxMZ4V+/CdAYSk53PdLRogq2UzRGYbZsTIyUeSn2q72lkZGw+N9BHfH
 pebAftdoHs6++q7WUJCeVyF5Qw8Oj6LbPRfw06OX95M666+eoTjjZ36lSYO97FK3vJyo rQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 2xykbp2wmj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2020 13:18:30 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015DICa1088209;
 Wed, 5 Feb 2020 13:18:30 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3020.oracle.com with ESMTP id 2xykc2ujfd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2020 13:18:30 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 015DITRp007284;
 Wed, 5 Feb 2020 13:18:29 GMT
Received: from starbug-mbp.localdomain (/10.169.111.17)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 05 Feb 2020 05:18:28 -0800
Received: from starbug-mbp (localhost [127.0.0.1])
 by starbug-mbp.localdomain (Postfix) with SMTP id 9F9C757DB787;
 Wed,  5 Feb 2020 13:18:25 +0000 (GMT)
Date: Wed, 5 Feb 2020 13:18:25 +0000
From: Darren Kenny <darren.kenny@oracle.com>
To: "Bulekov, Alexander" <alxndr@bu.edu>
Subject: Re: [PATCH v8 15/21] fuzz: add support for qos-assisted fuzz targets
Message-ID: <20200205131825.lxmr7pqbpzyw47bf@starbug-mbp>
Mail-Followup-To: "Bulekov, Alexander" <alxndr@bu.edu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
References: <20200129053357.27454-1-alxndr@bu.edu>
 <20200129053357.27454-16-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200129053357.27454-16-alxndr@bu.edu>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002050107
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002050106
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
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 29, 2020 at 05:34:24AM +0000, Bulekov, Alexander wrote:
>Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
>Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>---
> tests/qtest/fuzz/Makefile.include |   2 +
> tests/qtest/fuzz/qos_fuzz.c       | 229 ++++++++++++++++++++++++++++++
> tests/qtest/fuzz/qos_fuzz.h       |  33 +++++
> 3 files changed, 264 insertions(+)
> create mode 100644 tests/qtest/fuzz/qos_fuzz.c
> create mode 100644 tests/qtest/fuzz/qos_fuzz.h
>
>diff --git a/tests/qtest/fuzz/Makefile.include b/tests/qtest/fuzz/Makefile.include
>index a90915d56d..e3bdd33ff4 100644
>--- a/tests/qtest/fuzz/Makefile.include
>+++ b/tests/qtest/fuzz/Makefile.include
>@@ -1,8 +1,10 @@
> QEMU_PROG_FUZZ=qemu-fuzz-$(TARGET_NAME)$(EXESUF)
>
> fuzz-obj-y += tests/qtest/libqtest.o
>+fuzz-obj-y += $(libqos-obj-y)
> fuzz-obj-y += tests/qtest/fuzz/fuzz.o # Fuzzer skeleton
> fuzz-obj-y += tests/qtest/fuzz/fork_fuzz.o
>+fuzz-obj-y += tests/qtest/fuzz/qos_fuzz.o
>
> FUZZ_CFLAGS += -I$(SRC_PATH)/tests -I$(SRC_PATH)/tests/qtest
>
>diff --git a/tests/qtest/fuzz/qos_fuzz.c b/tests/qtest/fuzz/qos_fuzz.c
>new file mode 100644
>index 0000000000..efdcc6e9d3
>--- /dev/null
>+++ b/tests/qtest/fuzz/qos_fuzz.c
>@@ -0,0 +1,229 @@
>+/*
>+ * QOS-assisted fuzzing helpers
>+ *
>+ * Copyright (c) 2018 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
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
>+ * License along with this library; if not, see <http://www.gnu.org/licenses/>
>+ */
>+
>+#include "qemu/osdep.h"
>+#include "qemu/units.h"
>+#include "qapi/error.h"
>+#include "qemu-common.h"
>+#include "exec/memory.h"
>+#include "exec/address-spaces.h"
>+#include "sysemu/sysemu.h"
>+#include "qemu/main-loop.h"
>+
>+#include "tests/qtest/libqtest.h"
>+#include "tests/qtest/libqos/malloc.h"
>+#include "tests/qtest/libqos/qgraph.h"
>+#include "tests/qtest/libqos/qgraph_internal.h"
>+#include "tests/qtest/libqos/qos_external.h"
>+
>+#include "fuzz.h"
>+#include "qos_fuzz.h"
>+
>+#include "qapi/qapi-commands-machine.h"
>+#include "qapi/qapi-commands-qom.h"
>+#include "qapi/qmp/qlist.h"
>+
>+
>+void *fuzz_qos_obj;
>+QGuestAllocator *fuzz_qos_alloc;
>+
>+static const char *fuzz_target_name;
>+static char **fuzz_path_vec;
>+
>+/*
>+ * Replaced the qmp commands with direct qmp_marshal calls.
>+ * Probably there is a better way to do this
>+ */
>+static void qos_set_machines_devices_available(void)
>+{
>+    QDict *req = qdict_new();
>+    QObject *response;
>+    QDict *args = qdict_new();
>+    QList *lst;
>+    Error *err = NULL;
>+
>+    qmp_marshal_query_machines(NULL, &response, &err);
>+    assert(!err);
>+    lst = qobject_to(QList, response);
>+    apply_to_qlist(lst, true);
>+
>+    qobject_unref(response);
>+
>+
>+    qdict_put_str(req, "execute", "qom-list-types");
>+    qdict_put_str(args, "implements", "device");
>+    qdict_put_bool(args, "abstract", true);
>+    qdict_put_obj(req, "arguments", (QObject *) args);
>+
>+    qmp_marshal_qom_list_types(args, &response, &err);
>+    assert(!err);
>+    lst = qobject_to(QList, response);
>+    apply_to_qlist(lst, false);
>+    qobject_unref(response);
>+    qobject_unref(req);
>+}
>+
>+static char **current_path;
>+
>+void *qos_allocate_objects(QTestState *qts, QGuestAllocator **p_alloc)
>+{
>+    return allocate_objects(qts, current_path + 1, p_alloc);
>+}
>+
>+static const char *qos_build_main_args(void)
>+{
>+    char **path = fuzz_path_vec;

Is it possible that fuzz_path_vec is not valid here? Specifically,
how likely is it that walk_path() won't ever set it, or that it
results in a possible previous value being used since we don't reset
it before calling qos_graph_foreach_test_path() in
qos_get_cmdline().

Thanks,

Darren.

>+    QOSGraphNode *test_node;
>+    GString *cmd_line = g_string_new(path[0]);
>+    void *test_arg;
>+
>+    /* Before test */
>+    current_path = path;
>+    test_node = qos_graph_get_node(path[(g_strv_length(path) - 1)]);
>+    test_arg = test_node->u.test.arg;
>+    if (test_node->u.test.before) {
>+        test_arg = test_node->u.test.before(cmd_line, test_arg);
>+    }
>+    /* Prepend the arguments that we need */
>+    g_string_prepend(cmd_line,
>+            TARGET_NAME " -display none -machine accel=qtest -m 64 ");
>+    return cmd_line->str;
>+}
>+
>+/*
>+ * This function is largely a copy of qos-test.c:walk_path. Since walk_path
>+ * is itself a callback, its a little annoying to add another argument/layer of
>+ * indirection
>+ */
>+static void walk_path(QOSGraphNode *orig_path, int len)
>+{
>+    QOSGraphNode *path;
>+    QOSGraphEdge *edge;
>+
>+    /* etype set to QEDGE_CONSUMED_BY so that machine can add to the command line */
>+    QOSEdgeType etype = QEDGE_CONSUMED_BY;
>+
>+    /* twice QOS_PATH_MAX_ELEMENT_SIZE since each edge can have its arg */
>+    char **path_vec = g_new0(char *, (QOS_PATH_MAX_ELEMENT_SIZE * 2));
>+    int path_vec_size = 0;
>+
>+    char *after_cmd, *before_cmd, *after_device;
>+    GString *after_device_str = g_string_new("");
>+    char *node_name = orig_path->name, *path_str;
>+
>+    GString *cmd_line = g_string_new("");
>+    GString *cmd_line2 = g_string_new("");
>+
>+    path = qos_graph_get_node(node_name); /* root */
>+    node_name = qos_graph_edge_get_dest(path->path_edge); /* machine name */
>+
>+    path_vec[path_vec_size++] = node_name;
>+    path_vec[path_vec_size++] = qos_get_machine_type(node_name);
>+
>+    for (;;) {
>+        path = qos_graph_get_node(node_name);
>+        if (!path->path_edge) {
>+            break;
>+        }
>+
>+        node_name = qos_graph_edge_get_dest(path->path_edge);
>+
>+        /* append node command line + previous edge command line */
>+        if (path->command_line && etype == QEDGE_CONSUMED_BY) {
>+            g_string_append(cmd_line, path->command_line);
>+            g_string_append(cmd_line, after_device_str->str);
>+            g_string_truncate(after_device_str, 0);
>+        }
>+
>+        path_vec[path_vec_size++] = qos_graph_edge_get_name(path->path_edge);
>+        /* detect if edge has command line args */
>+        after_cmd = qos_graph_edge_get_after_cmd_line(path->path_edge);
>+        after_device = qos_graph_edge_get_extra_device_opts(path->path_edge);
>+        before_cmd = qos_graph_edge_get_before_cmd_line(path->path_edge);
>+        edge = qos_graph_get_edge(path->name, node_name);
>+        etype = qos_graph_edge_get_type(edge);
>+
>+        if (before_cmd) {
>+            g_string_append(cmd_line, before_cmd);
>+        }
>+        if (after_cmd) {
>+            g_string_append(cmd_line2, after_cmd);
>+        }
>+        if (after_device) {
>+            g_string_append(after_device_str, after_device);
>+        }
>+    }
>+
>+    path_vec[path_vec_size++] = NULL;
>+    g_string_append(cmd_line, after_device_str->str);
>+    g_string_free(after_device_str, true);
>+
>+    g_string_append(cmd_line, cmd_line2->str);
>+    g_string_free(cmd_line2, true);
>+
>+    /*
>+     * here position 0 has <arch>/<machine>, position 1 has <machine>.
>+     * The path must not have the <arch>, qtest_add_data_func adds it.
>+     */
>+    path_str = g_strjoinv("/", path_vec + 1);
>+
>+    /* Check that this is the test we care about: */
>+    char *test_name = strrchr(path_str, '/') + 1;
>+    if (strcmp(test_name, fuzz_target_name) == 0) {
>+        /*
>+         * put arch/machine in position 1 so run_one_test can do its work
>+         * and add the command line at position 0.
>+         */
>+        path_vec[1] = path_vec[0];
>+        path_vec[0] = g_string_free(cmd_line, false);
>+
>+        fuzz_path_vec = path_vec;
>+    } else {
>+        g_free(path_vec);
>+    }
>+
>+    g_free(path_str);
>+}
>+
>+static const char *qos_get_cmdline(FuzzTarget *t)
>+{
>+    /*
>+     * Set a global variable that we use to identify the qos_path for our
>+     * fuzz_target
>+     */
>+    fuzz_target_name = t->name;
>+    qos_set_machines_devices_available();
>+    qos_graph_foreach_test_path(walk_path);
>+    return qos_build_main_args();
>+}
>+
>+void fuzz_add_qos_target(
>+        FuzzTarget *fuzz_opts,
>+        const char *interface,
>+        QOSGraphTestOptions *opts
>+        )
>+{
>+    qos_add_test(fuzz_opts->name, interface, NULL, opts);
>+    fuzz_opts->get_init_cmdline = qos_get_cmdline;
>+    fuzz_add_target(fuzz_opts);
>+}
>+
>+void qos_init_path(QTestState *s)
>+{
>+    fuzz_qos_obj = qos_allocate_objects(s , &fuzz_qos_alloc);
>+}
>diff --git a/tests/qtest/fuzz/qos_fuzz.h b/tests/qtest/fuzz/qos_fuzz.h
>new file mode 100644
>index 0000000000..477f11b02b
>--- /dev/null
>+++ b/tests/qtest/fuzz/qos_fuzz.h
>@@ -0,0 +1,33 @@
>+/*
>+ * QOS-assisted fuzzing helpers
>+ *
>+ * Copyright Red Hat Inc., 2019
>+ *
>+ * Authors:
>+ *  Alexander Bulekov   <alxndr@bu.edu>
>+ *
>+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
>+ * See the COPYING file in the top-level directory.
>+ */
>+
>+#ifndef _QOS_FUZZ_H_
>+#define _QOS_FUZZ_H_
>+
>+#include "tests/qtest/fuzz/fuzz.h"
>+#include "tests/qtest/libqos/qgraph.h"
>+
>+int qos_fuzz(const unsigned char *Data, size_t Size);
>+void qos_setup(void);
>+
>+extern void *fuzz_qos_obj;
>+extern QGuestAllocator *fuzz_qos_alloc;
>+
>+void fuzz_add_qos_target(
>+        FuzzTarget *fuzz_opts,
>+        const char *interface,
>+        QOSGraphTestOptions *opts
>+        );
>+
>+void qos_init_path(QTestState *);
>+
>+#endif
>-- 
>2.23.0
>
>

