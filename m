Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196D3C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:37:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D755D20747
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TKcXwXe6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D755D20747
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrn2X-0000Lq-0n
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 14:37:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrmvz-0004ML-9S
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:30:43 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54103
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrmvw-0001Xj-Mp
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:30:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593887440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XsBDJFEC04b3XTFz4nBxIO5zxhzyAGQ01hQLAAQIsGo=;
 b=TKcXwXe6okdOUuNDJNJ0qM/BnkbNCPX3kIK8OVARL3vPt1jmMGnecu/z9dtk+5JNWNq/+q
 /ilxFyfGARQwuegln2iy5jO3OYvEjfa42jHG/bRb4he+EI9GO13wYMh4770xrtAdSQtw+6
 W3HGHP0ZbnzEoOJ1K4rklj7ELM+dZv8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-xBfikwVKOrS0kcJFDejFgg-1; Sat, 04 Jul 2020 14:30:35 -0400
X-MC-Unique: xBfikwVKOrS0kcJFDejFgg-1
Received: by mail-wm1-f69.google.com with SMTP id c124so7825798wme.0
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 11:30:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=XsBDJFEC04b3XTFz4nBxIO5zxhzyAGQ01hQLAAQIsGo=;
 b=APmC1bro6pLJfgg6I3XbfIotmjzDkZ3oCFIS8SP7POI9RH3fk3uNe3fM3qwtU6SRFE
 abunQp8yQaDVsg9IvLZaGmmzaJ8CuxX+6oAt2+7r94G9QMzd6HVemHUD4Z0yEsSVgZwe
 1VLs+NgRHRUrXE0h0vXC+mpW18cAcCKGErZdlcLeizYKzx84iH+2QBeqUjKzIw6JNR9G
 NJZVhy/4mdHIdQHChQHxIaU2GBGq3s4cP2+d2Mn+8qzhcRuRcdtM7VeN6fKjKeI1BeB2
 h08pn8v8WMdMZPnS04pWoBht1o8oTw8pnY4CORtz2ZMNcePQMfL3lp8n7k+pqXAzx6DX
 paRQ==
X-Gm-Message-State: AOAM532402unXdoa3uo59JZTwHnNFBntdlrVcHKi22hOO+2CeT4S6Jij
 /X1IaVuewn5ISyd84pa1GGAkAfy7DHehvVmsg2i3QU6pFThwZT71waOYqr7qT9waI8jKkODCQ6l
 ibSdFnlOPHN8ikko=
X-Received: by 2002:a5d:630d:: with SMTP id i13mr42318609wru.208.1593887434029; 
 Sat, 04 Jul 2020 11:30:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwE+d+B11E2636uIQUtE4bOl5JE4bt1NC/dCI/OQS5YDXnScNRdsGiXRRrxqpP+CS3F8o1mEg==
X-Received: by 2002:a5d:630d:: with SMTP id i13mr42318599wru.208.1593887433878; 
 Sat, 04 Jul 2020 11:30:33 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 f186sm16994044wmf.29.2020.07.04.11.30.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 11:30:33 -0700 (PDT)
Date: Sat, 4 Jul 2020 14:30:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 26/41] docs: vhost-user: add Virtio status protocol feature
Message-ID: <20200704182750.1088103-27-mst@redhat.com>
References: <20200704182750.1088103-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200704182750.1088103-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 08:57:02
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
 Maxime Coquelin <maxime.coquelin@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Maxime Coquelin <maxime.coquelin@redhat.com>

This patch specifies the VHOST_USER_SET_STATUS and
VHOST_USER_GET_STATUS requests, which are sent by
the master to update and query the Virtio status
in the backend.

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-Id: <20200618134501.145747-1-maxime.coquelin@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 docs/interop/vhost-user.rst | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 688b7c6900..10e3e3475e 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -816,6 +816,7 @@ Protocol features
   #define VHOST_USER_PROTOCOL_F_RESET_DEVICE         13
   #define VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS 14
   #define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS  15
+  #define VHOST_USER_PROTOCOL_F_STATUS               16
 
 Master message types
 --------------------
@@ -1307,6 +1308,29 @@ Master message types
   ``VHOST_USER_ADD_MEM_REG`` message, this message is used to set and
   update the memory tables of the slave device.
 
+``VHOST_USER_SET_STATUS``
+  :id: 39
+  :equivalent ioctl: VHOST_VDPA_SET_STATUS
+  :slave payload: N/A
+  :master payload: ``u64``
+
+  When the ``VHOST_USER_PROTOCOL_F_STATUS`` protocol feature has been
+  successfully negotiated, this message is submitted by the master to
+  notify the backend with updated device status as defined in the Virtio
+  specification.
+
+``VHOST_USER_GET_STATUS``
+  :id: 40
+  :equivalent ioctl: VHOST_VDPA_GET_STATUS
+  :slave payload: ``u64``
+  :master payload: N/A
+
+  When the ``VHOST_USER_PROTOCOL_F_STATUS`` protocol feature has been
+  successfully negotiated, this message is submitted by the master to
+  query the backend for its device status as defined in the Virtio
+  specification.
+
+
 Slave message types
 -------------------
 
-- 
MST


