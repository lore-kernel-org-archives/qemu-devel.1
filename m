Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EA2C38A30
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 16:44:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E09E2082E
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 16:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TcIGjDcd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E09E2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQZWr-0004nX-M7
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 12:44:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52266 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jQZW1-0004Cc-Lz
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 12:43:26 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jQZW0-0001N9-RE
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 12:43:25 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51910
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jQZW0-0001KC-Dw
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 12:43:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587401003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HuSKr75OPSW8c4DUg2pJSsuhkFIMHb/bMMEqmZ+JEHE=;
 b=TcIGjDcdvJ3psfNhwGtGpRp8Ud2Eqt5soFkbCboeMzZ4031byeIb3sbB4G5BfvXPW9Ezw8
 TXJpRPxYXV923v2H0TZXq0jYo4mnwdWRCMhOTQMDHxrdPFEqYmb9blsiuK7/G3IKx3nfgt
 XRsVGyw/BHqKtJalRwKU5wzCXOXc6gw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-_ev4oL2xMHqP-NjYAX1imw-1; Mon, 20 Apr 2020 12:43:20 -0400
X-MC-Unique: _ev4oL2xMHqP-NjYAX1imw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B02E3801A01;
 Mon, 20 Apr 2020 16:43:19 +0000 (UTC)
Received: from localhost (ovpn-112-169.ams2.redhat.com [10.36.112.169])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 119445C1B2;
 Mon, 20 Apr 2020 16:43:18 +0000 (UTC)
Date: Mon, 20 Apr 2020 17:43:17 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 9/9] block/io: expand in_flight inc/dec section:
 bdrv_make_zero
Message-ID: <20200420164317.GH7321@stefanha-x1.localdomain>
References: <20200408093051.9893-1-vsementsov@virtuozzo.com>
 <20200408093051.9893-10-vsementsov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20200408093051.9893-10-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9jHkwA2TBA/ec6v+"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 01:47:04
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--9jHkwA2TBA/ec6v+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 08, 2020 at 12:30:51PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> @@ -2768,6 +2772,49 @@ int bdrv_make_zero(BdrvChild *child, BdrvRequestFl=
ags flags)
>      }
>  }
> =20
> +typedef struct BdrvDoMakeZeroData {
> +    BdrvChild *child;
> +    BdrvRequestFlags flags;
> +    int ret;
> +    bool done;
> +} BdrvDoMakeZeroData;
> +
> +static void coroutine_fn bdrv_make_zero_co_entry(void *opaque)

Please document that the caller must inc/dec.

--9jHkwA2TBA/ec6v+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6d0SUACgkQnKSrs4Gr
c8i6rQf+MPUskuD0hssVqvYt/4ajZDP0s7KbiBjtca+s9+nVQUcBfC/HAtj8Z9PZ
9+FXyvk/2C/V5BUzGaY0UsVTn4pf3Zg/RS4M9A4HW2DMlqHQpGRs2RtKgzfliU4f
E7DZrgzxflKV/W2QZMsv8lDLi3UTl7Nm1MoeXltD7NtHs/ojH3aPcXlbjOmRqWZt
r+qZ4GlylAyNLeqCEgjEOldV85D0xiH1LflhRwY/yNXDZgYcQhIPc/dc6Nt2UDql
Wfhxt/E0qzcxicJzXg0m4wjJPTF8USDaUj0t0iwMdSgX1s1I2Aj3FfTxCIq6wAug
KPjAKP45SM0Mer/sznKQEasN0/4QKA==
=BAT2
-----END PGP SIGNATURE-----

--9jHkwA2TBA/ec6v+--


