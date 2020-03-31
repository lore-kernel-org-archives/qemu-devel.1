Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47298C2D0F3
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 14:58:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15D9320675
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 14:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W+CsjTzF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15D9320675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJILC-0001Ro-6F
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 10:58:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56380)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jJIKF-00085S-47
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:57:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jJIKD-000535-Sh
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:57:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59689
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jJIKD-00052q-OJ
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:57:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585666629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y3JDDCxeHsu0uxBdU3hqYhD9IDIpl6gR6DiqYZM/Jw0=;
 b=W+CsjTzFiTgh0ruyYntWxCsqeA51dRXEz6mQ1MojsU4K/n3QYncr+qipN2sq+RdVvLSksv
 97vLqj5WI0BbWzuuAJ07Juw3uE/oehnqSJnuC2d3kWRNgjoxATYT7Fz+i2jOR+Gr0lT1eb
 GZmo1G7fKkGOiWibhuISywGJ3q4Vkk8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-IRJ2DvtTP0aK9WxFsFMU3w-1; Tue, 31 Mar 2020 10:57:07 -0400
X-MC-Unique: IRJ2DvtTP0aK9WxFsFMU3w-1
Received: by mail-wr1-f70.google.com with SMTP id d1so13066545wru.15
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 07:57:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=0MtgQcn82XAWmRqhItN4weyN5S4MhXPLIRVwnSTTFuQ=;
 b=BD0KZCah4atoLcXwnWsTN/oeANjS9UATOfL12/Y5jbHR3WP/CGbzLQ4uSb+hO8xJO8
 V44XwYDGkwlEOZo6ipIMmdhhmhD9H7QZt59jzaJn4obhxGd3UYhTY6HrxsE30ROCHoUK
 UyoeF5OkaYLgbpAfLQ2djyLt9yw428jV76LG8LZcL2XSmWDe8Dvg1TmxR9eVSpBNHZ0x
 y+6VCaprHtWc6Ku3ibuye8xyz1aILhDlYe9Rj8+lIcXuRqiTVo4skuu0hMzIg/CxDAYo
 +x03UpvNkBVzZqs0nRwAsqykRN5rWaAoxrB+45QVUpL4Gw5W45HG2tvKkvMe1Dwe0Z1Z
 Tn9g==
X-Gm-Message-State: ANhLgQ1zmPQfBGLpvX12LL3r+y6m10tkFBfY/AOPNSn0uJB4q4HQYfUk
 ufn27bY39WKLcXX9fGQrSN6651pWVRG0uKE21qIDXI5ed8iu9AcVeXURJc+BWoA2eRnLGyAt3fB
 U36afm7NU4Exl6SU=
X-Received: by 2002:a1c:4d7:: with SMTP id 206mr3754950wme.5.1585666625678;
 Tue, 31 Mar 2020 07:57:05 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vt20bX8cLcjWZW8/qj5zisx4hb73rI+EShQcVb6YRqVRIUYWc/KtesLFJgkX1UcRObq10FVvw==
X-Received: by 2002:a1c:4d7:: with SMTP id 206mr3754931wme.5.1585666625473;
 Tue, 31 Mar 2020 07:57:05 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
 by smtp.gmail.com with ESMTPSA id f187sm4240956wme.9.2020.03.31.07.57.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2020 07:57:04 -0700 (PDT)
Date: Tue, 31 Mar 2020 10:57:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/10] MAINTAINERS: Add myself as virtio-balloon co-maintainer
Message-ID: <20200331145631.135630-3-mst@redhat.com>
References: <20200331145631.135630-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200331145631.135630-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
 David Hildenbrand <david@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Markus Armbruster <armbru@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

As suggested by Michael, let's add me as co-maintainer of virtio-balloon.
While at it, also add "balloon.c" and "include/sysemu/balloon.h" to the
file list.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20200312133725.8192-1-david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b5c86ec494..e580276603 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1634,6 +1634,15 @@ F: hw/virtio/trace-events
 F: net/vhost-user.c
 F: include/hw/virtio/
=20
+virtio-balloon
+M: Michael S. Tsirkin <mst@redhat.com>
+M: David Hildenbrand <david@redhat.com>
+S: Maintained
+F: hw/virtio/virtio-balloon*.c
+F: include/hw/virtio/virtio-balloon.h
+F: balloon.c
+F: include/sysemu/balloon.h
+
 virtio-9p
 M: Greg Kurz <groug@kaod.org>
 R: Christian Schoenebeck <qemu_oss@crudebyte.com>
--=20
MST


