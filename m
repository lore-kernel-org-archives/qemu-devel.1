Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367CAC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 12:48:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02AE92078D
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 12:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="faZ49iEx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02AE92078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jonmJ-0001YP-8z
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 08:48:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49032)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jonl4-0008Hz-9l
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 08:47:06 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47590
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jonl2-0004kC-Bk
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 08:47:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593175623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gLSqZOrfewjgQrgYXcj0+sqXBegu2p03gX3Kd1WQbzI=;
 b=faZ49iExGEVQokYivqvK667BYTTrUC7svrUc4/RYpIRyod5UCmgbUYHvsXbgus2nuwl746
 +iRcrR9C2Ap5pysH3xbINHWUOPVpWfFJWddufeya5GgRvVbm7uwyYhmraHJT1VQTjBUKq0
 JtC0vhi+ku4esC9xLp4dKXZQd18r/hE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-eFYkVfzwNOmmIg_zr6NQXA-1; Fri, 26 Jun 2020 08:46:39 -0400
X-MC-Unique: eFYkVfzwNOmmIg_zr6NQXA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB5E9107ACCA;
 Fri, 26 Jun 2020 12:46:37 +0000 (UTC)
Received: from localhost (ovpn-114-181.ams2.redhat.com [10.36.114.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5C89519D61;
 Fri, 26 Jun 2020 12:46:37 +0000 (UTC)
Date: Fri, 26 Jun 2020 13:46:36 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 17/17] block/nvme: Check BDRVNVMeState::plugged out of
 nvme_process_completion
Message-ID: <20200626124636.GX281902@stefanha-x1.localdomain>
References: <20200625184838.28172-1-philmd@redhat.com>
 <20200625184838.28172-18-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200625184838.28172-18-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="uN3tURjgVTLfI0kr"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 03:23:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--uN3tURjgVTLfI0kr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2020 at 08:48:38PM +0200, Philippe Mathieu-Daud=E9 wrote:
> @@ -529,10 +529,13 @@ static bool nvme_poll_queues(BDRVNVMeState *s)
>      bool progress =3D false;
>      int i;
> =20
> +    if (s->plugged) {
> +        return false;
> +    }
>      for (i =3D 0; i < s->nr_queues; i++) {
>          NVMeQueuePair *q =3D s->queues[i];
>          qemu_mutex_lock(&q->lock);
> -        while (nvme_process_completion(s, q)) {
> +        while (nvme_process_completion(q)) {
>              /* Keep polling */
>              progress =3D true;
>          }

This code transformation is correct but I hope plugged can be removed
from the completion code path in the future since its purpose is for
batching submissions.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--uN3tURjgVTLfI0kr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl717isACgkQnKSrs4Gr
c8jtngf+P0bsodENylbh/CfwLtR6CC4VXXAdzzJObtdRtB3RsllaDgDauDk9tD7A
FSgfVEOcO52TktD3SVs8qBhhVaHWSAFnihXcJpTqm9vGpLBwDw/rqa0dLszv1GP6
1TuUH/7+LBZkuS13NhRNr157cMtyAbquyy3KulQpRjhGdMduL3JvM9BbCL3rYJA2
Ch2fUsQ5A+fb06/NrroWoDRQwHEEXsmY5/BTVMF2mDqGCAEAbAVqOKMZRUl1E116
K8uv4hSsZB4+YVRwNtcpBAVSNQZuf9/xuALesPf2kNKMqlIweyq1aAsHN4AlMn6N
FAC1L2D7x8pVcVQNe9ZgdJcK/FxdSw==
=uqJ0
-----END PGP SIGNATURE-----

--uN3tURjgVTLfI0kr--


