Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F62AC31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 17:08:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C91562063F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 17:07:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C91562063F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42014 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbTCg-0003Eu-Sb
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 13:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60376)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hbRlp-00013r-H9
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 11:36:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hbRlh-0004BT-JU
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 11:36:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39876)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hbRl7-0003jq-Cy; Thu, 13 Jun 2019 11:35:25 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 31A67B5C0B;
 Thu, 13 Jun 2019 15:35:19 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-116-246.ams2.redhat.com
 [10.36.116.246])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 272BC60C7F;
 Thu, 13 Jun 2019 15:35:06 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 17:34:01 +0200
Message-Id: <20190613153405.24769-12-kwolf@redhat.com>
In-Reply-To: <20190613153405.24769-1-kwolf@redhat.com>
References: <20190613153405.24769-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Thu, 13 Jun 2019 15:35:24 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 11/15] monitor: Split out monitor/hmp.c
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
Cc: kwolf@redhat.com, berrange@redhat.com, qemu-block@nongnu.org,
 armbru@redhat.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move HMP infrastructure from monitor/misc.c to monitor/hmp.c. This is
code that can be shared for all targets, so compile it only once.

The amount of function and particularly extern variables in
monitor_int.h is probably a bit larger than it needs to be, but this way
no non-trivial code modifications are needed. The interfaces between HMP
and the monitor core can be cleaned up later.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 monitor/monitor-internal.h |   10 +
 monitor/hmp.c              | 1415 ++++++++++++++++++++++++++++++++++++
 monitor/misc.c             | 1360 +---------------------------------
 monitor/Makefile.objs      |    2 +-
 monitor/trace-events       |    4 +-
 5 files changed, 1443 insertions(+), 1348 deletions(-)
 create mode 100644 monitor/hmp.c

diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index 0a26f702dd..ad3b7ee7ec 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -26,6 +26,8 @@
 #define MONITOR_INT_H
=20
 #include "monitor/monitor.h"
+#include "qemu/cutils.h"
+
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/json-parser.h"
 #include "qapi/qmp/dispatch.h"
@@ -161,7 +163,10 @@ extern QemuMutex monitor_lock;
 extern MonitorList mon_list;
 extern int mon_refcount;
=20
+extern HMPCommand hmp_cmds[];
+
 void monitor_init_qmp(Chardev *chr, int flags);
