Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F3DC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:54:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA399206C3
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DdbC8biy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA399206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqf3s-0004CF-3q
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 11:54:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqf1D-0000FU-W0
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 11:51:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52057
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqf0w-0001dE-Ls
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 11:51:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593618669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IzDG3O/Zmn9pmRHIOJCjwWcgqwYzvkTgxjwJ1WL8rIs=;
 b=DdbC8biyryWYRA/EODAcybl0/Yoez3CeDClL0BeBSm/ocpByzblYIiBCCoWiE+fDrOXDfn
 0mrxGKzp4lj1i3Hk8Mzv01Kd90q7r2hveDSEKsTHXyN6y86tvtgg9QtEcffN1BmpIjG8d6
 aktjvoxJ2tHUfJrFzXXymk66/4KDZKE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-XIE1rZm9P3yP1-HCqltzEQ-1; Wed, 01 Jul 2020 11:51:07 -0400
X-MC-Unique: XIE1rZm9P3yP1-HCqltzEQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E63F80183C;
 Wed,  1 Jul 2020 15:51:06 +0000 (UTC)
Received: from localhost (ovpn-113-121.ams2.redhat.com [10.36.113.121])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9920C10013C1;
 Wed,  1 Jul 2020 15:51:05 +0000 (UTC)
Date: Wed, 1 Jul 2020 16:51:04 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 06/12] block/nvme: Use union of NvmeIdCtrl / NvmeIdNs
 structures
Message-ID: <20200701155104.GQ126613@stefanha-x1.localdomain>
References: <20200630191318.30021-1-philmd@redhat.com>
 <20200630191318.30021-7-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200630191318.30021-7-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="OxDG9cJJSSQMUzGF"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 22:25:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Maxim Levitsky <mlevitsk@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--OxDG9cJJSSQMUzGF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2020 at 09:13:12PM +0200, Philippe Mathieu-Daud=E9 wrote:
> We allocate an unique chunk of memory then use it for two
> different structures. By using an union, we make it clear
> the data is overlapping (and we can remove the casts).
>=20
> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  block/nvme.c | 31 +++++++++++++++----------------
>  1 file changed, 15 insertions(+), 16 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--OxDG9cJJSSQMUzGF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl78sOgACgkQnKSrs4Gr
c8jgdgf/YQ5y0hwlt2MNj98CaXw88tGEop+WSGM7WyV/y/Y1J/9zsR41JIV3GHom
QswA5BBGjnSSWCoNMpqe431Y0Nw0XilCwc1eyRoYrlkbFsGDDhbB4DYRqr8+6mLC
SfS/i+XGC87h3gZtxfG5LwsOwiEdP9hu+t7CNvqgvghJBc8A27L+/FIzJIhgT6+1
L5LyCExJUWqA8Xf7qyYMvx+NifVWcM0T9bzpUzm8Ba2vVtcft5X/t1OgZTwNvF/b
JwnClRQOnahQuq4Vg4tvvY8yorQELsI85A6og0awh21ov3qcimZgrjSf2KHy/Hs7
eXcczYch1ubFz5XDcmH7m8V4HY2Zxg==
=pKj+
-----END PGP SIGNATURE-----

--OxDG9cJJSSQMUzGF--


