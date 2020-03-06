Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBB6C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:31:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A88A22051A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Anm25XWz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A88A22051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAGot-0004XX-Oa
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 12:31:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48860)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jAGZc-0005BC-FD
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jAGZZ-0008Lt-MX
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:44 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44375
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jAGZZ-0008Ka-GA
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583514941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sByuPQu8tf0E78pwh2F877wIZuRaSQbvuW4w6ZxbEyM=;
 b=Anm25XWzDa+93b+X1GZcI/4rDqdPqvLDpSn84kMMGXKp1oKnbmKYsoZIP8Oz5Lou3CQjtH
 5JHrh7SuzrRaRIlesNGhlnP6BBJO4VdrhqYaIjfXbxvzCYWEnbkcoIeL95/jsITetmHbg1
 oqC3tfTjVW6apNmclMg8aRnVMAyglNQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-Ks7aPuPpPbS29lNpJAn68g-1; Fri, 06 Mar 2020 12:15:39 -0500
X-MC-Unique: Ks7aPuPpPbS29lNpJAn68g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EEA2E184C804;
 Fri,  6 Mar 2020 17:15:37 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0544373873;
 Fri,  6 Mar 2020 17:15:36 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 25/29] monitor: Add allow_hmp parameter to monitor_init()
Date: Fri,  6 Mar 2020 18:14:54 +0100
Message-Id: <20200306171458.1848-26-kwolf@redhat.com>
In-Reply-To: <20200306171458.1848-1-kwolf@redhat.com>
References: <20200306171458.1848-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a new parameter allow_hmp to monitor_init() so that the storage
daemon can disable HMP.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20200224143008.13362-20-kwolf@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/control.json         |  3 ++-
 include/monitor/monitor.h |  2 +-
 monitor/monitor.c         | 12 ++++++++++--
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/qapi/control.json b/qapi/control.json
index 3ee086aec7..85b12fe0fb 100644
--- a/qapi/control.json
+++ b/qapi/control.json
@@ -237,7 +237,8 @@
 #
 # @id:          Name of the monitor
 #
-# @mode:        Selects the monitor mode (default: readline)
+# @mode:        Selects the monitor mode (default: readline in the system
+#               emulator, control in qemu-storage-daemon)
 #
 # @pretty:      Enables pretty printing (QMP only)
 #
diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index ad823b9edb..1018d754a6 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -19,7 +19,7 @@ void monitor_init_globals(void);
 void monitor_init_globals_core(void);
 void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp);
 void monitor_init_hmp(Chardev *chr, bool use_readline, Error **errp);
-int monitor_init(MonitorOptions *opts, Error **errp);
+int monitor_init(MonitorOptions *opts, bool allow_hmp, Error **errp);
 int monitor_init_opts(QemuOpts *opts, Error **errp);
 void monitor_cleanup(void);
=20
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 2282bf6780..125494410a 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -611,7 +611,7 @@ void monitor_init_globals_core(void)
                                    NULL);
 }
=20
-int monitor_init(MonitorOptions *opts, Error **errp)
+int monitor_init(MonitorOptions *opts, bool allow_hmp, Error **errp)
 {
     Chardev *chr;
     Error *local_err =3D NULL;
@@ -622,11 +622,19 @@ int monitor_init(MonitorOptions *opts, Error **errp)
         return -1;
     }
=20
+    if (!opts->has_mode) {
+        opts->mode =3D allow_hmp ? MONITOR_MODE_READLINE : MONITOR_MODE_CO=
NTROL;
+    }
+
     switch (opts->mode) {
     case MONITOR_MODE_CONTROL:
         monitor_init_qmp(chr, opts->pretty, &local_err);
         break;
     case MONITOR_MODE_READLINE:
+        if (!allow_hmp) {
+            error_setg(errp, "Only QMP is supported");
+            return -1;
+        }
         if (opts->pretty) {
             warn_report("'pretty' is deprecated for HMP monitors, it has n=
o "
                         "effect and will be removed in future versions");
@@ -658,7 +666,7 @@ int monitor_init_opts(QemuOpts *opts, Error **errp)
         goto out;
     }
=20
-    monitor_init(options, &local_err);
+    monitor_init(options, true, &local_err);
     qapi_free_MonitorOptions(options);
=20
 out:
--=20
2.20.1


