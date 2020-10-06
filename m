Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A218FC41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 17:52:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01E05206CB
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 17:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A7XvO4o0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01E05206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPr8Y-0006VL-NC
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 13:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kPr7Y-00060J-2I
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 13:51:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30435)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kPr7U-0001AA-Lt
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 13:51:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602006680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QY/3xZNTK6mgW5hCIGA6pNFwuDOizV8dwTe4T/TnNAU=;
 b=A7XvO4o0icB93gq2dlDiMxYyEq7rn7tm4Bqk+mih25ZVb57ThJ6177Qdm+Qn3AJuMw0Wfr
 ZC6BnTMtDIKhx/PvZ/xyE/yCb3CRZueO8bacxRgrXvn/0Aa3F2w4X9re9uzpm6DT65SONS
 trw6p/3O9Xy4WJ1LvyKW8XKWOWTV71s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-bRQb2vjyPBaLkhTnY-1P3Q-1; Tue, 06 Oct 2020 13:51:18 -0400
X-MC-Unique: bRQb2vjyPBaLkhTnY-1P3Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8580B64145
 for <qemu-devel@nongnu.org>; Tue,  6 Oct 2020 17:51:17 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DE80A10013BD;
 Tue,  6 Oct 2020 17:51:16 +0000 (UTC)
Date: Tue, 6 Oct 2020 13:51:15 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v5 00/36] qapi: static typing conversion, pt1
Message-ID: <20201006175115.GE240186@localhost.localdomain>
References: <20201005195158.2348217-1-jsnow@redhat.com>
 <20201005230559.GA240186@localhost.localdomain>
 <03b7276d-f161-fb0e-7ef9-8e97c4e844a3@redhat.com>
MIME-Version: 1.0
In-Reply-To: <03b7276d-f161-fb0e-7ef9-8e97c4e844a3@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Rgf3q3z9SdmXC6oT"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 00:55:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Rgf3q3z9SdmXC6oT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 05, 2020 at 07:57:18PM -0400, John Snow wrote:
> On 10/5/20 7:05 PM, Cleber Rosa wrote:
> > Here on patches 08 an later, I've run:
> >=20
> >    flake8 ./scripts/qapi
> >=20
> > And starting on patch 24 ("qapi/source.py: add type hint annotations")
> > it complained about:
> >=20
> >    /scripts/qapi/source.py:44:31: F821 undefined name 'T'
>=20
> I think that must be flake8 < 3.8.0. Try using >=3D 3.8.0.
>

ACK, I was on 3.7.9.  They're all passing now with 3.8.4.

- Cleber.

--Rgf3q3z9SdmXC6oT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl98ro8ACgkQZX6NM6Xy
CfOqkRAAqNNYX6XkSyoA0WjUv3XuSDRzoxCrQD/NLE2zc5vK6w+CPIiCmAReYDuv
fuV9fZgXOkF5fhWpFgwq+H5jCOkLXb35Zj02LJlWk8m9Z4Gm8JHTFlQP7X0u67Sw
nEAEvgwGkg+hprLsDEZVMQ1iLN233NNLIfYK2KQgDEqJINMslYvcZDsL6iznES9i
qR22FiImD2sCfJTbkAwFkygxpftwkigbszbJTZHVp1jkgy9lmIii1UFrkXeXvQls
wMjXg6ifaYTXeqHnPb6Cb4iV3ag9dUOffBH07abpQCCnMZc+GFauw2t+l0IgMwF+
zyPXfyAHhmU+qN7Eksl76zqZsOH9Yo8xOyVlydaspFXs6mNhAfvbDi5n7Ea2ObL0
5O8+iH4cxUaH54Diu3xUYn2NP6r0Mqij8R52pp91BIQmRHxuSQug9X7+OcWwc9kB
Mb4sHKfKRWtjqsn74gubbWv2/ygQ4Q+2MAw8aYH+722kqtc3692+Lt1DLycTb2/H
w/6mlTJ7xsH2It5mx67rpjzu1eULTa1ra2EUaiuwiAz0GZApFI/Rd+1AlXUObBtX
Gi59DoDyuTVZLDcLVo3892ylSyXc4tDqi1UIMSC9MKDRZqf9usXVssxj5ipfNWpb
PmZXypCJetJY0s6QQ+N1tqGixSCwDpAL8VkJrX0FzIb1zxbEZgE=
=i4EI
-----END PGP SIGNATURE-----

--Rgf3q3z9SdmXC6oT--


