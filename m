Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B51FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 12:04:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0423420829
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 12:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NdXkhy1y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0423420829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k17I9-0008Ok-6p
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 08:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46130)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k17Gq-00074A-L7
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 08:02:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27347
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k17Gn-0002DY-53
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 08:02:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596110561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=q6lIF1Q4RG2E33TZ7M56IWUw+iuxiSxyI0QtlOv0HWI=;
 b=NdXkhy1ysSjrMfJretl6CSebZGPZ3SUSj0V8Y7EeoUJwMc/7/uQpyBgeqHMM5sW6QPZt96
 QBPnvzvyu/r+513opK0NPrsYgLViCCpkx4LJlreWx20e6S2GOP6rNcBEx5wbF0GwXfvzns
 Btth/eKJXI1nVYNi+DmFL+6ns36dUjI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-JFdtH6pWMiK6GY4G3vWF3g-1; Thu, 30 Jul 2020 08:02:37 -0400
X-MC-Unique: JFdtH6pWMiK6GY4G3vWF3g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 838B11DE9;
 Thu, 30 Jul 2020 12:02:36 +0000 (UTC)
Received: from localhost (ovpn-113-153.ams2.redhat.com [10.36.113.153])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E71CC8A191;
 Thu, 30 Jul 2020 12:02:35 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 0/2] qcow2: Release read-only bitmaps when inactivated
Date: Thu, 30 Jul 2020 14:02:32 +0200
Message-Id: <20200730120234.49288-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 03:59:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

When beginning migration, the qcow2 driver syncs all persistent bitmaps
to disk and then releases them.  If the user decides to continue on the
source after migration, those bitmaps are re-loaded from the qcow2
image.

However, we only do this for bitmaps that were actively synced, i.e. R/W
bitmaps.  RO bitmaps (those on backing images) are not written and thus
not released.  However, we still try to re-load them when continuing,
and that will then fail.

To fix this problem, I think we should just consider RO bitmaps to be in
sync from the beginning, so we can release them just like bitmaps that
we have actively written back to the image.  This is done by patch 1.

However, there’s a catch: Peter Krempa noted that it isn’t in libvirt’s
interest for the bitmaps to be released before migration at all, because
this makes them disappear from query-named-block-node’s dirty-bitmaps
list, but libvirt needs the bitmaps to be there:

https://bugzilla.redhat.com/show_bug.cgi?id=1858739#c3

If it’s really not feasible to keep the bitmaps around, then I suppose
what might work for libvirt is to query
image/format-specific/data/bitmaps in addition to dirty-bitmaps (every
bitmap that we released before migration must be a persistent bitmap).

What are your thoughts on this?


Max Reitz (2):
  qcow2: Release read-only bitmaps when inactivated
  iotests/169: Test source cont with backing bmap

 block/qcow2-bitmap.c       | 23 +++++++++++---
 tests/qemu-iotests/169     | 64 +++++++++++++++++++++++++++++++++++++-
 tests/qemu-iotests/169.out |  4 +--
 3 files changed, 84 insertions(+), 7 deletions(-)

-- 
2.26.2


