Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5A2C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 15:52:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 786E22089E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 15:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQ/hq00l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 786E22089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0pOU-0001jL-JV
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 11:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57128)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1i0pNi-0001Gk-PU
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 11:52:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1i0pNh-0002up-QJ
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 11:52:10 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44499)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1i0pNh-0002uA-I8
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 11:52:09 -0400
Received: by mail-wr1-x443.google.com with SMTP id p17so5886296wrf.11
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 08:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=8QG1+OQ7HGAeaOda2Y5wIHoIMv2Luu6aZDLkPB7qU/g=;
 b=QQ/hq00l8Fjn8SAlGKTHcpYkPfFQ5rXZxC7jG+H0JoNTaGF7rv45RR3g+QLw/ew9Uf
 U1+RzstXpNq4w7FvGZ/WmczC6/BJ0uPqbOHqa6cJ5QMCZP+7xlswjxbJb3wdPO2DVBTG
 41BukGg3jZZ5i1PKOdb6er/a9N1vybS89WOgKZNQOofakhmog2fgLjseqmr+wMBkZcR6
 QT4ANYfhBdrEE20sDTMXv6Kt4rRm6o+ZnQ9B2YX/rKgDwTs37BT6RUw4QF0NHVQJuU0+
 YgvVP9TPicF1JhJ3SWNzP9SS+XXOiVn6J3ZOOPXNLL0FGaOq68XeKoBnUIa1aeiu5NPJ
 HTqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=8QG1+OQ7HGAeaOda2Y5wIHoIMv2Luu6aZDLkPB7qU/g=;
 b=DErNMKli3qEPZfpNbCojhlYIP4FUswIJV7UGBWHGxmpd9dFWpd+Z6dZrEhXjOnWEqN
 3ztbDoHe6YkrobAchaT7Ougnk1TKlwdEJo7ot3T3iUY7HD5tgotERbz/hQDexwiDL2WP
 OwtYYn0rEWxIwfc6cQoe6d7Zslvt9MWkJ7/sGfYIHywjYCbFkQMNAqW+x+TsXIRb2dAT
 uWWbtZEF6VPuEfm9BcACnzgvn+jXFuG6O1ngHIWCi1H7vN0IYWzqkgBUrLGxIjLbK9j2
 /2M6m6pMwWflb2OLZEDDTOyPNSuRlLtASgiNn7kEIFlXsJPEbuoNFE86PjAbznT8xlpX
 tIYQ==
X-Gm-Message-State: APjAAAXF30CWD8iyMUaJ/OGRJZup0AcvnF3J/GIRMU/4urlpD5WZ5RwF
 HeIsn6RmDKVYM7ti+Y3XzTE=
X-Google-Smtp-Source: APXvYqxnjDcXqogOvqvtJySCvXhPQojQRMP0KZuX/efmABYc+z6HQn1IYdhjfz8rew3quFdMkWuG7w==
X-Received: by 2002:adf:dcc6:: with SMTP id x6mr48377626wrm.322.1566489128110; 
 Thu, 22 Aug 2019 08:52:08 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id w14sm11559wrl.21.2019.08.22.08.52.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2019 08:52:06 -0700 (PDT)
Date: Thu, 22 Aug 2019 16:52:05 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Raphael Norwitz <raphael.norwitz@nutanix.com>
Message-ID: <20190822155205.GA20522@stefanha-x1.localdomain>
References: <1560299717-177734-1-git-send-email-raphael.norwitz@nutanix.com>
 <20190614091841.GE10957@stefanha-x1.localdomain>
 <20190822040725.GA26234@raphael-norwitz.user.nutanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <20190822040725.GA26234@raphael-norwitz.user.nutanix.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH] vhost-user-scsi: prevent using
 uninitialized vqs
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
Cc: fam@euphon.net, pbonzini@redhat.com, qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2019 at 09:07:25PM -0700, Raphael Norwitz wrote:
> On Fri, Jun 14, 2019 at 10:18:41AM +0100, Stefan Hajnoczi wrote:
> > On Tue, Jun 11, 2019 at 05:35:17PM -0700, Raphael Norwitz wrote:
> > > Of the 3 virtqueues, seabios only sets cmd, leaving ctrl
> > > and event without a physical address. This can cause
> > > vhost_verify_ring_part_mapping to return ENOMEM, causing
> > > the following logs:
> > >=20
> > > qemu-system-x86_64: Unable to map available ring for ring 0
> > > qemu-system-x86_64: Verify ring failure on region 0
> > >=20
> > > The qemu commit e6cc11d64fc998c11a4dfcde8fda3fc33a74d844
> > > has already resolved the issue for vhost scsi devices but
> > > the fix was never applied to vhost-user scsi devices.
> > >=20
> > > Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
> > > ---
> > >  hw/scsi/vhost-user-scsi.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> Ping on this. Any reason it has not been merged?

I think Paolo is away on vacation.  I will send it through my tree
instead.

Stefan

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1euiUACgkQnKSrs4Gr
c8hYqAgAgda6osjU4uvOndPHZ3bWrr6ic+cuXb8VVMn6FqNqMDLZsIrS8H59WdTs
ao/hQArmo59opvERtn/H09RUwdzrX86Yi3Pu8tpiW5/UQM6Wi4HbYQDNfglUoH8D
yv3BTdtPCOmsmHqQcHb/zeOP/6I1M3Sbb1at/ygxB9xnnl36lH1h8YcZ+979IdYk
/H0iztCmA1N0WFErWGf34Hw4XWgQJ1sOVj2ORNa3UXNHC0mToxmxpkYDf3AssrHD
DEeACnuincmALhpbesgrpv/xHiks2eF1Pt/G+cSPEUbR01AIkozKBPiLFHoOnzim
2eBiI6jDeUk48UOAvmMCpZ1dMQ+41Q==
=BxNh
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--

