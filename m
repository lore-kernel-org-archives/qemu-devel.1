Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A04C4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 16:13:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 628E7206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 16:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XeooP//V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 628E7206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAG71-0001kw-EE
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 12:13:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39473)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iAFuR-00005o-Ja
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 12:00:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iAFuN-0004qE-Gy
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 12:00:53 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:37379)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iAFuI-0004o8-Jk
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 12:00:48 -0400
Received: by mail-wr1-x434.google.com with SMTP id i1so3776141wro.4
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 09:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=f082GMRizCGO0pbMb702PDf1wOACyEVkwKc8HPldKSg=;
 b=XeooP//VjdHKPOB1ltY0Yz1AZa6F5OL6TgVEKdZnJnXvXZGXpP7b3EdiYqmEYO4zgD
 RMHz0GtxvEXlyAxolBG5xdISQeqoUBk0JCHwUCTGwgAvKjyGhqtmgGG6RaW/9VXHm1zA
 uYwTndd4Q/OHvf1WvjQginiOWlW7uxskxpej0HCKq8Md3ELLqrRXz+GHNVIXfXunDTiD
 w/AsNiQsOvSr1GZ+9P/VJ/89RBoi5pZLqjavkwCbAQI3i6LuU5aVqCgMlL+GFZcnqHE5
 falB/rpBx2qqItjsjpU6U7LExuV0MWp+BKYrCaMwMAfK7tQ6FRMzrNLuOerISTcmmXY7
 XkSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=f082GMRizCGO0pbMb702PDf1wOACyEVkwKc8HPldKSg=;
 b=LCaZZLssfQEWe50XBMaZwTJSJP+AuO68r0zkRNVZZwADiP3FZnZdFJoRlgjHgAA3J+
 qmMZvstJses60kHzrzzwX59ShvLEzw8nr1Z++Wo46tyxBwEpr1VkjMYKqZnC6OS2EYr6
 Xf3rncmP1Q/m5InmO4eohbg7iq51T1t2+bLPB0mMccfm16LOUs9HOGrLQINww6lkkXv9
 40cqIM3+6/gwmy2LYV0St5IlAUYb0Gw8c4dID8122L/7pHT8nHTfTSoyBuaczIFHmTCw
 NgVQNAH564IH/ZoaKRUnTYL2yamUGCDT5it+jqKcCbVvTgJAZR2C5dZyj++dtfg0eAnH
 m5Pg==
X-Gm-Message-State: APjAAAWyf0ZVZhvyx+9rNJNqbCLSXbrr2Ji6zeruckL4DCpI8fwMIaua
 WsZw8vMuY0zUdwGSuWcle3Q4lJOd3CE=
X-Google-Smtp-Source: APXvYqyS5Yrt3RROmlRmz51pWs1eRjT1XMhkPXZHjc72Hnq96mtw7+M78uJ1lLDugF4WV+06wBV5Pw==
X-Received: by 2002:a5d:568d:: with SMTP id f13mr3322467wrv.162.1568736041325; 
 Tue, 17 Sep 2019 09:00:41 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id a6sm1934638wrr.85.2019.09.17.09.00.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2019 09:00:39 -0700 (PDT)
Date: Tue, 17 Sep 2019 17:00:38 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: John Snow <jsnow@redhat.com>
Message-ID: <20190917160038.GD18705@stefanha-x1.localdomain>
References: <12460c01-6960-bd66-501a-46fc31ad7be1@redhat.com>
 <46399543-4205-93b9-0ec2-7ebb3821eb93@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="BRE3mIcgqKzpedwo"
Content-Disposition: inline
In-Reply-To: <46399543-4205-93b9-0ec2-7ebb3821eb93@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
Subject: Re: [Qemu-devel] Python3 support for patches
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
 qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--BRE3mIcgqKzpedwo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2019 at 05:21:37PM -0400, John Snow wrote:
> On 9/13/19 3:32 PM, John Snow wrote:
> > Hi,
> >=20
> > I quite like the patches tool; but python2 is notably doomed.
> >=20
> > I tried my hand at polishing it up for python3 and pushed the results
> > here: https://github.com/jnsnow/patches/tree/python3
> >=20
> > I didn't faff around with trying to add simultaneous support: this is a
> > direct conversion in one big chunk. I used 2to3 and supplemented with
> > pylint and flake8 to find problem spots.
> >=20
> > I don't use all of the features of this tool, but maybe if you'd like to
> > give this a try you can test this branch and let me know if I missed any
> > spots.
> >=20
> > You can install patches 0.3.1 using the standard incantations:
> >> python3 setup.py install --user
> >=20
> > If it's too broken, you can uninstall it later with:
> >> pip3 uninstall patches
> >=20
> > You may need to check back to the master branch and force a
> > reinstallation of the python2 version to get the bin back in your PATH:
> >=20
> >> git checkout master
> >> python2 setup.py install --user
> >=20
> >=20
> > Happy python2 doomsday,
> > --js
> >=20
>=20
> Ah, this was definitely premature. I had a dream last night that this
> was working just fine, but in the harsh, unforgiving sunlight, there are
> still a few problems.
>=20
> Needs a few more minutes in the oven.

Okay, please let me know when it's working.

I'm currently working towards migrating to Python 3 in all areas of my
life but the patches tool is further down the list :).

Stefan

--BRE3mIcgqKzpedwo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2BAyYACgkQnKSrs4Gr
c8gt1Qf/fxb32ldAUmiISydcqZqB93vEyVBKxZrmDMZydUoG2HkMZ6rUN3aYkGTc
Gk2A3ilG2P3PwfMFld89tRFTEE1DGCyU2doWK/nnRyVw/26ZnJq73WLxkGUKPkgf
W4p0aBYfkCseV8By1khdMNNnjst9AHVO5delUoLf38m8OuGo2GgSZoRlbn8o0taW
IifJyKDwMzBiSvn/tkQPmyqUqSK9lwgZ/XVF/vO1yETP7p+Qtsasw9ESs18wvcxH
zgcDj2Qvq3FVvcGT1diCtYh/2QQ8Ox49Pkf5SYczHFDNAsG2lFok+vNu47hG6hve
O1RtzaU672l4jr3jPoQ5mp8Qdazoaw==
=fxsZ
-----END PGP SIGNATURE-----

--BRE3mIcgqKzpedwo--

