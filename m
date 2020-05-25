Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F50C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 11:18:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CBAF2071A
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 11:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="pXSpNGxM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CBAF2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdB7O-0007yX-U1
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 07:18:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57234)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex-krasikov@yandex-team.ru>)
 id 1jdB6W-00073R-So
 for qemu-devel@nongnu.org; Mon, 25 May 2020 07:17:12 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:34856)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex-krasikov@yandex-team.ru>)
 id 1jdB6T-00088o-KD
 for qemu-devel@nongnu.org; Mon, 25 May 2020 07:17:10 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::119])
 by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 2CF692E1498;
 Mon, 25 May 2020 14:17:04 +0300 (MSK)
Received: from vla5-58875c36c028.qloud-c.yandex.net
 (vla5-58875c36c028.qloud-c.yandex.net [2a02:6b8:c18:340b:0:640:5887:5c36])
 by mxbackcorp2j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 PiGnrMeGdC-H3dawHRF; Mon, 25 May 2020 14:17:04 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1590405424; bh=lYZtF9cKtNE1HsIsw4P024z2S6u+r72vbGyHE0bBmMM=;
 h=Message-Id:Date:Subject:To:From:Cc;
 b=pXSpNGxMawoiMYnBzs780KzQmLKWKKuIwqSXY0/tGEQICxkcy0mEHP382ylh7lVbG
 iqRlXiLoP1732Gd3uhwUWzRKN5qiFLBiOYGHeesuOl63WcHUbGQ8PYd64mPbpTuR2p
 Ydzqw8Icmrb+4ImKozUa14Dy+/IGr5VAg45bVbMM=
Authentication-Results: mxbackcorp2j.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b081:518::1:6])
 by vla5-58875c36c028.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 Wf8DxNgJwQ-H3XeSuT9; Mon, 25 May 2020 14:17:03 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
From: Alexey Krasikov <alex-krasikov@yandex-team.ru>
To: berrange@redhat.com,
	qemu-devel@nongnu.org
Subject: [PATCH v4 0/3] Add secret_keyring object
Date: Mon, 25 May 2020 14:16:52 +0300
Message-Id: <20200525111655.4127-1-alex-krasikov@yandex-team.ru>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=5.45.199.163;
 envelope-from=alex-krasikov@yandex-team.ru; helo=forwardcorp1j.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 07:17:04
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

v4 changes:
 - removed all extra white space aligment;
 - removed last NULL parameter from 'object_class_property_add_*' functions;
 - removed the word "support" from configure output summary.
 - removed the 'linux/keyctl.h' include from configure keyutils test;
 - temporary added 'g_test_skip()' at start of the metod
'test_secret_keyring_bad_key_access_right()'.

Alexey Krasikov (3):
  crypto/secret: move main logic from 'secret' to 'secret_common'.
  crypto/linux_keyring: add 'secret_keyring' secret object.
  test-crypto-secret: add 'secret_keyring' object tests.

 configure                       |  62 +++++
 crypto/Makefile.objs            |   2 +
 crypto/secret.c                 | 347 +--------------------------
 crypto/secret_common.c          | 403 ++++++++++++++++++++++++++++++++
 crypto/secret_keyring.c         | 148 ++++++++++++
 include/crypto/secret.h         |  20 +-
 include/crypto/secret_common.h  |  68 ++++++
 include/crypto/secret_keyring.h |  52 +++++
 tests/Makefile.include          |   4 +
 tests/test-crypto-secret.c      | 158 +++++++++++++
 10 files changed, 907 insertions(+), 357 deletions(-)
 create mode 100644 crypto/secret_common.c
 create mode 100644 crypto/secret_keyring.c
 create mode 100644 include/crypto/secret_common.h
 create mode 100644 include/crypto/secret_keyring.h

-- 
2.17.1


