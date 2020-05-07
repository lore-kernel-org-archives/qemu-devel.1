Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9DCC38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 12:12:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2D1E2075E
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 12:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aUBk52BX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2D1E2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWfOU-0002PV-1y
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 08:12:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jWfNN-0000do-2J
 for qemu-devel@nongnu.org; Thu, 07 May 2020 08:11:41 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48702
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jWfNM-0001Hg-1P
 for qemu-devel@nongnu.org; Thu, 07 May 2020 08:11:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588853498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yWIK2WHkaZ7PoBsR/efTku5ERSpbN52iLBpjRvBRm84=;
 b=aUBk52BXCW/lsdFzxgvClywrgJ0ngBgMVxqi9Kev8My+bSKBAKmIXbnOGSaky99tUpFAtb
 TxstpQ5DUcEdh5pYhSLAxcD3zSjCAmxU/gDZyAIQuF78iF+xHIohR9/kTxB59JDcDkyw4E
 cjWNVVAA7b9ZG9Y7i8vf0p2qr5h+cyY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-I4pGUAoqPf-mvMn6P8058Q-1; Thu, 07 May 2020 08:11:37 -0400
X-MC-Unique: I4pGUAoqPf-mvMn6P8058Q-1
Received: by mail-wm1-f69.google.com with SMTP id 72so3969232wmb.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 05:11:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vkOiz5+/Or/F9UlBm2bD/eJ721rs8ZUrKCeW7YzdojA=;
 b=UHmTDAmfA6mXp+LCMhPZyr13DeUSrd8U9pIqNE7Fd5n2iuB/kal5y9BkpdEnNreR+7
 UxgD03EMtKJY41s7W6hyNElRVHWcqwVctFsdGYN3llovU2JD6ErgO3tW3xWi0ik2AZwA
 FYF29GCC8Bk6OVpOzTfDxDdA/Oxc9+ShV/eW+8oqWiJyxZbdxbmwnBy1aplK4tXqrgaO
 HaXB0gTrOuL+rcjv3jKXHSsH9KrQC6j4Ihs0XuCFTQ3u9WduSQlHffViCSy0evyNKtYU
 51b/ohg7Ocqz8hCIbGY28RgtOnKMfbw6Hu1/BQlQwbut16VpPpR3bkRmbBjW+g0uuxTt
 3umQ==
X-Gm-Message-State: AGi0PuYuF3axPLFGZFpyIKgpCl1FDtismaaUk1H3ymA0EQiRSToHyn2W
 15a/tW18VlNit/c2SHm3x+L2GmcyAbQuxbnqbIVnyEimTQo1amMG/yWfp/vxBjQxukiFuilAZVj
 /8zn9AuYJnYQV+uY=
X-Received: by 2002:adf:e450:: with SMTP id t16mr16420893wrm.301.1588853495830; 
 Thu, 07 May 2020 05:11:35 -0700 (PDT)
X-Google-Smtp-Source: APiQypLoDqmQk78n0oGh5Q7LPEFCvVDqtsjoMbc+seVsA+rilXX6q9Lry+ejELZJgUYNIDTLJHlMvA==
X-Received: by 2002:adf:e450:: with SMTP id t16mr16420879wrm.301.1588853495686; 
 Thu, 07 May 2020 05:11:35 -0700 (PDT)
Received: from x1w.redhat.com (248.red-88-21-203.staticip.rima-tde.net.
 [88.21.203.248])
 by smtp.gmail.com with ESMTPSA id c17sm7889111wrn.59.2020.05.07.05.11.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2020 05:11:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] block/block-copy: Fix uninitialized variable in
 block_copy_task_entry
Date: Thu,  7 May 2020 14:11:28 +0200
Message-Id: <20200507121129.29760-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200507121129.29760-1-philmd@redhat.com>
References: <20200507121129.29760-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 00:55:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix when building with -Os:

    CC      block/block-copy.o
  block/block-copy.c: In function =E2=80=98block_copy_task_entry=E2=80=99:
  block/block-copy.c:428:38: error: =E2=80=98error_is_read=E2=80=99 may be =
used uninitialized in this function [-Werror=3Dmaybe-uninitialized]
    428 |         t->call_state->error_is_read =3D error_is_read;
        |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 block/block-copy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index 03500680f7..83e16c89d9 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -418,7 +418,7 @@ out:
 static coroutine_fn int block_copy_task_entry(AioTask *task)
 {
     BlockCopyTask *t =3D container_of(task, BlockCopyTask, task);
-    bool error_is_read;
+    bool error_is_read =3D false;
     int ret;
=20
     ret =3D block_copy_do_copy(t->s, t->offset, t->bytes, t->zeroes,
--=20
2.21.3


