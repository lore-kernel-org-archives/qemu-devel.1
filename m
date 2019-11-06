Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D6CC5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 15:20:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 734022166E
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 15:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q6X7NetR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 734022166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSN6n-0007fV-LC
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 10:20:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42116)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iSN5c-0006mC-K3
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 10:19:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iSN5b-00047Y-No
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 10:19:20 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38421)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iSN5b-00047A-H7
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 10:19:19 -0500
Received: by mail-wm1-x341.google.com with SMTP id z19so3814460wmk.3
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 07:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=tFagTDbU6iJ+/8adApGX/0jnOWdFGxF3ZapTlbN6CDU=;
 b=q6X7NetR5BmdvaepEuTP0sZXOoW3l9ACN0u8c3NLsYmlpRXSGsiRIpL5EDmUagwFbK
 ofHNRDDMPGz6yM1sNz9T3piw4W7SwZrNwnV1+ejHyDZ8UJE5+xeDxzaSzBQmHLbIJ9Or
 SuPr1zJ03yju0Xku24sD5g3YDtAGFRXVw/Mglv6UPEJwZOq6cxgVEgiY8E4OCXrW4SxF
 EGuKB83wZ9hKfiJ8zJu2g/eYxIo8Xk1BHGgwWokJBuwabJIILV9XPetvMSumHeasy5gj
 gXLXuM3ZU3qcC7U0zsBMQcYhEEN5ZIivXA6hh6RRXVdrYZEHB4tX4fsXmNNnXZEoafEw
 t+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=tFagTDbU6iJ+/8adApGX/0jnOWdFGxF3ZapTlbN6CDU=;
 b=ogd9MvVvSMPmEEDQpqgidOQL75HVnhtLHQugGSuud7k2wqVs6ITCC2moFdUl7AN1VW
 f/Ob4gjtJWeaVYjxLS6veWKhwbbY1YxP+GZ5TtTPLkMRgJTkVq+fdS79RROhhtqGCuxG
 fWkDjz5NPKvaXx26OtV0TRMYYTi+EByK0Bdgy4h20iy/QP0gd/qzE5OODjFhmgXzPrFp
 gbYef92tW83/IN7U1v+T11tI3LxOYPUdGNQOAT6MT9syUV453cch7zvD4Or9+Z0dyyla
 Gkm6dfaPxvNS2pADXu6pL8cxP9MOApv2mNWkan2FMrPBP/m8hM2cGW7CWrJulop2Xc4Y
 ORPQ==
X-Gm-Message-State: APjAAAXmrHAZtvf8RhrfjIwlZXm4FPXBdn5JcvN0TZ6KOSykzgfmGCbR
 8OHnXfzs523tNm41AiimaXg=
X-Google-Smtp-Source: APXvYqwyz5SGpApKpzV79J4aqjBrKY8TMtiD7vUaTcsthCMbBkAQnX04Cmqcj/pNKktAGw/n+dZA5w==
X-Received: by 2002:a7b:c211:: with SMTP id x17mr2858370wmi.71.1573053558558; 
 Wed, 06 Nov 2019 07:19:18 -0800 (PST)
Received: from localhost (178.165.129.116.wireless.dyn.drei.com.
 [178.165.129.116])
 by smtp.gmail.com with ESMTPSA id 65sm37034058wrs.9.2019.11.06.07.19.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2019 07:19:17 -0800 (PST)
Date: Wed, 6 Nov 2019 16:19:16 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Subject: Re: [PATCH v4 04/20] qtest: add qtest_server_send abstraction
Message-ID: <20191106151916.GD340561@stefanha-x1.localdomain>
References: <20191030144926.11873-1-alxndr@bu.edu>
 <20191030144926.11873-5-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="GyRA7555PLgSTuth"
Content-Disposition: inline
In-Reply-To: <20191030144926.11873-5-alxndr@bu.edu>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--GyRA7555PLgSTuth
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2019 at 02:49:51PM +0000, Oleinik, Alexander wrote:
> From: Alexander Oleinik <alxndr@bu.edu>
>=20
> qtest_server_send is a function pointer specifying the handler used to
> transmit data to the qtest client. In the standard configuration, this
> calls the CharBackend handler, but now it is possible for other types of
> handlers, e.g direct-function calls if the qtest client and server
> exist within the same process (inproc)
>=20
> Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
> ---
>  include/sysemu/qtest.h |  3 +++
>  qtest.c                | 17 +++++++++++++++--
>  2 files changed, 18 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--GyRA7555PLgSTuth
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3C5HQACgkQnKSrs4Gr
c8hDvwf/RkdARQgGZlzSOuBIIs6kbH8XoiegH4orsFecmgzhwSNGyk6dOtp7fGB5
tweUv1bzHKvVtUEBIBobPCZtDgKOvHTMZByAJxo3oJWWN1OTbvZ3THZBQTtVNazS
DenDTqzxTpfd69nD6pgjAYGv2rA+gNnzuTnN+UeE3i0MSdapeCHSHWj0bigonvAs
W5eWFCu9WOwFTahDff2lU6T2j7nOvz87f6CFv7oaTXE1JRM2ljeY4O2JNyVNh1Ce
3NJtHF/aaZ8rBZsOq1GcPs0k1l9sR6SegVlj6hxbOqV9+r4Z42G4/5CgfAD/zXxW
6VOfYe45r/En3gEjSdF31Bygx0s1Pw==
=Ez2x
-----END PGP SIGNATURE-----

--GyRA7555PLgSTuth--