+void monitor_init_hmp(Chardev *chr, int flags);
=20
 int monitor_puts(Monitor *mon, const char *str);
 void monitor_data_init(Monitor *mon, int flags, bool skip_flush,
@@ -174,4 +179,9 @@ void qmp_send_response(MonitorQMP *mon, const QDict *=
rsp);
 void monitor_data_destroy_qmp(MonitorQMP *mon);
 void monitor_qmp_bh_dispatcher(void *data);
=20
+int get_monitor_def(int64_t *pval, const char *name);
+void help_cmd(Monitor *mon, const char *name);
+void handle_hmp_command(MonitorHMP *mon, const char *cmdline);
+int hmp_compare_cmd(const char *name, const char *list);
+
 #endif
diff --git a/monitor/hmp.c b/monitor/hmp.c
new file mode 100644
index 0000000000..3621b195ed
--- /dev/null
+++ b/monitor/hmp.c
@@ -0,0 +1,1415 @@
+/*
+ * QEMU monitor
+ *
+ * Copyright (c) 2003-2004 Fabrice Bellard
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
+ * of this software and associated documentation files (the "Software"),=
 to deal
+ * in the Software without restriction, including without limitation the=
 rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be includ=
ed in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "monitor-internal.h"
+
+#include "qapi/error.h"
+#include "qapi/qmp/qnum.h"
+
+#include "qemu/config-file.h"
+#include "qemu/ctype.h"
+#include "qemu/log.h"
+#include "qemu/option.h"
+#include "qemu/units.h"
+#include "sysemu/block-backend.h"
+#include "sysemu/sysemu.h"
+
+#include "trace.h"
+
+static void monitor_command_cb(void *opaque, const char *cmdline,
+                               void *readline_opaque)
+{
+    MonitorHMP *mon =3D opaque;
+
+    monitor_suspend(&mon->common);
+    handle_hmp_command(mon, cmdline);
+    monitor_resume(&mon->common);
+}
+
+void monitor_read_command(MonitorHMP *mon, int show_prompt)
+{
+    if (!mon->rs) {
+        return;
+    }
+
+    readline_start(mon->rs, "(qemu) ", 0, monitor_command_cb, NULL);
+    if (show_prompt) {
+        readline_show_prompt(mon->rs);
+    }
+}
+
+int monitor_read_password(MonitorHMP *mon, ReadLineFunc *readline_func,
+                          void *opaque)
+{
+    if (mon->rs) {
+        readline_start(mon->rs, "Password: ", 1, readline_func, opaque);
+        /* prompt is printed on return from the command handler */
+        return 0;
+    } else {
+        monitor_printf(&mon->common,
+                       "terminal does not support password prompting\n")=
;
+        return -ENOTTY;
+    }
+}
+
+static int get_str(char *buf, int buf_size, const char **pp)
+{
+    const char *p;
+    char *q;
+    int c;
+
+    q =3D buf;
+    p =3D *pp;
+    while (qemu_isspace(*p)) {
+        p++;
+    }
+    if (*p =3D=3D '\0') {
+    fail:
+        *q =3D '\0';
+        *pp =3D p;
+        return -1;
+    }
+    if (*p =3D=3D '\"') {
+        p++;
+        while (*p !=3D '\0' && *p !=3D '\"') {
+            if (*p =3D=3D '\\') {
+                p++;
+                c =3D *p++;
+                switch (c) {
+                case 'n':
+                    c =3D '\n';
+                    break;
+                case 'r':
+                    c =3D '\r';
+                    break;
+                case '\\':
+                case '\'':
+                case '\"':
+                    break;
+                default:
+                    printf("unsupported escape code: '\\%c'\n", c);
+                    goto fail;
+                }
+                if ((q - buf) < buf_size - 1) {
+                    *q++ =3D c;
+                }
+            } else {
+                if ((q - buf) < buf_size - 1) {
+                    *q++ =3D *p;
+                }
+                p++;
+            }
+        }
+        if (*p !=3D '\"') {
+            printf("unterminated string\n");
+            goto fail;
+        }
+        p++;
+    } else {
+        while (*p !=3D '\0' && !qemu_isspace(*p)) {
+            if ((q - buf) < buf_size - 1) {
+                *q++ =3D *p;
+            }
+            p++;
+        }
+    }
+    *q =3D '\0';
+    *pp =3D p;
+    return 0;
+}
+
+#define MAX_ARGS 16
+
+static void free_cmdline_args(char **args, int nb_args)
+{
+    int i;
+
+    assert(nb_args <=3D MAX_ARGS);
+
+    for (i =3D 0; i < nb_args; i++) {
+        g_free(args[i]);
+    }
+
+}
+
+/*
+ * Parse the command line to get valid args.
+ * @cmdline: command line to be parsed.
+ * @pnb_args: location to store the number of args, must NOT be NULL.
+ * @args: location to store the args, which should be freed by caller, m=
ust
+ *        NOT be NULL.
+ *
+ * Returns 0 on success, negative on failure.
+ *
+ * NOTE: this parser is an approximate form of the real command parser. =
Number
+ *       of args have a limit of MAX_ARGS. If cmdline contains more, it =
will
+ *       return with failure.
+ */
+static int parse_cmdline(const char *cmdline,
+                         int *pnb_args, char **args)
+{
+    const char *p;
+    int nb_args, ret;
+    char buf[1024];
+
+    p =3D cmdline;
+    nb_args =3D 0;
+    for (;;) {
+        while (qemu_isspace(*p)) {
+            p++;
+        }
+        if (*p =3D=3D '\0') {
+            break;
+        }
+        if (nb_args >=3D MAX_ARGS) {
+            goto fail;
+        }
+        ret =3D get_str(buf, sizeof(buf), &p);
+        if (ret < 0) {
+            goto fail;
+        }
+        args[nb_args] =3D g_strdup(buf);
+        nb_args++;
+    }
+    *pnb_args =3D nb_args;
+    return 0;
+
+ fail:
+    free_cmdline_args(args, nb_args);
+    return -1;
+}
+
+/*
+ * Can command @cmd be executed in preconfig state?
+ */
+static bool cmd_can_preconfig(const HMPCommand *cmd)
+{
+    if (!cmd->flags) {
+        return false;
+    }
+
+    return strchr(cmd->flags, 'p');
+}
+
+static void help_cmd_dump_one(Monitor *mon,
+                              const HMPCommand *cmd,
+                              char **prefix_args,
+                              int prefix_args_nb)
+{
+    int i;
+
+    if (runstate_check(RUN_STATE_PRECONFIG) && !cmd_can_preconfig(cmd)) =
{
+        return;
+    }
+
+    for (i =3D 0; i < prefix_args_nb; i++) {
+        monitor_printf(mon, "%s ", prefix_args[i]);
+    }
+    monitor_printf(mon, "%s %s -- %s\n", cmd->name, cmd->params, cmd->he=
lp);
+}
+
+/* @args[@arg_index] is the valid command need to find in @cmds */
+static void help_cmd_dump(Monitor *mon, const HMPCommand *cmds,
+                          char **args, int nb_args, int arg_index)
+{
+    const HMPCommand *cmd;
+    size_t i;
+
+    /* No valid arg need to compare with, dump all in *cmds */
+    if (arg_index >=3D nb_args) {
+        for (cmd =3D cmds; cmd->name !=3D NULL; cmd++) {
+            help_cmd_dump_one(mon, cmd, args, arg_index);
+        }
+        return;
+    }
+
+    /* Find one entry to dump */
+    for (cmd =3D cmds; cmd->name !=3D NULL; cmd++) {
+        if (hmp_compare_cmd(args[arg_index], cmd->name) &&
+            ((!runstate_check(RUN_STATE_PRECONFIG) ||
+                cmd_can_preconfig(cmd)))) {
+            if (cmd->sub_table) {
+                /* continue with next arg */
+                help_cmd_dump(mon, cmd->sub_table,
+                              args, nb_args, arg_index + 1);
+            } else {
+                help_cmd_dump_one(mon, cmd, args, arg_index);
+            }
+            return;
+        }
+    }
+
+    /* Command not found */
+    monitor_printf(mon, "unknown command: '");
+    for (i =3D 0; i <=3D arg_index; i++) {
+        monitor_printf(mon, "%s%s", args[i], i =3D=3D arg_index ? "'\n" =
: " ");
+    }
+}
+
+void help_cmd(Monitor *mon, const char *name)
+{
+    char *args[MAX_ARGS];
+    int nb_args =3D 0;
+
+    /* 1. parse user input */
+    if (name) {
+        /* special case for log, directly dump and return */
+        if (!strcmp(name, "log")) {
+            const QEMULogItem *item;
+            monitor_printf(mon, "Log items (comma separated):\n");
+            monitor_printf(mon, "%-10s %s\n", "none", "remove all logs")=
;
+            for (item =3D qemu_log_items; item->mask !=3D 0; item++) {
+                monitor_printf(mon, "%-10s %s\n", item->name, item->help=
);
+            }
+            return;
+        }
+
+        if (parse_cmdline(name, &nb_args, args) < 0) {
+            return;
+        }
+    }
+
+    /* 2. dump the contents according to parsed args */
+    help_cmd_dump(mon, hmp_cmds, args, nb_args, 0);
+
+    free_cmdline_args(args, nb_args);
+}
+
+/*******************************************************************/
+
+static const char *pch;
+static sigjmp_buf expr_env;
+
+static void GCC_FMT_ATTR(2, 3) QEMU_NORETURN
+expr_error(Monitor *mon, const char *fmt, ...)
+{
+    va_list ap;
+    va_start(ap, fmt);
+    monitor_vprintf(mon, fmt, ap);
+    monitor_printf(mon, "\n");
+    va_end(ap);
+    siglongjmp(expr_env, 1);
+}
+
+static void next(void)
+{
+    if (*pch !=3D '\0') {
+        pch++;
+        while (qemu_isspace(*pch)) {
+            pch++;
+        }
+    }
+}
+
+static int64_t expr_sum(Monitor *mon);
+
+static int64_t expr_unary(Monitor *mon)
+{
+    int64_t n;
+    char *p;
+    int ret;
+
+    switch (*pch) {
+    case '+':
+        next();
+        n =3D expr_unary(mon);
+        break;
+    case '-':
+        next();
+        n =3D -expr_unary(mon);
+        break;
+    case '~':
+        next();
+        n =3D ~expr_unary(mon);
+        break;
+    case '(':
+        next();
+        n =3D expr_sum(mon);
+        if (*pch !=3D ')') {
+            expr_error(mon, "')' expected");
+        }
+        next();
+        break;
+    case '\'':
+        pch++;
+        if (*pch =3D=3D '\0') {
+            expr_error(mon, "character constant expected");
+        }
+        n =3D *pch;
+        pch++;
+        if (*pch !=3D '\'') {
+            expr_error(mon, "missing terminating \' character");
+        }
+        next();
+        break;
+    case '$':
+        {
+            char buf[128], *q;
+            int64_t reg =3D 0;
+
+            pch++;
+            q =3D buf;
+            while ((*pch >=3D 'a' && *pch <=3D 'z') ||
+                   (*pch >=3D 'A' && *pch <=3D 'Z') ||
+                   (*pch >=3D '0' && *pch <=3D '9') ||
+                   *pch =3D=3D '_' || *pch =3D=3D '.') {
+                if ((q - buf) < sizeof(buf) - 1) {
+                    *q++ =3D *pch;
+                }
+                pch++;
+            }
+            while (qemu_isspace(*pch)) {
+                pch++;
+            }
+            *q =3D 0;
+            ret =3D get_monitor_def(&reg, buf);
+            if (ret < 0) {
+                expr_error(mon, "unknown register");
+            }
+            n =3D reg;
+        }
+        break;
+    case '\0':
+        expr_error(mon, "unexpected end of expression");
+        n =3D 0;
+        break;
+    default:
+        errno =3D 0;
+        n =3D strtoull(pch, &p, 0);
+        if (errno =3D=3D ERANGE) {
+            expr_error(mon, "number too large");
+        }
+        if (pch =3D=3D p) {
+            expr_error(mon, "invalid char '%c' in expression", *p);
+        }
+        pch =3D p;
+        while (qemu_isspace(*pch)) {
+            pch++;
+        }
+        break;
+    }
+    return n;
+}
+
+static int64_t expr_prod(Monitor *mon)
+{
+    int64_t val, val2;
+    int op;
+
+    val =3D expr_unary(mon);
+    for (;;) {
+        op =3D *pch;
+        if (op !=3D '*' && op !=3D '/' && op !=3D '%') {
+            break;
+        }
+        next();
+        val2 =3D expr_unary(mon);
+        switch (op) {
+        default:
+        case '*':
+            val *=3D val2;
+            break;
+        case '/':
+        case '%':
+            if (val2 =3D=3D 0) {
+                expr_error(mon, "division by zero");
+            }
+            if (op =3D=3D '/') {
+                val /=3D val2;
+            } else {
+                val %=3D val2;
+            }
+            break;
+        }
+    }
+    return val;
+}
+
+static int64_t expr_logic(Monitor *mon)
+{
+    int64_t val, val2;
+    int op;
+
+    val =3D expr_prod(mon);
+    for (;;) {
+        op =3D *pch;
+        if (op !=3D '&' && op !=3D '|' && op !=3D '^') {
+            break;
+        }
+        next();
+        val2 =3D expr_prod(mon);
+        switch (op) {
+        default:
+        case '&':
+            val &=3D val2;
+            break;
+        case '|':
+            val |=3D val2;
+            break;
+        case '^':
+            val ^=3D val2;
+            break;
+        }
+    }
+    return val;
+}
+
+static int64_t expr_sum(Monitor *mon)
+{
+    int64_t val, val2;
+    int op;
+
+    val =3D expr_logic(mon);
+    for (;;) {
+        op =3D *pch;
+        if (op !=3D '+' && op !=3D '-') {
+            break;
+        }
+        next();
+        val2 =3D expr_logic(mon);
+        if (op =3D=3D '+') {
+            val +=3D val2;
+        } else {
+            val -=3D val2;
+        }
+    }
+    return val;
+}
+
+static int get_expr(Monitor *mon, int64_t *pval, const char **pp)
+{
+    pch =3D *pp;
+    if (sigsetjmp(expr_env, 0)) {
+        *pp =3D pch;
+        return -1;
+    }
+    while (qemu_isspace(*pch)) {
+        pch++;
+    }
+    *pval =3D expr_sum(mon);
+    *pp =3D pch;
+    return 0;
+}
+
+static int get_double(Monitor *mon, double *pval, const char **pp)
+{
+    const char *p =3D *pp;
+    char *tailp;
+    double d;
+
+    d =3D strtod(p, &tailp);
+    if (tailp =3D=3D p) {
+        monitor_printf(mon, "Number expected\n");
+        return -1;
+    }
+    if (d !=3D d || d - d !=3D 0) {
+        /* NaN or infinity */
+        monitor_printf(mon, "Bad number\n");
+        return -1;
+    }
+    *pval =3D d;
+    *pp =3D tailp;
+    return 0;
+}
+
+/*
+ * Store the command-name in cmdname, and return a pointer to
+ * the remaining of the command string.
+ */
+static const char *get_command_name(const char *cmdline,
+                                    char *cmdname, size_t nlen)
+{
+    size_t len;
+    const char *p, *pstart;
+
+    p =3D cmdline;
+    while (qemu_isspace(*p)) {
+        p++;
+    }
+    if (*p =3D=3D '\0') {
+        return NULL;
+    }
+    pstart =3D p;
+    while (*p !=3D '\0' && *p !=3D '/' && !qemu_isspace(*p)) {
+        p++;
+    }
+    len =3D p - pstart;
+    if (len > nlen - 1) {
+        len =3D nlen - 1;
+    }
+    memcpy(cmdname, pstart, len);
+    cmdname[len] =3D '\0';
+    return p;
+}
+
+/**
+ * Read key of 'type' into 'key' and return the current
+ * 'type' pointer.
+ */
+static char *key_get_info(const char *type, char **key)
+{
+    size_t len;
+    char *p, *str;
+
+    if (*type =3D=3D ',') {
+        type++;
+    }
+
+    p =3D strchr(type, ':');
+    if (!p) {
+        *key =3D NULL;
+        return NULL;
+    }
+    len =3D p - type;
+
+    str =3D g_malloc(len + 1);
+    memcpy(str, type, len);
+    str[len] =3D '\0';
+
+    *key =3D str;
+    return ++p;
+}
+
+static int default_fmt_format =3D 'x';
+static int default_fmt_size =3D 4;
+
+static int is_valid_option(const char *c, const char *typestr)
+{
+    char option[3];
+
+    option[0] =3D '-';
+    option[1] =3D *c;
+    option[2] =3D '\0';
+
+    typestr =3D strstr(typestr, option);
+    return (typestr !=3D NULL);
+}
+
+static const HMPCommand *search_dispatch_table(const HMPCommand *disp_ta=
ble,
+                                               const char *cmdname)
+{
+    const HMPCommand *cmd;
+
+    for (cmd =3D disp_table; cmd->name !=3D NULL; cmd++) {
+        if (hmp_compare_cmd(cmdname, cmd->name)) {
+            return cmd;
+        }
+    }
+
+    return NULL;
+}
+
+/*
+ * Parse command name from @cmdp according to command table @table.
+ * If blank, return NULL.
+ * Else, if no valid command can be found, report to @mon, and return
+ * NULL.
+ * Else, change @cmdp to point right behind the name, and return its
+ * command table entry.
+ * Do not assume the return value points into @table!  It doesn't when
+ * the command is found in a sub-command table.
+ */
+static const HMPCommand *monitor_parse_command(MonitorHMP *hmp_mon,
+                                               const char *cmdp_start,
+                                               const char **cmdp,
+                                               HMPCommand *table)
+{
+    Monitor *mon =3D &hmp_mon->common;
+    const char *p;
+    const HMPCommand *cmd;
+    char cmdname[256];
+
+    /* extract the command name */
+    p =3D get_command_name(*cmdp, cmdname, sizeof(cmdname));
+    if (!p) {
+        return NULL;
+    }
+
+    cmd =3D search_dispatch_table(table, cmdname);
+    if (!cmd) {
+        monitor_printf(mon, "unknown command: '%.*s'\n",
+                       (int)(p - cmdp_start), cmdp_start);
+        return NULL;
+    }
+    if (runstate_check(RUN_STATE_PRECONFIG) && !cmd_can_preconfig(cmd)) =
{
+        monitor_printf(mon, "Command '%.*s' not available with -preconfi=
g "
+                            "until after exit_preconfig.\n",
+                       (int)(p - cmdp_start), cmdp_start);
+        return NULL;
+    }
+
+    /* filter out following useless space */
+    while (qemu_isspace(*p)) {
+        p++;
+    }
+
+    *cmdp =3D p;
+    /* search sub command */
+    if (cmd->sub_table !=3D NULL && *p !=3D '\0') {
+        return monitor_parse_command(hmp_mon, cmdp_start, cmdp, cmd->sub=
_table);
+    }
+
+    return cmd;
+}
+
+/*
+ * Parse arguments for @cmd.
+ * If it can't be parsed, report to @mon, and return NULL.
+ * Else, insert command arguments into a QDict, and return it.
+ * Note: On success, caller has to free the QDict structure.
+ */
+static QDict *monitor_parse_arguments(Monitor *mon,
+                                      const char **endp,
+                                      const HMPCommand *cmd)
+{
+    const char *typestr;
+    char *key;
+    int c;
+    const char *p =3D *endp;
+    char buf[1024];
+    QDict *qdict =3D qdict_new();
+
+    /* parse the parameters */
+    typestr =3D cmd->args_type;
+    for (;;) {
+        typestr =3D key_get_info(typestr, &key);
+        if (!typestr) {
+            break;
+        }
+        c =3D *typestr;
+        typestr++;
+        switch (c) {
+        case 'F':
+        case 'B':
+        case 's':
+            {
+                int ret;
+
+                while (qemu_isspace(*p)) {
+                    p++;
+                }
+                if (*typestr =3D=3D '?') {
+                    typestr++;
+                    if (*p =3D=3D '\0') {
+                        /* no optional string: NULL argument */
+                        break;
+                    }
+                }
+                ret =3D get_str(buf, sizeof(buf), &p);
+                if (ret < 0) {
+                    switch (c) {
+                    case 'F':
+                        monitor_printf(mon, "%s: filename expected\n",
+                                       cmd->name);
+                        break;
+                    case 'B':
+                        monitor_printf(mon, "%s: block device name expec=
ted\n",
+                                       cmd->name);
+                        break;
+                    default:
+                        monitor_printf(mon, "%s: string expected\n", cmd=
->name);
+                        break;
+                    }
+                    goto fail;
+                }
+                qdict_put_str(qdict, key, buf);
+            }
+            break;
+        case 'O':
+            {
+                QemuOptsList *opts_list;
+                QemuOpts *opts;
+
+                opts_list =3D qemu_find_opts(key);
+                if (!opts_list || opts_list->desc->name) {
+                    goto bad_type;
+                }
+                while (qemu_isspace(*p)) {
+                    p++;
+                }
+                if (!*p) {
+                    break;
+                }
+                if (get_str(buf, sizeof(buf), &p) < 0) {
+                    goto fail;
+                }
+                opts =3D qemu_opts_parse_noisily(opts_list, buf, true);
+                if (!opts) {
+                    goto fail;
+                }
+                qemu_opts_to_qdict(opts, qdict);
+                qemu_opts_del(opts);
+            }
+            break;
+        case '/':
+            {
+                int count, format, size;
+
+                while (qemu_isspace(*p)) {
+                    p++;
+                }
+                if (*p =3D=3D '/') {
+                    /* format found */
+                    p++;
+                    count =3D 1;
+                    if (qemu_isdigit(*p)) {
+                        count =3D 0;
+                        while (qemu_isdigit(*p)) {
+                            count =3D count * 10 + (*p - '0');
+                            p++;
+                        }
+                    }
+                    size =3D -1;
+                    format =3D -1;
+                    for (;;) {
+                        switch (*p) {
+                        case 'o':
+                        case 'd':
+                        case 'u':
+                        case 'x':
+                        case 'i':
+                        case 'c':
+                            format =3D *p++;
+                            break;
+                        case 'b':
+                            size =3D 1;
+                            p++;
+                            break;
+                        case 'h':
+                            size =3D 2;
+                            p++;
+                            break;
+                        case 'w':
+                            size =3D 4;
+                            p++;
+                            break;
+                        case 'g':
+                        case 'L':
+                            size =3D 8;
+                            p++;
+                            break;
+                        default:
+                            goto next;
+                        }
+                    }
+                next:
+                    if (*p !=3D '\0' && !qemu_isspace(*p)) {
+                        monitor_printf(mon, "invalid char in format: '%c=
'\n",
+                                       *p);
+                        goto fail;
+                    }
+                    if (format < 0) {
+                        format =3D default_fmt_format;
+                    }
+                    if (format !=3D 'i') {
+                        /* for 'i', not specifying a size gives -1 as si=
ze */
+                        if (size < 0) {
+                            size =3D default_fmt_size;
+                        }
+                        default_fmt_size =3D size;
+                    }
+                    default_fmt_format =3D format;
+                } else {
+                    count =3D 1;
+                    format =3D default_fmt_format;
+                    if (format !=3D 'i') {
+                        size =3D default_fmt_size;
+                    } else {
+                        size =3D -1;
+                    }
+                }
+                qdict_put_int(qdict, "count", count);
+                qdict_put_int(qdict, "format", format);
+                qdict_put_int(qdict, "size", size);
+            }
+            break;
+        case 'i':
+        case 'l':
+        case 'M':
+            {
+                int64_t val;
+
+                while (qemu_isspace(*p)) {
+                    p++;
+                }
+                if (*typestr =3D=3D '?' || *typestr =3D=3D '.') {
+                    if (*typestr =3D=3D '?') {
+                        if (*p =3D=3D '\0') {
+                            typestr++;
+                            break;
+                        }
+                    } else {
+                        if (*p =3D=3D '.') {
+                            p++;
+                            while (qemu_isspace(*p)) {
+                                p++;
+                            }
+                        } else {
+                            typestr++;
+                            break;
+                        }
+                    }
+                    typestr++;
+                }
+                if (get_expr(mon, &val, &p)) {
+                    goto fail;
+                }
+                /* Check if 'i' is greater than 32-bit */
+                if ((c =3D=3D 'i') && ((val >> 32) & 0xffffffff)) {
+                    monitor_printf(mon, "\'%s\' has failed: ", cmd->name=
);
+                    monitor_printf(mon, "integer is for 32-bit values\n"=
);
+                    goto fail;
+                } else if (c =3D=3D 'M') {
+                    if (val < 0) {
+                        monitor_printf(mon, "enter a positive value\n");
+                        goto fail;
+                    }
+                    val *=3D MiB;
+                }
+                qdict_put_int(qdict, key, val);
+            }
+            break;
+        case 'o':
+            {
+                int ret;
+                uint64_t val;
+                const char *end;
+
+                while (qemu_isspace(*p)) {
+                    p++;
+                }
+                if (*typestr =3D=3D '?') {
+                    typestr++;
+                    if (*p =3D=3D '\0') {
+                        break;
+                    }
+                }
+                ret =3D qemu_strtosz_MiB(p, &end, &val);
+                if (ret < 0 || val > INT64_MAX) {
+                    monitor_printf(mon, "invalid size\n");
+                    goto fail;
+                }
+                qdict_put_int(qdict, key, val);
+                p =3D end;
+            }
+            break;
+        case 'T':
+            {
+                double val;
+
+                while (qemu_isspace(*p)) {
+                    p++;
+                }
+                if (*typestr =3D=3D '?') {
+                    typestr++;
+                    if (*p =3D=3D '\0') {
+                        break;
+                    }
+                }
+                if (get_double(mon, &val, &p) < 0) {
+                    goto fail;
+                }
+                if (p[0] && p[1] =3D=3D 's') {
+                    switch (*p) {
+                    case 'm':
+                        val /=3D 1e3; p +=3D 2; break;
+                    case 'u':
+                        val /=3D 1e6; p +=3D 2; break;
+                    case 'n':
+                        val /=3D 1e9; p +=3D 2; break;
+                    }
+                }
+                if (*p && !qemu_isspace(*p)) {
+                    monitor_printf(mon, "Unknown unit suffix\n");
+                    goto fail;
+                }
+                qdict_put(qdict, key, qnum_from_double(val));
+            }
+            break;
+        case 'b':
+            {
+                const char *beg;
+                bool val;
+
+                while (qemu_isspace(*p)) {
+                    p++;
+                }
+                beg =3D p;
+                while (qemu_isgraph(*p)) {
+                    p++;
+                }
+                if (p - beg =3D=3D 2 && !memcmp(beg, "on", p - beg)) {
+                    val =3D true;
+                } else if (p - beg =3D=3D 3 && !memcmp(beg, "off", p - b=
eg)) {
+                    val =3D false;
+                } else {
+                    monitor_printf(mon, "Expected 'on' or 'off'\n");
+                    goto fail;
+                }
+                qdict_put_bool(qdict, key, val);
+            }
+            break;
+        case '-':
+            {
+                const char *tmp =3D p;
+                int skip_key =3D 0;
+                /* option */
+
+                c =3D *typestr++;
+                if (c =3D=3D '\0') {
+                    goto bad_type;
+                }
+                while (qemu_isspace(*p)) {
+                    p++;
+                }
+                if (*p =3D=3D '-') {
+                    p++;
+                    if (c !=3D *p) {
+                        if (!is_valid_option(p, typestr)) {
+                            monitor_printf(mon, "%s: unsupported option =
-%c\n",
+                                           cmd->name, *p);
+                            goto fail;
+                        } else {
+                            skip_key =3D 1;
+                        }
+                    }
+                    if (skip_key) {
+                        p =3D tmp;
+                    } else {
+                        /* has option */
+                        p++;
+                        qdict_put_bool(qdict, key, true);
+                    }
+                }
+            }
+            break;
+        case 'S':
+            {
+                /* package all remaining string */
+                int len;
+
+                while (qemu_isspace(*p)) {
+                    p++;
+                }
+                if (*typestr =3D=3D '?') {
+                    typestr++;
+                    if (*p =3D=3D '\0') {
+                        /* no remaining string: NULL argument */
+                        break;
+                    }
+                }
+                len =3D strlen(p);
+                if (len <=3D 0) {
+                    monitor_printf(mon, "%s: string expected\n",
+                                   cmd->name);
+                    goto fail;
+                }
+                qdict_put_str(qdict, key, p);
+                p +=3D len;
+            }
+            break;
+        default:
+        bad_type:
+            monitor_printf(mon, "%s: unknown type '%c'\n", cmd->name, c)=
;
+            goto fail;
+        }
+        g_free(key);
+        key =3D NULL;
+    }
+    /* check that all arguments were parsed */
+    while (qemu_isspace(*p)) {
+        p++;
+    }
+    if (*p !=3D '\0') {
+        monitor_printf(mon, "%s: extraneous characters at the end of lin=
e\n",
+                       cmd->name);
+        goto fail;
+    }
+
+    return qdict;
+
+fail:
+    qobject_unref(qdict);
+    g_free(key);
+    return NULL;
+}
+
+void handle_hmp_command(MonitorHMP *mon, const char *cmdline)
+{
+    QDict *qdict;
+    const HMPCommand *cmd;
+    const char *cmd_start =3D cmdline;
+
+    trace_handle_hmp_command(mon, cmdline);
+
+    cmd =3D monitor_parse_command(mon, cmdline, &cmdline, hmp_cmds);
+    if (!cmd) {
+        return;
+    }
+
+    qdict =3D monitor_parse_arguments(&mon->common, &cmdline, cmd);
+    if (!qdict) {
+        while (cmdline > cmd_start && qemu_isspace(cmdline[-1])) {
+            cmdline--;
+        }
+        monitor_printf(&mon->common, "Try \"help %.*s\" for more informa=
tion\n",
+                       (int)(cmdline - cmd_start), cmd_start);
+        return;
+    }
+
+    cmd->cmd(&mon->common, qdict);
+    qobject_unref(qdict);
+}
+
+static void cmd_completion(MonitorHMP *mon, const char *name, const char=
 *list)
