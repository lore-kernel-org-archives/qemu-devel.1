Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33E0C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 12:44:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACF232078D
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 12:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R717yiCT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACF232078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joniz-0005RY-O4
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 08:44:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48154)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jonhf-0003x6-51
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 08:43:35 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54891
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jonhc-000383-JT
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 08:43:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593175411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rCEc6rKDKFhBXiHaMHxJRNzByDM/942u3ltaHRRXcHs=;
 b=R717yiCTRlW6uZr4omHDmFHCIv12riCAkpW+yErlOSXhWmTAl1Bt7lfOk3bXdVkMzIAUZd
 kND5BDJNWCWxcth9E4RGUa/Dm9tZdQcVsu2ROp9r9GdKfZnqw6BZVxedyucR6NYnJRU0rq
 ORtr4WDC2EYTc0yH9VbKrbN+zIWDxNs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-YVWSl8ttNu-KYZb3HO4mvA-1; Fri, 26 Jun 2020 08:43:27 -0400
X-MC-Unique: YVWSl8ttNu-KYZb3HO4mvA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 706AC8015F9;
 Fri, 26 Jun 2020 12:43:26 +0000 (UTC)
Received: from localhost (ovpn-114-181.ams2.redhat.com [10.36.114.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 16BF119D61;
 Fri, 26 Jun 2020 12:43:25 +0000 (UTC)
Date: Fri, 26 Jun 2020 13:43:24 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 16/17] block/nvme: Check BDRVNVMeState::plugged out of
 nvme_kick()
Message-ID: <20200626124324.GW281902@stefanha-x1.localdomain>
References: <20200625184838.28172-1-philmd@redhat.com>
 <20200625184838.28172-17-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200625184838.28172-17-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0zDq8CFkxn2hi9iJ"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 02:19:36
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

--0zDq8CFkxn2hi9iJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2020 at 08:48:37PM +0200, Philippe Mathieu-Daud=E9 wrote:
> The queues are tied to the hardware, not to the block driver.
> As this function doesn't need to know about the BDRVNVMeState,
> move the 'plugged' check to the caller.
> Since in nvme_aio_unplug() we know that s->plugged is false,
> we don't need the check.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  block/nvme.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--0zDq8CFkxn2hi9iJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl717WwACgkQnKSrs4Gr
c8jZPAf+MxNJi6SHe3JLjJptV4UMjDvONaSfwXalLJrjzj5AMUOfkT6RunLP4FRe
JYrumqkI90UJZtDCYcBsE+LJtljDW3zs11pVFAc0sPleV7quTB+DtoJxMJq/Z8UT
F0v/i1X0GsHlfsrgfrK3PprZwb3RN1k3fRWGxXCzzSLTb+jxFMhjWs7jEQUYMlqD
tZoKk1mOWifMY3QZzFxaxuYHnj9Mxp/s0VD5H1HCFRgEukbv+73PKyPLpiS8oafz
pqhRRJ4p7nM93YkyQdMz3BPUtx7WDaOyzYmKvmewdPIdMAKrhSEZFnp19s8WjoxI
7UkNXMmkJgL3wZycfZJG94EXqoWNlQ==
=J/pu
-----END PGP SIGNATURE-----

--0zDq8CFkxn2hi9iJ--


