Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E547C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 09:25:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C19BC20829
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 09:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CrDuyXsL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C19BC20829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXLEn-00078E-IN
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 05:25:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXLDn-000682-5M
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 05:24:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20239)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXLDl-0004ro-KM
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 05:24:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603790689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jSCLMVODQrmeprBu1Gyol/8yS0AKWmFHvg8RHg7m6TQ=;
 b=CrDuyXsL9OnqZkbyn8/MphjQfOD1ASsEZPKn5zfJBox+c6Ri4UnPEZiW5GSqqjcduND96B
 4QK5ij+aEMG37KOa/RFyIG+70Q3mX/B4/IwL71k4i0XiLWyfdVvXTE82fcUgvJ649kTta0
 AOqh6uGlYN0UgAg9lcFnlxHHl2Dck+o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-OoLpD7KsPV2XxkHufX88IA-1; Tue, 27 Oct 2020 05:24:44 -0400
X-MC-Unique: OoLpD7KsPV2XxkHufX88IA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 591281882FA7;
 Tue, 27 Oct 2020 09:24:43 +0000 (UTC)
Received: from localhost (ovpn-114-163.ams2.redhat.com [10.36.114.163])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B6AFB6EF57;
 Tue, 27 Oct 2020 09:24:36 +0000 (UTC)
Date: Tue, 27 Oct 2020 09:24:35 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 02/19] block/nvme: Set request_alignment at
 initialization
Message-ID: <20201027092435.GB79063@stefanha-x1.localdomain>
References: <20201026105504.4023620-1-philmd@redhat.com>
 <20201026105504.4023620-3-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201026105504.4023620-3-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="H1spWtNR+x+ondvy"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--H1spWtNR+x+ondvy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2020 at 11:54:47AM +0100, Philippe Mathieu-Daud=E9 wrote:
> When introducing this driver in commit bdd6a90a9e5
> ("block: Add VFIO based NVMe driver") we correctly
> set the request_alignment in nvme_refresh_limits()
> but forgot to set it at initialization. Do it now.

This patch is fine but the commit description does not explain why this
change is necessary. Is there a bug and how can it be triggered? Or is
this code change just for consistency?

> Reported-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  block/nvme.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--H1spWtNR+x+ondvy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+X51MACgkQnKSrs4Gr
c8iyMAgAoefgBy1691ke6ZsKYcxlAGTF+HutgXvpMM92/vZJ8l9734Q3eeiRz83Z
ojC0+oNRPjSv6YfPcJYbItH1uBXYKsnq/QhZH0mdhpLY3jIA/EfIsWm64fWkuREv
0nCMtboCu4lkU9KXnPWs+UZpXPpCtVWFG5wa1MZuZ0CbyuNYLC1yoRbvltRTOYk9
NaGvIDR8ILOZsq1tzqC6+fCrWLq1tmoTWHE0LvC8aVxGTrzGuERI2xMmuwfviQT9
TnXMkNFnhpQJwRj6N7REWCCPMVkvxSTd4qQlpPz1397kUy3AM7E/But+aYiImzvh
XdH3DAtBZQt2v62XwGjLjEuY0aX+ow==
=FrGL
-----END PGP SIGNATURE-----

--H1spWtNR+x+ondvy--


