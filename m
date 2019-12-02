Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C312C432C3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 12:36:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25988205ED
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 12:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="08m3UFvZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25988205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibkw9-0005Bg-VZ
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 07:36:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51960)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1ibkua-0003lK-6q
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 07:34:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1ibkuZ-0004gu-9k
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 07:34:44 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50253)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1ibkuY-0004dP-Sv
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 07:34:43 -0500
Received: by mail-wm1-x342.google.com with SMTP id p9so1721602wmg.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 04:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=0pgu67RsY3mQn8uOWezGaVK3XvvOJby1xuwXHBa8RXA=;
 b=08m3UFvZZfUvM2UwZDYh291v4FDVNflnfIiCKvDXUUEPFqpeyG9L1in8mlXgSm+EqS
 MZ4jI/RJIaN78acUJjpT2iuHyp5dFmZfYIunMEMno6zdKuKXBYts2+PBwNYuSKpFD2S6
 qySejW65hY8ELaO82/TejbWzt4qU/w71LqEYFcR2X8GUVJsFIpMsZnAKO5IzLhtyhfne
 GB8MXZHEi1ejQhQ+GuO5xWOJqKtnRMw5ZHlBKJFUisIVaV82i2NdvUCTLQUwFPBTcRoV
 y6gAKrD8SPVjlgol3LEPzG/4zSL1tRyoRulcbIKZmWOebA6RCYQo1xKsNzlWX4nIkP47
 v0xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=0pgu67RsY3mQn8uOWezGaVK3XvvOJby1xuwXHBa8RXA=;
 b=YqR4MUJIkenD8Fprk+NsuW6I/M7gTUdoHoxQOk4pv42rZwsIdzL6NIg1vgdxoFk+6C
 CoWBSOin13xIQMJBB4FZOnAky0uS+zRpfiqYNjs0kMMbLWy4IUn1HyAFCErLA93w1TqK
 EjJs+mGnrVAnyih3aLM9drcqAGCrNJOLlmt/zLnoKWiHIj/1QqITB2bLrvQUS9sMcpVD
 8OUW3ejPQAv5BvZQMkWs9mvnIGVej9/G4OCqzWO5WA5comH6p71SVvrZCvyzFFS48KUR
 OKwNZeMQ203fqoH65AhCfhjv9HQHxlgvYZaYpQva/0f6WYcxhsJ0oG/fCOOuFyQhXTDv
 TSgw==
X-Gm-Message-State: APjAAAUF7plbLtY0X31SKw291e12xCF43VN/8Ore6frVVCj7Xnhx+jbe
 MiMSUwBFyBb6WA1ZpCNcMty4Fw==
X-Google-Smtp-Source: APXvYqw6dcpBUFREBxqD3Jnd5AmCejtRlHjdRmaRXi5QB9QFjqDA76MB+9bsoSeg/hdELQBoasF6tA==
X-Received: by 2002:a1c:8055:: with SMTP id b82mr2733422wmd.127.1575290078802; 
 Mon, 02 Dec 2019 04:34:38 -0800 (PST)
Received: from f2.redhat.com (bzq-79-182-78-197.red.bezeqint.net.
 [79.182.78.197])
 by smtp.gmail.com with ESMTPSA id k8sm17134658wrl.3.2019.12.02.04.34.37
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 02 Dec 2019 04:34:38 -0800 (PST)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, kraxel@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH 0/2] Remove 'remote wakeup' flag from USB config descriptor
Date: Mon,  2 Dec 2019 14:34:28 +0200
Message-Id: <20191202123430.7125-1-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: yan@daynix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series of patches addresses possible functional problem of USB
devices with 'remote wakeup' capability, redirected to Windows VM
(local redirection using libusb or spice redirection using usbredir).

Yuri Benditovich (2):
  usb-host: remove 'remote wakeup' flag from configuration descriptor
  usb-redir: remove 'remote wakeup' flag from configuration descriptor

 hw/core/machine.c    |  2 ++
 hw/usb/host-libusb.c | 18 ++++++++++++++++++
 hw/usb/redirect.c    | 19 +++++++++++++++++++
 hw/usb/trace-events  |  1 +
 4 files changed, 40 insertions(+)

-- 
2.17.1


