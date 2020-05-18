Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A76EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 20:30:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFFFD2081A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 20:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="DPI0xN8W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFFFD2081A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jamOf-0006JC-6W
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 16:30:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex-krasikov@yandex-team.ru>)
 id 1jamNA-0004x5-AE
 for qemu-devel@nongnu.org; Mon, 18 May 2020 16:28:28 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:47844)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex-krasikov@yandex-team.ru>)
 id 1jamN4-0007qK-8v
 for qemu-devel@nongnu.org; Mon, 18 May 2020 16:28:24 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net
 [IPv6:2a02:6b8:0:1402::301])
 by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 3891E2E1512;
 Mon, 18 May 2020 23:28:16 +0300 (MSK)
Received: from iva4-7c3d9abce76c.qloud-c.yandex.net
 (iva4-7c3d9abce76c.qloud-c.yandex.net [2a02:6b8:c0c:4e8e:0:640:7c3d:9abc])
 by mxbackcorp1g.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 QAmTkgy0BQ-SF2OYjnN; Mon, 18 May 2020 23:28:16 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1589833696; bh=W99r3mZrkExWEuf5h8tmfMTrnqq8WIsAhrpa19jD6Ws=;
 h=Message-Id:Date:Subject:To:From:Cc;
 b=DPI0xN8WWPOoz+jdt/o7VGFllXUNqGPp6EXckWYIinSaL4eUhMeOZ9dxn5Xe+DGqC
 8QO4CO7GykK8ECXjnxpNcxBIcBVu0l9QbpfOaTQNRrBy1Tk0wpmGFaxe+H4+pLCC7R
 tPkFLy/SOELPkqLThQX+P4Q5n5jwI11FGgtMb83s=
Authentication-Results: mxbackcorp1g.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b081:305::1:5])
 by iva4-7c3d9abce76c.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 nVf2WDt3uL-SFXS7trg; Mon, 18 May 2020 23:28:15 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
From: Alexey Krasikov <alex-krasikov@yandex-team.ru>
To: berrange@redhat.com,
	qemu-devel@nongnu.org
Subject: [PATCH v3 0/3] Add secret_keyring object
Date: Mon, 18 May 2020 23:28:01 +0300
Message-Id: <20200518202804.3761-1-alex-krasikov@yandex-team.ru>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=95.108.205.193;
 envelope-from=alex-krasikov@yandex-team.ru; helo=forwardcorp1o.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 16:28:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: yc-core@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add the ability to store encryption keys in the Linux keyring
facility.

For that, factor out common parts from secret to a new abstract class
secret_common, and introduce new user-creatable secret_keyring class
inheriting from it.
Use '--enable-keyring/--disable-keyring' configuration parameters
to provide this feature.

Example:

$QEMU -object secret_keyring,id=sec0,serial=0x15968230

Alexey Krasikov (3):
  crypto/secret: move main logic from 'secret' to 'secret_common'.
  crypto/linux_keyring: add 'secret_keyring' secret object.
  test-crypto-secret: add 'secret_keyring' object tests.

 configure                       |  63 +++++
 crypto/Makefile.objs            |   2 +
 crypto/secret.c                 | 351 +--------------------------
 crypto/secret_common.c          | 405 ++++++++++++++++++++++++++++++++
 crypto/secret_keyring.c         | 141 +++++++++++
 include/crypto/secret.h         |  20 +-
 include/crypto/secret_common.h  |  68 ++++++
 include/crypto/secret_keyring.h |  45 ++++
 tests/Makefile.include          |   4 +
 tests/test-crypto-secret.c      | 154 ++++++++++++
 10 files changed, 892 insertions(+), 361 deletions(-)
 create mode 100644 crypto/secret_common.c
 create mode 100644 crypto/secret_keyring.c
 create mode 100644 include/crypto/secret_common.h
 create mode 100644 include/crypto/secret_keyring.h

-- 
2.17.1


