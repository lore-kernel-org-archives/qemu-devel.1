Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686EEC32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 11:49:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33C682072A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 11:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TOEPyg0+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33C682072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipWJi-000219-Ca
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 06:49:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50958)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ipWIs-0001Ad-GB
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:48:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ipWIr-00040p-6F
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:48:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45784
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ipWIr-0003yK-1K
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:48:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578570520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bc9K5/z0YeyljnWDHcX6B2kAlD5lK7TxurUwZ1652Tc=;
 b=TOEPyg0+sEtLgDeJdSxA7wMqZkJXQZUmXeVYnyRZoIaSrme4fRrZCw96RhrlL1bBql5Fow
 6MNU93tZF8e1iWTFpYskvvGts0eA5rRSNZNWWcfP3goBLiMmRp9ztFPScaF5F41NntMwsV
 GwG5NAMGDB2yU5LD8D6bFtjJiAljXR0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-gc2kczkgPdCw1gWajOauCg-1; Thu, 09 Jan 2020 06:48:39 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 869E8800D48;
 Thu,  9 Jan 2020 11:48:37 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-193.ams2.redhat.com [10.36.117.193])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A09BF9CA3;
 Thu,  9 Jan 2020 11:48:28 +0000 (UTC)
Date: Thu, 9 Jan 2020 12:48:27 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>
Subject: Re: [for-5.0 PATCH 02/11] qcow2: introduce icount field for snapshots
Message-ID: <20200109114827.GB9504@linux.fritz.box>
References: <157709434917.12933.4351155074716553976.stgit@pasha-Precision-3630-Tower>
 <157709439859.12933.3023824005902199560.stgit@pasha-Precision-3630-Tower>
MIME-Version: 1.0
In-Reply-To: <157709439859.12933.3023824005902199560.stgit@pasha-Precision-3630-Tower>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: gc2kczkgPdCw1gWajOauCg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: peter.maydell@linaro.org, pavel.dovgaluk@ispras.ru, pbonzini@redhat.com,
 quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com,
 crosthwaite.peter@gmail.com, qemu-devel@nongnu.org, armbru@redhat.com,
 alex.bennee@linaro.org, maria.klimushenkova@ispras.ru, mst@redhat.com,
 kraxel@redhat.com, boost.lists@gmail.com, thomas.dullien@googlemail.com,
 dovgaluk@ispras.ru, mreitz@redhat.com, artem.k.pisarenko@gmail.com,
 dgilbert@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 23.12.2019 um 10:46 hat Pavel Dovgalyuk geschrieben:
> From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
>=20
> This patch introduces the icount field for saving within the snapshot.
> It is required for navigation between the snapshots in record/replay mode=
.
>=20
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> Acked-by: Kevin Wolf <kwolf@redhat.com>

> diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
> index af5711e533..aa9d447cda 100644
> --- a/docs/interop/qcow2.txt
> +++ b/docs/interop/qcow2.txt
> @@ -584,6 +584,10 @@ Snapshot table entry:
> =20
>                      Byte 48 - 55:   Virtual disk size of the snapshot in=
 bytes
> =20
> +                    Byte 56 - 63:   icount value which corresponds to
> +                                    the record/replay instruction count
> +                                    when the snapshot was taken
> +

In the context of the next patch, I noticed that we should probably also
mention that -1ULL means "invalid".

Kevin


