Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4356C388F9
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 20:50:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 512BE206D4
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 20:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="He7CYrvR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 512BE206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbreK-0008Hw-Eb
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 15:50:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbraj-0003xd-NV
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 15:47:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21215)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbrah-0000Tp-PH
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 15:47:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604868430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5NBaRkUn5YAYhPpHLZeqVOEAZ8strin9MJlCWv9hP5E=;
 b=He7CYrvRrpXdUCjSHT5UUXMSsWRFEym9APwgObgD2h/eYFiQopXm03f4gVT2c0nIyH+ewr
 WRtgD2e6ZYy6crx0/YBvcum3f0uyalyWnsuJs7l8tOsMl8ihf+0tG1zaQhaewVG38NRLLn
 +iyUwIBfjcVJz/pG/tWe62iK1AoP5ik=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-XtZRne2CNUip9tiJPRIqcg-1; Sun, 08 Nov 2020 15:47:09 -0500
X-MC-Unique: XtZRne2CNUip9tiJPRIqcg-1
Received: by mail-wr1-f69.google.com with SMTP id 67so3401553wra.2
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 12:47:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5NBaRkUn5YAYhPpHLZeqVOEAZ8strin9MJlCWv9hP5E=;
 b=mfyTNz+HVOFDhzHDua/fihQ3uftlWIOanvllHPchFTGAlssncmngJQRvNudD2qCcv8
 ShV0aCLrx7eRQirahYqnjqJtWOJ45J3+KZ2wxuJH++OE4hWCyntp2aEf6GWueK7693/6
 LYS8XjBV1lkkIhBuBB3bqP882TSdIj+v8x7ErWZ5JWhf+JdWZMUkVxm6pTwGwOIxGIrb
 yU2wiTFjgaBVp2efwrvyCg7ziCketoMaPadm5kydkTON0LYjO0d/O704estUfCrMFjvI
 tJF5Xh12SwyswfR4FkRP2b3IZMFWZtcMWw4zcEecPOhrk3YA4cnTufyETr8TlFR/bgAj
 yv2A==
X-Gm-Message-State: AOAM5302b3p0uKq05V9poL2RRkP+vxQB8lHSx40Mha23VrOr+l6THoIN
 03bEj8V6YgraxNIA/9N9/jG/UnFrPS+DvD2K4VCSTkyJ8V3/kVEAPTHWsDWBxlN3qJtW0xlkSb+
 kJaSdzrUvruNY2gs=
X-Received: by 2002:a5d:5082:: with SMTP id a2mr14202755wrt.417.1604868427644; 
 Sun, 08 Nov 2020 12:47:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwknkLe87CG9Vs2damW/2NhZh5JvrWKcBdxiiHNL69MXrc1f+vsepWoNI1MEUzdyCP3wyocKQ==
X-Received: by 2002:a5d:5082:: with SMTP id a2mr14202736wrt.417.1604868427458; 
 Sun, 08 Nov 2020 12:47:07 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id d63sm10307371wmd.12.2020.11.08.12.47.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2020 12:47:06 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 v4 02/17] meson: always include contrib/libvhost-user
Date: Sun,  8 Nov 2020 21:45:20 +0100
Message-Id: <20201108204535.2319870-3-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201108204535.2319870-1-philmd@redhat.com>
References: <20201108204535.2319870-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/08 09:03:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

libvhost-user is needed when CONFIG_LINUX is set. The CONFIG_VHOST_USER
check in meson.build is incorrect.

In fact, no explicit check is needed since this dependency is not built
by default. If something declares a dependency on libvhost-user then it
will be built, otherwise it won't be built (i.e. on non-Linux hosts).

This fixes ./configure --disable-vhost-user && make.

Fixes: bc15e44cb2191bbb2318878acdf5038134e56394 ("configure: introduce --enable-vhost-user-blk-server")
Reported-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reported-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20201106210340.698771-1-stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 meson.build | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/meson.build b/meson.build
index f5175010dfa..b4736203219 100644
--- a/meson.build
+++ b/meson.build
@@ -1450,11 +1450,7 @@
   'util',
 ]
 
-vhost_user = not_found
-if 'CONFIG_VHOST_USER' in config_host
-  subdir('contrib/libvhost-user')
-endif
-
+subdir('contrib/libvhost-user')
 subdir('qapi')
 subdir('qobject')
 subdir('stubs')
-- 
2.26.2


