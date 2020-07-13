Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17F3C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 20:32:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CD9420720
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 20:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QKhSqlFk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CD9420720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv57h-0002n9-Lv
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 16:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1jv571-0001wb-HP
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 16:31:43 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58027
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1jv56z-0002rc-To
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 16:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594672301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AnK8O7cUzkeBBB7zAK2UzndYow2mZh8HUQVIMK230gE=;
 b=QKhSqlFkdmeQbXKpNQXgv0WPrS9bvjRetJILWNu+BvnZ9XVHZdT0GDocdOXq7KDeUDIWUm
 CqSdfB7B7njfJWjFVporGzNQxOtZRrEPGIv9n4rbsr9BBMkd2o20n4XF5HbQq58LYn5j6A
 MC9D5l3TmNo2zN9xL8rvDRDUP4Ta8jI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-WpwlFGPQOrqK8-1xQU5NQA-1; Mon, 13 Jul 2020 16:31:38 -0400
X-MC-Unique: WpwlFGPQOrqK8-1xQU5NQA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B94AA100A91D;
 Mon, 13 Jul 2020 20:31:37 +0000 (UTC)
Received: from localhost.localdomain (ovpn-112-247.rdu2.redhat.com
 [10.10.112.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B561C78A45;
 Mon, 13 Jul 2020 20:31:33 +0000 (UTC)
Date: Mon, 13 Jul 2020 16:31:31 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v5 04/12] python/machine.py: Perform early cleanup for
 wait() calls, too
Message-ID: <20200713203131.GA2958592@localhost.localdomain>
References: <20200710050649.32434-1-jsnow@redhat.com>
 <20200710050649.32434-5-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200710050649.32434-5-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 01:36:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2020 at 01:06:41AM -0400, John Snow wrote:
> This is primarily for consistency, and is a step towards wait() and
> shutdown() sharing the same implementation so that the two cleanup paths
> cannot diverge.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  python/qemu/machine.py | 1 +
>  1 file changed, 1 insertion(+)
>

Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl8MxKMACgkQZX6NM6Xy
CfOtxA/9EQEBdwQPTOvMhRcBqofiwFLa+MLcNvgouDjP4IBh40by+bmWq/aSa8Mi
b97Fi3kem8zM3imy2kX3VsqozB5HfJkwCVo+O/hgUK8S9WE1gq8Ds0SD6GWGEVBe
ux9bD6ydIIJ9TThhMkX1sD1bkOJ53r0LM9h0xO232+5+iO6iCc/AQFfSjbCY8rXJ
UkLQYIzAE0bz4NTzbeMwuSTATTFn4ZZ0Dii7GA3eSGEWFWxOv3s60DH9tMqH6rGS
0VhS6lsYYQJkfSMV7+lTsWL4oMIGYCkLCk4TcAVrmlB1mIyn4ySJbgNJIV3xFqst
8brqkI8knj4MCyVwkFY6zJXj0Role/OiGmxVw6xrfbZE2/TkQP9PiZNy3tu9biYZ
6z3g6DZZjaRl6VFMK77Hi/wu2e4PE88caPfiLivNL1/f7mCcn2Ok6TfYdMYi7GZ0
TDPEUFpmPvUX48hf2XwFcmAeEanQNjzMgtYFaI+A3JKAEHmm/glplgrGXTQKuhMs
KYw19dxSM+VDDsz5yvXENqRZRz88X79h3tfn8sS4qx1dMGaFaSzIt+do3V9Cl6mO
T3K+h1MoKPkg5QMqwCnsRjWRR5ffFqWlVCGLAurrI9gSPneYLrtZ1EWLVWqrWLD+
4qmEfOcCL+mI1SGtDhcGhmDUeHE7F/lxZNw8bHQC5pNva6WxuLQ=
=nvc3
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--


