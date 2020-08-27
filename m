Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18918C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 15:38:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D81D52177B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 15:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="efYzcAnA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D81D52177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBJz2-0007wx-5m
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 11:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kBJxi-0006j5-Nf
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 11:37:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51679)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kBJxe-00082j-Ml
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 11:37:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598542628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3pT7yM8sF334B20UH+dfchA4yGZwR0dLTpAKDiuiUik=;
 b=efYzcAnACe4wKQV3Qdv+0T/jW8lsU2wtKyzXR6CBsbMfCKBfjSTQA1BISadVAdo4q/DcEs
 HQ6FFgOAaKPF8Y8QnGRpZ66U7SWeFRuxMMDy62mLSzUBYDMeRXu5u8B8u694UaXCCtkdRV
 0zftYp1wZHMB4mTOg8FP98VV6U8amik=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-oRXB8_j4O0qA-zX8WvSTaw-1; Thu, 27 Aug 2020 11:37:07 -0400
X-MC-Unique: oRXB8_j4O0qA-zX8WvSTaw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21C301DDFF
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 15:37:06 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-114-163.ams2.redhat.com
 [10.36.114.163])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 85CEC5D9E8;
 Thu, 27 Aug 2020 15:36:58 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, vgoyal@redhat.com, stefanha@redhat.com,
 virtio-fs@redhat.com
Subject: [PATCH v2 0/6] virtiofsd xattr name mappings
Date: Thu, 27 Aug 2020 16:36:51 +0100
Message-Id: <20200827153657.111098-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 02:54:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

  This is a second cut of a xattr name mapping option for virtiofsd.
It allows the user of virtiofsd to define a fairly flexible mapping
from the view of the xattr names the host fs has and the ones that the
guest sees.

  The hope is this allows things like:
    a) Different selinux attributes on host/guest
    b) separation of trusted. attributes that clash on overlayfs
    c) support for privileged xattr's in guests running with an
       unprivileged virtiofsd.

There's no apparent standard for this kind of mapping, so I made
it flexible by specifying a mapping rule in the option.

Prefix's can be added (selectively or globally), xattr's can be
dropped in either direction or passed through.

Dave

v2
  Switch from cryptic single letter codes to full words in rules
  Allow rules to use any separator character
  Add examples to doc
  Add a couple of fixups for a gcc warning and make gcc spot my
  format errors.

Dr. David Alan Gilbert (6):
  virtiofsd: Silence gcc warning
  virtiofsd: Add printf checking to fuse_log
  tools/virtiofsd: xattr name mappings: Add option
  tools/virtiofsd: xattr name mappings: Map client xattr names
  tools/virtiofsd: xattr name mappings: Map server xattr names
  tools/virtiofsd: xattr name mapping examples

 docs/tools/virtiofsd.rst         | 104 ++++++++++
 tools/virtiofsd/fuse_log.h       |   2 +
 tools/virtiofsd/passthrough_ll.c | 340 ++++++++++++++++++++++++++++++-
 3 files changed, 442 insertions(+), 4 deletions(-)

-- 
2.26.2


