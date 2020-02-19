Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E966FC34056
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 18:00:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B956224656
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 18:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TRgqxlQ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B956224656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4Te5-0000GT-VP
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 13:00:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54146)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j4Tc2-0005SS-6t
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 12:58:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j4Tc1-0000ze-B8
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 12:58:18 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22797
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j4Tc1-0000zQ-78
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 12:58:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582135096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pprUbUGqxaraWCBYQ2zBJZvBEN69OaNe7mnkw+OxYsk=;
 b=TRgqxlQ1x+24k7I+jTRBnYwZD8nYb4JZVAaP3FlEO9YqcNZHG4YbYCYf1AR8UuEmYEnOvj
 hlBRhOSmMY81Bpsd/wsGg0w1DExFYRmtAOX12VulMybJS7S7CsquXVAnX2io6oDO4LwWc2
 RRXkHM04UGMzsx2dgBNVm5mrT29O+TQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-Rqw13ylCPcGn2ZntC4EcoQ-1; Wed, 19 Feb 2020 12:58:14 -0500
X-MC-Unique: Rqw13ylCPcGn2ZntC4EcoQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C8A2107BAA5
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 17:58:13 +0000 (UTC)
Received: from localhost (unknown [10.36.118.184])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 07B1977920;
 Wed, 19 Feb 2020 17:58:12 +0000 (UTC)
Date: Wed, 19 Feb 2020 16:45:22 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] memory: batch allocate ioeventfds[] in
 address_space_update_ioeventfds()
Message-ID: <20200219164522.GA1089598@stefanha-x1.localdomain>
References: <20200218182226.913977-1-stefanha@redhat.com>
 <90eee6ef-73ad-f577-8bc1-813e12219cd2@redhat.com>
MIME-Version: 1.0
In-Reply-To: <90eee6ef-73ad-f577-8bc1-813e12219cd2@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2020 at 12:36:04PM +0100, Paolo Bonzini wrote:
> On 18/02/20 19:22, Stefan Hajnoczi wrote:
> > +     * It is likely that the number of ioeventfds hasn't changed much,=
 so use
> > +     * the previous size as the starting value.
> > +     */
> > +    ioeventfd_max =3D as->ioeventfd_nb;
> > +    ioeventfds =3D g_new(MemoryRegionIoeventfd, ioeventfd_max);
>=20
> This would be a bit space-inefficient if we are adding just one ioeventfd=
,
> because it would waste 64 entries right below.  I would like to squash th=
is
> if it's okay with you:

Yes, please feel free to squash it:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5NZiIACgkQnKSrs4Gr
c8jUcggAw59sO0X1guqqn9rpeyg11v0ARmnNVA6ssP5ApmY+5KG1JfrJndGRuso2
0kkunmUmRnMt5YSnhNsCpFKMfMiIToLBOQBioWis2gkQuxE6vlbvl3Dw83FpI5Lf
0afSlYgbweW7wPwO2JVU7DLnoPxSJ9vGt4Lelgj3ov0sLuSIhNL43GXKk2316V3w
9zWTzL6KRMainHELFAiVCIYOhUPC+ZbUfjJ2BfTaz1EVP1sYV2fciny1xsvCAS4W
S486pAFFNI7hHoGtykLD4vgm2lNvhoYWL8o8WBiZWpUqGDKTwd2xj4jKCRZ6TTXW
0MOg01i3Zbe/1roZaqUetPqdfQkowQ==
=ENnX
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--


