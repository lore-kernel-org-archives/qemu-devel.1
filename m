Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E493DC54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 12:33:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEAF120675
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 12:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N0RXvM64"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEAF120675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYU6V-0002qs-T8
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 08:33:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jYU4l-0001xJ-La
 for qemu-devel@nongnu.org; Tue, 12 May 2020 08:31:59 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23553
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jYU4k-0007l8-4X
 for qemu-devel@nongnu.org; Tue, 12 May 2020 08:31:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589286716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=Tymn16+Vw59V1soK62ktoPQyBW5PI0+sBafxtB6xXxM=;
 b=N0RXvM64MU8HGtdBFqSLzbHuYYb6Wq7i+hblvzoENsWbdY9Yv4UGxzQa+j0boxaRiyQQH0
 cHW152sVlwPr2ZHMpbcop8v7MB9GQ8GrUuaM8nOAGo+ilPvBeo4ngURM4zTYGHeJ6d+WNN
 LKyHIizqP91c3vxn6vT/i6cGpQoP1bg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-D9J3ibqdN02jDGKE1mWucA-1; Tue, 12 May 2020 08:31:55 -0400
X-MC-Unique: D9J3ibqdN02jDGKE1mWucA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 554A3835B43
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 12:31:54 +0000 (UTC)
Received: from thuth.com (ovpn-112-112.ams2.redhat.com [10.36.112.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8DBB3100034E;
 Tue, 12 May 2020 12:31:52 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Jason Wang <jasowang@redhat.com>
Subject: [PATCH v2 0/2] net: Drop legacy "name" from -net and remove NetLegacy
Date: Tue, 12 May 2020 14:31:47 +0200
Message-Id: <20200512123149.30207-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
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
Cc: Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since commit b4983c570c7a ("net: Remove deprecated [hub_id name] tuple of
'hostfwd_add' / 'hostfwd_remove'"), the "name" parameter is not used
internally anymore. And it's been marked as deprecated since QEMU v3.1,
so it is time to remove the "name" parameter from -net now. Once this
has been done, we can also drop the obsolete NetLegacy structure since
there is no major difference between Netdev and NetLegacy anymore.

v2:
 - Rebased to master (use the deprecated.rst instead of qemu-deprecated.texi)

Thomas Huth (2):
  net: Drop the legacy "name" parameter from the -net option
  net: Drop the NetLegacy structure, always use Netdev instead

 docs/system/deprecated.rst | 15 ++++---
 net/net.c                  | 84 ++++++--------------------------------
 qapi/net.json              | 51 +----------------------
 3 files changed, 22 insertions(+), 128 deletions(-)

-- 
2.18.1


