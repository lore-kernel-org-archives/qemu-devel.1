Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04039C432C3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 09:02:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1686206B6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 09:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bzR1JQm7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1686206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWzP4-0004hn-Vo
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 04:02:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56233)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iWzNQ-0004G7-4n
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 04:00:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iWzNM-0004aa-VP
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 04:00:47 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26197
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iWzNM-0004aN-RO
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 04:00:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574154044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lb4urd+nF2hDkjxdjOka4SIZOYV6dszILUzz7uCOTds=;
 b=bzR1JQm7uqwymQJr2uSvABsmIsMlKSKW3R+H1c9e5XipLULEFWhQuVcUY9pdNsXwgqNf5f
 QUDb3M/wiFN1n+u1M12wDbd3bcBJAWaIKqem9U8aiN/rtGbQyDryf1Qh7sU1rqCwCn9G+b
 0BrJYUko+uKMbGMY8MgKlUdjAgWWoq4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-93E6CYsfPOymbDTMosQv-g-1; Tue, 19 Nov 2019 04:00:40 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2EC3107ACFA;
 Tue, 19 Nov 2019 09:00:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.163])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 299A6610B0;
 Tue, 19 Nov 2019 09:00:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7706411385C7; Tue, 19 Nov 2019 10:00:37 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/1] monitor/qmp: resume monitor when clearing its queue
Date: Tue, 19 Nov 2019 10:00:37 +0100
Message-Id: <20191119090037.21686-2-armbru@redhat.com>
In-Reply-To: <20191119090037.21686-1-armbru@redhat.com>
References: <20191119090037.21686-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 93E6CYsfPOymbDTMosQv-g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: w.bumiller@proxmox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wolfgang Bumiller <w.bumiller@proxmox.com>

When a monitor's queue is filled up in handle_qmp_command()
it gets suspended. It's the dispatcher bh's job currently to
resume the monitor, which it does after processing an event
from the queue. However, it is possible for a
CHR_EVENT_CLOSED event to be processed before before the bh
is scheduled, which will clear the queue without resuming
the monitor, thereby preventing the dispatcher from reaching
the resume() call.
Any new connections to the qmp socket will be accept()ed and
show the greeting, but will not respond to any messages sent
afterwards (as they will not be read from the
still-suspended socket).
Fix this by resuming the monitor when clearing a queue which
was filled up.

Signed-off-by: Wolfgang Bumiller <w.bumiller@proxmox.com>
Message-Id: <20191115085914.21287-1-w.bumiller@proxmox.com>
---
 monitor/qmp.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/monitor/qmp.c b/monitor/qmp.c
index 9d9e5d8b27..b67a8e7d1f 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -75,10 +75,35 @@ static void monitor_qmp_cleanup_req_queue_locked(Monito=
rQMP *mon)
     }
 }
=20
-static void monitor_qmp_cleanup_queues(MonitorQMP *mon)
+static void monitor_qmp_cleanup_queue_and_resume(MonitorQMP *mon)
 {
     qemu_mutex_lock(&mon->qmp_queue_lock);
+
+    /*
+     * Same condition as in monitor_qmp_bh_dispatcher(), but before
+     * removing an element from the queue (hence no `- 1`).
+     * Also, the queue should not be empty either, otherwise the
+     * monitor hasn't been suspended yet (or was already resumed).
+     */
+    bool need_resume =3D (!qmp_oob_enabled(mon) ||
+        mon->qmp_requests->length =3D=3D QMP_REQ_QUEUE_LEN_MAX)
+        && !g_queue_is_empty(mon->qmp_requests);
+
     monitor_qmp_cleanup_req_queue_locked(mon);
+
+    if (need_resume) {
+        /*
+         * handle_qmp_command() suspended the monitor because the
+         * request queue filled up, to be resumed when the queue has
+         * space again.  We just emptied it; resume the monitor.
+         *
+         * Without this, the monitor would remain suspended forever
+         * when we get here while the monitor is suspended.  An
+         * unfortunately timed CHR_EVENT_CLOSED can do the trick.
+         */
+        monitor_resume(&mon->common);
+    }
+
     qemu_mutex_unlock(&mon->qmp_queue_lock);
 }
=20
@@ -263,9 +288,10 @@ static void handle_qmp_command(void *opaque, QObject *=
req, Error *err)
=20
     /*
      * Suspend the monitor when we can't queue more requests after
-     * this one.  Dequeuing in monitor_qmp_bh_dispatcher() will resume
-     * it.  Note that when OOB is disabled, we queue at most one
-     * command, for backward compatibility.
+     * this one.  Dequeuing in monitor_qmp_bh_dispatcher() or
+     * monitor_qmp_cleanup_queue_and_resume() will resume it.
+     * Note that when OOB is disabled, we queue at most one command,
+     * for backward compatibility.
      */
     if (!qmp_oob_enabled(mon) ||
         mon->qmp_requests->length =3D=3D QMP_REQ_QUEUE_LEN_MAX - 1) {
@@ -332,7 +358,7 @@ static void monitor_qmp_event(void *opaque, int event)
          * stdio, it's possible that stdout is still open when stdin
          * is closed.
          */
-        monitor_qmp_cleanup_queues(mon);
+        monitor_qmp_cleanup_queue_and_resume(mon);
         json_message_parser_destroy(&mon->parser);
         json_message_parser_init(&mon->parser, handle_qmp_command,
                                  mon, NULL);
--=20
2.21.0


