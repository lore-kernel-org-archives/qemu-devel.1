Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02927C2D0EF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 05:21:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C24872076A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 05:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JnVW4yya"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C24872076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOwyI-0007nR-Tr
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 01:21:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54346)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <coiby.xu@gmail.com>) id 1jOwxW-0007NI-US
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 01:21:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <coiby.xu@gmail.com>) id 1jOwxV-0006B8-Jj
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 01:21:06 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:44015)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <coiby.xu@gmail.com>)
 id 1jOwxS-00062t-GE; Thu, 16 Apr 2020 01:21:02 -0400
Received: by mail-pf1-x442.google.com with SMTP id u9so1139699pfm.10;
 Wed, 15 Apr 2020 22:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:date:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=dZOgxOgb08SABN/jOg9112JFKL+OCsOS5OOF/mckrDc=;
 b=JnVW4yyaNtEvcYb5/hQ7N0j/CsnkzOD8YOL+kvcG49l6xyiDdniiFCowmNPAZXij+O
 a/RJiPi9vGDADu3ioJQEHEKmRQZnm04Gh9Kpwz1HI4bzjjRtZFwkDUjoSuDsD5H3LvQu
 aQy6+7cY212t4BAiUZcjMQOvusL/CQAxtQK93UL/6NhZtY9UiMcMxeUoNebxAg9U9PFB
 a1rq6BdSqPdV7wGI17MOjTeoAGzXu5vCvCeMOYC4C2TYjbhwViNz372TGtyWQoZ25E33
 orRjzSnrCk9qhPk9JA7elbVW62HY11azu7J9OBLfSWdDGh9Ls83B0MJeWlyXs0Dgh9mi
 O2Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=dZOgxOgb08SABN/jOg9112JFKL+OCsOS5OOF/mckrDc=;
 b=cHekQiZSny5N5BlLfZVllGQKC20anbN2YkyP0Hb1UzR1z5u37FNOb5zW7b+ODVwfSJ
 J6rPjp9nOTK3jA+lujdd6itE7D/nDMPNgHTMXgomEDEsssjWh4l+ComDAwbwCxpZZMEy
 MKVCXXv+vVS6XQHjZXsceOJdd8lLqV1woKVb9woTsQqA8f/oP8IZ5HxKag/FtUo1/YfH
 P2YUDLZofP7+lldqr405EtXyyJHBs9MrE+qvPs/G9RM+82YpHn8jMvKE6YauIanecnP+
 SCtM0jyuOHu/yt+uVj0AsqUSM6vbAwJUoRFXXUVAvtTNTpFgQdgyp8nEoeknayeIe+e0
 5YFA==
X-Gm-Message-State: AGi0PuZwufJTErNMl6LFhLmpBnaeiPNDG4/tOWWd8YoFs+7HQikL0wXY
 vs/xougzVKboEP30oIFfbb0=
X-Google-Smtp-Source: APiQypIaBh+iPntOA67tS1RHw7VARWKxh0fJPEBJXwW0vugge+qGLD+TWw8rjQkxEYnXOz15DBSF2w==
X-Received: by 2002:a65:5606:: with SMTP id l6mr26867107pgs.446.1587014460817; 
 Wed, 15 Apr 2020 22:21:00 -0700 (PDT)
Received: from localhost ([2001:e42:102:1532:160:16:113:140])
 by smtp.gmail.com with ESMTPSA id x27sm15774262pfj.74.2020.04.15.22.20.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2020 22:20:59 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date: Thu, 16 Apr 2020 13:20:56 +0800
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v2 08/20] qemu-storage-daemon: Add --object option
Message-ID: <20200416052056.7l5ohyn73pjsivur@r>
References: <20200224143008.13362-1-kwolf@redhat.com>
 <20200224143008.13362-9-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200224143008.13362-9-kwolf@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 stefanha@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Kevin,

I tried to start vhost-user block device backend server with the
following command,
   $ qemu-storage-daemon --blockdev driver=file,node-name=disk,filename=file.img,read-only=off \
                   --object vhost-user-blk-server,id=disk,unix-socket=/tmp/vu_blk.socket,node-name=disk,writable=off

but the following error occurred,

   qemu-storage-daemon: Invalid parameter type for 'writable', expected: boolean

I notice qmp_object_add is used. Should we use user_creatable_add_opts
instead?

diff --git a/qemu-storage-daemon.c b/qemu-storage-daemon.c
index dd128978cc..9d21aaaf54 100644
--- a/qemu-storage-daemon.c
+++ b/qemu-storage-daemon.c
@@ -277,8 +277,6 @@ static void process_options(int argc, char *argv[])
              {
                  QemuOpts *opts;
                  const char *type;
-                QDict *args;
-                QObject *ret_data = NULL;

                  /* FIXME The keyval parser rejects 'help' arguments, so we must
                   * unconditionall try QemuOpts first. */
@@ -288,12 +286,11 @@ static void process_options(int argc, char *argv[])
                  if (type && user_creatable_print_help(type, opts)) {
                      exit(EXIT_SUCCESS);
                  }
+
+
+                user_creatable_add_opts(opts, &error_fatal);
                  qemu_opts_del(opts);

-                args = keyval_parse(optarg, "qom-type", &error_fatal);
-                qmp_object_add(args, &ret_data, &error_fatal);
-                qobject_unref(args);
-                qobject_unref(ret_data);
                  break;
              }
          default:

