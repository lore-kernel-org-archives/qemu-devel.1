Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB464C10F03
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 22:28:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACDEC218D2
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 22:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="VRf1xOj7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACDEC218D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60377 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJ3uM-0002Yj-UV
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 18:28:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60226)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from
	<3oI-_XAIKCqkNTPXXPUN.LXVZNVd-MNeNUWXWPWd.XaP@flex--ek.bounces.google.com>)
	id 1hJ3mX-0007jb-Uy
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:20:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from
	<3oI-_XAIKCqkNTPXXPUN.LXVZNVd-MNeNUWXWPWd.XaP@flex--ek.bounces.google.com>)
	id 1hJ3mQ-0005cz-Gc
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:20:50 -0400
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a]:48289)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from
	<3oI-_XAIKCqkNTPXXPUN.LXVZNVd-MNeNUWXWPWd.XaP@flex--ek.bounces.google.com>)
	id 1hJ3mO-0005Sf-Cn
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:20:46 -0400
Received: by mail-pg1-x54a.google.com with SMTP id o1so10835250pgv.15
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 15:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
	h=date:message-id:mime-version:subject:from:to:cc;
	bh=G7+dfKJloFPbILTvvf6aGmjJBsYOILBOFQc4/5QimiM=;
	b=VRf1xOj7d2tOFLuCMSviOux/vfFy9CnA5TVpqWvP16aF/IASpVp3k89wNJbbwgqrpk
	4wtvdvt/r85Gu8KXoPnLkpOe5zAry+HXm09BSsauWqzdQauFqyQ1jIxQXbeRlronKkUy
	DgvKkKTIM03bfunz2bvDE1wRVFZ0rYHU5F8l/YbXX5941x9K1H/MkrR7BWgfabIYWBF6
	/apeIric+GQq3Z82Nvfm789L/MiZYFrBogbAWZk7qcRMImUzQXHAILfS1SaxlWwJtorc
	kufDOWlzV/WDbd75AqoMcGRbxvzurtI8ntXNmlQQZshDx0TDJ2B0zU0A7E8Tjky8SZ7L
	HBTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
	bh=G7+dfKJloFPbILTvvf6aGmjJBsYOILBOFQc4/5QimiM=;
	b=Jl+12Zu6F7xFSl0Km/WQKxr4mzQrI2eBsi7jUnO7HoVMkIzWp0Ruy/wijmX5VGsye9
	uflvX/ausHsPutpDEK1kxvhLiRCaq0WfWXSEChKApx69ATmdRtcSV0w6VN4xSKvFOXZq
	jWLLqkWZlv6MTxelDIAg3TJl2H9GGA7dZWpc0sWYt8PC2I65oUakjkG55AYAcIU9TYFo
	1hINKufM0cKfwmuzJhoKIwTePOplghWyko3B9lUbDSNWZxsY3DmR+4rFDooKqYAIHScB
	5wLi1vD8PHXp0OrsQMeUXAugWPj9iTtwLgYjdXq+K4+a6w5O6J9Wkp5T0N59c6ZoJe42
	pInw==
X-Gm-Message-State: APjAAAUFsBBu5ZNjeon+XdKgmxO0I1qn17u22Qzq8LZ/bIXqBw073CTg
	pb45GY2AetukttIol14wbvGvVf55t4mL1Jey3+oSw8vwGU6ikQBo2nRXiIp7gfheCx9wCAB4xIU
	WgDM8B/thzuYovORTbKzn6ROFpyraUIThNG4MfglGcB1ZdRM2tA==
X-Google-Smtp-Source: APXvYqwKZdHy3mL27tNmki6N3e56VQADasNQaZcWr+/7V387BOQHf2vKajg90LkvV2VpMz2S0WA5gA==
X-Received: by 2002:a63:5b4d:: with SMTP id l13mr26812926pgm.160.1556058016828;
	Tue, 23 Apr 2019 15:20:16 -0700 (PDT)
Date: Tue, 23 Apr 2019 15:20:05 -0700
Message-Id: <20190423222005.246981-1-ek@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::54a
X-Mailman-Approved-At: Tue, 23 Apr 2019 18:28:10 -0400
Subject: [Qemu-devel] [PATCH] The ioctl(SIOCGIFNAME) call requires a struct
 ifreq.
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
From: Erik Kline via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Erik Kline <ek@google.com>
Cc: Erik Kline <ek@google.com>, ek@loon.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423222005.zR6vB7fu2MNu3NdFj_I7uCyFR_MAfIjKZilILonjQw0@z>

Signed-off-by: Erik Kline <ek@google.com>
Buglink: https://bugs.launchpad.net/qemu/+bug/1814352
---
 linux-user/ioctls.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index ae8951625f..37501f575c 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -178,7 +178,7 @@
 #endif /* CONFIG_USBFS */
 
   IOCTL(SIOCATMARK, IOC_R, MK_PTR(TYPE_INT))
-  IOCTL(SIOCGIFNAME, IOC_RW, MK_PTR(TYPE_INT))
+  IOCTL(SIOCGIFNAME, IOC_RW, MK_PTR(MK_STRUCT(STRUCT_int_ifreq)))
   IOCTL(SIOCGIFFLAGS, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_short_ifreq)))
   IOCTL(SIOCSIFFLAGS, IOC_W, MK_PTR(MK_STRUCT(STRUCT_short_ifreq)))
   IOCTL(SIOCGIFADDR, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_sockaddr_ifreq)))
-- 
2.21.0.593.g511ec345e18-goog


