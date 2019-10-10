Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17B4C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 08:18:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E6D6208C3
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 08:18:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E6D6208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iITe8-0000qq-8K
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 04:18:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56368)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@pond.sub.org>) id 1iITch-0000A8-EC
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 04:16:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@pond.sub.org>) id 1iITce-00027v-EY
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 04:16:35 -0400
Received: from oxygen.pond.sub.org ([2a01:4f8:13b:3ad0:1::3]:40064)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@pond.sub.org>)
 id 1iITcd-00027N-Eq; Thu, 10 Oct 2019 04:16:32 -0400
Received: from blackfin.pond.sub.org (p5DCDBB4B.dip0.t-ipconnect.de
 [93.205.187.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by oxygen.pond.sub.org (Postfix) with ESMTPSA id 718494A7B3;
 Thu, 10 Oct 2019 10:16:28 +0200 (CEST)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 16E941138619; Thu, 10 Oct 2019 10:16:28 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Mario Smarduch <msmarduch@digitalocean.com>
Subject: Re: [PATCHv2 1/2] util/qemu-error: add guest name helper with -msg
 options
References: <20191009164459.8209-1-msmarduch@digitalocean.com>
 <20191009164459.8209-2-msmarduch@digitalocean.com>
Date: Thu, 10 Oct 2019 10:16:28 +0200
Message-ID: <87y2xtt3qb.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:4f8:13b:3ad0:1::3
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
Cc: ehabkost@redhat.com, qemu-trivial@nongnu.org, mtosatti@redhat.com,
 qemu-devel@nongnu.org, pbonzini@redhat.com, philmd@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I don't think merging this via qemu-trivial is a good idea.  First, it's
not sufficiently trivial, as we shall see below.  Second, the code in
question has a maintainer willing to review and merge patches: me.  I
can't always review as quickly as we all would like; sorry about that.

Mario Smarduch <msmarduch@digitalocean.com> writes:

> This patch adds an option to enable/disable printing lead guest name in
> logging messages.

Why is that useful?  Remember, the commit message is how you pitch your
patch to the maintainers :)

> A '-msg name=on|off' allows to turn on, off guest name logging.
>
> If guest name is not set disabling this makes sense.
>
> Verified with all combinations of 
>   '-msg timestamp=yes|no,name=yes|no.

Information on how you tested are welcome.  I'd put that ...

> Signed-off-by: Mario Smarduch <msmarduch@digitalocean.com>
> ---

... below the --- line, since there's no need to record it for
posterity.

>  include/qemu/error-report.h |  1 +
>  qemu-options.hx             | 10 ++++++----
>  util/qemu-error.c           | 31 +++++++++++++++++++++++++++++++
>  vl.c                        |  5 +++++
>  4 files changed, 43 insertions(+), 4 deletions(-)
>
> diff --git a/include/qemu/error-report.h b/include/qemu/error-report.h
> index 00d069b..9b44a06 100644
> --- a/include/qemu/error-report.h
> +++ b/include/qemu/error-report.h
> @@ -74,5 +74,6 @@ void error_init(const char *argv0);
>  
>  const char *error_get_progname(void);
>  extern bool enable_timestamp_msg;
> +extern bool enable_guestname_msg;
>  
>  #endif
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 2a04ca6..6066001 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4164,14 +4164,16 @@ HXCOMM Deprecated by -accel tcg
>  DEF("no-kvm", 0, QEMU_OPTION_no_kvm, "", QEMU_ARCH_I386)
>  
>  DEF("msg", HAS_ARG, QEMU_OPTION_msg,
> -    "-msg timestamp[=on|off]\n"
> +    "-msg [timestamp=on|off][name=on|off]\n"

Name of what?  Let's call it "guest-name".

>      "                change the format of messages\n"
> -    "                on|off controls leading timestamps (default:on)\n",
> +    "                timestamp=on|off controls leading timestamps (default: on)\n"
> +    "                name=on|off controls leading guest name (default: off)\n",
>      QEMU_ARCH_ALL)
>  STEXI
> -@item -msg timestamp[=on|off]
> +@item -msg timestamp=on|off
> +@item -msg name=on|off
>  @findex -msg
> -prepend a timestamp to each log message.(default:on)
> +Prepend additional information to each log message
>  ETEXI

Preexisting: "log message" isn't quite right.  This isn't about logging,
it's about error messages.  Related to logging only because the software
layer above QEMU typically captures and logs them.

Your patch loses the explanation of what timestamp=on does, and its
default value.  Remember, this is the manual, and the text in DEF() is
*not* visible here.

It also incorrectly suggests you can have either timestamp or name, but
not both.

Better:

   STEXI
   @item -msg [guest-name[=on|off]][,timestamp[=on|off]]
   @findex -msg
   Control error message format.
   @table @option
   @item guest-name=on|off
   Prefix messages with the guest name.  Default is off.
   @item timestamp=on|off
   Prefix messages with a timestamp.  Default is off.
   @end table
   ETEXI

>  
>  DEF("dump-vmstate", HAS_ARG, QEMU_OPTION_dump_vmstate,
> diff --git a/util/qemu-error.c b/util/qemu-error.c
> index f373f3b..8ece7b2 100644
> --- a/util/qemu-error.c
> +++ b/util/qemu-error.c
> @@ -11,6 +11,8 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/option.h"
> +#include "qemu/config-file.h"
>  #include "monitor/monitor.h"
>  #include "qemu/error-report.h"
>  
> @@ -192,6 +194,8 @@ static void print_loc(void)
>  }
>  
>  bool enable_timestamp_msg;
> +bool enable_guestname_msg;
> +
>  /*
>   * Print a message to current monitor if we have one, else to stderr.
>   * @report_type is the type of message: error, warning or informational.
> @@ -228,6 +232,27 @@ static void vreport(report_type type, const char *fmt, va_list ap)
>      error_printf("\n");
>  }
>  
> +static const char *error_get_guestname(void)
> +{
> +    QemuOpts *opts = qemu_opts_find(qemu_find_opts("name"), NULL);
> +    return qemu_opt_get(opts, "guest");
> +}
> +
> +/*
> + * Also print the guest name, handy if we log to a server.
> + */
> +static void error_print_guestname(void)
> +{
> +    const char *name;
> +
> +    if (enable_guestname_msg) {
> +        name = error_get_guestname();
> +        if (name && !cur_mon) {
> +            error_printf("Guest [%s] ", name);

Looks a bit ornate.  For instance:

    $ qemu-system-x86_64 -name frob --msg timestamp,name bad.img
    Guest [frob] 2019-10-10T07:13:15.135641Z qemu-system-x86_64: bad.img: Could not open 'bad.img': No such file or directory

Any particular reason for "Guest [%s] " instead of plain "%s "?

If the guest name is not set, -msg name=on gets silently ignored.
Shouldn't we reject it instead?

> +        }
> +    }
> +}
> +
>  /*
>   * Print an error message to current monitor if we have one, else to stderr.
>   * Format arguments like vsprintf().  The resulting message should be
> @@ -237,6 +262,7 @@ static void vreport(report_type type, const char *fmt, va_list ap)
>   */
>  void error_vreport(const char *fmt, va_list ap)
>  {
> +    error_print_guestname();
>      vreport(REPORT_TYPE_ERROR, fmt, ap);
>  }
>  
> @@ -248,6 +274,7 @@ void error_vreport(const char *fmt, va_list ap)
>   */
>  void warn_vreport(const char *fmt, va_list ap)
>  {
> +    error_print_guestname();
>      vreport(REPORT_TYPE_WARNING, fmt, ap);
>  }
>  
> @@ -274,6 +301,7 @@ void error_report(const char *fmt, ...)
>  {
>      va_list ap;
>  
> +    error_print_guestname();
>      va_start(ap, fmt);
>      vreport(REPORT_TYPE_ERROR, fmt, ap);
>      va_end(ap);
> @@ -289,6 +317,7 @@ void warn_report(const char *fmt, ...)
>  {
>      va_list ap;
>  
> +    error_print_guestname();
>      va_start(ap, fmt);
>      vreport(REPORT_TYPE_WARNING, fmt, ap);
>      va_end(ap);
> @@ -324,6 +353,7 @@ bool error_report_once_cond(bool *printed, const char *fmt, ...)
>          return false;
>      }
>      *printed = true;
> +    error_print_guestname();
>      va_start(ap, fmt);
>      vreport(REPORT_TYPE_ERROR, fmt, ap);
>      va_end(ap);
> @@ -344,6 +374,7 @@ bool warn_report_once_cond(bool *printed, const char *fmt, ...)
>          return false;
>      }
>      *printed = true;
> +    error_print_guestname();
>      va_start(ap, fmt);
>      vreport(REPORT_TYPE_WARNING, fmt, ap);
>      va_end(ap);

This doesn't look right.  What's wrong with printing the name right
where we already print the timestamp, in vreport()?

> diff --git a/vl.c b/vl.c
> index 002bf49..024bdc6 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -417,6 +417,10 @@ static QemuOptsList qemu_msg_opts = {
>              .name = "timestamp",
>              .type = QEMU_OPT_BOOL,
>          },
> +        {
> +            .name = "name",
> +            .type = QEMU_OPT_BOOL,
> +        },
>          { /* end of list */ }
>      },
>  };
> @@ -1263,6 +1267,7 @@ static void realtime_init(void)
>  static void configure_msg(QemuOpts *opts)
>  {
>      enable_timestamp_msg = qemu_opt_get_bool(opts, "timestamp", true);
> +    enable_guestname_msg = qemu_opt_get_bool(opts, "name", false);
>  }