On Mon, Feb 24, 2020 at 03:29:56PM +0100, Kevin Wolf wrote:
>Add a command line option to create user-creatable QOM objects.
>
>Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>---
> qemu-storage-daemon.c | 47 +++++++++++++++++++++++++++++++++++++++++++
> Makefile.objs         |  2 +-
> qom/Makefile.objs     |  1 +
> 3 files changed, 49 insertions(+), 1 deletion(-)
>
>diff --git a/qemu-storage-daemon.c b/qemu-storage-daemon.c
>index c30caaf59e..0cd8144c81 100644
>--- a/qemu-storage-daemon.c
>+++ b/qemu-storage-daemon.c
>@@ -33,15 +33,19 @@
> #include "qapi/error.h"
> #include "qapi/qapi-visit-block-core.h"
> #include "qapi/qapi-commands-block-core.h"
>+#include "qapi/qmp/qdict.h"
> #include "qapi/qobject-input-visitor.h"
>
> #include "qemu-common.h"
> #include "qemu-version.h"
> #include "qemu/config-file.h"
> #include "qemu/error-report.h"
>+#include "qemu/help_option.h"
> #include "qemu/log.h"
> #include "qemu/main-loop.h"
> #include "qemu/module.h"
>+#include "qemu/option.h"
>+#include "qom/object_interfaces.h"
>
> #include "trace/control.h"
>
>@@ -63,12 +67,31 @@ static void help(void)
> "             [,driver specific parameters...]\n"
> "                         configure a block backend\n"
> "\n"
>+"  --object help          list object types that can be added\n"
>+"  --object <type>,help   list properties for the given object type\n"
>+"  --object <type>[,<property>=<value>...]\n"
>+"                         create a new object of type <type>, setting\n"
>+"                         properties in the order they are specified. Note\n"
>+"                         that the 'id' property must be set.\n"
>+"                         See the qemu(1) man page for documentation of the\n"
>+"                         objects that can be added.\n"
>+"\n"
> QEMU_HELP_BOTTOM "\n",
>     error_get_progname());
> }
>
> enum {
>     OPTION_BLOCKDEV = 256,
>+    OPTION_OBJECT,
>+};
>+
>+static QemuOptsList qemu_object_opts = {
>+    .name = "object",
>+    .implied_opt_name = "qom-type",
>+    .head = QTAILQ_HEAD_INITIALIZER(qemu_object_opts.head),
>+    .desc = {
>+        { }
>+    },
> };
>
> static void process_options(int argc, char *argv[])
>@@ -78,6 +101,7 @@ static void process_options(int argc, char *argv[])
>     static const struct option long_options[] = {
>         {"blockdev", required_argument, NULL, OPTION_BLOCKDEV},
>         {"help", no_argument, NULL, 'h'},
>+        {"object", required_argument, NULL, OPTION_OBJECT},
>         {"trace", required_argument, NULL, 'T'},
>         {"version", no_argument, NULL, 'V'},
>         {0, 0, 0, 0}
>@@ -121,6 +145,29 @@ static void process_options(int argc, char *argv[])
>                 qapi_free_BlockdevOptions(options);
>                 break;
>             }
>+        case OPTION_OBJECT:
>+            {
>+                QemuOpts *opts;
>+                const char *type;
>+                QDict *args;
>+                QObject *ret_data = NULL;
>+
>+                /* FIXME The keyval parser rejects 'help' arguments, so we must
>+                 * unconditionall try QemuOpts first. */
>+                opts = qemu_opts_parse(&qemu_object_opts,
>+                                       optarg, true, &error_fatal);
>+                type = qemu_opt_get(opts, "qom-type");
>+                if (type && user_creatable_print_help(type, opts)) {
>+                    exit(EXIT_SUCCESS);
>+                }
>+                qemu_opts_del(opts);
>+
>+                args = keyval_parse(optarg, "qom-type", &error_fatal);
>+                qmp_object_add(args, &ret_data, &error_fatal);
>+                qobject_unref(args);
>+                qobject_unref(ret_data);
>+                break;
>+            }
>         default:
>             g_assert_not_reached();
>         }
>diff --git a/Makefile.objs b/Makefile.objs
>index c7e1b36130..fa92b00427 100644
>--- a/Makefile.objs
>+++ b/Makefile.objs
>@@ -31,7 +31,7 @@ endif # CONFIG_SOFTMMU or CONFIG_TOOLS
> # storage-daemon-obj-y is code used by qemu-storage-daemon (these objects are
> # used for system emulation, too, but specified separately there)
>
>-storage-daemon-obj-y = block/
>+storage-daemon-obj-y = block/ qom/
> storage-daemon-obj-y += blockdev.o iothread.o
>
> ######################################################################
>diff --git a/qom/Makefile.objs b/qom/Makefile.objs
>index f9d77350ac..1b45d104ba 100644
>--- a/qom/Makefile.objs
>+++ b/qom/Makefile.objs
>@@ -2,3 +2,4 @@ qom-obj-y = object.o container.o qom-qobject.o
> qom-obj-y += object_interfaces.o
>
> common-obj-$(CONFIG_SOFTMMU) += qom-hmp-cmds.o qom-qmp-cmds.o
>+storage-daemon-obj-y += qom-qmp-cmds.o
>--
>2.20.1
>

