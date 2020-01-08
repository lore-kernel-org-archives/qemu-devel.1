Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC517C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 13:55:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 763E72067D
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 13:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f8e/ijKF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 763E72067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipBo3-00032I-8U
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 08:55:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54011)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ipBme-00017L-7d
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 08:54:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ipBmd-0002f1-9x
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 08:54:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57081
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ipBmd-0002e8-6P
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 08:54:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578491642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cb/1BH6QI6Eg7u9kkyFNFjCbikU/0CtzUVtJMKybI0M=;
 b=f8e/ijKFigti28ewy/rXKE4jHkrsZ3cLNW2Q++G7SFGn2WLcQp6kH05tYsfbICTe0oA3zW
 zAxwLkkfA7eGV61dejt/OLdWpq/MTkmaIz/z8HAllhI29a3Jvcj7auva+WfMqLrDBi5wVu
 qxa7zUPfC5vuW52BoCiS9BxU81FG/e4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-fNISo1DzOy2VNhSyhXBfOw-1; Wed, 08 Jan 2020 08:54:01 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8BEA1DC20
 for <qemu-devel@nongnu.org>; Wed,  8 Jan 2020 13:54:00 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 865B810013A7;
 Wed,  8 Jan 2020 13:53:59 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, vkuznets@redhat.com, mst@redhat.com,
 jasowang@redhat.com
Subject: [PATCH 1/2] vhost: Don't pass ram device sections
Date: Wed,  8 Jan 2020 13:53:52 +0000
Message-Id: <20200108135353.75471-2-dgilbert@redhat.com>
In-Reply-To: <20200108135353.75471-1-dgilbert@redhat.com>
References: <20200108135353.75471-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: fNISo1DzOy2VNhSyhXBfOw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

Don't pass RAM blocks that are marked as ram devices to vhost.
There's normally something special about them and they're not
normally just shared memory.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/virtio/vhost.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 4da0d5a6c5..c81f0be71b 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -402,6 +402,7 @@ static bool vhost_section(struct vhost_dev *dev, Memory=
RegionSection *section)
     bool log_dirty =3D memory_region_get_dirty_log_mask(section->mr) &
                      ~(1 << DIRTY_MEMORY_MIGRATION);
     result =3D memory_region_is_ram(section->mr) &&
+        !memory_region_is_ram_device(section->mr) &&
         !memory_region_is_rom(section->mr);
=20
     /* Vhost doesn't handle any block which is doing dirty-tracking other
--=20
2.24.1


