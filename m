Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A786AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:48:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D9EB20734
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VIpLvman"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D9EB20734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jisf4-0003iQ-B7
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 00:48:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisLV-0001Kh-Mn
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:28:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36390
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisLU-0008M7-NE
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:28:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591763292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DbDRG1p4/X4N+xWJw2tEfw4K/ZQW4xdSXq7Ah8IdwPY=;
 b=VIpLvmanWFB4BVsP7IvN7kRR6PDaztm5INWFpm03jsfYqb3p+/NtcZ+37GcL9aVyBJAJaU
 VYuWbzKZQVmxOcCYg2HGKuhLG3oELu8tiRjBs/z185RM8pP9C+sHBRjlJUEoY2xsZjJfER
 775ju1d4FS5IPPeqwkL1dSiQJOitnD4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-ZPTqZacKPcSnFAUFhs0t1w-1; Wed, 10 Jun 2020 00:28:10 -0400
X-MC-Unique: ZPTqZacKPcSnFAUFhs0t1w-1
Received: by mail-wr1-f70.google.com with SMTP id a4so512772wrp.5
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 21:28:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=DbDRG1p4/X4N+xWJw2tEfw4K/ZQW4xdSXq7Ah8IdwPY=;
 b=gM20Ki+2lQYvRHeu/rvTZ8hHYxAe1ZrpYUUFc0wR/k+6ipGXl84F3J9y+pdkcRh3TO
 +RKG+v23I65cwBbE4Jsj9pgpk+mmO+LzB89ShhR17SQRk5Vskg+1g6HCtE4VGyIqANaB
 bsBQp3D+auzwJjevhqSc+msXgnMVZMUavDQxwKofKTYD/3+flznkiu7a8nJ+E4rEqlcE
 rgqukECyWtdynWsQnfH0GyUiSokpNRf65RMQht3z6PliGyrmL+kOIxpreJ0WtMr/WSDG
 jtAw84S4Y6thyMHHYWOd/ekg+8AGMEbXhrVQn4HGKnpjV3Z/rNvZb67Fi+dHmMjlHs2h
 czcw==
X-Gm-Message-State: AOAM531BAclPpx2drgWtQNnDFWLE3l5ACOsfcNigQIFpISWnDSZaezZ0
 IwZx1x9Y2jaIOEwFrkryBOOZeTdyTh2R/5r5atJlNcNUdvL3+phqfJxOZFEkynodGbk0lGNBzeT
 X9JtKz/QGSHwXTCU=
X-Received: by 2002:a5d:6944:: with SMTP id r4mr1280838wrw.169.1591763288747; 
 Tue, 09 Jun 2020 21:28:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzizWhudp2123aEsGVy0Jg4N+DhCMNrYF59+UYcws1ot5Xy472Udx9J/HZkmHssua7TaC9vKg==
X-Received: by 2002:a5d:6944:: with SMTP id r4mr1280817wrw.169.1591763288524; 
 Tue, 09 Jun 2020 21:28:08 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id u13sm6113674wrp.53.2020.06.09.21.28.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 21:28:08 -0700 (PDT)
Date: Wed, 10 Jun 2020 00:28:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 42/56] Support ram slot configuration in libvhost-user
Message-ID: <20200610042613.1459309-43-mst@redhat.com>
References: <20200610042613.1459309-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200610042613.1459309-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 21:17:20
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Johannes Berg <johannes.berg@intel.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Raphael Norwitz <raphael.norwitz@nutanix.com>

The VHOST_USER_GET_MAX_MEM_SLOTS message allows a vhost-user backend to
specify a maximum number of ram slots it is willing to support. This
change adds support for libvhost-user to process this message. For now
the backend will reply with 8 as the maximum number of regions
supported.

libvhost-user does not yet support the vhost-user protocol feature
VHOST_USER_PROTOCOL_F_CONFIGIRE_MEM_SLOTS, so qemu should never
send the VHOST_USER_GET_MAX_MEM_SLOTS message. Therefore this new
functionality is not currently used.

Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
Message-Id: <1588533678-23450-8-git-send-email-raphael.norwitz@nutanix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 contrib/libvhost-user/libvhost-user.h |  1 +
 contrib/libvhost-user/libvhost-user.c | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-user/libvhost-user.h
index f30394fab6..88ef40d26a 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -97,6 +97,7 @@ typedef enum VhostUserRequest {
     VHOST_USER_SET_INFLIGHT_FD = 32,
     VHOST_USER_GPU_SET_SOCKET = 33,
     VHOST_USER_VRING_KICK = 35,
+    VHOST_USER_GET_MAX_MEM_SLOTS = 36,
     VHOST_USER_MAX
 } VhostUserRequest;
 
diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index cccfa22209..9f039b707e 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -137,6 +137,7 @@ vu_request_to_string(unsigned int req)
         REQ(VHOST_USER_SET_INFLIGHT_FD),
         REQ(VHOST_USER_GPU_SET_SOCKET),
         REQ(VHOST_USER_VRING_KICK),
+        REQ(VHOST_USER_GET_MAX_MEM_SLOTS),
         REQ(VHOST_USER_MAX),
     };
 #undef REQ
@@ -1565,6 +1566,22 @@ vu_handle_vring_kick(VuDev *dev, VhostUserMsg *vmsg)
     return false;
 }
 
+static bool vu_handle_get_max_memslots(VuDev *dev, VhostUserMsg *vmsg)
+{
+    vmsg->flags = VHOST_USER_REPLY_MASK | VHOST_USER_VERSION;
+    vmsg->size  = sizeof(vmsg->payload.u64);
+    vmsg->payload.u64 = VHOST_MEMORY_MAX_NREGIONS;
+    vmsg->fd_num = 0;
+
+    if (!vu_message_write(dev, dev->sock, vmsg)) {
+        vu_panic(dev, "Failed to send max ram slots: %s\n", strerror(errno));
+    }
+
+    DPRINT("u64: 0x%016"PRIx64"\n", (uint64_t) VHOST_MEMORY_MAX_NREGIONS);
+
+    return false;
+}
+
 static bool
 vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
 {
@@ -1649,6 +1666,8 @@ vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
         return vu_set_inflight_fd(dev, vmsg);
     case VHOST_USER_VRING_KICK:
         return vu_handle_vring_kick(dev, vmsg);
+    case VHOST_USER_GET_MAX_MEM_SLOTS:
+        return vu_handle_get_max_memslots(dev, vmsg);
     default:
         vmsg_close_fds(vmsg);
         vu_panic(dev, "Unhandled request: %d", vmsg->request);
-- 
MST


