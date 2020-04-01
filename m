Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D04C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 12:12:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9392D206F8
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 12:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYhsGRKf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9392D206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJcEF-0002Eo-OU
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 08:12:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45363)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <singhalsimran0@gmail.com>) id 1jJcDE-0001Qj-Fe
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 08:11:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <singhalsimran0@gmail.com>) id 1jJcDC-0000YB-0z
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 08:11:16 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:53744)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <singhalsimran0@gmail.com>)
 id 1jJcDB-0000Wu-Gm; Wed, 01 Apr 2020 08:11:13 -0400
Received: by mail-pj1-x1041.google.com with SMTP id l36so2622865pjb.3;
 Wed, 01 Apr 2020 05:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=FuDRYvHnYYf+dkIWyJIZR4ZnrXq3DkjWg4dJWTRrxfk=;
 b=cYhsGRKfQVPzEnZ3IuNwocMjEAwpFHSyWzsI9if/3g9LecyGOpEesPoZRYBV+pMOq8
 SJGgmnoX4T24oSMP34Qp8hSApLhzqnTRdEcqoT2puOhloTsWHSBSDSffVg/FOuQSC2hx
 rtjR/uA+NLKpcQOYQMynmnLrGFNLPsZTWdEj5QxSikK5q5v4oUCvLgFnNaU9Sad/JXHW
 hqkQlxrd9as18QkNewmI8zvAOiKMnZcq9K3sMNiwHEq8VCTkNNLfkjtaqtSXV0CM9HMK
 iIapnhgifJDeAxjvVGJ/xEdOdUNFVFDS4RbKU/78i33+gYX4mU9hITC0CYCL+Qgod8Nh
 cNXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=FuDRYvHnYYf+dkIWyJIZR4ZnrXq3DkjWg4dJWTRrxfk=;
 b=VcK8ZJYfnig3JBMUf/PMxopse6DX+yKkgNt/dbjXsW18tYHpzznlm/zkrgidbA5OAX
 xeRMNOdc536hfTG/AxVhBl5q9tpV/ki4Hy/5RgIakZh7Tydmyr+Fek49R/OopLSYt7p1
 NUFUCkLmKrSrtHAkErgc5hUWVPv17VAN2gqXgSvC5Lg4xoNA4jitDLsrHuNSl6z2iLLV
 6mkNTykay2AeCXYsdEs2GIGqXLqmmcluEXZEb4Nf7Sugu4yw5Vz+6FNa8RgivcgMDnNr
 k0qV9jrxoqjrc0dBAIJufHQw7jkkIizMpSuAJ3V6KRWsmOZacnkJNhjG7+HqhkeN32ef
 8FWg==
X-Gm-Message-State: ANhLgQ1v2A/EEr3sT5cYWRwPBk7CayHvFhRsN9P1hhR9Q/47nYoKuj6l
 mExnXkl27Nh2l51sggqYTck=
X-Google-Smtp-Source: ADFU+vte9SY08DvNk+IWoFROuHwWWinWoDejNLP6G2XVm5TMilIQIuI18EqkuqgXcVBguEa6qpRkDg==
X-Received: by 2002:a17:902:a411:: with SMTP id
 p17mr22440205plq.157.1585743071808; 
 Wed, 01 Apr 2020 05:11:11 -0700 (PDT)
Received: from simran-Inspiron-5558 ([2409:4052:200f:7af7:f5db:ec54:4b36:5338])
 by smtp.gmail.com with ESMTPSA id x75sm1494167pfc.161.2020.04.01.05.11.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2020 05:11:10 -0700 (PDT)
Date: Wed, 1 Apr 2020 17:41:01 +0530
From: Simran Singhal <singhalsimran0@gmail.com>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH] Compress lines for immediate return
Message-ID: <20200401121101.GA26994@simran-Inspiron-5558>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1041
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Peter Lieven <pl@kamp.de>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Julia Suvorova <jusual@mail.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Compress two lines into a single line if immediate return statement is found.

It also remove variables progress, val, data, ret and sock
as they are no longer needed.

Remove space between function "mixer_load" and '(' to fix the
checkpatch.pl error:-
ERROR: space prohibited between function name and open parenthesis '('

Signed-off-by: Simran Singhal <singhalsimran0@gmail.com>
---
 block/file-posix.c      | 3 +--
 block/nfs.c             | 3 +--
 block/nvme.c            | 4 +---
 block/vhdx.c            | 3 +--
 hw/audio/ac97.c         | 4 +---
 hw/audio/adlib.c        | 5 +----
 hw/display/cirrus_vga.c | 4 +---
 migration/ram.c         | 4 +---
 ui/gtk.c                | 3 +--
 util/qemu-sockets.c     | 5 +----
 10 files changed, 10 insertions(+), 28 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 7e19bbff5f..dc01f0d4d3 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1627,8 +1627,7 @@ static int handle_aiocb_write_zeroes_unmap(void *opaque)
 
     /* If we couldn't manage to unmap while guaranteed that the area reads as
      * all-zero afterwards, just write zeroes without unmapping */
-    ret = handle_aiocb_write_zeroes(aiocb);
-    return ret;
+    return handle_aiocb_write_zeroes(aiocb);
 }
 
 #ifndef HAVE_COPY_FILE_RANGE
