Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E456C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 09:38:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1255206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 09:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wt+JgJ0c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1255206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfguB-0005P4-54
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 05:38:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfgtc-0004xc-K5
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 05:38:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24275
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfgtb-0007S0-Lq
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 05:38:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591004295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=A6IuMVBo3w0VRUGSdpAL1rExyTTAdFr6jjDb7IBj4CA=;
 b=Wt+JgJ0cROSHJ89sMxqiRXgGmKx4t+WRWL6MO0yLz7zEGbT0Vsq5Wn7OiCcVpnIEczwOM2
 HEbkrB7GC4xwjQche863/MRSp0XWzMC9zCJ8zRMtFUE3RI7tF5YzcY6pVGHRpJu/cMNyjN
 K1cQ2eZY9ZSVlDUnZkYVCQ8kiXiMn40=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-KVeX3DGHMCuURFhkW2EXjA-1; Mon, 01 Jun 2020 05:38:11 -0400
X-MC-Unique: KVeX3DGHMCuURFhkW2EXjA-1
Received: by mail-wr1-f69.google.com with SMTP id n6so4675055wrv.6
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 02:38:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=A6IuMVBo3w0VRUGSdpAL1rExyTTAdFr6jjDb7IBj4CA=;
 b=Gryl0EPAqG0BhBtUyFtc/IaDzBuhZGWI07PMBMMAyGOzYhLrN/22W0EmvVaiAVjy9W
 6Sm8p5ngU6TzMktB1YEkZckxU+QEmI0JN5K107/p/5uvmwEdSTLioH0F5nhf00oIXVj6
 FDNctiXxefQ36d4PKg99Jtkev01Xmgt3sN6d912WDLAMKjjL0mhVIq206PnytjCOWWA0
 ELvN1ajL1fskmyqQIOxSrK/YXgQRFQnL0kP8/+9HDg0FZIgVBo7q67qEErJUFIokxdH2
 tHvQ913Q6dBzS8ZDVELcljuLH4cEOX9qy9MfWAXEceODi/xNIhNdiw8LuG0RgeqCPCB8
 3IIg==
X-Gm-Message-State: AOAM533mQuGhQfJa7KkenpLg0SIxF55MG4Np979cIem2jpV6zNKXiZCh
 Gtv3LE4UhhPhInvJBdDWJGf8Z0JkqHH5rlvk5n8E1AxQol78V96jUlU/YG7cL8G9qleHC/WMJqy
 PTjJwXW8BGgzeCdg=
X-Received: by 2002:adf:ec03:: with SMTP id x3mr21025452wrn.297.1591004290231; 
 Mon, 01 Jun 2020 02:38:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwm5iK+NWZaCD7/vg4ESVQf5wukLhK2K6zrbITsXuHe0e2Tbz5zoIcXjdBgWMTHQEpFTkT41w==
X-Received: by 2002:adf:ec03:: with SMTP id x3mr21025442wrn.297.1591004290036; 
 Mon, 01 Jun 2020 02:38:10 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id z132sm13020375wmc.29.2020.06.01.02.38.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 02:38:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH] qemu/thread: Mark qemu_thread_exit() with 'noreturn'
 attribute
Date: Mon,  1 Jun 2020 11:38:08 +0200
Message-Id: <20200601093808.13102-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 05:35:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

After upgrading to Ubuntu 20.04 LTS, GCC 9.3 complains:

  util/qemu-thread-posix.c: In function ‘qemu_thread_exit’:
  util/qemu-thread-posix.c:577:6: error: function might be candidate for attribute ‘noreturn’ [-Werror=suggest-attribute=noreturn]
    577 | void qemu_thread_exit(void *retval)
        |      ^~~~~~~~~~~~~~~~

Fix by marking the qemu_thread_exit function with QEMU_NORETURN
to set the 'noreturn' attribute.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
RFC because I'm not sure the error is correct, or we should
simply ignore it by default with -Wno-suggest-attribute=noreturn.
---
 include/qemu/thread.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/qemu/thread.h b/include/qemu/thread.h
index d22848138e..06c058fb58 100644
--- a/include/qemu/thread.h
+++ b/include/qemu/thread.h
@@ -177,7 +177,7 @@ void qemu_thread_create(QemuThread *thread, const char *name,
 void *qemu_thread_join(QemuThread *thread);
 void qemu_thread_get_self(QemuThread *thread);
 bool qemu_thread_is_self(QemuThread *thread);
-void qemu_thread_exit(void *retval);
+void qemu_thread_exit(void *retval) QEMU_NORETURN;
 void qemu_thread_naming(bool enable);
 
 struct Notifier;
-- 
2.21.3


