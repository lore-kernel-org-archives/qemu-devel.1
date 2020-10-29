Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BF1C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 08:17:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBDA32071A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 08:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xht/DlLz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBDA32071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY37T-0002j0-06
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 04:17:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kY33c-0008CM-Do
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 04:13:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30337)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kY33X-0001qQ-HK
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 04:13:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603959189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YeylHGa9TX7XYJAJL+hq7bTQMoYpp35iSQ/+avbNMfo=;
 b=Xht/DlLz5wmyvQdP2kGMjhE2PTjFitOpkL+TP/yjMTghY0UZsIFXnubVtxw8a/LmWHL6z+
 +HIJRHMnC8qGjAs12XjTob8J/ID2eZt9sIOpbNzmBAYC3fkbOuJ7Zx64ZLkBoxHR6dH558
 QIMBOJ3bTOMDcR8cAVXnNGflERciPDE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-rio2OL8iOOuSIzzQXPzPSw-1; Thu, 29 Oct 2020 04:13:06 -0400
X-MC-Unique: rio2OL8iOOuSIzzQXPzPSw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A67AC1842142;
 Thu, 29 Oct 2020 08:13:05 +0000 (UTC)
Received: from localhost (ovpn-112-178.ams2.redhat.com [10.36.112.178])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3A0811992D;
 Thu, 29 Oct 2020 08:13:05 +0000 (UTC)
Date: Thu, 29 Oct 2020 08:13:04 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Joelle van Dyne <j@getutm.app>
Subject: Re: [PATCH v3 6/7] tcg: implement JIT for iOS and Apple Silicon
Message-ID: <20201029081304.GB253276@stefanha-x1.localdomain>
References: <20201028030701.14086-1-j@getutm.app>
 <20201028030701.14086-7-j@getutm.app>
 <20201028115358.GJ221115@stefanha-x1.localdomain>
 <CA+E+eSAPEWFoG01mVVi_04jvdYXj+onNHea0X2KZzPadp+hktQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CA+E+eSAPEWFoG01mVVi_04jvdYXj+onNHea0X2KZzPadp+hktQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="A6N2fC+uXW/VQSAv"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 01:47:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2020 at 06:04:56PM -0700, Joelle van Dyne wrote:
> Will fix the typo in the commit message.
>=20
> Re: "reverse engineered functions", Apple does not provide any
> documentation on their extensions to ARM architecture. APRR is one
> such proprietary feature that is controlled by MRS/MSR writes to an
> undocumented system register. We reverse engineered the functionality
> by tracing how libsystem_pthread.dylib works and replicating the
> MRS/MSR calls.
>=20
> More details: https://siguza.github.io/APRR/
>=20
> Legally, I don't think this is any different from reverse engineering
> some hardware interface to write a Linux driver but IANAL.

Thanks, I have taken the discussion off-list where we can get advice
regarding this case.

Stefan

--A6N2fC+uXW/VQSAv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+aeZAACgkQnKSrs4Gr
c8hHWgf8C8nD33gHmDoDGjGpO7/hwhy2DIqDeKFMVZevpRLKOTukPMBqgfcT6NXc
PAcqL/w7hwcTz4USYcDqrLcy6SJI3Ex5NbPIbyp+YabCFt/PveuUYgHf7GIdO76y
HsL8u3EViAtDB69V3Lma4aYrKnPCEcoKgc+cL84m7jxhGbmP0lG4OfytpVP17TB7
GtbMr7MXhD7ZU4vUojjGWS5O2Oih77gDm7ec2XuTsTuZ2z82lQmvQYWkvsH5B82T
gfXwVQ5vRGyOPWOCexWhj8VPSmaxrhhVa4ErKq9qTMd1Uo2QNgLRxZa/fKTx25qE
W3V6ZvkdWFjPF2A1feuOKS6oFu5Efw==
=y7zr
-----END PGP SIGNATURE-----

--A6N2fC+uXW/VQSAv--


