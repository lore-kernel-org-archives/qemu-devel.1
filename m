Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33084C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 17:08:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE6EA2073B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 17:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DnYF3lmW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE6EA2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieizr-0000Zg-R1
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 12:08:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36490)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1ieizE-00008t-49
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 12:07:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1ieizB-0003Ro-JA
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 12:07:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21493
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ieizB-0003RS-80
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 12:07:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575997664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4EqulWTUPAFcxsF8kdJYtSNUmDhhVHzgsXI5Za2WKcg=;
 b=DnYF3lmWpEOdb8/ARFUJ8b3ns6JsJX8UF3DFJr3vVPXrP9+E4W0kWnWXzTMkNf7cSIce1l
 aoElMbthGUpv2VSvzOP9Q4kFy0AgC7VikFOE0xkcYob8dvyqYtxN2VHgsxMOb/ftfFWCtu
 zohS8vVozrid2mzdfknrR5StpC1N7sw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-YgKKYpYgMU2jfDdtYs3-vA-1; Tue, 10 Dec 2019 12:07:43 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02CF88CD0E0;
 Tue, 10 Dec 2019 17:07:42 +0000 (UTC)
Received: from gondolin (dhcp-192-245.str.redhat.com [10.33.192.245])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1D50C61F36;
 Tue, 10 Dec 2019 17:07:40 +0000 (UTC)
Date: Tue, 10 Dec 2019 18:07:39 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Subject: Re: [PATCH v3] qga: fence guest-set-time if hwclock not available
Message-ID: <20191210180739.273f2117.cohuck@redhat.com>
In-Reply-To: <20191205115350.18713-1-cohuck@redhat.com>
References: <20191205115350.18713-1-cohuck@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: YgKKYpYgMU2jfDdtYs3-vA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Laszlo Ersek <lersek@redhat.com>,
 "Daniel P . =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu,  5 Dec 2019 12:53:50 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> The Posix implementation of guest-set-time invokes hwclock to
> set/retrieve the time to/from the hardware clock. If hwclock
> is not available, the user is currently informed that "hwclock
> failed to set hardware clock to system time", which is quite
> misleading. This may happen e.g. on s390x, which has a different
> timekeeping concept anyway.
>=20
> Let's check for the availability of the hwclock command and
> return QERR_UNSUPPORTED for guest-set-time if it is not available.
>=20
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>=20
> v2->v3:
>   - added 'static' keyword to hwclock_path
>=20
> Not sure what tree this is going through; if there's no better place,
> I can also take this through the s390 tree.
>=20
> ---
>  qga/commands-posix.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

Queued to s390-next.