We store -msg parameter "timestamp" in enable_timestamp_msg so vreport()
doesn't have to retrieve it all the time.

You do the same for parameter "name", but you still retrieve -name
parameter "guest" all the time.  Misses the point, I'm afraid :)

I append a revised patch to illustrate what I mean.


From 487d50757336125560a06141c4af2f565bdc3c16 Mon Sep 17 00:00:00 2001
From: Mario Smarduch <msmarduch@digitalocean.com>
Date: Wed, 9 Oct 2019 09:44:58 -0700
Subject: [RFC PATCH] error: New -msg guest-name to include guest name in
 messages

TODO why is that useful?

Looks like this:

    $ qemu-system-x86_64 --msg name=on,timestamp=on bad.img
    2019-10-10T08:02:45.905913Z qemu-system-x86_64: bad.img: Could not open 'bad.img': No such file or directory

Signed-off-by: Mario Smarduch <msmarduch@digitalocean.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qemu/error-report.h |  1 +
 util/qemu-error.c           |  7 +++++++
 vl.c                        | 10 ++++++++++
 qemu-options.hx             |  7 +++++--
 4 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/include/qemu/error-report.h b/include/qemu/error-report.h
index 87532d8596..50b3587a05 100644
--- a/include/qemu/error-report.h
+++ b/include/qemu/error-report.h
@@ -74,6 +74,7 @@ void error_init(const char *argv0);
 
 const char *error_get_progname(void);
 
