Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB1BC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 15:51:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDF6A20672
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 15:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BJjAvpk8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDF6A20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXSGh-0005sd-Na
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 10:51:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37743)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jfreimann@redhat.com>) id 1iXSF1-0003uk-Pn
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:50:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jfreimann@redhat.com>) id 1iXSEz-0002IT-9S
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:50:03 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26413
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jfreimann@redhat.com>)
 id 1iXSEy-0002I0-Cj
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:50:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574264999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2TRk8fJfA5n8JzkRniyIbLUXQh2cAdItGovB2eGT07U=;
 b=BJjAvpk8mujfLOpwa/q/ajOZ3cmCJW2/bY2GZJXfxpktszzxDQ+k5FbWDn3O2NAV4RJvnd
 CdU9EskwuS47Pxv+0CInqn1PR5n8zWQyB8m4Cx0DCnpsKPtqfutjzJLR6EWgLY+prf0KEO
 2g1SHKtFP9tnRm5c5QzWjDH7ZYFqynU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-x4Ff4TqFMlGQf8kusDJMDQ-1; Wed, 20 Nov 2019 10:49:56 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8661B107ACC6;
 Wed, 20 Nov 2019 15:49:55 +0000 (UTC)
Received: from localhost (dhcp-192-217.str.redhat.com [10.33.192.217])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CABD966D2D;
 Wed, 20 Nov 2019 15:49:52 +0000 (UTC)
From: Jens Freimann <jfreimann@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/4] net/virtio: fixes for failover
Date: Wed, 20 Nov 2019 16:49:47 +0100
Message-Id: <20191120154951.27877-1-jfreimann@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: x4Ff4TqFMlGQf8kusDJMDQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: peter.maydell@linaro.org, jasowang@redhat.com, dgilbert@redhat.com,
 mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series fixes bugs found by coverity and one reported by David
Gilbert.

v2->v3:
 * change patch description and subject of patch 3/4

Jens Freimann (4):
  net/virtio: fix dev_unplug_pending
  net/virtio: return early when failover primary alread added
  net/virtio: fix re-plugging of primary device
  net/virtio: return error when device_opts arg is NULL

 hw/net/virtio-net.c | 58 +++++++++++++++++++++++++++++----------------
 migration/savevm.c  |  3 ++-
 2 files changed, 40 insertions(+), 21 deletions(-)

--=20
2.21.0


