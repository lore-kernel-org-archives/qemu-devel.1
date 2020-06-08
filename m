Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC5DC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:32:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9A522053B
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BPDfi87C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9A522053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiKhm-0008E0-14
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 12:32:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38602)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiKI1-0002gw-61
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:06:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25227
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiKI0-0000Fg-1P
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:06:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591632379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IQ2Zwmt+Uey5o0Uah3Zvdno8y42e5J5YjRZjcD6UUkc=;
 b=BPDfi87CHOysbUP2eYSpqIkK6sV5T6M6cSB+Ar5y1KMAyDkZuLdMXYAwcrUZwy1WjQxCL0
 GxXPNGwwoVeIVkZUjoqOMzm9iEAhIc3JyZDwan8wFNixwWCU9Tag6pqCELUL5xFmipLHg6
 mj809kfge3jdCcoktyKzgZmzXEPFxVk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-6HbYzaKfOuCYxe-G1LFokA-1; Mon, 08 Jun 2020 12:06:15 -0400
X-MC-Unique: 6HbYzaKfOuCYxe-G1LFokA-1
Received: by mail-wr1-f72.google.com with SMTP id d6so7343766wrn.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 09:06:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=IQ2Zwmt+Uey5o0Uah3Zvdno8y42e5J5YjRZjcD6UUkc=;
 b=S9Cyl+lK+jLEwabC/NprPq0S25rV/6Y+RPWewrtY9zypQvBQG1ZUT8is1ApKEblLgS
 LQ8KMnDfLFfFGeLEWMuJ+ijLp/BXm7bBfZMygEapp126fCYbzH9f0p1YqwF3jJDXFGwM
 QzejFB+jP76Qf7Yc95rOyGFDJz2wJXyap7cUPVrB7Ol//rHZYeJ6eJ4HJlATTKH5N2q8
 1hJ5KhO0PDT7gUJYYJ2vjHfLcEFVjHhdutPF2JqJvdXDF4jQRgfORNOhmae6emWwb+Yc
 CYQX8F/8ZDa4THlhtkEDbqOqelfOC6WbCDCZIu6Plt8rn8x7SQKCASlkfyh2B6AS3XS1
 s1Hg==
X-Gm-Message-State: AOAM5311N0NfpdsF/fgFaRBxuF6i5ddUqQ7Hl6KxU7862eUNEgKvpqxt
 kp6FspHCgXxRi0FZl8s2FYVIQ8k3fcki828NfwHwuqKaYqRTtvHvJerTswUqh3s6AUZpehQiauE
 dk8HVTJM47Dl4oIY=
X-Received: by 2002:a05:6000:1104:: with SMTP id
 z4mr24024570wrw.272.1591632374450; 
 Mon, 08 Jun 2020 09:06:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyPKGJLisyMOH/ojvihDYa0lan6gnwMhb7yaO/6lsrH3bKYJhiQTZOhUJwlTONMDJsyX94C8g==
X-Received: by 2002:a05:6000:1104:: with SMTP id
 z4mr24024548wrw.272.1591632374222; 
 Mon, 08 Jun 2020 09:06:14 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id j4sm48617wma.7.2020.06.08.09.06.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 09:06:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org, =?UTF-8?q?Martin=20Li=C5=A1ka?= <mliska@suse.cz>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH v2] hw/openrisc/openrisc_sim: Add assertion to silence GCC
 warning
Date: Mon,  8 Jun 2020 18:06:11 +0200
Message-Id: <20200608160611.16966-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 05:40:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Jia Liu <proljc@gmail.com>, qemu-trivial@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, 1874073@bugs.launchpad.net,
 Christophe de Dinechin <dinechin@redhat.com>,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When compiling with GCC 10 (Fedora 32) using CFLAGS=-O2 we get:

    CC      or1k-softmmu/hw/openrisc/openrisc_sim.o
  hw/openrisc/openrisc_sim.c: In function ‘openrisc_sim_init’:
  hw/openrisc/openrisc_sim.c:87:42: error: ‘cpu_irqs[0]’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
     87 |         sysbus_connect_irq(s, i, cpu_irqs[i][irq_pin]);
        |                                  ~~~~~~~~^~~

While humans can tell smp_cpus will always be in the [1, 2] range,
(openrisc_sim_machine_init sets mc->max_cpus = 2), the compiler
can't.

Add an assertion to give the compiler a hint there's no use of
uninitialized data.

Buglink: https://bugs.launchpad.net/qemu/+bug/1874073
Reported-by: Martin Liška <mliska@suse.cz>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Tested-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
v2: Fixed typo in subject (eblake)
Supersedes: <20200608071409.17024-1-philmd@redhat.com>
---
 hw/openrisc/openrisc_sim.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index d08ce61811..02f5259e5e 100644
--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -134,6 +134,7 @@ static void openrisc_sim_init(MachineState *machine)
     int n;
     unsigned int smp_cpus = machine->smp.cpus;
 
+    assert(smp_cpus >= 1 && smp_cpus <= 2);
     for (n = 0; n < smp_cpus; n++) {
         cpu = OPENRISC_CPU(cpu_create(machine->cpu_type));
         if (cpu == NULL) {
-- 
2.21.3


