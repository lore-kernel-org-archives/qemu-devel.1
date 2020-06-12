Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CFDC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 15:10:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35E882081A
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 15:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U4q+PTnB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35E882081A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjlK7-0006sz-Dp
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 11:10:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50384)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl2w-0008Sd-K8
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:52:42 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51044
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl2u-0001Y7-Oj
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591973560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DbDRG1p4/X4N+xWJw2tEfw4K/ZQW4xdSXq7Ah8IdwPY=;
 b=U4q+PTnBBX/r47G5DS8Yv9UKWbEf1d9HjIsydMM04htaJCW4I/jRxP91V6cUYvg2C8uiCC
 dsAyM/u3xbOePNbSpBqZWEaP5uSjDrRloMXe97Q2OZWe0oq3CBxkj8HSDe7WFAO2s4F3bm
 iqXMXu9/TxRLnqKfS630NOPNQBdmt9M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-MfBwT0C-MImDbbvsW7tvsQ-1; Fri, 12 Jun 2020 10:52:38 -0400
X-MC-Unique: MfBwT0C-MImDbbvsW7tvsQ-1
Received: by mail-wr1-f71.google.com with SMTP id o1so3961427wrm.17
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 07:52:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=DbDRG1p4/X4N+xWJw2tEfw4K/ZQW4xdSXq7Ah8IdwPY=;
 b=meogjho8lslI+F9eQasL+z9flFt3T0FkN3MJrwOs8xN+4NuA494hsEJr+VV0RBEqtF
 +w+0jwIsGiAx6TdGPsrdBpe84+b2NCWUm4XMyWQTwc07+noTtLGjehsz3bv9rk1C+R3h
 38/9I9Boco2Zk1kOe2bih6gWDsu0ku9eVN53mQm4WCny5V7mGsNm3DAkz4d+1g/K2Gw9
 CyUiFkFp1sXdlqwnL6MZXAhAJvQhlvySmG4GVsbqk9b0ZlibE2NcBL0+Y/Nn1rAr8fO+
 3jQq1jju9GhbW+q3N0UsGwpf+DsCgGaK167Fb11Dnnf89iFDmWeIJfqokGKpXDzH2bXK
 il2A==
X-Gm-Message-State: AOAM531DC5o8kwCfTxNxBHrE1LgAGcOh4kADCSEf6h5oy3/jjJvi1Nq7
 TY/orEZncrhmV4/19xbPi+O+kh5HVR3HbecJe0T47hC/E+b8+D5BOmmwozTrmJ8Y+xb8qKh3lTX
 b+UlATjd9/a4pedY=
X-Received: by 2002:adf:82f8:: with SMTP id 111mr15136042wrc.257.1591973556955; 
 Fri, 12 Jun 2020 07:52:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0+TsFT2dVsw3DQpIcI5I+C/pbobHHCSmkAbeGk42+hTlGnI5ekmCeqwLUoW/9dW6iG1304A==
X-Received: by 2002:adf:82f8:: with SMTP id 111mr15136020wrc.257.1591973556773; 
 Fri, 12 Jun 2020 07:52:36 -0700 (PDT)
Received: from redhat.com (bzq-79-178-18-124.red.bezeqint.net. [79.178.18.124])
 by smtp.gmail.com with ESMTPSA id a16sm10115856wrx.8.2020.06.12.07.52.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 07:52:36 -0700 (PDT)
Date: Fri, 12 Jun 2020 10:52:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 42/58] Support ram slot configuration in libvhost-user
Message-ID: <20200612141917.9446-43-mst@redhat.com>
References: <20200612141917.9446-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200612141917.9446-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 09:30:54
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
 Johannes Berg <johannes.berg@intel.com>, David Hildenbrand <david@redhat.com>,
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


