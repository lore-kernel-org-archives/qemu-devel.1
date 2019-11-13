Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDF8C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 09:26:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BC8F2067B
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 09:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XHUIQE8E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BC8F2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUouh-0003zO-5q
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 04:26:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44974)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iUotk-00032D-9F
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 04:25:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iUotj-0006b7-9M
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 04:25:12 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20347
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iUotj-0006Yn-5j
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 04:25:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573637110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9PZS+Le9P3FsskF0CwhBeJ2yhtb61uyEtHKrlgYplmk=;
 b=XHUIQE8EAbmqjE9SaEQJvaxsnZ9aF7w6ohm6hlqkO0WMApAZMpBh0L+7VaCOj7ie9qauB8
 89zc1S3I7aWFGjdR4uKnXn9S6SEbRQZzH1p8XVKkkPwWNwagty96y4mXmIuUYf/fEKvCHt
 I0Q0B/1QF/dPzpYJoRvcF84qsY9HtZU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-ekva7z-kNnOjCNhu3U_wSw-1; Wed, 13 Nov 2019 04:25:07 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD77F8E18F9;
 Wed, 13 Nov 2019 09:25:06 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-169.ams2.redhat.com [10.36.117.169])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A75BA17F20;
 Wed, 13 Nov 2019 09:25:04 +0000 (UTC)
Date: Wed, 13 Nov 2019 10:25:02 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Peter Krempa <pkrempa@redhat.com>
Subject: Re: [PATCH 2/2] iotests: Test multiple blockdev-snapshot calls
Message-ID: <20191113092502.GA6471@linux.fritz.box>
References: <20191108085312.27049-1-kwolf@redhat.com>
 <20191108085312.27049-3-kwolf@redhat.com>
 <20191112160726.GC163480@angien.pipo.sk>
MIME-Version: 1.0
In-Reply-To: <20191112160726.GC163480@angien.pipo.sk>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: ekva7z-kNnOjCNhu3U_wSw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 12.11.2019 um 17:07 hat Peter Krempa geschrieben:
> On Fri, Nov 08, 2019 at 09:53:12 +0100, Kevin Wolf wrote:
> > Test that doing a second blockdev-snapshot doesn't make the first
> > overlay's backing file go away.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  tests/qemu-iotests/273     |  76 +++++++++
> >  tests/qemu-iotests/273.out | 337 +++++++++++++++++++++++++++++++++++++
> >  tests/qemu-iotests/group   |   1 +
> >  3 files changed, 414 insertions(+)
> >  create mode 100755 tests/qemu-iotests/273
> >  create mode 100644 tests/qemu-iotests/273.out
>=20
> Didn't apply cleanly for me.
>=20
> >=20
> > diff --git a/tests/qemu-iotests/273 b/tests/qemu-iotests/273
> > new file mode 100755
> > index 0000000000..60076de7ce
> > --- /dev/null
> > +++ b/tests/qemu-iotests/273
> > @@ -0,0 +1,76 @@
> > +#!/usr/bin/env bash
> > +#
> > +# Test large write to a qcow2 image
>=20
> Cut&paste?

Indeed. I'll change it like this:

# Test multiple blockdev-snapshot calls with 'backing': null

> Rest looks good
>=20
> Reviewed-by: Peter Krempa <pkrempa@redhat.com>

Thanks!

Kevin