+{
+    const char *p, *pstart;
+    char cmd[128];
+    int len;
+
+    p =3D list;
+    for (;;) {
+        pstart =3D p;
+        p =3D qemu_strchrnul(p, '|');
+        len =3D p - pstart;
+        if (len > sizeof(cmd) - 2) {
+            len =3D sizeof(cmd) - 2;
+        }
+        memcpy(cmd, pstart, len);
+        cmd[len] =3D '\0';
+        if (name[0] =3D=3D '\0' || !strncmp(name, cmd, strlen(name))) {
+            readline_add_completion(mon->rs, cmd);
+        }
+        if (*p =3D=3D '\0') {
+            break;
+        }
+        p++;
+    }
+}
+
+static void file_completion(MonitorHMP *mon, const char *input)
+{
+    DIR *ffs;
+    struct dirent *d;
+    char path[1024];
+    char file[1024], file_prefix[1024];
+    int input_path_len;
+    const char *p;
+
+    p =3D strrchr(input, '/');
+    if (!p) {
+        input_path_len =3D 0;
+        pstrcpy(file_prefix, sizeof(file_prefix), input);
+        pstrcpy(path, sizeof(path), ".");
+    } else {
+        input_path_len =3D p - input + 1;
+        memcpy(path, input, input_path_len);
+        if (input_path_len > sizeof(path) - 1) {
+            input_path_len =3D sizeof(path) - 1;
+        }
+        path[input_path_len] =3D '\0';
+        pstrcpy(file_prefix, sizeof(file_prefix), p + 1);
+    }
+
+    ffs =3D opendir(path);
+    if (!ffs) {
+        return;
+    }
+    for (;;) {
+        struct stat sb;
+        d =3D readdir(ffs);
+        if (!d) {
+            break;
+        }
+
+        if (strcmp(d->d_name, ".") =3D=3D 0 || strcmp(d->d_name, "..") =3D=
=3D 0) {
+            continue;
+        }
+
+        if (strstart(d->d_name, file_prefix, NULL)) {
+            memcpy(file, input, input_path_len);
+            if (input_path_len < sizeof(file)) {
+                pstrcpy(file + input_path_len, sizeof(file) - input_path=
_len,
+                        d->d_name);
+            }
+            /*
+             * stat the file to find out if it's a directory.
+             * In that case add a slash to speed up typing long paths
+             */
+            if (stat(file, &sb) =3D=3D 0 && S_ISDIR(sb.st_mode)) {
+                pstrcat(file, sizeof(file), "/");
+            }
+            readline_add_completion(mon->rs, file);
+        }
+    }
+    closedir(ffs);
+}
+
+static const char *next_arg_type(const char *typestr)
+{
+    const char *p =3D strchr(typestr, ':');
+    return (p !=3D NULL ? ++p : typestr);
+}
+
+static void monitor_find_completion_by_table(MonitorHMP *mon,
+                                             const HMPCommand *cmd_table=
,
+                                             char **args,
+                                             int nb_args)
+{
+    const char *cmdname;
+    int i;
+    const char *ptype, *old_ptype, *str, *name;
+    const HMPCommand *cmd;
+    BlockBackend *blk =3D NULL;
+
+    if (nb_args <=3D 1) {
+        /* command completion */
+        if (nb_args =3D=3D 0) {
+            cmdname =3D "";
+        } else {
+            cmdname =3D args[0];
+        }
+        readline_set_completion_index(mon->rs, strlen(cmdname));
+        for (cmd =3D cmd_table; cmd->name !=3D NULL; cmd++) {
+            if (!runstate_check(RUN_STATE_PRECONFIG) ||
+                 cmd_can_preconfig(cmd)) {
+                cmd_completion(mon, cmdname, cmd->name);
+            }
+        }
+    } else {
+        /* find the command */
+        for (cmd =3D cmd_table; cmd->name !=3D NULL; cmd++) {
+            if (hmp_compare_cmd(args[0], cmd->name) &&
+                (!runstate_check(RUN_STATE_PRECONFIG) ||
+                 cmd_can_preconfig(cmd))) {
+                break;
+            }
+        }
+        if (!cmd->name) {
+            return;
+        }
+
+        if (cmd->sub_table) {
+            /* do the job again */
+            monitor_find_completion_by_table(mon, cmd->sub_table,
+                                             &args[1], nb_args - 1);
+            return;
+        }
+        if (cmd->command_completion) {
+            cmd->command_completion(mon->rs, nb_args, args[nb_args - 1])=
;
+            return;
+        }
+
+        ptype =3D next_arg_type(cmd->args_type);
+        for (i =3D 0; i < nb_args - 2; i++) {
+            if (*ptype !=3D '\0') {
+                ptype =3D next_arg_type(ptype);
+                while (*ptype =3D=3D '?') {
+                    ptype =3D next_arg_type(ptype);
+                }
+            }
+        }
+        str =3D args[nb_args - 1];
+        old_ptype =3D NULL;
+        while (*ptype =3D=3D '-' && old_ptype !=3D ptype) {
+            old_ptype =3D ptype;
+            ptype =3D next_arg_type(ptype);
+        }
+        switch (*ptype) {
+        case 'F':
+            /* file completion */
+            readline_set_completion_index(mon->rs, strlen(str));
+            file_completion(mon, str);
+            break;
+        case 'B':
+            /* block device name completion */
+            readline_set_completion_index(mon->rs, strlen(str));
+            while ((blk =3D blk_next(blk)) !=3D NULL) {
+                name =3D blk_name(blk);
+                if (str[0] =3D=3D '\0' ||
+                    !strncmp(name, str, strlen(str))) {
+                    readline_add_completion(mon->rs, name);
+                }
+            }
+            break;
+        case 's':
+        case 'S':
+            if (!strcmp(cmd->name, "help|?")) {
+                monitor_find_completion_by_table(mon, cmd_table,
+                                                 &args[1], nb_args - 1);
+            }
+            break;
+        default:
+            break;
+        }
+    }
+}
+
+static void monitor_find_completion(void *opaque,
+                                    const char *cmdline)
+{
+    MonitorHMP *mon =3D opaque;
+    char *args[MAX_ARGS];
+    int nb_args, len;
+
+    /* 1. parse the cmdline */
+    if (parse_cmdline(cmdline, &nb_args, args) < 0) {
+        return;
+    }
+
+    /* if the line ends with a space, it means we want to complete the
+     * next arg */
+    len =3D strlen(cmdline);
+    if (len > 0 && qemu_isspace(cmdline[len - 1])) {
+        if (nb_args >=3D MAX_ARGS) {
+            goto cleanup;
+        }
+        args[nb_args++] =3D g_strdup("");
+    }
+
+    /* 2. auto complete according to args */
+    monitor_find_completion_by_table(mon, hmp_cmds, args, nb_args);
+
+cleanup:
+    free_cmdline_args(args, nb_args);
+}
+
+static void monitor_read(void *opaque, const uint8_t *buf, int size)
+{
+    MonitorHMP *mon;
+    Monitor *old_mon =3D cur_mon;
+    int i;
+
+    cur_mon =3D opaque;
+    mon =3D container_of(cur_mon, MonitorHMP, common);
+
+    if (mon->rs) {
+        for (i =3D 0; i < size; i++) {
+            readline_handle_byte(mon->rs, buf[i]);
+        }
+    } else {
+        if (size =3D=3D 0 || buf[size - 1] !=3D 0) {
+            monitor_printf(cur_mon, "corrupted command\n");
+        } else {
+            handle_hmp_command(mon, (char *)buf);
+        }
+    }
+
+    cur_mon =3D old_mon;
+}
+
+static void monitor_event(void *opaque, int event)
+{
+    Monitor *mon =3D opaque;
+    MonitorHMP *hmp_mon =3D container_of(mon, MonitorHMP, common);
+
+    switch (event) {
+    case CHR_EVENT_MUX_IN:
+        qemu_mutex_lock(&mon->mon_lock);
+        mon->mux_out =3D 0;
+        qemu_mutex_unlock(&mon->mon_lock);
+        if (mon->reset_seen) {
+            readline_restart(hmp_mon->rs);
+            monitor_resume(mon);
+            monitor_flush(mon);
+        } else {
+            atomic_mb_set(&mon->suspend_cnt, 0);
+        }
+        break;
+
+    case CHR_EVENT_MUX_OUT:
+        if (mon->reset_seen) {
+            if (atomic_mb_read(&mon->suspend_cnt) =3D=3D 0) {
+                monitor_printf(mon, "\n");
+            }
+            monitor_flush(mon);
+            monitor_suspend(mon);
+        } else {
+            atomic_inc(&mon->suspend_cnt);
+        }
+        qemu_mutex_lock(&mon->mon_lock);
+        mon->mux_out =3D 1;
+        qemu_mutex_unlock(&mon->mon_lock);
+        break;
+
+    case CHR_EVENT_OPENED:
+        monitor_printf(mon, "QEMU %s monitor - type 'help' for more "
+                       "information\n", QEMU_VERSION);
+        if (!mon->mux_out) {
+            readline_restart(hmp_mon->rs);
+            readline_show_prompt(hmp_mon->rs);
+        }
+        mon->reset_seen =3D 1;
+        mon_refcount++;
+        break;
+
+    case CHR_EVENT_CLOSED:
+        mon_refcount--;
+        monitor_fdsets_cleanup();
+        break;
+    }
+}
+
+
+/*
+ * These functions just adapt the readline interface in a typesafe way. =
 We
+ * could cast function pointers but that discards compiler checks.
+ */
+static void GCC_FMT_ATTR(2, 3) monitor_readline_printf(void *opaque,
+                                                       const char *fmt, =
...)
+{
+    MonitorHMP *mon =3D opaque;
+    va_list ap;
+    va_start(ap, fmt);
+    monitor_vprintf(&mon->common, fmt, ap);
+    va_end(ap);
+}
+
+static void monitor_readline_flush(void *opaque)
+{
+    MonitorHMP *mon =3D opaque;
+    monitor_flush(&mon->common);
+}
+
+void monitor_init_hmp(Chardev *chr, int flags)
+{
+    MonitorHMP *mon =3D g_malloc0(sizeof(*mon));
+    bool use_readline =3D flags & MONITOR_USE_READLINE;
+
+    monitor_data_init(&mon->common, flags, false, false);
+    qemu_chr_fe_init(&mon->common.chr, chr, &error_abort);
+
+    if (use_readline) {
+        mon->rs =3D readline_init(monitor_readline_printf,
+                                monitor_readline_flush,
+                                mon,
+                                monitor_find_completion);
+        monitor_read_command(mon, 0);
+    }
+
+    qemu_chr_fe_set_handlers(&mon->common.chr, monitor_can_read, monitor=
_read,
+                             monitor_event, NULL, &mon->common, NULL, tr=
ue);
+    monitor_list_append(&mon->common);
+}
diff --git a/monitor/misc.c b/monitor/misc.c
index 368b8297d4..c8289959c0 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -24,7 +24,6 @@
=20
 #include "qemu/osdep.h"
 #include "monitor-internal.h"
