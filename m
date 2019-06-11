Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9AAC43218
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 15:23:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BDDE208E3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 15:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ns+DhRI2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BDDE208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60160 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haic1-0002z8-7U
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 11:23:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54259)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1haiV6-0008V1-1D
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 11:15:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1haiV3-0007Fq-Tc
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 11:15:51 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:41445)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1haiV3-0006vo-GG
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 11:15:49 -0400
Received: by mail-wr1-x430.google.com with SMTP id c2so13477628wrm.8
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2019 08:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=QWCKKdB89/LQiLCgr5TJc2h18ombv6vA4G1LPxk/F08=;
 b=ns+DhRI2sL6RonpV4Qs9H7oH4in0FpcHFMKAM6VdzbeeFmnrqncDl0CydwH27yYGZB
 TtgkS6M9wGU8tOmK3lKa6EbPS/rp4lZkCEmYy7E5MYrwfcNEAVG/q/iTXJ35tODjGShO
 btbgG74xShG+cWtR+HDt5rtKeDTN5U+Byg7UpWAX6Tz0Q4N8M7NGhOwyOImBxYRtYgA2
 g1iY+7ZG2z/KcmJjj5uWGfP9JPbyaMnBfUMA73DIMFhYwO3pcWvrggdERJOX74HsjU4L
 uNNXFs68m3D00WVHb0kM0q8/t1SNSMglyHu0v2KDinORZlYI1tY7ebiHf6zPqdVD+tHX
 ZCgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=QWCKKdB89/LQiLCgr5TJc2h18ombv6vA4G1LPxk/F08=;
 b=pT6ll02lPdzbb2BdnCWhrCJG7WwVl0XKBulBEeVcFbRI745KplSAECoD+tN6X02Hhc
 9VDKxWWasycSk9eoTODb9/CnsokAVTEvOWmD7kxofKOxy5qZjrYrMyTSpaUIfLeCWEYn
 pv6JY4BeBseu59QuI5PHVUlUp4qE1BfV0KhMg1Z6W2U9C/lo59C3YZNtenEpg5kcxjDR
 mqLpqwuCtivQa5I5Msdd3zS7AYbY0xnz6eEKT7qKI9G2hYpFf8TUloljJeVqoM/It5AU
 oAlNVOHQf2EkW83JrnDMIDgF4uU+eklAQpaYWw9hl2Oy3IyyAj+KU2Cx6rtzwGLxL8ZP
 my2A==
X-Gm-Message-State: APjAAAUY9PSMXG82ATPj/4u8R+xrQ8JCW4uUtwAkCo2TB7XLIlZaPMYp
 Ft1PcIr/2KajoOEb+rkC8LY=
X-Google-Smtp-Source: APXvYqw6sxantcNGzApMzubqg+NM2h1U3ytlZKGy+3a2azj++a4nWfOj2FFRyTXQZRy81aPxlJ312A==
X-Received: by 2002:adf:baca:: with SMTP id w10mr3602712wrg.230.1560266132099; 
 Tue, 11 Jun 2019 08:15:32 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id t6sm3560769wmb.29.2019.06.11.08.15.30
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 11 Jun 2019 08:15:31 -0700 (PDT)
Date: Tue, 11 Jun 2019 16:15:30 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: colin.xu@intel.com, hang.yuan@intel.com
Message-ID: <20190611151530.GA1620@stefanha-x1.localdomain>
References: <a84315e7-6e37-cb4b-1ec8-f1e5831594e8@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <a84315e7-6e37-cb4b-1ec8-f1e5831594e8@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
Subject: Re: [Qemu-devel] New HAXM maintainer
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
Cc: haxm-team@intel.com, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2019 at 05:34:24PM +0800, Yu Ning wrote:
> I am leaving Intel, and will soon lose access to my Intel email accounts.
> Effective today, I am no longer maintainer of the HAXM open source project
> (https://github.com/intel/haxm). Colin Xu (colin DOT xu AT intel DOT com)
> will take my place, and he will be helped by Henry Yuan (hang DOT yuan AT
> intel DOT com) as well as the rest of the HAXM team at Intel (team email:
> haxm DASH team AT intel DOT com).
>=20
> I am grateful for all the support this community has given to HAXM and
> myself over the past few years. I would appreciate your continued support
> for the project and the Intel HAXM team.

Colin and Henry, do you want to send a patch to the ./MAINTAINERS file?

By listing yourselves as maintainers in that file
scripts/get_maintainer.pl will identify you.  This script is often used
by people to decide who should be CCed on patch emails.

Stefan

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlz/xZIACgkQnKSrs4Gr
c8h2Vgf9FQuWxD64UCgT9wsJD1xwNL2n80YofEgUW7BTvq4wQsb6rdHX0nDNzVIU
cDTTBSSAuJc+cNkq1CxDn97DtdXu/aGSfDFSGaiMJHIferP7LQCGMnF09Cw4SnB9
VudUhSESjtIQrhqHzuBxabO6aq03ZLnFKjVUI+u9CaUCYqWep6Lo2xTzs2AuAxIF
TCN3nvmGY3VUj+UdvU+kuRYzSOBRLB0mpUWZ6FB4NrNRzQwrtJqqqyqcKORubVcQ
+gDjE9bnGi17DiaZPqAtbumkD/ZjP/LfyNcx8V26yhSxJtg5Fh7D5YQzKwV0wZlF
hasglOHkjbriPXSHM5gxkaNBpvhJcA==
=hcbt
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--