+extern const char *error_guest_name;
 extern bool error_with_timestamp;
 
 #endif
diff --git a/util/qemu-error.c b/util/qemu-error.c
index dac7c7dc50..c5d00d57d5 100644
--- a/util/qemu-error.c
+++ b/util/qemu-error.c
@@ -24,6 +24,9 @@ typedef enum {
     REPORT_TYPE_INFO,
 } report_type;
 
+/* Prepend guest name to messages */
+const char *error_guest_name;
+
 /* Prepend timestamp to messages */
 bool error_with_timestamp;
 
@@ -206,6 +209,10 @@ static void vreport(report_type type, const char *fmt, va_list ap)
     GTimeVal tv;
     gchar *timestr;
 
+    if (error_guest_name && !cur_mon) {
+        error_printf("%s ", error_guest_name);
+    }
+
     if (error_with_timestamp && !cur_mon) {
         g_get_current_time(&tv);
         timestr = g_time_val_to_iso8601(&tv);
diff --git a/vl.c b/vl.c
index b8e4c11f02..26974e2b79 100644
--- a/vl.c
+++ b/vl.c
@@ -417,6 +417,10 @@ static QemuOptsList qemu_msg_opts = {
             .name = "timestamp",
             .type = QEMU_OPT_BOOL,
         },
+        {
+            .name = "guest-name",
+            .type = QEMU_OPT_BOOL,
+        },
         { /* end of list */ }
     },
 };
@@ -1262,6 +1266,12 @@ static void realtime_init(void)
 
 static void configure_msg(QemuOpts *opts)
 {
+    if (qemu_opt_get_bool(opts, "guest-name", false)) {
+        error_guest_name = qemu_opt_get(qemu_opts_find(qemu_find_opts("name"),
+                                                       NULL),
+                                        "guest");
+    }
+
     error_with_timestamp = qemu_opt_get_bool(opts, "timestamp", false);
 }
 
diff --git a/qemu-options.hx b/qemu-options.hx
index 158244da0f..6cd402db74 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4164,15 +4164,18 @@ HXCOMM Deprecated by -accel tcg
 DEF("no-kvm", 0, QEMU_OPTION_no_kvm, "", QEMU_ARCH_I386)
 
 DEF("msg", HAS_ARG, QEMU_OPTION_msg,
-    "-msg timestamp[=on|off]\n"
+    "-msg [guest-name[=on|off]][,timestamp[=on|off]]\n"
     "                control error message format\n"
+    "                guest-name=on includes the guest name (default: off)\n"
     "                timestamp=on enables timestamps (default: off)\n",
     QEMU_ARCH_ALL)
 STEXI
-@item -msg timestamp[=on|off]
+@item -msg [guest-name[=on|off]][,timestamp[=on|off]]
 @findex -msg
 Control error message format.
 @table @option
+@item guest-name=on|off
+Prefix messages with the guest name.  Default is off.
 @item timestamp=on|off
 Prefix messages with a timestamp.  Default is off.
 @end table
-- 
2.21.0