diff --git a/block/nfs.c b/block/nfs.c
index cc2413d5ab..100f15bd1f 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -623,8 +623,7 @@ static int nfs_file_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     bs->total_sectors = ret;
-    ret = 0;
-    return ret;
+    return 0;
 }
 
 static QemuOptsList nfs_create_opts = {
diff --git a/block/nvme.c b/block/nvme.c
index 7b7c0cc5d6..eb2f54dd9d 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -575,11 +575,9 @@ static bool nvme_poll_cb(void *opaque)
 {
     EventNotifier *e = opaque;
     BDRVNVMeState *s = container_of(e, BDRVNVMeState, irq_notifier);
-    bool progress = false;
 
     trace_nvme_poll_cb(s);
-    progress = nvme_poll_queues(s);
-    return progress;
+    return nvme_poll_queues(s);
 }
 
 static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
diff --git a/block/vhdx.c b/block/vhdx.c
index 33e57cd656..2c0e7ee44d 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -411,8 +411,7 @@ int vhdx_update_headers(BlockDriverState *bs, BDRVVHDXState *s,
     if (ret < 0) {
         return ret;
     }
-    ret = vhdx_update_header(bs, s, generate_data_write_guid, log_guid);
-    return ret;
+    return vhdx_update_header(bs, s, generate_data_write_guid, log_guid);
 }
 
 /* opens the specified header block from the VHDX file header section */
diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
index 1ec87feec0..8a9b9924c4 100644
--- a/hw/audio/ac97.c
+++ b/hw/audio/ac97.c
@@ -573,11 +573,9 @@ static uint32_t nam_readb (void *opaque, uint32_t addr)
 static uint32_t nam_readw (void *opaque, uint32_t addr)
 {
     AC97LinkState *s = opaque;
-    uint32_t val = ~0U;
     uint32_t index = addr;
     s->cas = 0;
-    val = mixer_load (s, index);
-    return val;
+    return mixer_load(s, index);
 }
 
 static uint32_t nam_readl (void *opaque, uint32_t addr)
diff --git a/hw/audio/adlib.c b/hw/audio/adlib.c
index d6c1fb0586..7c3b67dcfb 100644
--- a/hw/audio/adlib.c
+++ b/hw/audio/adlib.c
@@ -120,13 +120,10 @@ static void adlib_write(void *opaque, uint32_t nport, uint32_t val)
 static uint32_t adlib_read(void *opaque, uint32_t nport)
 {
     AdlibState *s = opaque;
-    uint8_t data;
     int a = nport & 3;
 
     adlib_kill_timers (s);
-    data = OPLRead (s->opl, a);
-
-    return data;
+    return OPLRead (s->opl, a);
 }
 
 static void timer_handler (void *opaque, int c, double interval_Sec)
diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index 0d391e1300..1f29731ffe 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -2411,12 +2411,10 @@ static uint64_t cirrus_linear_bitblt_read(void *opaque,
                                           unsigned size)
 {
     CirrusVGAState *s = opaque;
-    uint32_t ret;
 
     /* XXX handle bitblt */
     (void)s;
-    ret = 0xff;
-    return ret;
+    return 0xff;
 }
 
 static void cirrus_linear_bitblt_write(void *opaque,
diff --git a/migration/ram.c b/migration/ram.c
index 04f13feb2e..06cba88632 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2135,9 +2135,7 @@ int ram_postcopy_send_discard_bitmap(MigrationState *ms)
     }
     trace_ram_postcopy_send_discard_bitmap();
 
-    ret = postcopy_each_ram_send_discard(ms);
-
-    return ret;
+    return postcopy_each_ram_send_discard(ms);
 }
 
 /**
diff --git a/ui/gtk.c b/ui/gtk.c
index 030b251c61..83f2f5d49b 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1650,8 +1650,7 @@ static GSList *gd_vc_menu_init(GtkDisplayState *s, VirtualConsole *vc,
                      G_CALLBACK(gd_menu_switch_vc), s);
     gtk_menu_shell_append(GTK_MENU_SHELL(view_menu), vc->menu_item);
 
-    group = gtk_radio_menu_item_get_group(GTK_RADIO_MENU_ITEM(vc->menu_item));
-    return group;
+    return gtk_radio_menu_item_get_group(GTK_RADIO_MENU_ITEM(vc->menu_item));
 }
 
 #if defined(CONFIG_VTE)
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index bcc06d0e01..86c48b9fa5 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -765,15 +765,12 @@ static int vsock_connect_addr(const struct sockaddr_vm *svm, Error **errp)
 static int vsock_connect_saddr(VsockSocketAddress *vaddr, Error **errp)
 {
     struct sockaddr_vm svm;
-    int sock = -1;
 
     if (!vsock_parse_vaddr_to_sockaddr(vaddr, &svm, errp)) {
         return -1;
     }
 
-    sock = vsock_connect_addr(&svm, errp);
-
-    return sock;
+    return vsock_connect_addr(&svm, errp);
 }
 
 static int vsock_listen_saddr(VsockSocketAddress *vaddr,
-- 
2.17.1


