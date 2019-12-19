Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C984C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:18:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58504206D8
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GAtRlNdf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58504206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihwdA-0001a0-AU
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 09:18:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51373)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ihwQ4-0006QV-V3
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:04:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ihwPz-0000zg-RU
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:04:48 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31066
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ihwPz-0000wq-LC
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:04:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576764283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zRavHMNMrAnCq6s1aCzlexZE1Ud+L01GZLTpSyv3La0=;
 b=GAtRlNdfnLxx8GQLYTUSUoBddP1DwWisqBuNcdendgtpNESKy6BM1kFsVlQEMaSG8R37Gv
 oQJrh0S+o66cWQVvS9NYTCoezpkY48G2KfdfnA4Dy+zZr3wvJ/wLVw8OHj2nozzBlmuohl
 i392hP8KvUPzKgRLP+V79Gkpao4ZThs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-dE3Xrr-jOq-xOhgNJkq2oQ-1; Thu, 19 Dec 2019 09:04:40 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2074107ACC4;
 Thu, 19 Dec 2019 14:04:38 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-53.ams2.redhat.com [10.36.117.53])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C2176940E;
 Thu, 19 Dec 2019 14:04:37 +0000 (UTC)
Date: Thu, 19 Dec 2019 15:04:33 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH] block: nbd: Fix dirty bitmap context name
Message-ID: <20191219140433.GK5230@linux.fritz.box>
References: <20191219125151.21482-1-nsoffer@redhat.com>
 <443c32b3-0e0c-ef9e-4d5b-9404b16eaa02@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <443c32b3-0e0c-ef9e-4d5b-9404b16eaa02@virtuozzo.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: dE3Xrr-jOq-xOhgNJkq2oQ-1
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
Cc: Nir Soffer <nsoffer@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Nir Soffer <nirsof@gmail.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 19.12.2019 um 14:41 hat Vladimir Sementsov-Ogievskiy geschrieben:
> Ahh, I see, it's documented as
>=20
> +# @bitmap: Also export the dirty bitmap reachable from @device, so the
> +#          NBD client can use NBD_OPT_SET_META_CONTEXT with
> +#          "qemu:dirty-bitmap:NAME" to inspect the bitmap. (since 4.0)
>=20
> and it is logical to assume that export name (which is @name argument) is
> mentioned. But we never mentioned it. This is just documented after
> removed experimenatl command x-nbd-server-add-bitmap,
>=20
> look at
>=20
> commit 7dc570b3806e5b0a4c9219061556ed5a4a0de80c
> Author: Eric Blake <eblake@redhat.com>
> Date:   Fri Jan 11 13:47:18 2019 -0600
>=20
>      nbd: Remove x-nbd-server-add-bitmap
>=20
> ...
>=20
> -# @bitmap-export-name: How the bitmap will be seen by nbd clients
> -#                      (default @bitmap)
> -#
> -# Note: the client must use NBD_OPT_SET_META_CONTEXT with a query of
> -# "qemu:dirty-bitmap:NAME" (where NAME matches @bitmap-export-name) to a=
ccess
> -# the exposed bitmap.
>=20
>=20
> So, this "NAME" is saved and now looks incorrect. What should be fixed, i=
s Qapi
> documentation.

Hm, I don't know these interfaces very well, but from you explanation it
looks to me as if having a bitmap name made sense with
x-nbd-server-add-bitmap because it could be called more than once for
exporting multiple bitmaps.

But now, we have only nbd-server-add, which takes a single bitmap name.
As we don't have to distinguish multiple bitmaps any more, wouldn't it
make more sense to use "qemu:dirty-bitmap" without any other
information? Both export name and bitmap name are already identified by
the connection.

But if we have to have something there, using the bitmap name (which may
or may not be the same as used in the image file) makes a little more
sense because it makes the interface extensible for the case that we
ever want to re-introduce an nbd-server-add-bitmap.

(By the way, even if the patch were correct, it lacks a Signed-off-by.)

Kevin