-#include "qemu/units.h"
 #include <dirent.h>
 #include "cpu.h"
 #include "hw/hw.h"
@@ -157,14 +156,10 @@ static QLIST_HEAD(, MonFdset) mon_fdsets;
=20
 int mon_refcount;
=20
-static HMPCommand hmp_cmds[];
 static HMPCommand hmp_info_cmds[];
=20
 __thread Monitor *cur_mon;
=20
-static void monitor_command_cb(void *opaque, const char *cmdline,
-                               void *readline_opaque);
-
 /**
  * Is @mon is using readline?
  * Note: not all HMP monitors use readline, e.g., gdbserver has a
@@ -199,31 +194,6 @@ bool monitor_cur_is_qmp(void)
     return cur_mon && monitor_is_qmp(cur_mon);
 }
=20
-void monitor_read_command(MonitorHMP *mon, int show_prompt)
-{
-    if (!mon->rs)
-        return;
-
-    readline_start(mon->rs, "(qemu) ", 0, monitor_command_cb, NULL);
-    if (show_prompt)
-        readline_show_prompt(mon->rs);
-}
-
-int monitor_read_password(MonitorHMP *mon, ReadLineFunc *readline_func,
-                          void *opaque)
-{
-    if (mon->rs) {
-        readline_start(mon->rs, "Password: ", 1, readline_func, opaque);
-        /* prompt is printed on return from the command handler */
-        return 0;
-    } else {
-        monitor_printf(&mon->common,
-                       "terminal does not support password prompting\n")=
;
-        return -ENOTTY;
-    }
-}
-
-
 static void monitor_flush_locked(Monitor *mon);
