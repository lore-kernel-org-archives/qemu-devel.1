Return-Path: <SRS0=qQQb=4Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C7DC10DCE
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 13:33:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1546920866
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 13:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G+9ynz7f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1546920866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAw3u-0006zf-9h
	for qemu-devel@archiver.kernel.org; Sun, 08 Mar 2020 09:33:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53027)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jAw1h-0004ly-TY
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 09:31:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jAw1g-0006a1-Ur
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 09:31:29 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30553
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jAw1g-0006Zu-QD
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 09:31:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583674288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+ingQukXqhyYANrIdEMVg6/xA+WiLczxiRmxDnvapgw=;
 b=G+9ynz7fvQNh6u3jGRbf3kI0/u3N1Bgyn8JCAuHqOvn/aoCCQB3223SwlBROXIyN66JiGE
 RCPNKJ6Nk+xaYl3vOh7uhyzk85qYTln3j/EG9Y9OJfMnwmU+la9TvlXGz/i3J2feNfMsbh
 n7auSypze7OVzy+qhJE6p54xvo2hTM0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-x5ViJXElNDKWr5dnoRsVQQ-1; Sun, 08 Mar 2020 09:31:26 -0400
X-MC-Unique: x5ViJXElNDKWr5dnoRsVQQ-1
Received: by mail-qt1-f198.google.com with SMTP id j35so4962938qte.19
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2020 06:31:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=jhaVEc1976vvFcZUoBl4MhVwpmTYuCRTZAxZTDn5INw=;
 b=EnI5fWqaVyQZALWDMwakPVJUnavej0yRhsxyH1YtgAYNLSIVTCsjK5IahZhv2GLGWP
 k0z/ISWCq3p4pniqviHp/nHgf00lTo4KSBfOJU2Pp5L4BoxzxbsDbfmqeAAqQ1C/XX/v
 CxPnQ0JS0YEsRXz7jECiY30KbEKOHAFNVxa63PvjDKTcDDharMBQtJRyrrkqar8ZkjtU
 bh1kfHifWQzAPlM0OYa/lSXLXEDjsmlRW44s2M4q44PuxSpKpoZE1n1pbnyH3VN1N0lE
 unQxYjh/k/ZOfebdj/UHmHOO3u9ZGoAaySV9LrBjeZ73WpOlL2LLZ0dqcuR+pfhYE1jo
 Oswg==
X-Gm-Message-State: ANhLgQ05Li7zDn+dMHI5ChHiIX70XRvXjXLRQDZ4yJj6ZAlyG3lSPZp9
 MeAV+sae2trZWnVBAEJlWkGwyyK1GmRETKodaaOPYL7AlXnnrX+WC2sBEXTkl1qAI0ggylTu7Zc
 bY36DyU5DBSiucZA=
X-Received: by 2002:a05:620a:22ea:: with SMTP id
 p10mr10878690qki.75.1583674285827; 
 Sun, 08 Mar 2020 06:31:25 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vu7AsYPOMNiAHetUBfiQuC5yn8kSav3lkFgKmSBGtM0nU72/tQS8plS/fnyIBhNtwJorQNgAw==
X-Received: by 2002:a05:620a:22ea:: with SMTP id
 p10mr10878668qki.75.1583674285552; 
 Sun, 08 Mar 2020 06:31:25 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id h24sm13891117qkk.3.2020.03.08.06.31.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Mar 2020 06:31:24 -0700 (PDT)
Date: Sun, 8 Mar 2020 09:31:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/4] vhost-vsock: fix error message output
Message-ID: <20200308133054.1563705-4-mst@redhat.com>
References: <20200308133054.1563705-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200308133054.1563705-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 =?utf-8?Q?J=C3=A1n?= Tomko <jtomko@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Nick Erdmann <n@nirf.de>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Nick Erdmann <n@nirf.de>

error_setg_errno takes a positive error number, so we should not invert
errno's sign.

Signed-off-by: Nick Erdmann <n@nirf.de>
Message-Id: <04df3f47-c93b-1d02-d250-f9bda8dbc0fa@nirf.de>
Reviewed-by: J=C3=A1n Tomko <jtomko@redhat.com>
Fixes: fc0b9b0e1cbb ("vhost-vsock: add virtio sockets device")
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-vsock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index 66da96583b..9f9093e196 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -325,7 +325,7 @@ static void vhost_vsock_device_realize(DeviceState *dev=
, Error **errp)
     } else {
         vhostfd =3D open("/dev/vhost-vsock", O_RDWR);
         if (vhostfd < 0) {
-            error_setg_errno(errp, -errno,
+            error_setg_errno(errp, errno,
                              "vhost-vsock: failed to open vhost device");
             return;
         }
--=20
MST


