Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B92EC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 18:03:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1F6221D81
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 18:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D/r4HMGI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1F6221D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSl7e-0008Fz-M2
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 14:03:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kSl6Z-00077S-Mw
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 14:02:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59025)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kSl6Y-0008Eq-3B
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 14:02:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602698545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=o8UKqiC88JN5RyXw68jVrAGN3Xaxvgo7Lm36hFz33IU=;
 b=D/r4HMGIIyR4Gfdsh1tjYE7vTLq8qmAIcQ9428opwaWxJvJFDUOBAgKgGC1PKWySLjBJtL
 xjr56dbMeerEPRc7GuL4je0kjiDIpu+fiTuJ4qNBEOAWjBE0F5hM2oNQopiKxB5/s16ojA
 m3cC/RZroWMNMDznx0V46MlLYtB0O00=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-45L2EpKBOneUL_oAc1dfTg-1; Wed, 14 Oct 2020 14:02:23 -0400
X-MC-Unique: 45L2EpKBOneUL_oAc1dfTg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 523FE8015B1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 18:02:22 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-113-95.ams2.redhat.com
 [10.36.113.95])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8BD706EF53;
 Wed, 14 Oct 2020 18:02:12 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com,
 dinechin@redhat.com, virtio-fs@redhat.com
Subject: [PATCH v3 0/5] virtiofsd xattr name mappings
Date: Wed, 14 Oct 2020 19:02:04 +0100
Message-Id: <20201014180209.49299-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 03:37:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

This is a 3rd cut of an xattr name mapping option for virtiofsd.
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

The major change for v3 is the addition of a 'map' simple syntax
that should cover a lot of the simple cases without people needing
to use the more complex rule syntax.  There's also some cleanups
basedon reviews by Christophe.

Dave


Dr. David Alan Gilbert (5):
  tools/virtiofsd: xattr name mappings: Add option
  tools/virtiofsd: xattr name mappings: Map client xattr names
  tools/virtiofsd: xattr name mappings: Map server xattr names
  tools/virtiofsd: xattr name mapping examples
  tools/virtiofsd: xattr name mappings: Simple 'map'

 docs/tools/virtiofsd.rst         | 122 ++++++++
 tools/virtiofsd/passthrough_ll.c | 476 ++++++++++++++++++++++++++++++-
 2 files changed, 595 insertions(+), 3 deletions(-)

-- 
2.28.0


