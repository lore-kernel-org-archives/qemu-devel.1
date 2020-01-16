Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0835AC33CAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 20:25:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6345206D7
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 20:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hyo2D4ie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6345206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isBho-000897-PQ
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 15:25:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55787)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1isBgp-00073k-2D
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 15:24:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1isBgm-0006aa-G8
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 15:24:25 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42640
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1isBgl-0006ZA-Ko
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 15:24:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579206262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2F0ela31txc2k0gKlYz+cW0w1xtIBjYn/NIT4w53JqI=;
 b=Hyo2D4iepYQLV3Qj1F7iDIQvsIod1KKGxd4eyjQdDUgg47XELB6tm+VRRAkGYqUhffsd4M
 owVnxItfZPTWx7MnjALDo2mdrKLomsQFndkmRjTwZW+Dt+mwjDWX+q1ewEWwh1gnHPrk+W
 K0JWLUQUtZSjRVrPizilqOMDxlgtOxk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-0c2pIgQOOIeWA-3OtnTJ0A-1; Thu, 16 Jan 2020 15:24:21 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3ADD3800D48
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 20:24:20 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.16])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BA2BF5C1D8;
 Thu, 16 Jan 2020 20:24:16 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, vkuznets@redhat.com, mst@redhat.com,
 jasowang@redhat.com, pbonzini@redhat.com
Subject: [PATCH v3 0/2] Fix hyperv synic on vhost
Date: Thu, 16 Jan 2020 20:24:12 +0000
Message-Id: <20200116202414.157959-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 0c2pIgQOOIeWA-3OtnTJ0A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

Hyperv's synic (that we emulate) is a feature that allows the guest
to place some magic (4k) pages of RAM anywhere it likes in GPA.
This confuses vhost's RAM section merging when these pages
land over the top of hugepages.

This v3 takes a different approach to v2 and v1.
It avoids doing the hugepage alignment except for vhost-user:

  a) Vhost kernel : doesn't need alignment, it's turned off
     synic won't cause a problem.

  b) vhost user : Already filters out anything without an fd
     synic won't cause a problem.

(Not tried vhost-user yet, it currently seems broken even without this).

This might also cause some other reported problems with vga
pages causing similar issues.

bz: https://bugzilla.redhat.com/show_bug.cgi?id=3D1779041

Dr. David Alan Gilbert (2):
  vhost: Add names to section rounded warning
  vhost: Only align sections for vhost-user

 hw/virtio/vhost.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

--=20
2.24.1


