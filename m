Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3578EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 11:55:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0123F23CD5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 11:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TUvsb12U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0123F23CD5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpsNl-0001LL-7q
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 07:55:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jpsMs-0008WI-Gp
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 07:54:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25683
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jpsMq-0007Fy-Re
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 07:54:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593431671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4+WnwAAoEzBB+5gQEaCkji5FwIjiSpEHzlyEYSIydvY=;
 b=TUvsb12U/qid+iEHna6G9CRKtFBJgHOIleCSLaQOptbQnd1CcNT61hHYe0octEHIcYkuZL
 q00AjBT3FCCD2KulPXXnrlsqj+pc6+jllFBVYn9ikim8fI/Oporg5zGit/EcW6UNtW8gSZ
 KjsAmrMkxTJ4L0HfnZTsPpOwjL3CgWg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-E3girjSyO_2Y74CCFdtbsA-1; Mon, 29 Jun 2020 07:54:30 -0400
X-MC-Unique: E3girjSyO_2Y74CCFdtbsA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0BE0D100A8E9
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 11:54:29 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-114-210.ams2.redhat.com
 [10.36.114.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8D29A96B8F;
 Mon, 29 Jun 2020 11:54:22 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, virtio-fs@redhat.com, stefanha@redhat.com,
 vgoyal@redhat.com
Subject: [PATCH v2 0/3] virtiofsd capability changes and addition
Date: Mon, 29 Jun 2020 12:54:17 +0100
Message-Id: <20200629115420.98443-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 01:37:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi,
  This is a set of changes relating to the capability restirctions
introduced in virtiofsd back in a59feb483b8.
 
The first one is a potentially important fix; the missing terminator
could mean extra capabilities are added based on junk on the stack;
although that's not been seen in practice.
 
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

v2
  Pass a copy of the parameter list into setup_capabilities

Dr. David Alan Gilbert (3):
  virtiofsd: Terminate capability list
  virtiofsd: Check capability calls
  virtiofsd: Allow addition or removal of capabilities

 docs/tools/virtiofsd.rst         |  5 +++
 tools/virtiofsd/helper.c         |  2 +
 tools/virtiofsd/passthrough_ll.c | 71 +++++++++++++++++++++++++++++---
 3 files changed, 73 insertions(+), 5 deletions(-)

-- 
2.26.2


