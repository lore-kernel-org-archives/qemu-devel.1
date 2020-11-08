Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10384C388F9
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 06:35:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B1F820719
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 06:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hostfission.com header.i=@hostfission.com header.b="QFjdQ9e1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B1F820719
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=hostfission.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbeIJ-0001bg-Ei
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 01:35:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51208)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <root@moya.office.hostfission.com>)
 id 1kbeH9-0000kz-FC
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 01:34:07 -0500
Received: from mail1.hostfission.com ([139.99.139.48]:35116)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <root@moya.office.hostfission.com>)
 id 1kbeH7-0003Da-Qd
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 01:34:07 -0500
Received: from moya.office.hostfission.com (office.hostfission.com
 [220.233.29.71])
 by mail1.hostfission.com (Postfix) with ESMTP id 343E244A96;
 Sun,  8 Nov 2020 17:34:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hostfission.com;
 s=mail; t=1604817242;
 bh=ExqUQewmtf+h7e5Nlvh47OkHR0dMGRDLNMdxFaIbe1o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QFjdQ9e18WicJMj/o5vS7Y3KHO3LdatVmdKzhL7Ajrdjyb24vKJIn+9lOpBoZCe0H
 tBW4Kv4z2B8v1vxuwYgwZhCNYtlxMctIIRZONe6JJwaCcoy+eY7HSkL+BAmTquM9Fr
 wFADGcX+S+6XA80weDhCTK26XpkRXeF22VzaHsB4=
Received: by moya.office.hostfission.com (Postfix, from userid 0)
 id 100E83A0210; Sun,  8 Nov 2020 17:34:01 +1100 (AEDT)
From: Geoffrey McRae <geoff@hostfission.com>
To: qemu-devel@nongnu.org
Cc: Geoffrey McRae <geoff@hostfission.com>, kraxel@redhat.com,
 pbonzini@redhat.com, qemu_oss@crudebyte.com
Subject: [PATCH v10 0/1] audio/jack: fix use after free segfault
Date: Sun,  8 Nov 2020 17:33:49 +1100
Message-Id: <20201108063351.35804-1-geoff@hostfission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201107000458.8754-1-geoff@hostfission.com>
References: <20201107000458.8754-1-geoff@hostfission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=139.99.139.48;
 envelope-from=root@moya.office.hostfission.com; helo=mail1.hostfission.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/08 01:34:04
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v10:
  * fixed typo in commit message
  * qjack_shutdown_lock is now static

Geoffrey McRae (1):
  audio/jack: fix use after free segfault

 audio/jackaudio.c | 50 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 13 deletions(-)

-- 
2.20.1


