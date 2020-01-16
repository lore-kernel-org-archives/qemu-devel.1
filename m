Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67882C33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 14:34:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 325952051A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 14:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DmURarkE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 325952051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is6E8-0005ha-C8
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 09:34:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52808)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1is6DM-00054J-ND
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:33:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1is6DI-0001Bz-7O
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:33:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60155
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1is6DI-0001BZ-2u
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:33:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579185215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RzJlY9fKNrDLesRYTkPgbzkabvDvsep4+3VQJecLq+c=;
 b=DmURarkEu2noWXqoxHcZeuSsYec69WoeLIvJxoc5rNgVH+AX5mdPrG6snqBhgyKcprd7Le
 HYVh9ThVuu8N7mTHG5JKkQPC7avs63m7IMgzLKK8+qg1cDFWDv9ImYOfJByK8FMnsg5m4l
 RKdnH9ulMtVA+m26mptdD6L5/2ZpgvE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-YQ6Ckw6WMBqwCvVt5Q3GDA-1; Thu, 16 Jan 2020 09:33:33 -0500
X-MC-Unique: YQ6Ckw6WMBqwCvVt5Q3GDA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB192100550E
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 14:33:32 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.19])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C09D461069;
 Thu, 16 Jan 2020 14:33:27 +0000 (UTC)
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-45-dgilbert@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.3
From: Sergio Lopez <slp@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH 044/104] virtiofsd: prevent ".." escape in lo_do_lookup()
In-reply-to: <20191212163904.159893-45-dgilbert@redhat.com>
Date: Thu, 16 Jan 2020 15:33:24 +0100
Message-ID: <87sgkfwjwr.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
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
Cc: "Dr. David Alan Gilbert \(git\)" <dgilbert@redhat.com>, stefanha@redhat.com,
 vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain


Dr. David Alan Gilbert (git) <dgilbert@redhat.com> writes:

> From: Stefan Hajnoczi <stefanha@redhat.com>
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tools/virtiofsd/passthrough_ll.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Sergio Lopez <slp@redhat.com>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl4gdDQACgkQ9GknjS8M
AjUkRw/+MceC3rKGgNQ6c9XT6mcUr9jwS+dqr2kPGmpo9+7MN+DHpxQCVqNbetw1
sxBdoxFZ7ggfFRYj0ktVSGkoyoqqCnlZj8Ea7Jpv6/zAHThizN0y2zoxYZJOBWYr
FXUxajXyVm0xt8MlopDxzKS5oxV7vpnIOPSfIAkf1oykW+iua7/o41P+WxXTfIfA
8pKYZaFtBMR7MFQ5cvgnR0PB/5KSCprDJN9SQgPs7n4dF7MC/M3sUb62yAIb9CU7
q9p+Agt+Vt3DU+YNdfb4Ps+sB6Upk9Hq6dBWrLVJyJLV7E5UE5tsOJM87X7S+2tW
VfHWksI3+JfRUZujZQfD5zo+gL94py/Oo9uSTtM33BdbWge7cLNbjtdlmLXore8p
b42X9MQkiPkUBicYzjaF21p9H3w/Of08gr5XvbZggjA9EPp/BVRVkuKD0PhZd0mC
HsZ/ueofjci72/8W5nmHXvWhnvNgsnQdBXZG1NayxdZa5/d1eM03egNOMg2Ogx6U
CK/rIt1yHazvRV5AboMJWhJV99CDABXeroUkU49ykgaR4h+6mb4CowO36JPwkuh/
/Sq2w5TQIU/MtzMLxnuTJlqmteeIVipGYS2R2n6lJqDofb+yBmAAcuKG8LI23ldd
lf0lnwVNH2/8J93nnJ1oci9YmfgxPeY7uhqyQuakuthA960MsEo=
=SyVZ
-----END PGP SIGNATURE-----
--=-=-=--


