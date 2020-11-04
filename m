Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888A0C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 18:59:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0366D2080D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 18:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NRLOApDU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0366D2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaO0G-0004vn-0L
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 13:59:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaNk3-0001sH-Ln
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 13:42:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28633)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaNk0-00027k-ES
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 13:42:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604515359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=APdAnMGOimWpi0/lmUkQSWdNUl1kK18oif2GgMOHc/o=;
 b=NRLOApDUTXXL3d2OoLx+zmEeycwJN7SU2kkERM9RLBv0v7LlkCxMCsGKezrPn/ZURUgwbS
 29y00RHh9lfEr8IbZi+6t60UJq9LEXQTSAns6GQTFkqTKO4dY+GbUQgOSPoHxRLmtSQ8s/
 +SewSdBAuUEg4qkTJWcAyqDss8jISpQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-vkVddHj6N12VlGpBlPwKrA-1; Wed, 04 Nov 2020 13:42:37 -0500
X-MC-Unique: vkVddHj6N12VlGpBlPwKrA-1
Received: by mail-wr1-f69.google.com with SMTP id w3so7464924wrt.11
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 10:42:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=APdAnMGOimWpi0/lmUkQSWdNUl1kK18oif2GgMOHc/o=;
 b=oy6ZR0bVlaarSiCiq6bLiXzh6VwcV5Sqb1n0kVCghasvjS3H4wyENDoTFjTDrex9CH
 LpZvejCfcxuPfXtfUNvH12WxTJa2kBw3vejAgLAuyz1+/NzIF85rVcBnx3GGwZAMwF7l
 JBc0WSCXIS097c3f1AuzYTs6pJKO0V2DVxt6192Sjagh6aiQGzjxplV9s+66A8gEaQiV
 rpaO4Xt4dqek6WLepPhgVeKmMLbqDW0nbmbOS2QKqYcRS5NWQQPRkxqB7syTq0Ezl0ry
 w9zNbZQ5tFfocnwFjVLuJpbMEAxEpHew3pnADh+TIQs5eOwLqLY/2KLLFH/QE19xzzY0
 FWAQ==
X-Gm-Message-State: AOAM531OmDtYVbdi9V0W+btBpdMpxU5PASQeyC9BmLWYYNTBSduM/hwf
 gWyVCBX0+RdvUlWRBd/IcGEPnWezxGxg0g4tbpeTlQ21qMir+xP/XjO+H4wwdJrI5cYbY+o1nI+
 8btvnTqOl9CArnDo=
X-Received: by 2002:a5d:420d:: with SMTP id n13mr33529118wrq.196.1604515356215; 
 Wed, 04 Nov 2020 10:42:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwsWobb6UbmptgnJ36rO278I6Xt4A1ZR8tLSRPtW8ULqMxqPLGerJGXWJFVjO2shv8QwQH+PA==
X-Received: by 2002:a5d:420d:: with SMTP id n13mr33529110wrq.196.1604515356081; 
 Wed, 04 Nov 2020 10:42:36 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id z14sm3634058wmc.15.2020.11.04.10.42.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2020 10:42:35 -0800 (PST)
Date: Wed, 4 Nov 2020 13:42:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 27/31] libvhost-user: follow QEMU comment style
Message-ID: <20201104184040.285057-28-mst@redhat.com>
References: <20201104184040.285057-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201104184040.285057-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20201027173528.213464-2-stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 contrib/libvhost-user/libvhost-user.h | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-user/libvhost-user.h
index 3bbeae8587..a1539dbb69 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -392,7 +392,8 @@ struct VuDev {
     bool broken;
     uint16_t max_queues;
 
-    /* @read_msg: custom method to read vhost-user message
+    /*
+     * @read_msg: custom method to read vhost-user message
      *
      * Read data from vhost_user socket fd and fill up
      * the passed VhostUserMsg *vmsg struct.
@@ -409,15 +410,19 @@ struct VuDev {
      *
      */
     vu_read_msg_cb read_msg;
-    /* @set_watch: add or update the given fd to the watch set,
-     * call cb when condition is met */
+
+    /*
+     * @set_watch: add or update the given fd to the watch set,
+     * call cb when condition is met.
+     */
     vu_set_watch_cb set_watch;
 
     /* @remove_watch: remove the given fd from the watch set */
     vu_remove_watch_cb remove_watch;
 
-    /* @panic: encountered an unrecoverable error, you may try to
-     * re-initialize */
+    /*
+     * @panic: encountered an unrecoverable error, you may try to re-initialize
+     */
     vu_panic_cb panic;
     const VuDevIface *iface;
 
-- 
MST


