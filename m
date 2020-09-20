Return-Path: <SRS0=9ZvH=C5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61846C43463
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 03:01:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43516208C3
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 03:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="Ya9OQWDM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43516208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJpbp-000312-BD
	for qemu-devel@archiver.kernel.org; Sat, 19 Sep 2020 23:01:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antonkuchin@yandex-team.ru>)
 id 1kJpa1-0002Qp-Ia
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 22:59:57 -0400
Received: from forwardcorp1o.mail.yandex.net ([2a02:6b8:0:1a2d::193]:43426)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antonkuchin@yandex-team.ru>)
 id 1kJpZx-000511-9X
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 22:59:56 -0400
Received: from iva8-d077482f1536.qloud-c.yandex.net
 (iva8-d077482f1536.qloud-c.yandex.net
 [IPv6:2a02:6b8:c0c:2f26:0:640:d077:482f])
 by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 70E982E1595;
 Sun, 20 Sep 2020 05:59:45 +0300 (MSK)
Received: from iva8-88b7aa9dc799.qloud-c.yandex.net
 (iva8-88b7aa9dc799.qloud-c.yandex.net [2a02:6b8:c0c:77a0:0:640:88b7:aa9d])
 by iva8-d077482f1536.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id
 sxI2qWIZvS-xjvCaikC; Sun, 20 Sep 2020 05:59:45 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1600570785; bh=AnGlemRkzuB2qAqDxXeZeh6SQhepMa77SVMgbAW8muY=;
 h=Date:Message-ID:To:Subject:From:Cc;
 b=Ya9OQWDMtA8hILM9P5EKLSSDofKiuyry92vFmBCRvfuUWPmybOlsqVMFZCYrEM1sn
 Me+CPWVZvLfACjO4uv+C5gTEC7pDfwb49LkXzmCNrpFWUODQNwg/cmIdnmHN6Oh9lL
 iOuog+Ln6csK+cb1EQi8B+2xjPLoQ2uyp436M18M=
Authentication-Results: iva8-d077482f1536.qloud-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-iva.dhcp.yndx.net (dynamic-iva.dhcp.yndx.net
 [2a02:6b8:b080:9005::1:1])
 by iva8-88b7aa9dc799.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 to26qVMTri-xjmODWKX; Sun, 20 Sep 2020 05:59:45 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client certificate not present)
From: Anton Kuchin <antonkuchin@yandex-team.ru>
Subject: vhost-user: questions regarding migration
To: qemu-devel@nongnu.org
Message-ID: <6ef03e9e-aaff-ce20-7f61-0771fcf007eb@yandex-team.ru>
Date: Sun, 20 Sep 2020 05:59:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------5A408325C0C21AAA82EE7F25"
Content-Language: en-US
Received-SPF: pass client-ip=2a02:6b8:0:1a2d::193;
 envelope-from=antonkuchin@yandex-team.ru; helo=forwardcorp1o.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: yc-core@yandex-team.ru, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------5A408325C0C21AAA82EE7F25
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

I'm implementing migration support in vhost-user backend and have a
couple of questions:

1. How master can be sure that logging was started?

We expect that right after set_fatures command with VHOST_F_LOG_ALL flag
all memory modifications will be tracked in log, but slave can need a
little time to process this command so there is a chance that some
requests can be untracked. Is there a way to ensure all requests are
logged or determine the moment since when tracking starts and master can
start migrating memory?

2. Why do we need separate log_addr for vring and how can it be not
covered by mem table?

As far as I understand slave receives used address in set_vring_addr
command and to map it correctly we do need valid entry in memory table.
So this field looks redundant to me. Am I missing something?

BTW the word "log_guest_addr" is mentioned only once in the document and
in "vring address description" payload it is just called "log",
shouldn't we should change this names to match?


--------------5A408325C0C21AAA82EE7F25
Content-Type: application/pgp-keys;
 name="pEpkey.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="pEpkey.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
=3DhqCi
-----END PGP PUBLIC KEY BLOCK-----

--------------5A408325C0C21AAA82EE7F25--

