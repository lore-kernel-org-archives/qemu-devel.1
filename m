Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FDFC43215
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 23:20:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD2BF222C2
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 23:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GkAhMJHK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD2BF222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXCnl-0005NX-2x
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 18:20:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43623)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1iXCmn-0004fk-WA
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 18:19:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1iXCmn-0000RI-26
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 18:19:53 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28092
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1iXCmm-0000R3-D0
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 18:19:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574205591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N22XnHrEZgP+KuiBjj1UxYY+Ric/lCN676lvy47U9Sg=;
 b=GkAhMJHKQJCBgfhCe0qOG+2eRizzJ1Sn5TNyWEUP6Db7WqUPHTydX1lPw8RfCIJ4UU0aCG
 bzcJ0NxNhiYAEp7OLom8LfJV4Q4qrk28bQdsomqsaEEjP1w3HVq9RbMzM62JhooWFjWOMf
 kwhm1MArb0IBiSt6b0RuO4NX3Vsy5wM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-4bqCuQ91PrKRFWFqCi1reQ-1; Tue, 19 Nov 2019 18:19:49 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10CCD8018A2
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 23:19:49 +0000 (UTC)
Received: from x1.home (ovpn-116-56.phx2.redhat.com [10.3.116.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D8BD9691B4;
 Tue, 19 Nov 2019 23:19:46 +0000 (UTC)
Date: Tue, 19 Nov 2019 16:19:45 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Jens Freimann <jfreimann@redhat.com>
Subject: Re: [PATCH] vfio: don't ignore return value of migrate_add_blocker
Message-ID: <20191119161945.729e45d9@x1.home>
In-Reply-To: <20191114133449.11536-1-jfreimann@redhat.com>
References: <20191114133449.11536-1-jfreimann@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 4bqCuQ91PrKRFWFqCi1reQ-1
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 14 Nov 2019 14:34:49 +0100
Jens Freimann <jfreimann@redhat.com> wrote:

> When an error occurs in migrate_add_blocker() it sets a
> negative return value and uses error pointer we pass in.
> Instead of just looking at the error pointer check for a negative return
> value and avoid a coverity error because the return value is
> set but never used. This fixes CID 1407219.
>=20
> Fixes: f045a0104c8c ("vfio: unplug failover primary device before
>   migration")
> Signed-off-by: Jens Freimann <jfreimann@redhat.com>
> ---
>  hw/vfio/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index e6569a7968..ed01774673 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2737,7 +2737,7 @@ static void vfio_realize(PCIDevice *pdev, Error **e=
rrp)
>          error_setg(&vdev->migration_blocker,
>                  "VFIO device doesn't support migration");
>          ret =3D migrate_add_blocker(vdev->migration_blocker, &err);
> -        if (err) {
> +        if (ret) {
>              error_propagate(errp, err);
>              error_free(vdev->migration_blocker);
>              return;

Slightly late notice, but I did include this in my last pull request
and it's included in v4.2.0-rc2 with Stefano and Philippe's R-b.
Thanks,

Alex


