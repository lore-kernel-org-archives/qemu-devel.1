Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAFCC43215
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 16:46:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C78C20674
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 16:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QyUDxC2I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C78C20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVekE-0006S3-Ov
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 11:46:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53427)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1iVeVt-0007Mm-C3
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 11:32:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1iVeVs-0004EP-Bj
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 11:32:01 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40772
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1iVeVs-0004DX-8H
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 11:32:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573835519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9rITASvu+CLUW9uwsnwJHZkbRT0BDAa5FevngGChaLs=;
 b=QyUDxC2IFeJJ+/ZyvLstAKEU6tB6Zgt6CIw/pFZFBidfQipKtUktp8V9Ct5QSdNM+5GlWa
 ZUP/zwE7lAt0MGJAsfl/1qB8Cm/aWGke4uMa4dF1S0uwMsY/DosMoumyv7pUtedpq8ix67
 w0zRQagqKCX87lYRQGaLyBcFA/lhMOs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-oeIG7BZ9OZ-0_hQiR1GjKQ-1; Fri, 15 Nov 2019 11:31:57 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E34C41007310
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 16:31:56 +0000 (UTC)
Received: from x1.home (ovpn-116-56.phx2.redhat.com [10.3.116.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A097660C18;
 Fri, 15 Nov 2019 16:31:56 +0000 (UTC)
Date: Fri, 15 Nov 2019 09:31:55 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Michal Privoznik <mprivozn@redhat.com>
Subject: Re: [PATCH 0/2] A pair of memory access problems
Message-ID: <20191115093155.3c6b5a31@x1.home>
In-Reply-To: <cover.1573468531.git.mprivozn@redhat.com>
References: <cover.1573468531.git.mprivozn@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: oeIG7BZ9OZ-0_hQiR1GjKQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 11 Nov 2019 11:37:40 +0100
Michal Privoznik <mprivozn@redhat.com> wrote:

> The first patch fixes a crasher, the second fixes a memleak.
>=20
> Michal Privoznik (2):
>   hw/vfio/pci: Fix double free of migration_blocker
>   vfio-helpers: Free QEMUVFIOState in qemu_vfio_close()
>=20
>  hw/vfio/pci.c       | 2 ++
>  util/vfio-helpers.c | 1 +
>  2 files changed, 3 insertions(+)

I'll take the first patch, looks like there's some discussion still on
the vfio-helpers patch and I don't own that file anyway, so please post
it separately.  Thanks,

Alex


