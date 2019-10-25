Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C40CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 10:38:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41EB62070B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 10:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fSZNJ5tA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41EB62070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNwzZ-0004KN-LM
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 06:38:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36913)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iNwvB-0007aC-23
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 06:34:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iNwv8-0006xe-QK
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 06:34:16 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40024
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iNwv8-0006vz-Iv
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 06:34:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571999654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=i4Bnwbkl9tFsqB0HzcDR8hsm5i3Hmk+UGK9peS2hjY4=;
 b=fSZNJ5tA2kuiKQbaNuYCp3OEUKVIGFYTv6bAVQ2cUq7DGf99+XQtHGA0AdgIML8j6qMu6t
 J+RUnGWEth6aD2eGEsNx0QMYdyG1h0Oi55PHDWutQ4Eeal/mETD681nPuF5l34Sjp49vz3
 5a+pbpLaKMnPvQY+QMy6+v9JksoDrkw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-3xM3UgQdNmO_LS06rVs8ZQ-1; Fri, 25 Oct 2019 06:34:10 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 580DC107AD31
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 10:34:09 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 273E85DC1E;
 Fri, 25 Oct 2019 10:34:05 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH 0/2] more rcu_read_(un)lock conversions
Date: Fri, 25 Oct 2019 11:34:01 +0100
Message-Id: <20191025103403.120616-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 3xM3UgQdNmO_LS06rVs8ZQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi,
  Two more rcu_read_(un)lock conversions around
virtio stuff.
(to go with, but independent of my previous 'virtio: Use auto rcu_read macr=
os')

I like the way that the virtio-net case simplifies the function
a lot.

Dr. David Alan Gilbert (2):
  virtio/vhost: Use auto_rcu_read macros
  virtio_net: use RCU_READ_LOCK_GUARD

 hw/net/virtio-net.c | 7 ++-----
 hw/virtio/vhost.c   | 4 +---
 2 files changed, 3 insertions(+), 8 deletions(-)

--=20
2.23.0


