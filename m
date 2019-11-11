Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A77C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 11:20:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02294214DB
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 11:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FwaXfbga"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02294214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iU7jk-0001iK-6p
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 06:20:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56336)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iU7j2-000163-BS
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 06:19:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iU7j1-0003Aa-DU
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 06:19:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28119
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iU7j1-00039r-A7
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 06:19:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573471154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4lUkvGPHBz+PVducHJD0SFNXIJlIQOTuBtEYnHgdA6U=;
 b=FwaXfbgaRNTV5GiP0doO/mJoru1CFNHTYsoZSEr18hrIrjXKlYWEMHVHWDLGCOOPOYlrV/
 u+fyAdKyTP1Sj0fQIysb5Ma8SwUV0jmYpJaCNMRwq07gv+kyQoGUoLrjVhdiUGeXaFTqlZ
 EiMn1y2al0v9BvCOIaI6AN8+tEvQItk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-pBw32uElP8SvIxQmREwlMw-1; Mon, 11 Nov 2019 06:19:11 -0500
X-MC-Unique: pBw32uElP8SvIxQmREwlMw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83F04801E51;
 Mon, 11 Nov 2019 11:19:10 +0000 (UTC)
Received: from localhost (ovpn-117-169.ams2.redhat.com [10.36.117.169])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8AB811001B35;
 Mon, 11 Nov 2019 11:19:04 +0000 (UTC)
Date: Mon, 11 Nov 2019 11:19:03 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Subject: Re: [PATCH v2 1/1] virtio: make seg_max virtqueue size dependent
Message-ID: <20191111111903.GD442334@stefanha-x1.localdomain>
References: <20191108134249.19004-1-dplotnikov@virtuozzo.com>
 <20191108134249.19004-2-dplotnikov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20191108134249.19004-2-dplotnikov@virtuozzo.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="tEFtbjk+mNEviIIX"
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
Cc: den@virtuozzo.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--tEFtbjk+mNEviIIX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 08, 2019 at 04:42:49PM +0300, Denis Plotnikov wrote:
> +    virtio_stl_p(vdev, &blkcfg.seg_max, s->conf.queue_size - 2);
[...]
> +    virtio_stl_p(vdev, &scsiconf->seg_max, s->conf.virtqueue_size - 2);

Please extend the queue_size checks to report an error when queue_size
<= 2.

Stefan

--tEFtbjk+mNEviIIX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3JQ6cACgkQnKSrs4Gr
c8g4ZggApzjc65foH+ZSYuuk/48JdznG4FCjxIc0eIYN1xGHriJVYJVd6nD6bdgV
DHvzkTmAUSFkgN5eKvTAuu7seXUnnjDUDiJvKiPJpVxVONLg/R5TsRDKPOl9f1Jk
3+uxdzeFa4D2pukkVj2aRLOtCD16NlwoA04eUjBd0maKZuJcigQS+OX2qN07XFe4
y/M97IICyqB8l+/HB2yhDBGU+wD5fpUOis2TgkiiUBAbzjFw3z/TrfDZw2ghzXRM
BR4aXdOob+jhyKn+G5OM9Cn2bkqQVWkNFZfvZBU7PgC1Xx1X2szV0VTVcv5eaN4G
g08953j4DoRgnTp9xdCFGpmbi/hfsA==
=/yy+
-----END PGP SIGNATURE-----

--tEFtbjk+mNEviIIX--


