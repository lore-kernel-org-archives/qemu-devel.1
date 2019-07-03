Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42D8C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 10:06:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91CBA218A3
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 10:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnfIehs4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91CBA218A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hic9f-0006Q1-Jd
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 06:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45143)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hic7v-0005pf-Tb
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 06:04:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hic7u-0006oU-Nb
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 06:04:35 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:45599)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hic7u-0006lb-9K
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 06:04:34 -0400
Received: by mail-wr1-x42a.google.com with SMTP id f9so2044673wre.12
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 03:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=rpmW2YAQ/4TIZg9D3uQ+O3vyfIRCKS5c8d5Qfeu61jM=;
 b=EnfIehs4SACVOOTPLYiIQ0LvYQ1UBWa7EfWew/3lNSRE2ZKk6a046F7wde1uI0KK1y
 NP7irEx+fkTPpS9e1k1FxxXhPiq2MwmetazJe6OmVqMO9g0ngTyDS34N5Si6bKMtC3j4
 grr4kD3OqN+uqOT5b8D6i7jfDR49n4rD4WfzkFdL99prhDiG1xuclTp7ok/GbxGmhQp9
 O9QmWsxPjH7I/NK5dXUk3f4W3jnHJrSS8aWKPY55WaqkajP4MxO1O4sOyGnfF9CzFX6H
 QD0Oa3o8EIEQmpuC/mBQ1Ylm+KV5ivy05xqi+xuumxE/nLp2vRzpMGq8q5Qe05cXQLfK
 1hog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=rpmW2YAQ/4TIZg9D3uQ+O3vyfIRCKS5c8d5Qfeu61jM=;
 b=ivK1H9qpXUK49cWOVGW+SSD4pRHIuF1VM6oktSvCF+p7yagYxzQXUR67EtAL3PLnTT
 kYtcg3+MjvMj4esxzWxWUVram9LdxpDYMp83OWfiyC+uwBILoMqX5gWh2E8a/BLXnPhX
 iceoQnfjwnjZMvKwZv5MmFwU0dC34p+IYFHGpQXYTDgrFxMOa+KquCOmGFSFqGo610nR
 pKCZE5sC7+qqg5p/03x0jC3xsYxpYG5hcoTsfK4fCPkHZagtGEet2IjFAIJQuEmEIGN/
 MKC7HOL2j4/af5Qmu62Vo00mU8RGOy5CDvfFXek/r7H2P2rjmwYN58p9HpmSxTjvNYy7
 nNgQ==
X-Gm-Message-State: APjAAAXDSHODPLNb1tEEgei8xLbJR3DoKHHVJwUMIpG+SK2rmiskuOK0
 OJ7bP99mRf/uC0p8YoZFDIg=
X-Google-Smtp-Source: APXvYqxzUPx47I2bOfGXkacGdRLBxju7YVdNLqaLvELZcS3mdpubTbLpTVZ/lECjB4vNqgEN/GetGw==
X-Received: by 2002:a5d:6709:: with SMTP id o9mr28548818wru.301.1562148273039; 
 Wed, 03 Jul 2019 03:04:33 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id o24sm5007541wmh.2.2019.07.03.03.04.31
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 03 Jul 2019 03:04:31 -0700 (PDT)
Date: Wed, 3 Jul 2019 11:04:31 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Raphael Norwitz <raphael.norwitz@nutanix.com>
Message-ID: <20190703100431.GA17523@stefanha-x1.localdomain>
References: <6EF9E5BE-2FBF-4CC4-BA1F-AE55ADD82A6E@nutanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
In-Reply-To: <6EF9E5BE-2FBF-4CC4-BA1F-AE55ADD82A6E@nutanix.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
Subject: Re: [Qemu-devel] Should memory hotplug work with vhost-user
 backends?
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
Cc: Mike Cui <cui@nutanix.com>, dilbert@stefanha-x1.localdomain,
 "Michael S. Tsirkin" <mst@redhat.com>, Malcolm Crossley <malcolm@nutanix.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 Felipe Franciosi <felipe@nutanix.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "changchun.ouyang@intel.com" <changchun.ouyang@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 02, 2019 at 10:08:54PM +0000, Raphael Norwitz wrote:
> For background I am trying to work around a ram slot limit imposed by the=
 vhost-user protocol. We are having trouble reconciling the comment here: h=
ttps://github.com/qemu/qemu/blob/master/hw/virtio/vhost-user.c#L333  that =
=E2=80=9CFor non-vring specific requests, like VHOST_USER_SET_MEM_TABLE., w=
e just need to send it once the first time=E2=80=9D and the high level impl=
ementation of memory hot-add, which calls set_mem_table every time a VM hot=
 adds memory.
>=20
> A few questions:
> 1.
> What exactly is the check `if (vhost_user_one_time_request(msg->hdr.reque=
st) && dev->vq_index !=3D 0)` for? In the message for commit b931bfbf042983=
f311b3b09894d8030b2755a638, which introduced the check, I see it says =E2=
=80=9Cnon-vring specific messages[, which should] be sent only once=E2=80=
=9D and gives VHOST_USER_SET_MEM_TABLE as an example one such message. The =
`vhost_user_one_time_request()` call clearly checks whether this type of me=
ssage is the kind of message is supposed to be sent once of which VHOST_USE=
R_SET_MEM_TABLE is one. Why, then, does this commit add the check if `dev->=
vq_index !=3D 0`? It seems like there is a latent assumption that after the=
 first call dev->vq_index should be set to some value greater than one, how=
ever for many cases such as vhost-user-scsi devices we can see this is clea=
rly not the case https://github.com/qemu/qemu/blob/master/hw/scsi/vhost-use=
r-scsi.c#L95. Is this check then =E2=80=98broken=E2=80=99 for such devices?
>=20
> 2.
> If this check is indeed broken for such devices, and set_mem_table call i=
s only supposed to be run once for such devices, is the ability to call it =
multiple times technically a bug for devices such as vhost-user-scsci devic=
es? If so, this would imply that the existing ability to hot add memory to =
vhost-user-scsi devices is by extension technically a bug/unintended behavi=
or. Is this the case?

Hi Raphael,
David Gilbert and I recently came to the conclusion that memory hotplug
is not safe in vhost-user device backends built using libvhost-user.

It's likely that memory hotplug hasn't been fully thought through at the
protocol specification and QEMU vhost-user master implementation levels
either.

We didn't investigate deeper for the time being, but I'm not surprised
that you've found inconsistencies.  The ability to hotplug memory is a
valuable feature.  It will be necessary to get it working sooner or
later.

Are you going to work on it?

Stefan

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0cfa4ACgkQnKSrs4Gr
c8ga1wgAmva3Qc55mEoXcDaqVs6KdktECFwlsbttk+jJ0+sd5TDoJNxaaghbayw1
xFZN6/dvTjVE5y69GPaSdR1e0+BV+toLvdJwkf7TAjITBSa8OgQAbCwykttdHc6J
nyd/xpeekni3qkVUz9+y/WHCyxAT1b3wUveTaEeeqdrxZViR0Tslcw3hhpiTwBZI
JNj9CPsIjCIDSI8//cueqWeyy0LjrkYt6YbaTQdxXsNHeWm/czemWQkejNML+ZnY
Ub4VCqrvA2xo/CL//Eff+Hn1FKAvEjDCJ1jGOMFqO65lhpdcE6XazK/3HFm6gTsz
ditCEQfveCw7HPxL3m04XXWgjkFO5g==
=Dev0
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--

