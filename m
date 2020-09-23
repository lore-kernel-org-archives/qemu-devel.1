Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9324C4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 23:11:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05C6A208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 23:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="coiNsH3g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05C6A208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLDv2-0002kb-WB
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 19:11:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51844)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLDuM-0002Kl-K3
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 19:10:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49283)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLDuL-0008Ej-3k
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 19:10:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600902640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TwjGTBByqBSaJxFlotbLEn/mm9Q2y0woTeSl5NseCh4=;
 b=coiNsH3gGiqbLL65f5KBl2/InTFVZgrzvt+RWzPCtb/BUsjFa9KF29ErHZkJp9JqrZ/HU8
 cjmEQZcJfA+6CsuNjzHUysRq72zAzzXUClxdgJIbkkPJnH4K+0b1IKitJ6un/iaGHOsJSg
 BhfibWaJdoyjt0/mT5FEtWtwtp3iYlE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-nAFBlEL0MzOUj1ru3DK2ow-1; Wed, 23 Sep 2020 19:10:36 -0400
X-MC-Unique: nAFBlEL0MzOUj1ru3DK2ow-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 259A2801AF7;
 Wed, 23 Sep 2020 23:10:35 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 552E65C269;
 Wed, 23 Sep 2020 23:10:34 +0000 (UTC)
Date: Wed, 23 Sep 2020 19:10:32 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH v2 24/38] qapi/gen.py: Fix edge-case of _is_user_module
Message-ID: <20200923231032.GY191229@localhost.localdomain>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-25-jsnow@redhat.com>
 <20200923151743.GK3312949@habkost.net>
 <5723714c-e784-ece7-5523-d6d3b5f981a1@redhat.com>
 <20200923183335.GU3312949@habkost.net>
MIME-Version: 1.0
In-Reply-To: <20200923183335.GU3312949@habkost.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Qesg98+uAFykT7J8"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Qesg98+uAFykT7J8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2020 at 02:33:35PM -0400, Eduardo Habkost wrote:
> On Wed, Sep 23, 2020 at 02:29:28PM -0400, John Snow wrote:
> > On 9/23/20 11:17 AM, Eduardo Habkost wrote:
> > > This changes behavior if name=3D=3D'', and I guess this is OK, but
> > > I'm not sure.  I miss documentation on `visit_module()`,
> > > `visit_include()`, and `_is_user_module()`.  I don't know what
> > > `name` means here, and what is a "user module".
> > >=20
> >=20
> > Good spot, I missed that.
> >

Nice catch indeed.

> > I can probably do: bool(name and not name.startswith('./'))
> >

In this case I like my previous suggestion even better. :)

- Cleber.

--Qesg98+uAFykT7J8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9r1egACgkQZX6NM6Xy
CfPRUQ//eOg6MHffW8pz3UzIlgsemCLm/13jG14iIX2n5QhdTnfzIWFm+ULLnjaQ
KyTItEWigUVFZ0pnFXmdd0+FL7mxUdpydkF74jfa0BR6Ih08lZEoqA4RcM49yIdn
4sVVVSJjqLz8X7F1PBjhAKJVr3A/5LQ+nsRC/oZbPTBSJmoe32t1O7sfv6vi6O7E
CJB29idUaJd9HUR6VLW3thU543xJ59XeLmffjkhblV0b0kt7QjMikYRIR8YEumSC
up3ggsW59EePo6nuBsJLOkp7+4PSxTVD+dt/EGSHITnkUz/QeY5/unaCKm4IxOvp
uf9DPWo+OUMvSiqg22OAM/2f8z4jyx0bbEKRgfiCnu4XQ+mm3adHHbAGVSZzIgTz
qN7BWaUi2xxiUHPzeZg827QYFkd7mtgGjxBiYKGiZac3XCoZ8CIu2msCzUrox6kn
rHE7rVzLaGNRvsaqfq1jNjzJBO2Y6LxDZ3eKsLQnaoVHSCdz/DfwdMHrEysuniHF
2Uvy/rESGw4u2wDnfWfIsPRQKrlb/rwGhACLWLSFq88kqCh38It6ZPU/xWr2kECl
ETA5pxpKr4rlPadUxAK5B/RH22ap6KphS46eD48z7zjsuHNIDC0pBkzY5okycOSE
SUrrv4AsqDfR7fqWGE3hKmGAQpvarya8tHb8fB2/ACt4BxifGG8=
=zTxL
-----END PGP SIGNATURE-----

--Qesg98+uAFykT7J8--


