Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8ABC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 09:45:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F0F2206F1
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 09:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d5Plj+xg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F0F2206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnJ0s-0007Ki-F7
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 05:45:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jnIyP-0001fH-HT
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 05:42:41 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31749
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jnIyJ-0003vd-4H
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 05:42:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592818954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JJcyVEfmpUlPXV+7Txg+19ksSRhNUXebEHc8TmRn96A=;
 b=d5Plj+xgo9M/ZPyxoDeAjY5ASD8oA8InfhP6hBRs2eWZMWzJfmK6LYGF8IewYXccdYbXX/
 2KATBdUJOtBmUDcglwO8ozJO9c4uv88jq8XV6qD1kvjUyke4PBzK5pQWy58ypa+orYSRDU
 k8JitkN323AZFLSJ3VUUNDVmDFK8Cbo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-DXpjWq38NZe_ccnLI573zA-1; Mon, 22 Jun 2020 05:42:32 -0400
X-MC-Unique: DXpjWq38NZe_ccnLI573zA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70F42EC1A0;
 Mon, 22 Jun 2020 09:42:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 123AF1A265;
 Mon, 22 Jun 2020 09:42:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D87D01138476; Mon, 22 Jun 2020 11:42:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 08/16] blockdev: Deprecate -drive with bogus interface type
Date: Mon, 22 Jun 2020 11:42:19 +0200
Message-Id: <20200622094227.1271650-9-armbru@redhat.com>
In-Reply-To: <20200622094227.1271650-1-armbru@redhat.com>
References: <20200622094227.1271650-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 03:17:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: kwolf@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, mreitz@redhat.com, pbonzini@redhat.com,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Drives with interface types other than if=none are for onboard
devices.  Unfortunately, any such drives the board doesn't pick up can
still be used with -device, like this:

    $ qemu-system-x86_64 -nodefaults -display none -S -drive if=floppy,id=bogus,unit=7 -device ide-cd,drive=bogus -monitor stdio
    QEMU 5.0.50 monitor - type 'help' for more information
    (qemu) info block
    bogus: [not inserted]
	Attached to:      /machine/peripheral-anon/device[0]
	Removable device: not locked, tray closed
    (qemu) info qtree
    bus: main-system-bus
      type System
      [...]
	    bus: ide.1
	      type IDE
	      dev: ide-cd, id ""
--->		drive = "bogus"
		[...]
		unit = 0 (0x0)
      [...]

This kind of abuse has always worked.  Deprecate it:

    qemu-system-x86_64: -drive if=floppy,id=bogus,unit=7: warning: bogus if=floppy is deprecated, use if=none

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/system/deprecated.rst |  8 ++++++++
 include/sysemu/blockdev.h  |  2 ++
 blockdev.c                 | 27 +++++++++++++++++++++++++--
 softmmu/vl.c               |  8 ++++++++
 4 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
index 6f8bf19d37..728233a8ff 100644
--- a/docs/system/deprecated.rst
+++ b/docs/system/deprecated.rst
@@ -190,6 +190,14 @@ become
 
     -device floppy,unit=1,drive=...
 
+``-drive`` with bogus interface type
+''''''''''''''''''''''''''''''''''''
+
+Drives with interface types other than ``if=none`` are for onboard
+devices.  It is possible to use drives the board doesn't pick up with
+-device.  This usage is now deprecated.  Use ``if=none`` instead.
+
+
 QEMU Machine Protocol (QMP) commands
 ------------------------------------
 
diff --git a/include/sysemu/blockdev.h b/include/sysemu/blockdev.h
index a86d99b3d8..3b5fcda08d 100644
--- a/include/sysemu/blockdev.h
+++ b/include/sysemu/blockdev.h
@@ -35,6 +35,7 @@ struct DriveInfo {
     bool is_default;            /* Added by default_drive() ?  */
     int media_cd;
     QemuOpts *opts;
+    bool claimed_by_board;
     QTAILQ_ENTRY(DriveInfo) next;
 };
 
@@ -45,6 +46,7 @@ BlockBackend *blk_by_legacy_dinfo(DriveInfo *dinfo);
 void override_max_devs(BlockInterfaceType type, int max_devs);
 
 DriveInfo *drive_get(BlockInterfaceType type, int bus, int unit);
+void drive_mark_claimed_by_board(void);
 void drive_check_orphaned(void);
 DriveInfo *drive_get_by_index(BlockInterfaceType type, int index);
 int drive_get_max_bus(BlockInterfaceType type);
diff --git a/blockdev.c b/blockdev.c
index 72df193ca7..31d5eaf6bf 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -239,6 +239,19 @@ DriveInfo *drive_get(BlockInterfaceType type, int bus, int unit)
     return NULL;
 }
 
+void drive_mark_claimed_by_board(void)
+{
+    BlockBackend *blk;
+    DriveInfo *dinfo;
+
+    for (blk = blk_next(NULL); blk; blk = blk_next(blk)) {
+        dinfo = blk_legacy_dinfo(blk);
+        if (dinfo && blk_get_attached_dev(blk)) {
+            dinfo->claimed_by_board = true;
+        }
+    }
+}
+
 void drive_check_orphaned(void)
 {
     BlockBackend *blk;
@@ -248,8 +261,10 @@ void drive_check_orphaned(void)
 
     for (blk = blk_next(NULL); blk; blk = blk_next(blk)) {
         dinfo = blk_legacy_dinfo(blk);
-        if (!blk_get_attached_dev(blk) && !dinfo->is_default &&
-            dinfo->type != IF_NONE) {
+        if (dinfo->is_default || dinfo->type == IF_NONE) {
+            continue;
+        }
+        if (!blk_get_attached_dev(blk)) {
             loc_push_none(&loc);
             qemu_opts_loc_restore(dinfo->opts);
             error_report("machine type does not support"
@@ -257,6 +272,14 @@ void drive_check_orphaned(void)
                          if_name[dinfo->type], dinfo->bus, dinfo->unit);
             loc_pop(&loc);
             orphans = true;
+            continue;
+        }
+        if (!dinfo->claimed_by_board && dinfo->type != IF_VIRTIO) {
+            loc_push_none(&loc);
+            qemu_opts_loc_restore(dinfo->opts);
+            warn_report("bogus if=%s is deprecated, use if=none",
+                        if_name[dinfo->type]);
+            loc_pop(&loc);
         }
     }
 
diff --git a/softmmu/vl.c b/softmmu/vl.c
index f669c06ede..3e15ee2435 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -4347,6 +4347,14 @@ void qemu_init(int argc, char **argv, char **envp)
     /* from here on runstate is RUN_STATE_PRELAUNCH */
     machine_run_board_init(current_machine);
 
+    /*
+     * TODO To drop support for deprecated bogus if=..., move
+     * drive_check_orphaned() here, replacing this call.  Also drop
+     * its deprecation warning, along with DriveInfo member
+     * @claimed_by_board.
+     */
+    drive_mark_claimed_by_board();
+
     realtime_init();
 
     soundhw_init();
-- 
2.26.2


