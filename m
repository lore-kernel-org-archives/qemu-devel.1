Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE9F8C47247
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 12:54:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFEFB24959
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 12:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gERLWeZL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFEFB24959
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX2W0-0004qw-Tm
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 08:54:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jX2KM-00007o-19
 for qemu-devel@nongnu.org; Fri, 08 May 2020 08:42:07 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37719
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jX2KJ-000813-RH
 for qemu-devel@nongnu.org; Fri, 08 May 2020 08:42:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588941723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XC5LymuLezO93qw0QpLvL81IijmzdBx2X6B9K+5jUUA=;
 b=gERLWeZLRE06x0hBh8A/y5JGTp1luC2sUDP8doHit7TchO8tlPecQ7n7kxaXSFx0Kl7+Ld
 wE0jMSoXKM1sHuFTNfCi8EEX1u3gtjAjjDFUUKwJb5KiBXBHmX/91qD5U06ytl8TYbxiqo
 3EUxN7/LgER4B8Tv3Hl9ZfK/IYnDzRE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-Did0VJCjMDmXFy--g0GnXg-1; Fri, 08 May 2020 08:42:00 -0400
X-MC-Unique: Did0VJCjMDmXFy--g0GnXg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67795107ACCA;
 Fri,  8 May 2020 12:41:59 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-190.ams2.redhat.com
 [10.36.113.190])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 638816E715;
 Fri,  8 May 2020 12:41:58 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 13/30] vmdk: Don't update L2 table for zero write on zero
 cluster
Date: Fri,  8 May 2020 14:41:18 +0200
Message-Id: <20200508124135.252565-14-kwolf@redhat.com>
In-Reply-To: <20200508124135.252565-1-kwolf@redhat.com>
References: <20200508124135.252565-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 01:34:54
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If a cluster is already zeroed, we don't have to call vmdk_L2update(),
which is rather slow because it flushes the image file.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20200430133007.170335-5-kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vmdk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index ab8eec1f27..2880d88dea 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -2013,7 +2013,7 @@ static int vmdk_pwritev(BlockDriverState *bs, uint64_=
t offset,
                     offset_in_cluster =3D=3D 0 &&
                     n_bytes >=3D extent->cluster_sectors * BDRV_SECTOR_SIZ=
E) {
                 n_bytes =3D extent->cluster_sectors * BDRV_SECTOR_SIZE;
-                if (!zero_dry_run) {
+                if (!zero_dry_run && ret !=3D VMDK_ZEROED) {
                     /* update L2 tables */
                     if (vmdk_L2update(extent, &m_data, VMDK_GTE_ZEROED)
                             !=3D VMDK_OK) {
--=20
2.25.3


