Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFB2C55191
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 20:22:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43F7A20724
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 20:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q33MOWoQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43F7A20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRiN5-0006yt-3v
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 16:22:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55348)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRiLr-0004Ya-9V
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 16:21:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRiLq-0003Nq-Q7
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 16:21:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35436
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jRiLq-0003NW-CO
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 16:21:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587673297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8pU1FGRWMr9wFChCxvp9YPnfOkoE9DOPVGwWc1xi51Q=;
 b=Q33MOWoQ18/7I8W2f1MoeeYEhTzGsmvkdY4RA97mnxLuivJukReZua5pjpM7IMEoDZQgBt
 N4cbFxIQMscZFglJN6N79VvyCbWLdpDgNm/8RQ3oFGqZ++F+Lhe15f7CxgnN8eEdii1aLd
 e2JM8kl0kCqA1XRSK/gb608keh9z4zA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-kYY2Cv8UPfCews5lwClptg-1; Thu, 23 Apr 2020 16:21:36 -0400
X-MC-Unique: kYY2Cv8UPfCews5lwClptg-1
Received: by mail-wr1-f70.google.com with SMTP id x15so3419409wrn.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 13:21:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MAl6CeAivHgSy+VUA/NScy4gWhWpCQWoVZ2DVxmZ3RI=;
 b=sSryivdJIohko6Sm9JmxYwFw+R40GvShYwt5aSuKHqHMUnesJPWz2parZiTT/eyvIG
 y+W7oNYVpdba3LsVGMcy7KLYD++EHLZ2nSQhUXBJjVQnOqwm31tICKZvE6eGrZz5qqcw
 AHMJ6ErHkCRl6NWjf809uCEST2pwIoqbRGd86Ow6Q8ApADw7qYhWXmAFFLoAMv1yVo02
 NRF7Q/5OfF021ABThatjs6sJI1rmSHIFsZjVT9ICAFm2Jskg3qZEH0UnS1uACNgk4SJ4
 r6em8nzfGXMO2H1yWzFaHKe9clV3Cw0HsqYII7B1U6kVhIjT19wt6KLYsmliDM4/LpTw
 7dLg==
X-Gm-Message-State: AGi0PuaC3pkIrp7FlytD7orOprWcWRdyw9x3iyDLYmZJrp6ueQfeqUZM
 5JxdRfoztVWj3t7RuMRhiwC5P9RkSpNUhUQblEApgbuD1Ou7ZVK5972bmXQMBxEGw7dnu8bhBzC
 7RKILGlQMKyMBgck=
X-Received: by 2002:adf:ee0c:: with SMTP id y12mr7508969wrn.0.1587673294669;
 Thu, 23 Apr 2020 13:21:34 -0700 (PDT)
X-Google-Smtp-Source: APiQypKQPnNcVHQhQ8nOPRlwicSuLfqzuDvwPh7mi8p/kAH4cmdhld0jq1TGlV9yfLAOzZvnBfVicA==
X-Received: by 2002:adf:ee0c:: with SMTP id y12mr7508943wrn.0.1587673294395;
 Thu, 23 Apr 2020 13:21:34 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id j13sm5196975wro.51.2020.04.23.13.21.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2020 13:21:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/7] chardev: Restrict msmouse / wctablet / testdev to system
 emulation
Date: Thu, 23 Apr 2020 22:21:08 +0200
Message-Id: <20200423202112.644-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200423202112.644-1-philmd@redhat.com>
References: <20200423202112.644-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 16:21:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John G Johnson <john.g.johnson@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The msmouse / wctablet / testdev character devices are only
used by system emulation. Remove them from user mode and tools.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 chardev/Makefile.objs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/chardev/Makefile.objs b/chardev/Makefile.objs
index d68e1347f9..15ee7f47da 100644
--- a/chardev/Makefile.objs
+++ b/chardev/Makefile.objs
@@ -17,7 +17,7 @@ chardev-obj-y +=3D char-udp.o
 chardev-obj-$(CONFIG_WIN32) +=3D char-win.o
 chardev-obj-$(CONFIG_WIN32) +=3D char-win-stdio.o
=20
-common-obj-y +=3D msmouse.o wctablet.o testdev.o
+common-obj-$(CONFIG_SOFTMMU) +=3D msmouse.o wctablet.o testdev.o
 common-obj-$(CONFIG_BRLAPI) +=3D baum.o
 baum.o-cflags :=3D $(SDL_CFLAGS)
 baum.o-libs :=3D $(BRLAPI_LIBS)
--=20
2.21.1


