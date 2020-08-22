Return-Path: <SRS0=Iy1T=CA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1252C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 14:29:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8C3B2072D
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 14:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gdmY0961"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8C3B2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9UWC-0008J2-2p
	for qemu-devel@archiver.kernel.org; Sat, 22 Aug 2020 10:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k9UVQ-0007pg-23
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 10:28:28 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20791
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k9UVO-0003DX-Ca
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 10:28:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598106504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Rya/zuWafbehHgcw5lsiJngukITIZWz/iT/Kuq6eJAg=;
 b=gdmY09617zji8We7o8EMxMa1RohWQ3yMoVVCKvhDmyvR9+bDd2iq/aqGho/FTuHXUYsM/j
 GENQeZFE40Yjofe9KgQds9n7+D9KuIyN2sbd4aSL4+da8Z/9V1rDqOC8N6WRBUEEwgCF46
 F7Lxj1Nt2wDcYCkay/1SNJ9LwtctpmY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-kKMxB-tvMHiOy7CrJFictA-1; Sat, 22 Aug 2020 10:28:20 -0400
X-MC-Unique: kKMxB-tvMHiOy7CrJFictA-1
Received: by mail-wr1-f71.google.com with SMTP id t3so1757177wrr.5
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2020 07:28:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Rya/zuWafbehHgcw5lsiJngukITIZWz/iT/Kuq6eJAg=;
 b=f4NEnq9s47HQpaoPRVpeoCgMhyShbC/9IlZGLNyqOm1OJLwk7bgu1r7a9erY3wlfwz
 EDXYowisY9qu6k5RhGw4Ch3/rC3lteV3M3W6kttVw6tjZcD5bQOjXRINlp9FjMVL9VZb
 6Jy94VQ+v5F4QuW5q/UUYKuO2H6SkUbTEEYpJiHQp4EgARzFRQgw3RLuaChQWHCxmhiD
 iIirzFtTk3HMAV+qVeGq98/8bBMzO9QdW4ADInK0YiW9N8L3XYd/xH53sKN+9Uisb2kN
 aeGNJXkSregsMMNCOkCUztD7hrqdG1/dtWjZBEBT3tTeA/LrUpnHh9TAxiSAwUkVS4QV
 mK8w==
X-Gm-Message-State: AOAM533qrO8Hke8Erb1axaD9gqWX060vFet4+s6zQx9YrGEwU2hluka4
 g6ARP8sh6owlaLe3lsDwjWXZUw4xOC5W+HBVyn2IhYmh8wTlPUuUdWOMRpg8wFF/GXm/ehIJI9L
 8S6OsaWu3KtwEEog=
X-Received: by 2002:adf:dfc7:: with SMTP id q7mr4964583wrn.59.1598106499324;
 Sat, 22 Aug 2020 07:28:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxpdmAMej6NDZ8M1XOv7qt+lcjbLK9OM51/K30vMq5CK/W0O8kpd9PsM3hISGHwl2ornv1gPA==
X-Received: by 2002:adf:dfc7:: with SMTP id q7mr4964567wrn.59.1598106499090;
 Sat, 22 Aug 2020 07:28:19 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id t12sm3693023wrm.61.2020.08.22.07.28.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2020 07:28:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] hw/isa/superio: Clean suspicious QOM types
Date: Sat, 22 Aug 2020 16:28:14 +0200
Message-Id: <20200822142816.1318214-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/22 08:31:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix SuperI/O QOM issues reported here:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg731954.html

Supersedes: <20200821173831.1262979-1-philmd@redhat.com>

Eduardo Habkost (1):
  hw/isa/superio: Do not enforce class_size when inherited from parent

Philippe Mathieu-Daudé (1):
  hw/isa/superio: Set abstract TYPE_ISA_SUPERIO instance size

 hw/isa/isa-superio.c       | 2 +-
 hw/isa/smc37c669-superio.c | 2 --
 hw/isa/vt82c686.c          | 2 --
 3 files changed, 1 insertion(+), 5 deletions(-)

-- 
2.26.2


