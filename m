Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767F0C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 23:33:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EF1F20863
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 23:33:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EF1F20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43646 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSrml-00017Y-9t
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 19:33:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hSrQq-0007Qe-Jx
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:11:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hSrQp-00086Z-Nd
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:11:00 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39334)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hSrQp-00086Q-JI
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:10:59 -0400
Received: by mail-qk1-f194.google.com with SMTP id z128so9928305qkb.6
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 16:10:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=GEBbw5yBYMAQw8+9J5YyvTBzIi99r+JtCnmq4U1dRRs=;
	b=GQSdHE9HMc6+4WTtjPXOvNhW9szZcmJ3RWmZBV9homU1jyBJqe5RdZNXNmIZTTP/0o
	L8yw4il4o4tgsDuc8PqvBaf5hInaXsF6jnEOoM6s8W/jiXe+PgfoNLNXOj0bY5OaxzZI
	jPMmwP6p8C1xfqeGbmmvtK7y6WBJlr5nTjzMv7AHWg8nGegydZJ2/Kn/I8ay3NecBZu5
	GXMB3o0MG5R/E4fBKMDuTc+EtbMSpQs0My7gIAX9u20N/mYdhpku9TpHX0GiS57uRpTS
	Gc5RNWF9G8RdBfsDdgfADulgZ6OFXjiUprQEWj32uIGg5ekBJg0I3+D6hJ0X+UNaGBqq
	o4DA==
X-Gm-Message-State: APjAAAXUQWo0ZP9Wpi86MMAfnpA75t6baKa6/KuurKd6osAJGpiiT5xF
	zuiQ/WSaF+CTcgl2Iw509pruyDVleHE=
X-Google-Smtp-Source: APXvYqx9ik2NQriD2/kE1gcA/oZtiuyglnp/sCOak5EKpk9B2H1/pVwkn60aND3bSvblfuz5dJkJ+A==
X-Received: by 2002:a05:620a:1268:: with SMTP id
	b8mr33726444qkl.283.1558393858905; 
	Mon, 20 May 2019 16:10:58 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net.
	[173.76.105.71]) by smtp.gmail.com with ESMTPSA id
	p8sm11130783qta.24.2019.05.20.16.10.57
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Mon, 20 May 2019 16:10:58 -0700 (PDT)
Date: Mon, 20 May 2019 19:10:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190416184624.15397-3-dan.streetman@canonical.com>
References: <20190520231008.20140-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190520231008.20140-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.222.194
Subject: [Qemu-devel] [PULL v2 15/36] do not call vhost_net_cleanup() on
 running net from char user event
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Dan Streetman <ddstreet@canonical.com>,
	Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190520231057.wMb_ql2QWCmA0-CEHIgSDLNypkYTghBko0QYxOrGpiY@z>

From: Dan Streetman <ddstreet@canonical.com>

Buglink: https://launchpad.net/bugs/1823458

Currently, a user CHR_EVENT_CLOSED event will cause net_vhost_user_event()
to call vhost_user_cleanup(), which calls vhost_net_cleanup() for all
its queues.  However, vhost_net_cleanup() must never be called like
this for fully-initialized nets; when other code later calls
vhost_net_stop() - such as from virtio_net_vhost_status() - it will try
to access the already-cleaned-up fields and fail with assertion errors
or segfaults.

The vhost_net_cleanup() will eventually be called from
qemu_cleanup_net_client().

Signed-off-by: Dan Streetman <ddstreet@canonical.com>
Message-Id: <20190416184624.15397-3-dan.streetman@canonical.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vhost-user.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/vhost-user.c b/net/vhost-user.c
index 5a26a24708..51921de443 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -236,7 +236,6 @@ static void chr_closed_bh(void *opaque)
     s = DO_UPCAST(NetVhostUserState, nc, ncs[0]);
 
     qmp_set_link(name, false, &err);
-    vhost_user_stop(queues, ncs);
 
     qemu_chr_fe_set_handlers(&s->chr, NULL, NULL, net_vhost_user_event,
                              NULL, opaque, NULL, true);
-- 
MST