=20
 static gboolean monitor_unblocked(GIOChannel *chan, GIOCondition cond,
@@ -542,8 +512,6 @@ static void monitor_qapi_event_init(void)
                                                 qapi_event_throttle_equa=
l);
 }
=20
-static void handle_hmp_command(MonitorHMP *mon, const char *cmdline);
-
 static void monitor_iothread_init(void);
=20
 void monitor_data_init(Monitor *mon, int flags, bool skip_flush,
@@ -612,245 +580,27 @@ out:
     return output;
 }
=20
-static int compare_cmd(const char *name, const char *list)
+/**
+ * Is @name in the '|' separated list of names @list?
+ */
+int hmp_compare_cmd(const char *name, const char *list)
 {
     const char *p, *pstart;
     int len;
     len =3D strlen(name);
     p =3D list;
-    for(;;) {
+    for (;;) {
         pstart =3D p;
         p =3D qemu_strchrnul(p, '|');
-        if ((p - pstart) =3D=3D len && !memcmp(pstart, name, len))
+        if ((p - pstart) =3D=3D len && !memcmp(pstart, name, len)) {
             return 1;
-        if (*p =3D=3D '\0')
-            break;
-        p++;
-    }
-    return 0;
-}
-
-static int get_str(char *buf, int buf_size, const char **pp)
-{
-    const char *p;
-    char *q;
-    int c;
-
-    q =3D buf;
-    p =3D *pp;
-    while (qemu_isspace(*p)) {
-        p++;
-    }
-    if (*p =3D=3D '\0') {
-    fail:
-        *q =3D '\0';
-        *pp =3D p;
-        return -1;
-    }
-    if (*p =3D=3D '\"') {
-        p++;
-        while (*p !=3D '\0' && *p !=3D '\"') {
-            if (*p =3D=3D '\\') {
-                p++;
-                c =3D *p++;
-                switch (c) {
-                case 'n':
-                    c =3D '\n';
-                    break;
-                case 'r':
-                    c =3D '\r';
-                    break;
-                case '\\':
-                case '\'':
-                case '\"':
-                    break;
-                default:
-                    printf("unsupported escape code: '\\%c'\n", c);
-                    goto fail;
-                }
-                if ((q - buf) < buf_size - 1) {
-                    *q++ =3D c;
-                }
-            } else {
-                if ((q - buf) < buf_size - 1) {
-                    *q++ =3D *p;
-                }
-                p++;
-            }
-        }
-        if (*p !=3D '\"') {
-            printf("unterminated string\n");
-            goto fail;
-        }
-        p++;
-    } else {
-        while (*p !=3D '\0' && !qemu_isspace(*p)) {
-            if ((q - buf) < buf_size - 1) {
-                *q++ =3D *p;
-            }
-            p++;
-        }
-    }
-    *q =3D '\0';
-    *pp =3D p;
-    return 0;
-}
-
-#define MAX_ARGS 16
-
-static void free_cmdline_args(char **args, int nb_args)
-{
-    int i;
-
-    assert(nb_args <=3D MAX_ARGS);
-
-    for (i =3D 0; i < nb_args; i++) {
-        g_free(args[i]);
-    }
-
-}
-
-/*
- * Parse the command line to get valid args.
- * @cmdline: command line to be parsed.
- * @pnb_args: location to store the number of args, must NOT be NULL.
- * @args: location to store the args, which should be freed by caller, m=
ust
- *        NOT be NULL.
- *
- * Returns 0 on success, negative on failure.
- *
- * NOTE: this parser is an approximate form of the real command parser. =
Number
- *       of args have a limit of MAX_ARGS. If cmdline contains more, it =
will
- *       return with failure.
- */
-static int parse_cmdline(const char *cmdline,
-                         int *pnb_args, char **args)
-{
-    const char *p;
-    int nb_args, ret;
-    char buf[1024];
-
-    p =3D cmdline;
-    nb_args =3D 0;
-    for (;;) {
-        while (qemu_isspace(*p)) {
-            p++;
         }
         if (*p =3D=3D '\0') {
             break;
         }
-        if (nb_args >=3D MAX_ARGS) {
-            goto fail;
-        }
-        ret =3D get_str(buf, sizeof(buf), &p);
-        if (ret < 0) {
-            goto fail;
-        }
-        args[nb_args] =3D g_strdup(buf);
-        nb_args++;
+        p++;
     }
-    *pnb_args =3D nb_args;
     return 0;
-
- fail:
-    free_cmdline_args(args, nb_args);
-    return -1;
-}
-
-/*
- * Can command @cmd be executed in preconfig state?
- */
-static bool cmd_can_preconfig(const HMPCommand *cmd)
-{
-    if (!cmd->flags) {
-        return false;
-    }
-
-    return strchr(cmd->flags, 'p');
-}
-
-static void help_cmd_dump_one(Monitor *mon,
-                              const HMPCommand *cmd,
-                              char **prefix_args,
-                              int prefix_args_nb)
-{
-    int i;
-
-    if (runstate_check(RUN_STATE_PRECONFIG) && !cmd_can_preconfig(cmd)) =
{
-        return;
-    }
-
-    for (i =3D 0; i < prefix_args_nb; i++) {
-        monitor_printf(mon, "%s ", prefix_args[i]);
-    }
-    monitor_printf(mon, "%s %s -- %s\n", cmd->name, cmd->params, cmd->he=
lp);
-}
-
-/* @args[@arg_index] is the valid command need to find in @cmds */
-static void help_cmd_dump(Monitor *mon, const HMPCommand *cmds,
-                          char **args, int nb_args, int arg_index)
-{
-    const HMPCommand *cmd;
-    size_t i;
-
-    /* No valid arg need to compare with, dump all in *cmds */
-    if (arg_index >=3D nb_args) {
-        for (cmd =3D cmds; cmd->name !=3D NULL; cmd++) {
-            help_cmd_dump_one(mon, cmd, args, arg_index);
-        }
-        return;
-    }
-
-    /* Find one entry to dump */
-    for (cmd =3D cmds; cmd->name !=3D NULL; cmd++) {
-        if (compare_cmd(args[arg_index], cmd->name) &&
-            ((!runstate_check(RUN_STATE_PRECONFIG) ||
-                cmd_can_preconfig(cmd)))) {
-            if (cmd->sub_table) {
-                /* continue with next arg */
-                help_cmd_dump(mon, cmd->sub_table,
-                              args, nb_args, arg_index + 1);
-            } else {
-                help_cmd_dump_one(mon, cmd, args, arg_index);
-            }
-            return;
-        }
-    }
-
-    /* Command not found */
-    monitor_printf(mon, "unknown command: '");
-    for (i =3D 0; i <=3D arg_index; i++) {
-        monitor_printf(mon, "%s%s", args[i], i =3D=3D arg_index ? "'\n" =
: " ");
-    }
-}
-
-static void help_cmd(Monitor *mon, const char *name)
-{
-    char *args[MAX_ARGS];
-    int nb_args =3D 0;
-
-    /* 1. parse user input */
-    if (name) {
-        /* special case for log, directly dump and return */
-        if (!strcmp(name, "log")) {
-            const QEMULogItem *item;
-            monitor_printf(mon, "Log items (comma separated):\n");
-            monitor_printf(mon, "%-10s %s\n", "none", "remove all logs")=
;
-            for (item =3D qemu_log_items; item->mask !=3D 0; item++) {
-                monitor_printf(mon, "%-10s %s\n", item->name, item->help=
);
-            }
-            return;
-        }
-
-        if (parse_cmdline(name, &nb_args, args) < 0) {
-            return;
-        }
-    }
-
-    /* 2. dump the contents according to parsed args */
-    help_cmd_dump(mon, hmp_cmds, args, nb_args, 0);
-
-    free_cmdline_args(args, nb_args);
 }
=20
 static void do_help_cmd(Monitor *mon, const QDict *qdict)
@@ -2510,30 +2260,16 @@ static HMPCommand hmp_info_cmds[] =3D {
 };
=20
 /* hmp_cmds and hmp_info_cmds would be sorted at runtime */
-static HMPCommand hmp_cmds[] =3D {
+HMPCommand hmp_cmds[] =3D {
 #include "hmp-commands.h"
     { NULL, NULL, },
 };
=20
-/*******************************************************************/
-
-static const char *pch;
-static sigjmp_buf expr_env;
-
-
-static void GCC_FMT_ATTR(2, 3) QEMU_NORETURN
-expr_error(Monitor *mon, const char *fmt, ...)
-{
-    va_list ap;
-    va_start(ap, fmt);
-    monitor_vprintf(mon, fmt, ap);
-    monitor_printf(mon, "\n");
-    va_end(ap);
-    siglongjmp(expr_env, 1);
-}
-
-/* return 0 if OK, -1 if not found */
-static int get_monitor_def(target_long *pval, const char *name)
+/*
+ * Set @pval to the value in the register identified by @name.
+ * return 0 if OK, -1 if not found
+ */
+int get_monitor_def(int64_t *pval, const char *name)
 {
     const MonitorDef *md =3D target_monitor_defs();
     CPUState *cs =3D mon_get_cpu();
@@ -2546,7 +2282,7 @@ static int get_monitor_def(target_long *pval, const=
 char *name)
     }
=20
     for(; md->name !=3D NULL; md++) {
-        if (compare_cmd(name, md->name)) {
+        if (hmp_compare_cmd(name, md->name)) {
             if (md->get_value) {
                 *pval =3D md->get_value(md, md->offset);
             } else {
@@ -2576,829 +2312,6 @@ static int get_monitor_def(target_long *pval, con=
st char *name)
     return ret;
 }
=20
-static void next(void)
-{
-    if (*pch !=3D '\0') {
-        pch++;
-        while (qemu_isspace(*pch))
-            pch++;
-    }
-}
-
-static int64_t expr_sum(Monitor *mon);
-
-static int64_t expr_unary(Monitor *mon)
-{
-    int64_t n;
-    char *p;
-    int ret;
-
-    switch(*pch) {
-    case '+':
-        next();
-        n =3D expr_unary(mon);
-        break;
-    case '-':
-        next();
-        n =3D -expr_unary(mon);
-        break;
-    case '~':
-        next();
-        n =3D ~expr_unary(mon);
-        break;
-    case '(':
-        next();
-        n =3D expr_sum(mon);
-        if (*pch !=3D ')') {
-            expr_error(mon, "')' expected");
-        }
-        next();
-        break;
-    case '\'':
-        pch++;
-        if (*pch =3D=3D '\0')
-            expr_error(mon, "character constant expected");
-        n =3D *pch;
-        pch++;
-        if (*pch !=3D '\'')
-            expr_error(mon, "missing terminating \' character");
-        next();
-        break;
-    case '$':
-        {
-            char buf[128], *q;
-            target_long reg=3D0;
-
-            pch++;
-            q =3D buf;
-            while ((*pch >=3D 'a' && *pch <=3D 'z') ||
-                   (*pch >=3D 'A' && *pch <=3D 'Z') ||
-                   (*pch >=3D '0' && *pch <=3D '9') ||
-                   *pch =3D=3D '_' || *pch =3D=3D '.') {
-                if ((q - buf) < sizeof(buf) - 1)
-                    *q++ =3D *pch;
-                pch++;
-            }
-            while (qemu_isspace(*pch))
-                pch++;
-            *q =3D 0;
-            ret =3D get_monitor_def(&reg, buf);
-            if (ret < 0)
-                expr_error(mon, "unknown register");
-            n =3D reg;
-        }
-        break;
-    case '\0':
-        expr_error(mon, "unexpected end of expression");
-        n =3D 0;
-        break;
-    default:
-        errno =3D 0;
-        n =3D strtoull(pch, &p, 0);
-        if (errno =3D=3D ERANGE) {
-            expr_error(mon, "number too large");
-        }
-        if (pch =3D=3D p) {
-            expr_error(mon, "invalid char '%c' in expression", *p);
-        }
-        pch =3D p;
-        while (qemu_isspace(*pch))
-            pch++;
-        break;
-    }
-    return n;
-}
-
-
-static int64_t expr_prod(Monitor *mon)
-{
-    int64_t val, val2;
-    int op;
-
-    val =3D expr_unary(mon);
-    for(;;) {
-        op =3D *pch;
-        if (op !=3D '*' && op !=3D '/' && op !=3D '%')
-            break;
-        next();
-        val2 =3D expr_unary(mon);
-        switch(op) {
-        default:
-        case '*':
-            val *=3D val2;
-            break;
-        case '/':
-        case '%':
-            if (val2 =3D=3D 0)
-                expr_error(mon, "division by zero");
-            if (op =3D=3D '/')
-                val /=3D val2;
-            else
-                val %=3D val2;
-            break;
-        }
-    }
-    return val;
-}
-
-static int64_t expr_logic(Monitor *mon)
-{
-    int64_t val, val2;
-    int op;
-
-    val =3D expr_prod(mon);
-    for(;;) {
-        op =3D *pch;
-        if (op !=3D '&' && op !=3D '|' && op !=3D '^')
-            break;
-        next();
-        val2 =3D expr_prod(mon);
-        switch(op) {
-        default:
-        case '&':
-            val &=3D val2;
-            break;
-        case '|':
-            val |=3D val2;
-            break;
-        case '^':
-            val ^=3D val2;
-            break;
-        }
-    }
-    return val;
-}
-
-static int64_t expr_sum(Monitor *mon)
-{
-    int64_t val, val2;
-    int op;
-
-    val =3D expr_logic(mon);
-    for(;;) {
-        op =3D *pch;
-        if (op !=3D '+' && op !=3D '-')
-            break;
-        next();
-        val2 =3D expr_logic(mon);
-        if (op =3D=3D '+')
-            val +=3D val2;
-        else
-            val -=3D val2;
-    }
-    return val;
-}
-
-static int get_expr(Monitor *mon, int64_t *pval, const char **pp)
-{
-    pch =3D *pp;
-    if (sigsetjmp(expr_env, 0)) {
-        *pp =3D pch;
-        return -1;
-    }
-    while (qemu_isspace(*pch))
-        pch++;
-    *pval =3D expr_sum(mon);
-    *pp =3D pch;
-    return 0;
-}
-
-static int get_double(Monitor *mon, double *pval, const char **pp)
-{
-    const char *p =3D *pp;
-    char *tailp;
-    double d;
-
-    d =3D strtod(p, &tailp);
-    if (tailp =3D=3D p) {
-        monitor_printf(mon, "Number expected\n");
-        return -1;
-    }
-    if (d !=3D d || d - d !=3D 0) {
-        /* NaN or infinity */
-        monitor_printf(mon, "Bad number\n");
-        return -1;
-    }
-    *pval =3D d;
-    *pp =3D tailp;
-    return 0;
-}
-
-/*
- * Store the command-name in cmdname, and return a pointer to
- * the remaining of the command string.
- */
-static const char *get_command_name(const char *cmdline,
-                                    char *cmdname, size_t nlen)
-{
-    size_t len;
-    const char *p, *pstart;
-
-    p =3D cmdline;
-    while (qemu_isspace(*p))
-        p++;
-    if (*p =3D=3D '\0')
-        return NULL;
-    pstart =3D p;
-    while (*p !=3D '\0' && *p !=3D '/' && !qemu_isspace(*p))
-        p++;
-    len =3D p - pstart;
-    if (len > nlen - 1)
-        len =3D nlen - 1;
-    memcpy(cmdname, pstart, len);
-    cmdname[len] =3D '\0';
-    return p;
-}
-
-/**
- * Read key of 'type' into 'key' and return the current
- * 'type' pointer.
- */
-static char *key_get_info(const char *type, char **key)
-{
-    size_t len;
-    char *p, *str;
-
-    if (*type =3D=3D ',')
-        type++;
-
-    p =3D strchr(type, ':');
-    if (!p) {
-        *key =3D NULL;
-        return NULL;
-    }
-    len =3D p - type;
-
-    str =3D g_malloc(len + 1);
-    memcpy(str, type, len);
-    str[len] =3D '\0';
-
-    *key =3D str;
-    return ++p;
-}
-
-static int default_fmt_format =3D 'x';
-static int default_fmt_size =3D 4;
-
-static int is_valid_option(const char *c, const char *typestr)
-{
-    char option[3];
- =20
-    option[0] =3D '-';
-    option[1] =3D *c;
-    option[2] =3D '\0';
- =20
-    typestr =3D strstr(typestr, option);
-    return (typestr !=3D NULL);
-}
-
-static const HMPCommand *search_dispatch_table(const HMPCommand *disp_ta=
ble,
-                                               const char *cmdname)
-{
-    const HMPCommand *cmd;
-
-    for (cmd =3D disp_table; cmd->name !=3D NULL; cmd++) {
-        if (compare_cmd(cmdname, cmd->name)) {
-            return cmd;
-        }
-    }
-
-    return NULL;
-}
-
-/*
- * Parse command name from @cmdp according to command table @table.
- * If blank, return NULL.
- * Else, if no valid command can be found, report to @mon, and return
- * NULL.
- * Else, change @cmdp to point right behind the name, and return its
- * command table entry.
- * Do not assume the return value points into @table!  It doesn't when
- * the command is found in a sub-command table.
- */
-static const HMPCommand *monitor_parse_command(MonitorHMP *hmp_mon,
-                                               const char *cmdp_start,
-                                               const char **cmdp,
-                                               HMPCommand *table)
-{
-    Monitor *mon =3D &hmp_mon->common;
-    const char *p;
-    const HMPCommand *cmd;
-    char cmdname[256];
-
-    /* extract the command name */
-    p =3D get_command_name(*cmdp, cmdname, sizeof(cmdname));
-    if (!p)
-        return NULL;
-
-    cmd =3D search_dispatch_table(table, cmdname);
-    if (!cmd) {
-        monitor_printf(mon, "unknown command: '%.*s'\n",
-                       (int)(p - cmdp_start), cmdp_start);
-        return NULL;
-    }
-    if (runstate_check(RUN_STATE_PRECONFIG) && !cmd_can_preconfig(cmd)) =
{
-        monitor_printf(mon, "Command '%.*s' not available with -preconfi=
g "
-                            "until after exit_preconfig.\n",
-                       (int)(p - cmdp_start), cmdp_start);
-        return NULL;
-    }
-
-    /* filter out following useless space */
-    while (qemu_isspace(*p)) {
-        p++;
-    }
-
-    *cmdp =3D p;
-    /* search sub command */
-    if (cmd->sub_table !=3D NULL && *p !=3D '\0') {
-        return monitor_parse_command(hmp_mon, cmdp_start, cmdp, cmd->sub=
_table);
-    }
-
-    return cmd;
-}
-
-/*
- * Parse arguments for @cmd.
- * If it can't be parsed, report to @mon, and return NULL.
- * Else, insert command arguments into a QDict, and return it.
- * Note: On success, caller has to free the QDict structure.
- */
-
-static QDict *monitor_parse_arguments(Monitor *mon,
-                                      const char **endp,
-                                      const HMPCommand *cmd)
-{
-    const char *typestr;
-    char *key;
-    int c;
-    const char *p =3D *endp;
-    char buf[1024];
-    QDict *qdict =3D qdict_new();
-
-    /* parse the parameters */
-    typestr =3D cmd->args_type;
-    for(;;) {
-        typestr =3D key_get_info(typestr, &key);
-        if (!typestr)
-            break;
-        c =3D *typestr;
-        typestr++;
-        switch(c) {
-        case 'F':
-        case 'B':
-        case 's':
-            {
-                int ret;
-
-                while (qemu_isspace(*p))
-                    p++;
-                if (*typestr =3D=3D '?') {
-                    typestr++;
-                    if (*p =3D=3D '\0') {
-                        /* no optional string: NULL argument */
-                        break;
-                    }
-                }
-                ret =3D get_str(buf, sizeof(buf), &p);
-                if (ret < 0) {
-                    switch(c) {
-                    case 'F':
-                        monitor_printf(mon, "%s: filename expected\n",
-                                       cmd->name);
-                        break;
-                    case 'B':
-                        monitor_printf(mon, "%s: block device name expec=
ted\n",
-                                       cmd->name);
-                        break;
-                    default:
-                        monitor_printf(mon, "%s: string expected\n", cmd=
->name);
-                        break;
-                    }
-                    goto fail;
-                }
-                qdict_put_str(qdict, key, buf);
-            }
-            break;
-        case 'O':
-            {
-                QemuOptsList *opts_list;
-                QemuOpts *opts;
-
-                opts_list =3D qemu_find_opts(key);
-                if (!opts_list || opts_list->desc->name) {
-                    goto bad_type;
-                }
-                while (qemu_isspace(*p)) {
-                    p++;
-                }
-                if (!*p)
-                    break;
-                if (get_str(buf, sizeof(buf), &p) < 0) {
-                    goto fail;
-                }
-                opts =3D qemu_opts_parse_noisily(opts_list, buf, true);
-                if (!opts) {
-                    goto fail;
-                }
-                qemu_opts_to_qdict(opts, qdict);
-                qemu_opts_del(opts);
-            }
-            break;
-        case '/':
-            {
-                int count, format, size;
-
-                while (qemu_isspace(*p))
-                    p++;
-                if (*p =3D=3D '/') {
-                    /* format found */
-                    p++;
-                    count =3D 1;
-                    if (qemu_isdigit(*p)) {
-                        count =3D 0;
-                        while (qemu_isdigit(*p)) {
-                            count =3D count * 10 + (*p - '0');
-                            p++;
-                        }
-                    }
-                    size =3D -1;
-                    format =3D -1;
-                    for(;;) {
-                        switch(*p) {
-                        case 'o':
-                        case 'd':
-                        case 'u':
-                        case 'x':
-                        case 'i':
-                        case 'c':
-                            format =3D *p++;
-                            break;
-                        case 'b':
-                            size =3D 1;
-                            p++;
-                            break;
-                        case 'h':
-                            size =3D 2;
-                            p++;
-                            break;
-                        case 'w':
-                            size =3D 4;
-                            p++;
-                            break;
-                        case 'g':
-                        case 'L':
-                            size =3D 8;
-                            p++;
-                            break;
-                        default:
-                            goto next;
-                        }
-                    }
-                next:
-                    if (*p !=3D '\0' && !qemu_isspace(*p)) {
-                        monitor_printf(mon, "invalid char in format: '%c=
'\n",
-                                       *p);
-                        goto fail;
-                    }
-                    if (format < 0)
-                        format =3D default_fmt_format;
-                    if (format !=3D 'i') {
-                        /* for 'i', not specifying a size gives -1 as si=
ze */
-                        if (size < 0)
-                            size =3D default_fmt_size;
-                        default_fmt_size =3D size;
-                    }
-                    default_fmt_format =3D format;
-                } else {
-                    count =3D 1;
-                    format =3D default_fmt_format;
-                    if (format !=3D 'i') {
-                        size =3D default_fmt_size;
-                    } else {
-                        size =3D -1;
-                    }
-                }
-                qdict_put_int(qdict, "count", count);
-                qdict_put_int(qdict, "format", format);
-                qdict_put_int(qdict, "size", size);
-            }
-            break;
-        case 'i':
-        case 'l':
-        case 'M':
-            {
-                int64_t val;
-
-                while (qemu_isspace(*p))
-                    p++;
-                if (*typestr =3D=3D '?' || *typestr =3D=3D '.') {
-                    if (*typestr =3D=3D '?') {
-                        if (*p =3D=3D '\0') {
-                            typestr++;
-                            break;
-                        }
-                    } else {
-                        if (*p =3D=3D '.') {
-                            p++;
-                            while (qemu_isspace(*p))
-                                p++;
-                        } else {
-                            typestr++;
-                            break;
-                        }
-                    }
-                    typestr++;
-                }
-                if (get_expr(mon, &val, &p))
-                    goto fail;
-                /* Check if 'i' is greater than 32-bit */
-                if ((c =3D=3D 'i') && ((val >> 32) & 0xffffffff)) {
-                    monitor_printf(mon, "\'%s\' has failed: ", cmd->name=
);
-                    monitor_printf(mon, "integer is for 32-bit values\n"=
);
-                    goto fail;
-                } else if (c =3D=3D 'M') {
-                    if (val < 0) {
-                        monitor_printf(mon, "enter a positive value\n");
-                        goto fail;
-                    }
-                    val *=3D MiB;
-                }
-                qdict_put_int(qdict, key, val);
-            }
-            break;
-        case 'o':
-            {
-                int ret;
-                uint64_t val;
-                const char *end;
-
-                while (qemu_isspace(*p)) {
-                    p++;
-                }
-                if (*typestr =3D=3D '?') {
-                    typestr++;
-                    if (*p =3D=3D '\0') {
-                        break;
-                    }
-                }
-                ret =3D qemu_strtosz_MiB(p, &end, &val);
-                if (ret < 0 || val > INT64_MAX) {
-                    monitor_printf(mon, "invalid size\n");
-                    goto fail;
-                }
-                qdict_put_int(qdict, key, val);
-                p =3D end;
-            }
-            break;
-        case 'T':
-            {
-                double val;
-
-                while (qemu_isspace(*p))
-                    p++;
-                if (*typestr =3D=3D '?') {
-                    typestr++;
-                    if (*p =3D=3D '\0') {
-                        break;
-                    }
-                }
-                if (get_double(mon, &val, &p) < 0) {
-                    goto fail;
-                }
-                if (p[0] && p[1] =3D=3D 's') {
-                    switch (*p) {
-                    case 'm':
-                        val /=3D 1e3; p +=3D 2; break;
-                    case 'u':
-                        val /=3D 1e6; p +=3D 2; break;
-                    case 'n':
-                        val /=3D 1e9; p +=3D 2; break;
-                    }
-                }
-                if (*p && !qemu_isspace(*p)) {
-                    monitor_printf(mon, "Unknown unit suffix\n");
-                    goto fail;
-                }
-                qdict_put(qdict, key, qnum_from_double(val));
-            }
-            break;
-        case 'b':
-            {
-                const char *beg;
-                bool val;
-
-                while (qemu_isspace(*p)) {
-                    p++;
-                }
-                beg =3D p;
-                while (qemu_isgraph(*p)) {
-                    p++;
-                }
-                if (p - beg =3D=3D 2 && !memcmp(beg, "on", p - beg)) {
-                    val =3D true;
-                } else if (p - beg =3D=3D 3 && !memcmp(beg, "off", p - b=
eg)) {
-                    val =3D false;
-                } else {
-                    monitor_printf(mon, "Expected 'on' or 'off'\n");
-                    goto fail;
-                }
-                qdict_put_bool(qdict, key, val);
-            }
-            break;
-        case '-':
-            {
-                const char *tmp =3D p;
-                int skip_key =3D 0;
-                /* option */
-
-                c =3D *typestr++;
-                if (c =3D=3D '\0')
-                    goto bad_type;
-                while (qemu_isspace(*p))
-                    p++;
-                if (*p =3D=3D '-') {
-                    p++;
-                    if(c !=3D *p) {
-                        if(!is_valid_option(p, typestr)) {
-                 =20
-                            monitor_printf(mon, "%s: unsupported option =
-%c\n",
-                                           cmd->name, *p);
-                            goto fail;
-                        } else {
-                            skip_key =3D 1;
-                        }
-                    }
-                    if(skip_key) {
-                        p =3D tmp;
-                    } else {
-                        /* has option */
-                        p++;
-                        qdict_put_bool(qdict, key, true);
-                    }
-                }
-            }
-            break;
-        case 'S':
-            {
-                /* package all remaining string */
-                int len;
-
-                while (qemu_isspace(*p)) {
-                    p++;
-                }
-                if (*typestr =3D=3D '?') {
-                    typestr++;
-                    if (*p =3D=3D '\0') {
-                        /* no remaining string: NULL argument */
-                        break;
-                    }
-                }
-                len =3D strlen(p);
-                if (len <=3D 0) {
-                    monitor_printf(mon, "%s: string expected\n",
-                                   cmd->name);
-                    goto fail;
-                }
-                qdict_put_str(qdict, key, p);
-                p +=3D len;
-            }
-            break;
-        default:
-        bad_type:
-            monitor_printf(mon, "%s: unknown type '%c'\n", cmd->name, c)=
;
-            goto fail;
-        }
-        g_free(key);
-        key =3D NULL;
-    }
-    /* check that all arguments were parsed */
-    while (qemu_isspace(*p))
-        p++;
-    if (*p !=3D '\0') {
-        monitor_printf(mon, "%s: extraneous characters at the end of lin=
e\n",
-                       cmd->name);
-        goto fail;
-    }
-
-    return qdict;
-
-fail:
-    qobject_unref(qdict);
-    g_free(key);
-    return NULL;
-}
-
-static void handle_hmp_command(MonitorHMP *mon, const char *cmdline)
-{
-    QDict *qdict;
-    const HMPCommand *cmd;
-    const char *cmd_start =3D cmdline;
-
-    trace_handle_hmp_command(mon, cmdline);
-
-    cmd =3D monitor_parse_command(mon, cmdline, &cmdline, hmp_cmds);
-    if (!cmd) {
-        return;
-    }
-
-    qdict =3D monitor_parse_arguments(&mon->common, &cmdline, cmd);
-    if (!qdict) {
-        while (cmdline > cmd_start && qemu_isspace(cmdline[-1])) {
-            cmdline--;
-        }
-        monitor_printf(&mon->common, "Try \"help %.*s\" for more informa=
tion\n",
-                       (int)(cmdline - cmd_start), cmd_start);
-        return;
-    }
-
-    cmd->cmd(&mon->common, qdict);
-    qobject_unref(qdict);
-}
-
-static void cmd_completion(MonitorHMP *mon, const char *name, const char=
 *list)
-{
-    const char *p, *pstart;
-    char cmd[128];
-    int len;
-
-    p =3D list;
-    for(;;) {
-        pstart =3D p;
-        p =3D qemu_strchrnul(p, '|');
-        len =3D p - pstart;
-        if (len > sizeof(cmd) - 2)
-            len =3D sizeof(cmd) - 2;
-        memcpy(cmd, pstart, len);
-        cmd[len] =3D '\0';
-        if (name[0] =3D=3D '\0' || !strncmp(name, cmd, strlen(name))) {
-            readline_add_completion(mon->rs, cmd);
-        }
-        if (*p =3D=3D '\0')
-            break;
-        p++;
-    }
-}
-
-static void file_completion(MonitorHMP *mon, const char *input)
-{
-    DIR *ffs;
-    struct dirent *d;
-    char path[1024];
-    char file[1024], file_prefix[1024];
-    int input_path_len;
-    const char *p;
-
-    p =3D strrchr(input, '/');
-    if (!p) {
-        input_path_len =3D 0;
-        pstrcpy(file_prefix, sizeof(file_prefix), input);
-        pstrcpy(path, sizeof(path), ".");
-    } else {
-        input_path_len =3D p - input + 1;
-        memcpy(path, input, input_path_len);
-        if (input_path_len > sizeof(path) - 1)
-            input_path_len =3D sizeof(path) - 1;
-        path[input_path_len] =3D '\0';
-        pstrcpy(file_prefix, sizeof(file_prefix), p + 1);
-    }
-
-    ffs =3D opendir(path);
-    if (!ffs)
-        return;
-    for(;;) {
-        struct stat sb;
-        d =3D readdir(ffs);
-        if (!d)
-            break;
-
-        if (strcmp(d->d_name, ".") =3D=3D 0 || strcmp(d->d_name, "..") =3D=
=3D 0) {
-            continue;
-        }
-
-        if (strstart(d->d_name, file_prefix, NULL)) {
-            memcpy(file, input, input_path_len);
-            if (input_path_len < sizeof(file))
-                pstrcpy(file + input_path_len, sizeof(file) - input_path=
_len,
-                        d->d_name);
-            /* stat the file to find out if it's a directory.
-             * In that case add a slash to speed up typing long paths
-             */
-            if (stat(file, &sb) =3D=3D 0 && S_ISDIR(sb.st_mode)) {
-                pstrcat(file, sizeof(file), "/");
-            }
-            readline_add_completion(mon->rs, file);
-        }
-    }
-    closedir(ffs);
-}
-
-static const char *next_arg_type(const char *typestr)
-{
-    const char *p =3D strchr(typestr, ':');
-    return (p !=3D NULL ? ++p : typestr);
-}
-
 static void add_completion_option(ReadLineState *rs, const char *str,
                                   const char *option)
 {
@@ -3829,127 +2742,6 @@ void loadvm_completion(ReadLineState *rs, int nb_=
args, const char *str)
     }
 }
=20
-static void monitor_find_completion_by_table(MonitorHMP *mon,
-                                             const HMPCommand *cmd_table=
,
-                                             char **args,
-                                             int nb_args)
-{
-    const char *cmdname;
-    int i;
-    const char *ptype, *old_ptype, *str, *name;
-    const HMPCommand *cmd;
-    BlockBackend *blk =3D NULL;
-
-    if (nb_args <=3D 1) {
-        /* command completion */
-        if (nb_args =3D=3D 0)
-            cmdname =3D "";
-        else
-            cmdname =3D args[0];
-        readline_set_completion_index(mon->rs, strlen(cmdname));
-        for (cmd =3D cmd_table; cmd->name !=3D NULL; cmd++) {
-            if (!runstate_check(RUN_STATE_PRECONFIG) ||
-                 cmd_can_preconfig(cmd)) {
-                cmd_completion(mon, cmdname, cmd->name);
-            }
-        }
-    } else {
-        /* find the command */
-        for (cmd =3D cmd_table; cmd->name !=3D NULL; cmd++) {
-            if (compare_cmd(args[0], cmd->name) &&
-                (!runstate_check(RUN_STATE_PRECONFIG) ||
-                 cmd_can_preconfig(cmd))) {
-                break;
-            }
-        }
-        if (!cmd->name) {
-            return;
-        }
-
-        if (cmd->sub_table) {
-            /* do the job again */
-            monitor_find_completion_by_table(mon, cmd->sub_table,
-                                             &args[1], nb_args - 1);
-            return;
-        }
-        if (cmd->command_completion) {
-            cmd->command_completion(mon->rs, nb_args, args[nb_args - 1])=
;
-            return;
-        }
-
-        ptype =3D next_arg_type(cmd->args_type);
-        for(i =3D 0; i < nb_args - 2; i++) {
-            if (*ptype !=3D '\0') {
-                ptype =3D next_arg_type(ptype);
-                while (*ptype =3D=3D '?')
-                    ptype =3D next_arg_type(ptype);
-            }
-        }
-        str =3D args[nb_args - 1];
-        old_ptype =3D NULL;
-        while (*ptype =3D=3D '-' && old_ptype !=3D ptype) {
-            old_ptype =3D ptype;
-            ptype =3D next_arg_type(ptype);
-        }
-        switch(*ptype) {
-        case 'F':
-            /* file completion */
-            readline_set_completion_index(mon->rs, strlen(str));
-            file_completion(mon, str);
-            break;
-        case 'B':
-            /* block device name completion */
-            readline_set_completion_index(mon->rs, strlen(str));
-            while ((blk =3D blk_next(blk)) !=3D NULL) {
-                name =3D blk_name(blk);
-                if (str[0] =3D=3D '\0' ||
-                    !strncmp(name, str, strlen(str))) {
-                    readline_add_completion(mon->rs, name);
-                }
-            }
-            break;
-        case 's':
-        case 'S':
-            if (!strcmp(cmd->name, "help|?")) {
-                monitor_find_completion_by_table(mon, cmd_table,
-                                                 &args[1], nb_args - 1);
-            }
-            break;
-        default:
-            break;
-        }
-    }
-}
-
-static void monitor_find_completion(void *opaque,
-                                    const char *cmdline)
-{
-    MonitorHMP *mon =3D opaque;
-    char *args[MAX_ARGS];
-    int nb_args, len;
-
-    /* 1. parse the cmdline */
-    if (parse_cmdline(cmdline, &nb_args, args) < 0) {
-        return;
-    }
-
-    /* if the line ends with a space, it means we want to complete the
-       next arg */
-    len =3D strlen(cmdline);
-    if (len > 0 && qemu_isspace(cmdline[len - 1])) {
-        if (nb_args >=3D MAX_ARGS) {
-            goto cleanup;
-        }
-        args[nb_args++] =3D g_strdup("");
-    }
-
-    /* 2. auto complete according to args */
-    monitor_find_completion_by_table(mon, hmp_cmds, args, nb_args);
-
-cleanup:
-    free_cmdline_args(args, nb_args);
-}
-
 int monitor_can_read(void *opaque)
 {
     Monitor *mon =3D opaque;
@@ -3957,38 +2749,6 @@ int monitor_can_read(void *opaque)
     return !atomic_mb_read(&mon->suspend_cnt);
 }
=20
-static void monitor_read(void *opaque, const uint8_t *buf, int size)
-{
-    MonitorHMP *mon;
-    Monitor *old_mon =3D cur_mon;
-    int i;
-
-    cur_mon =3D opaque;
-    mon =3D container_of(cur_mon, MonitorHMP, common);
-
-    if (mon->rs) {
-        for (i =3D 0; i < size; i++)
-            readline_handle_byte(mon->rs, buf[i]);
-    } else {
-        if (size =3D=3D 0 || buf[size - 1] !=3D 0)
-            monitor_printf(cur_mon, "corrupted command\n");
-        else
-            handle_hmp_command(mon, (char *)buf);
-    }
-
-    cur_mon =3D old_mon;
-}
-
-static void monitor_command_cb(void *opaque, const char *cmdline,
-                               void *readline_opaque)
-{
-    MonitorHMP *mon =3D opaque;
-
-    monitor_suspend(&mon->common);
-    handle_hmp_command(mon, cmdline);
-    monitor_resume(&mon->common);
-}
-
 int monitor_suspend(Monitor *mon)
 {
     if (monitor_is_hmp_non_interactive(mon)) {
@@ -4043,58 +2803,6 @@ void monitor_resume(Monitor *mon)
     trace_monitor_suspend(mon, -1);
 }
=20
-static void monitor_event(void *opaque, int event)
-{
-    Monitor *mon =3D opaque;
-    MonitorHMP *hmp_mon =3D container_of(mon, MonitorHMP, common);
-
-    switch (event) {
-    case CHR_EVENT_MUX_IN:
-        qemu_mutex_lock(&mon->mon_lock);
-        mon->mux_out =3D 0;
-        qemu_mutex_unlock(&mon->mon_lock);
-        if (mon->reset_seen) {
-            readline_restart(hmp_mon->rs);
-            monitor_resume(mon);
-            monitor_flush(mon);
-        } else {
-            atomic_mb_set(&mon->suspend_cnt, 0);
-        }
-        break;
-
-    case CHR_EVENT_MUX_OUT:
-        if (mon->reset_seen) {
-            if (atomic_mb_read(&mon->suspend_cnt) =3D=3D 0) {
-                monitor_printf(mon, "\n");
-            }
-            monitor_flush(mon);
-            monitor_suspend(mon);
-        } else {
-            atomic_inc(&mon->suspend_cnt);
-        }
-        qemu_mutex_lock(&mon->mon_lock);
-        mon->mux_out =3D 1;
-        qemu_mutex_unlock(&mon->mon_lock);
-        break;
-
-    case CHR_EVENT_OPENED:
-        monitor_printf(mon, "QEMU %s monitor - type 'help' for more "
-                       "information\n", QEMU_VERSION);
-        if (!mon->mux_out) {
-            readline_restart(hmp_mon->rs);
-            readline_show_prompt(hmp_mon->rs);
-        }
-        mon->reset_seen =3D 1;
-        mon_refcount++;
-        break;
-
-    case CHR_EVENT_CLOSED:
-        mon_refcount--;
-        monitor_fdsets_cleanup();
-        break;
-    }
-}
-
 static int
 compare_mon_cmd(const void *a, const void *b)
 {
@@ -4137,25 +2845,6 @@ void monitor_init_globals(void)
                                    NULL);
 }
=20
-/* These functions just adapt the readline interface in a typesafe way. =
 We
- * could cast function pointers but that discards compiler checks.
- */
-static void GCC_FMT_ATTR(2, 3) monitor_readline_printf(void *opaque,
-                                                       const char *fmt, =
...)
-{
-    MonitorHMP *mon =3D opaque;
-    va_list ap;
-    va_start(ap, fmt);
-    monitor_vprintf(&mon->common, fmt, ap);
-    va_end(ap);
-}
-
-static void monitor_readline_flush(void *opaque)
-{
-    MonitorHMP *mon =3D opaque;
-    monitor_flush(&mon->common);
-}
-
 /*
  * Print to current monitor if we have one, else to stderr.
  */
@@ -4198,27 +2887,6 @@ void monitor_list_append(Monitor *mon)
     }
 }
=20
-static void monitor_init_hmp(Chardev *chr, int flags)
-{
-    MonitorHMP *mon =3D g_malloc0(sizeof(*mon));
-    bool use_readline =3D flags & MONITOR_USE_READLINE;
-
-    monitor_data_init(&mon->common, flags, false, false);
-    qemu_chr_fe_init(&mon->common.chr, chr, &error_abort);
-
-    if (use_readline) {
-        mon->rs =3D readline_init(monitor_readline_printf,
-                                monitor_readline_flush,
-                                mon,
-                                monitor_find_completion);
-        monitor_read_command(mon, 0);
-    }
-
-    qemu_chr_fe_set_handlers(&mon->common.chr, monitor_can_read, monitor=
_read,
-                             monitor_event, NULL, &mon->common, NULL, tr=
ue);
-    monitor_list_append(&mon->common);
-}
-
 void monitor_init(Chardev *chr, int flags)
 {
     if (flags & MONITOR_USE_CONTROL) {
diff --git a/monitor/Makefile.objs b/monitor/Makefile.objs
index 1037c09ff8..bea8838acc 100644
--- a/monitor/Makefile.objs
+++ b/monitor/Makefile.objs
@@ -1,3 +1,3 @@
 obj-y +=3D misc.o
-common-obj-y +=3D qmp.o
+common-obj-y +=3D qmp.o hmp.o
 common-obj-y +=3D qmp-cmds.o hmp-cmds.o
diff --git a/monitor/trace-events b/monitor/trace-events
index a06dde3fd3..2285d26121 100644
--- a/monitor/trace-events
+++ b/monitor/trace-events
@@ -1,10 +1,12 @@
 # See docs/devel/tracing.txt for syntax documentation.
=20
+# hmp.c
+handle_hmp_command(void *mon, const char *cmdline) "mon %p cmdline: %s"
+
 # misc.c
 monitor_protocol_event_handler(uint32_t event, void *qdict) "event=3D%d =
data=3D%p"
 monitor_protocol_event_emit(uint32_t event, void *data) "event=3D%d data=
=3D%p"
 monitor_protocol_event_queue(uint32_t event, void *qdict, uint64_t rate)=
 "event=3D%d data=3D%p rate=3D%" PRId64
-handle_hmp_command(void *mon, const char *cmdline) "mon %p cmdline: %s"
 monitor_suspend(void *ptr, int cnt) "mon %p: %d"
=20
 # qmp.c
--=20
2.20.1


