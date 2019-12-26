Return-Path: <SRS0=LSdK=2Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CE7C2D0DC
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2019 04:37:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40E352075E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2019 04:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="WPKq2bDq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40E352075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ikKuB-00010j-8x
	for qemu-devel@archiver.kernel.org; Wed, 25 Dec 2019 23:37:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54011)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1ikKtP-0000AK-CA
 for qemu-devel@nongnu.org; Wed, 25 Dec 2019 23:37:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1ikKtO-0002sv-9s
 for qemu-devel@nongnu.org; Wed, 25 Dec 2019 23:36:59 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40286)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1ikKtO-0002sa-4m
 for qemu-devel@nongnu.org; Wed, 25 Dec 2019 23:36:58 -0500
Received: by mail-wm1-x343.google.com with SMTP id t14so5259083wmi.5
 for <qemu-devel@nongnu.org>; Wed, 25 Dec 2019 20:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=K7tbimO2/2dQv24tAym1UO0nhakXFIkSbfRgILSTGkY=;
 b=WPKq2bDqE1Q39BatoyzIXkba9o4yzP0kYibn8rxBL5luSyfCGqac9dSluwlcyH9kCc
 tDp+PrfNheVBymB2hGPMG/OqB6inZDSSye1LfrUeVT2KyKc5ADYBHE9KiwWb9yGrrOrY
 nWAXQk6RhaN5ftkNUo3LrT95pCC9HZcR5ZoEo+Y2GqJwZBWS8mFZNZ8SAjfJuGgcLHKY
 cY8Dx3/7ij0Cic5f/bLA7/7jbBfXk6mkcUh1EaURRGMIHTt1BDWq4Egimfm+VSUrNxeF
 RK0y3u74eL8Ffn9TXuPzQNixa0EGxlQMCMVYLpl2wu9mhKFwT5SHhOxJ/yZuC0YGvCVt
 PkLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=K7tbimO2/2dQv24tAym1UO0nhakXFIkSbfRgILSTGkY=;
 b=gl8o41rYHJN1pF5Dq+K1eaTa1fNcSlCjZhGg9g6zLxrZ4W82PIS4S38Rdn7ncpde/S
 QdllkXTHhIaMQ6OtxbtqAn9TVPU0UXtERsOjGr4JKDnySQYbRhLzdyvVZNTDPnkKDesh
 7bapzhlEU3UDpFrVMuaK5C3wLH7ppcuebGYIfHU4gV63hzlgPgUQa5X8Tmu4POYVQy4Y
 hfJ31WHGpU3DPV0zDBAeozRjGVSGbrvtENrrKDCWerEnPGpFr38n5Ecj70/7SbWs0Vot
 4iMzgSU1mRezneXc07xb7QUKwdTPsshZARHkLmyh7qwzwpcTQwzMFbUc+fCRUdbnZmWL
 EUzw==
X-Gm-Message-State: APjAAAVBq8dpiGiJCkazefMw25070NJo7W6H1NFxPMYIw0/2UHxXoKq/
 Vp3YJoIo8JG0brXZWoCgtF4nPw==
X-Google-Smtp-Source: APXvYqxvQAEwucxFmtpDLLFbBjyME4E0jQDbLLDLnnYZGhSJOJyTSbQGP2C8B8Izz8AgFlcR5nj5vg==
X-Received: by 2002:a7b:cd07:: with SMTP id f7mr11495912wmj.37.1577335017228; 
 Wed, 25 Dec 2019 20:36:57 -0800 (PST)
Received: from f2.redhat.com (bzq-79-182-106-171.red.bezeqint.net.
 [79.182.106.171])
 by smtp.gmail.com with ESMTPSA id a1sm29428800wrr.80.2019.12.25.20.36.56
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 25 Dec 2019 20:36:56 -0800 (PST)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	qemu-devel@nongnu.org
Subject: [PATCH 1/2] virtio: reset region cache when on queue deletion
Date: Thu, 26 Dec 2019 06:36:48 +0200
Message-Id: <20191226043649.14481-2-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191226043649.14481-1-yuri.benditovich@daynix.com>
References: <20191226043649.14481-1-yuri.benditovich@daynix.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: yan@daynix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

https://bugzilla.redhat.com/show_bug.cgi?id=1708480
Fix leak of region reference that prevents complete
device deletion on hot unplug.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
---
 hw/virtio/virtio.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 04716b5f6c..baadec8abc 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2340,6 +2340,11 @@ void virtio_del_queue(VirtIODevice *vdev, int n)
     vdev->vq[n].vring.num_default = 0;
     vdev->vq[n].handle_output = NULL;
     vdev->vq[n].handle_aio_output = NULL;
+    /*
+     * with vring.num = 0 the queue will be ignored
+     * in later loops of region cache reset
+     */
+    virtio_virtqueue_reset_region_cache(&vdev->vq[n]);
     g_free(vdev->vq[n].used_elems);
 }
 
-- 
2.17.1


