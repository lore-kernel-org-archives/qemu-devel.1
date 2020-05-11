Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18E2C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 15:35:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83AFA206DB
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 15:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GESoZIvx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83AFA206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYASY-0002r5-Nd
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 11:35:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jYAQq-0001LR-Gb
 for qemu-devel@nongnu.org; Mon, 11 May 2020 11:33:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47990
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jYAQp-0006AA-RM
 for qemu-devel@nongnu.org; Mon, 11 May 2020 11:33:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589211207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WX2SaKZnxHTqOZ0+XhlwBDRW/3pG7mHIeO/h38SfnHw=;
 b=GESoZIvxzUq2lwVodNt2kVKZV7NDA7PeNGg1vdmj+a97hk49K+RpBfTDDKyDTmyFRsnqy8
 m6be7lbEdtKJNxZOlYeAb0XsvlYmabTAxD7gXDM/ELjdE2a9/C1vf010N2G53wsUpJiclJ
 ZbUaqbwrWIsKFJ9fSlwTmaiz/mUYSEo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-RpszKXQkM963iCZlEfSF8Q-1; Mon, 11 May 2020 11:33:24 -0400
X-MC-Unique: RpszKXQkM963iCZlEfSF8Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32BE719200C3;
 Mon, 11 May 2020 15:33:23 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-142.ams2.redhat.com [10.36.114.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CD264341EC;
 Mon, 11 May 2020 15:33:21 +0000 (UTC)
Date: Mon, 11 May 2020 17:33:20 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v2 2/4] iotests/229: Use blkdebug to inject an error
Message-ID: <20200511153320.GF5661@linux.fritz.box>
References: <20200511135825.219437-1-kwolf@redhat.com>
 <20200511135825.219437-3-kwolf@redhat.com>
 <dab0c0e9-e77b-6f3c-9dc0-45ecd15498e5@redhat.com>
MIME-Version: 1.0
In-Reply-To: <dab0c0e9-e77b-6f3c-9dc0-45ecd15498e5@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6sX45UoQRIJXqkqR"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 00:05:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: vsementsov@virtuozzo.com, jsnow@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 11.05.2020 um 17:18 hat Max Reitz geschrieben:
> On 11.05.20 15:58, Kevin Wolf wrote:
> > 229 relies on the mirror running into an I/O error when the target is
> > smaller than the source. After changing mirror to catch this condition
> > while starting the job, this test case won't get a job that is paused
> > for an I/O error any more. Use blkdebug instead to inject an error.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > Message-Id: <20200507145228.323412-2-kwolf@redhat.com>
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>=20
> Did you do this on purpose, or did you send the patch mail this way
> accidentally (with Message-ID tag and double S-o-b)?

It's an artifact on applying my own patch from the list with Message-Id
tags (as we're asked to do), rebasing my development branch (which got
rid of the original version of the commit message) and then noticing in
the last minute that it doesn't pass iotests.

Kevin

--6sX45UoQRIJXqkqR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAl65cEAACgkQfwmycsiP
L9bjVRAAuK2RXUHvVYxVDEPxI6bD++jHOnGL0mlQMuOBLVDbSlaIBhYwTvS5UCvn
jO4/mUVIGMB0nR8D5wSTsTCB4ZKLi8qm7CK4c2Of+E+NPoA6BnS3OzOxPhoezMnr
/FU8N2d2iziGNKO6WV6ZwV2nUAqctZ7FZExPtJW1XixzCOg5DTOmJvsLr2wxOiPe
kPdMJpA7mnOPRg0Zild8ilOMgGjaa7anyOkpAiSFIxicWjpPshyR8vm2FJhRvRPw
I6QXCvhAcbn/hI6oWDwYrTdToEpjM4rwnj1rUpigcemvVQcUx7vGoWgeZDHp+xeL
2x4Rm0iWXcL/mUaks5u0ywyc3Caw+vBAX8hoHGwBqndL8zAmtW2Z/zPUrFFQS1MF
Vme/hUYjn+Io2ijGKGdD5900tv6w59Z9qtkRBCTSWFOxcWGxqaLhVTeHpkiE/NwE
hPWptZzNICciNpD1ZyohDa8Up9ACmA9VL/P6cnLpS6bNTOJE4cAj0ZrlsKKtlswB
xqiMII3NTCy74xYw4ngAV/SSec6wFFzb3Uw7ed8HPCo+M4bv0fn4pSCqDGrSK2V+
ccg79nTwj8noVezl2qHBxcoFu+NPKvWnLKz7uHAvOxDFCaZbgRYxpj1jisdSwpaa
B3Xc2dy9SznNjXmthG2zX8FP13ebhtTZY3zulR28ybp9pIyPAhY=
=ETaI
-----END PGP SIGNATURE-----

--6sX45UoQRIJXqkqR--


