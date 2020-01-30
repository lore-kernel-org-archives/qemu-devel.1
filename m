Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83617C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 21:51:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E95120708
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 21:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u52YfGAy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E95120708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixHj7-0006Ng-Gq
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 16:51:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59198)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1ixHWw-00039G-9V
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:39:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1ixHWu-0001Ih-Vo
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:39:18 -0500
Received: from mail-qv1-xf43.google.com ([2607:f8b0:4864:20::f43]:34451)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1ixHWu-0001H1-Qj; Thu, 30 Jan 2020 16:39:16 -0500
Received: by mail-qv1-xf43.google.com with SMTP id o18so2282180qvf.1;
 Thu, 30 Jan 2020 13:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=h5SbyMypGbh8uE4ME+OX7Faq9skFF2b4ce/NxvMRXi0=;
 b=u52YfGAyBg/d63zYVZsqnwxPNDcozpJBjx+d7ScilQLXuJRmW4Lo+Ih3roXV60/j1b
 Iz8Ui6xEKx0bHe9syMosASyD9+ZcgrplAQlYZZeNUSYafpeM44leZMAYTI0RskAap5oR
 g5y+99vy14jch5SEpYBbjzjcMI2Y4cS3cyu105kSU40IjpZ9PAZBWXBqYpo5pR7RMG0X
 W9xvODT+gWLCD0aYuR0T6AhyUxayOzZlHCgKM4ru4aduYqK6hIxZmeNRXdrnfXGqvwdT
 KgF4DPpnsusTcZ6Pw+VJ4VX87dJeAe7/grfHc2GkWf71KxetvdP9O4+/folwp7CvQCTs
 L+HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=h5SbyMypGbh8uE4ME+OX7Faq9skFF2b4ce/NxvMRXi0=;
 b=Z5bcL5Qw+MuwmO0QAaFb9eXiptdxNIqlM3DFO29un3L4gZ75n+CNFJ8cMd+vKSdmgE
 7vmClqoy3zi1QegDk8cYwFYzAfqq+fTaDXjMOhtTGkGJYlrQAcgoFOx+7WDj9wmsLeNx
 1NAfe3fZPoxaoOIUxenad972qpdAK464F5NS9OmQ25qjnSkfrSOLSISjUgPEkzhT4KZJ
 94KriJycenbzEmBid0ZVWCckeWipe88LoCeGmXLCsT5z/xpwgSUeKVdnufmKuragrmID
 1hjTRRWP9a7TcwynLb9B9jyMsdJIP5sfkfwGhUACr6eWBpXP1AwPNh8iQaUv6bB9WfQ3
 2j+Q==
X-Gm-Message-State: APjAAAUPx5U9Sy2KBuQXLu4l5XxK8fGhpUa25t4UcoE1zF+O1eYMB7eH
 pLfsyUyCD0uI2WMDx8KFrfgyMX2E
X-Google-Smtp-Source: APXvYqwR7W8rsPFY+GGY5SUQqmNEKYGS1nTxp5eVAxfVB16sGGBugTsJEPaqGE8evEaNRW5LuOL1tw==
X-Received: by 2002:ad4:53a5:: with SMTP id j5mr7064662qvv.239.1580420355455; 
 Thu, 30 Jan 2020 13:39:15 -0800 (PST)
Received: from rekt.ibmuc.com ([2804:431:c7c7:c177:887c:ce1b:6a44:15ec])
 by smtp.gmail.com with ESMTPSA id f26sm3650597qtv.77.2020.01.30.13.39.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2020 13:39:15 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 0/4] delete created files when
 block_crypto_co_create_opts_luks fails
Date: Thu, 30 Jan 2020 18:39:03 -0300
Message-Id: <20200130213907.2830642-1-danielhb413@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f43
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
Cc: kwolf@redhat.com, Daniel Henrique Barboza <danielhb413@gmail.com>,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The version 8 of this patch series got buried and it's now
conflicting with master. Rebase and re-sending it.

Also, I contemplated the idea of moving/copying the password
verification in qcrypto_block_luks_create() all the way back to the
start of block_crypto_co_create_opts_luks(), failing early before the
bdrv_create_file(), avoiding the problem altogether without the
need of a delete_file API I'm trying to push here (see patch 03
commit message for detailed info about the bug).

This idea was dropped after I saw that:

- We would need to store the resulting password, now being retrieved
early in block_crypto_co_create_opts_luks(), in a new
QCryptoBlockCreateOptions string to be used inside
qcrypto_block_luks_create() as intended. An alternative would be to
call qcrypto_secret_lookup_as_utf8() twice, discarding the first
string;

- There are a lot of ways to fail in qcrypto_block_luks_create()
other than a non-UTF8 password that would trigger the same problem.
A more appropiate way of doing what I intended, instead of
copying/hacking code around to fail before bdrv_create(), is some sort
of bdrv_validate() API that would encapsulate everything that is
related to user input validation for the security drivers. This
API could then be called before the file creation (maybe inside
bdrv_create itself) and fail early if needed. This is too overkill
for what I'm trying to fix here, and I'm not sure if it would be
a net gain compared to the delete_file API.


All that said, I believe that this patch series presents a sane
solution with the code we have ATM.


changes in this version:
- rebase with current master at 204aa60b37
- previous version:
https://lists.gnu.org/archive/html/qemu-devel/2019-11/msg01551.html


Daniel Henrique Barboza (4):
  block: introducing 'bdrv_co_delete_file' interface
  block.c: adding bdrv_co_delete_file
  crypto.c: cleanup created file when block_crypto_co_create_opts_luks
    fails
  qemu-iotests: adding LUKS cleanup for non-UTF8 secret error

 block.c                    | 26 +++++++++++++++
 block/crypto.c             | 18 ++++++++++
 block/file-posix.c         | 23 +++++++++++++
 include/block/block.h      |  1 +
 include/block/block_int.h  |  4 +++
 tests/qemu-iotests/282     | 67 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/282.out | 11 +++++++
 tests/qemu-iotests/group   |  1 +
 8 files changed, 151 insertions(+)
 create mode 100755 tests/qemu-iotests/282
 create mode 100644 tests/qemu-iotests/282.out

-- 
2.24.1


