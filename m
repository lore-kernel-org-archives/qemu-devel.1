Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F18BC47253
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 14:43:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF47F206F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 14:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FalUXXkj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF47F206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUAPW-0002eX-1N
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 10:43:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34974)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jUAOe-0001Wg-3w
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:42:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jUAOd-0001TE-IB
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:42:39 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56254
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jUAOd-0001Mo-2u
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:42:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588257758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Eza9hA/BYOiLlOB6tV4FIfo8wrZA9EFXcEHdfnlWgZE=;
 b=FalUXXkjARB71Kxb833E4+hsMStanFPQ0OWDaTy2k0i7GSMByM6ZfXiBQn384u7OX5aDV5
 eLLJIX2UjScgmXcTHAFBQeacTu1cBqc1IBYGpgD2r2iv3/mL++cMdRmgS6atRaKy9cMhKg
 xeBhj1zkMErxgicj6D4Q2zwusSUbVL0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-Isnhva_LOVCdwff3pDVGTA-1; Thu, 30 Apr 2020 10:42:36 -0400
X-MC-Unique: Isnhva_LOVCdwff3pDVGTA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 85712100CCC3;
 Thu, 30 Apr 2020 14:42:35 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-60.ams2.redhat.com [10.36.114.60])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CD4176B8C5;
 Thu, 30 Apr 2020 14:42:30 +0000 (UTC)
Date: Thu, 30 Apr 2020 16:42:29 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 6/6] iotests: vmdk: Enable zeroed_grained=on by default
Message-ID: <20200430144229.GD6578@linux.fritz.box>
References: <20200430133007.170335-1-kwolf@redhat.com>
 <20200430133007.170335-7-kwolf@redhat.com>
 <c11c2633-34a3-22b1-aa3a-3ff8189672cd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <c11c2633-34a3-22b1-aa3a-3ff8189672cd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:31:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 30.04.2020 um 16:22 hat Eric Blake geschrieben:
> On 4/30/20 8:30 AM, Kevin Wolf wrote:
> > In order to avoid bitrot in the zero cluster code in VMDK, enable
> > zero_grained=3Don by default for the tests.
>=20
> Here, you spell it zero_grained=3Don,

Thanks for spotting this, the typo is in the commit message.

> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >   tests/qemu-iotests/059   | 6 +++---
> >   tests/qemu-iotests/check | 3 +++
> >   2 files changed, 6 insertions(+), 3 deletions(-)
>=20
> So you're changing the default for better coverage and speed, but ensurin=
g
> that 59 still covers the (slower) zero_grained=3Doff.  Seems reasonable.

The real reason why I'm changing 059 is that zeroed_grain=3Don works only
with some subformats and the test case tests many different subformats,
including those for which it doesn't work.

Kevin


