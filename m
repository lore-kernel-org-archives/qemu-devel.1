Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCF4C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 09:09:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2A5020818
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 09:09:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2A5020818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44909 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRYrS-0005xL-LT
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 05:09:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1hRYpZ-0004Uv-U6
	for qemu-devel@nongnu.org; Fri, 17 May 2019 05:07:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1hRYpY-0003jq-Bp
	for qemu-devel@nongnu.org; Fri, 17 May 2019 05:07:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46516)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1hRYpY-0003iq-4R
	for qemu-devel@nongnu.org; Fri, 17 May 2019 05:07:08 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B6D4E81DE3;
	Fri, 17 May 2019 09:07:06 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-157.pek2.redhat.com
	[10.72.12.157])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 229F860BE0;
	Fri, 17 May 2019 09:07:04 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Date: Fri, 17 May 2019 17:06:55 +0800
Message-Id: <1558084017-15947-3-git-send-email-jasowang@redhat.com>
In-Reply-To: <1558084017-15947-1-git-send-email-jasowang@redhat.com>
References: <1558084017-15947-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Fri, 17 May 2019 09:07:06 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 2/4] e1000: Never increment the RX undersize
 count register
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
Cc: Jason Wang <jasowang@redhat.com>, Chris Kenna <chris.kenna@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Chris Kenna <chris.kenna@oracle.com>

In situations where e1000 receives an undersized Ethernet frame,
QEMU increments the emulated "Receive Undersize Count (RUC)"
register when padding the frame.

This is incorrect because this an expected scenario (e.g. with
VLAN tag stripping) and not an error. As such, QEMU should not
increment the emulated RUC.

Fixes: 3b2743017749 ("e1000: Implementing various counters")

Reviewed-by: Mark Kanda <mark.kanda@oracle.com>
Reviewed-by: Bhavesh Davda <bhavesh.davda@oracle.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Chris Kenna <chris.kenna@oracle.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/e1000.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index 9b39bcc..121452d 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -901,7 +901,6 @@ e1000_receive_iov(NetClientState *nc, const struct iovec *iov, int iovcnt)
     if (size < sizeof(min_buf)) {
         iov_to_buf(iov, iovcnt, 0, min_buf, size);
         memset(&min_buf[size], 0, sizeof(min_buf) - size);
-        e1000x_inc_reg_if_not_full(s->mac_reg, RUC);
         min_iov.iov_base = filter_buf = min_buf;
         min_iov.iov_len = size = sizeof(min_buf);
         iovcnt = 1;
-- 
2.5.0


