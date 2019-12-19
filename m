Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3773BC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:52:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00174218AC
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Psx1/Qap"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00174218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihwEU-0002Js-4h
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 08:52:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51030)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ihvv6-0007nT-Uq
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:32:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ihvv4-0008FI-Ep
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:32:48 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28140
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ihvv4-0008AJ-9F
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:32:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576762365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UbBKytEdEEGRHx3+BjPaI+XkJq85rItn/54wFTPJnxE=;
 b=Psx1/QapimmP+3+MrsdGY8T+blPZ0u9kytKpnyr7p7CbpoL9Co1qW/kfZJs/gA5E8vgHJd
 F9dtytbHYgwQyJAuiCURtUbEzQyCbGT/8ieL4UmpwyC5Ot10yNqe1WgmeY5GkjrFdFqM5n
 ovTD3lGGnKY9VzIXiNEMk/jQTvNRaI4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-U-aHLfASNJS6cQXuTzRSuw-1; Thu, 19 Dec 2019 08:32:42 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 174A41009607;
 Thu, 19 Dec 2019 13:32:41 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-53.ams2.redhat.com [10.36.117.53])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DF5087D97D;
 Thu, 19 Dec 2019 13:32:39 +0000 (UTC)
Date: Thu, 19 Dec 2019 14:32:37 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Tuguoyi <tu.guoyi@h3c.com>
Subject: Re: [PATCH v2] qcow2: Move error check of local_err near its
 assignment
Message-ID: <20191219133237.GJ5230@linux.fritz.box>
References: <d7301bf410e04b50a494a82679335158@h3c.com>
MIME-Version: 1.0
In-Reply-To: <d7301bf410e04b50a494a82679335158@h3c.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: U-aHLfASNJS6cQXuTzRSuw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: "vsementsov@virtuozzo.com" <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 18.12.2019 um 12:53 hat Tuguoyi geschrieben:
> The local_err check outside of the if block was necessary
> when it was introduced in commit d1258dd0c87 because it needed to be
> executed even if qcow2_load_autoloading_dirty_bitmaps() returned false.
>=20
> After some modifications that all required the error check to remain
> where it is, commit 9c98f145dfb finally moved the
> qcow2_load_dirty_bitmaps() call into the if block, so now the error
> check should be there, too.
>=20
> Signed-off-by: Guoyi Tu <tu.guoyi@h3c.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Thanks, applied to the block branch.

Kevin


