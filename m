Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9481C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 14:44:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B49DA206A3
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 14:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E0oiMPfZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B49DA206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYW9E-0003YB-Og
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 10:44:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jYW8J-0002ct-L2
 for qemu-devel@nongnu.org; Tue, 12 May 2020 10:43:47 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47592
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jYW8I-00041C-1F
 for qemu-devel@nongnu.org; Tue, 12 May 2020 10:43:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589294625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FQKW6TBh4t9zmYp0B9781KLY+yGuF22r24HrsYvALyQ=;
 b=E0oiMPfZITpGJVz9XE37AaigsP7ITt9LjVvPbjYKYzFVBVx2Jf+tQOb0T82hhkteCOoVSG
 z6eQ9GeRoyW/kzAiz0XtlTkXh15mj4Sa/DwVDF7FDNz2Ai6hp4wtPtWmYH0sIfEpabnMVk
 omyplbialYLSaJMjldej+llswCYjtx0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-gUnJ9uM_PUCVUjYzAR305g-1; Tue, 12 May 2020 10:43:41 -0400
X-MC-Unique: gUnJ9uM_PUCVUjYzAR305g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3238801504;
 Tue, 12 May 2020 14:43:39 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-74.ams2.redhat.com [10.36.114.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A8D6D5D9E5;
 Tue, 12 May 2020 14:43:30 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [RFC PATCH 0/3] block: Synchronous bdrv_*() from coroutine in
 different AioContext
Date: Tue, 12 May 2020 16:43:15 +0200
Message-Id: <20200512144318.181049-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 02:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, s.reiter@proxmox.com,
 armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com,
 t.lamprecht@proxmox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Stefan (Reiter), after looking a bit closer at this, I think there is no
bug in QEMU, but the bug is in your coroutine code that calls block
layer functions without moving into the right AioContext first. I've
written this series anyway as it potentially makes the life of callers
easier and would probably make your buggy code correct.

However, it doesn't feel right to commit something like patch 2 without
having a user for it. Is there a reason why you can't upstream your
async snapshot code?

The series would also happen fix a bug in my recent patch to convert
qmp_block_resize() to coroutines, but I feel it's not how I would
naturally fix it. Switching the thread already in the QMP handler before
calling bdrv_truncate() would feel more appropriate. I wonder if it
wouldn't actually be the same for your snapshot code.

Kevin Wolf (3):
  block: Factor out bdrv_run_co()
  block: Allow bdrv_run_co() from different AioContext
  block: Assert we're running in the right thread

 block/io.c | 122 ++++++++++++++++++++---------------------------------
 1 file changed, 45 insertions(+), 77 deletions(-)

-- 
2.25.3


