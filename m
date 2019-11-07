Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6906C5DF61
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 13:55:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0F742178F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 13:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ol/6QWVy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0F742178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSiFu-0000Mu-KD
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 08:55:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41900)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iSiEp-0007ww-VA
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 08:54:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iSiEo-0007mF-PU
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 08:54:15 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40728)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iSiEo-0007hN-IN
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 08:54:14 -0500
Received: by mail-wr1-x442.google.com with SMTP id i10so3114576wrs.7
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2019 05:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Ldhiw3m4VnKB6qmznGx8/0y5tGlxpC4AZ4GW3jmQWzA=;
 b=ol/6QWVyaQ2OxJfElSMwAZfEKojN+KoUfeRS0oI4OHdEC/QB49cU5WhthyHbrzl0GV
 aOuegU6svaY7PnXHzv+jn+h+xRFW+Epk5Mi9n4XxrO+Kyo5oNz4zXubesDsRBqHgZ82Q
 HONjvYTZXYF5e6R9TdsIZL0E1rArnbrFyPGb3Pxmufq3jmCXXMdGC8BymxR9dE0/Dspn
 +0B3PpptDfpgFq9Ld2RjdDcFFNFn0LfSEJVDtuZLw5qWrMbEc0L7SBP2R6f+9f4sc/1i
 EPXbFh/oIRnGt/tVdd+pOK8m7l7Q7gmoloPI+cAk+r3Nu0l3Gudtm+7J2lS5qLavlD2R
 DXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Ldhiw3m4VnKB6qmznGx8/0y5tGlxpC4AZ4GW3jmQWzA=;
 b=QvVYrD5WXArvOZjKeA+RsxhkJ1f+CjHz6FZDHzJKMnWssNJZKJfSX63sU3P/1yu/iG
 qI8J6B+g1jBXroDl50qXoi2tLzLVQ6TPMV5FdOAIgSLEe6+knqo6r/tqK0xuMASP8W/G
 0DydU7dNjzc2dDZhfE/cSTqESA2zyiYd/EYaCenuqV3isKj4fmG0FXSNHUa1CgxyEO+4
 6t3RfDhtqAFDeCvVgB5eKU3IYsTB8eHAnl6lmk66OpYEpVHGtlgEI1cjFPRRc4lxtMip
 MIUUmrg4yykW4jyu5u3j1/8x6g3NFYTlnr9RGMPCUdzL+k1PUdv5JH0B+GOJjyTRSOOQ
 RSxw==
X-Gm-Message-State: APjAAAWgfAT3NS6t1BKP6+PEOWuAtRPm6mHeRqTqkAelxoESrudZ4i6Q
 /reDOySffxHwXjMDz1704ZE=
X-Google-Smtp-Source: APXvYqx7xogWv/um2A+AZu2UGDQ5t7TdGvAULCF9NTaazDo3WNC53JcrGmqRFXS61OD7OFZxutb37g==
X-Received: by 2002:a05:6000:1605:: with SMTP id
 u5mr2886834wrb.252.1573134852089; 
 Thu, 07 Nov 2019 05:54:12 -0800 (PST)
Received: from localhost (77.119.131.75.wireless.dyn.drei.com. [77.119.131.75])
 by smtp.gmail.com with ESMTPSA id h205sm2324441wmf.35.2019.11.07.05.54.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2019 05:54:11 -0800 (PST)
Date: Thu, 7 Nov 2019 14:54:01 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Rajath Shashidhara <rajaths@cs.utexas.edu>
Subject: Re: Looking for issues/features for my first contribution
Message-ID: <20191107135401.GH365089@stefanha-x1.localdomain>
References: <f5a16b3c-2c17-60e4-e80b-dd20b3c088cc@cs.utexas.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ISKrrfpKsPiF35CV"
Content-Disposition: inline
In-Reply-To: <f5a16b3c-2c17-60e4-e80b-dd20b3c088cc@cs.utexas.edu>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: dinahbaum@utexas.edu, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--ISKrrfpKsPiF35CV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 06, 2019 at 05:50:44PM -0600, Rajath Shashidhara wrote:
> Hi all,
>=20
> I am a Computer Science graduate student at The University of Texas at
> Austin (UT, Austin). I am looking forward to contributing to qemu !
>=20
> This semester, I am taking a class in Virtualization
> (https://github.com/vijay03/cs378-f19) and contributing to a virtualizati=
on
> related open-source project is a significant part of the course.
> I would be interested in contributing a patchset to qemu - possibly a
> self-contained feature or a reasonably complex bug fix that can be comple=
ted
> in under a month's time. I did look at both the bugtracker and the QEMU
> Google Summer of Code 2019 page
> [https://wiki.qemu.org/Google_Summer_of_Code_2019] for ideas. However, I
> would be interested in hearing from the community and I would be delighted
> if somebody can be suggest a suitable project !
>=20
> I am an advanced C programmer with both professional and academic backgro=
und
> in systems design & implementation - especially OS & Networks. Given my
> background, I feel fairly confident that I can pickup the QEMU codebase
> quickly.

Please check with Dinah Baum whether the SeaBIOS MMConfig task is
already taken, maybe you'd like to work on it if the task is still
available:

  https://lore.kernel.org/qemu-devel/20191105163952.GI166646@stefanha-x1.lo=
caldomain/

Stefan

--ISKrrfpKsPiF35CV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3EIfkACgkQnKSrs4Gr
c8jIWgf9GhfqBJ9RoFAUR07d9TeyqFg3SqPNHQrBNyKhL4mq+Krt0nSYBYVuorpm
/HtiIPsDhwEWxJZje2K+w2NzJJwNlDxxFWfiisE7pgzWa/TVwZ/4HdsMec8Cmth7
vIcWPGXGSfT6xLCZzSPKvkYvSSJv4jx8TtcTMIFkewyDO6NjGv+nNaYiCIKvX6Zp
Xcrd+IW9c+YHheT9oGXHd0hoNRlF6mBoui9x2GzMZ0MYLR3bGAON4w9pX7UqthXR
hmC0Xv0PJPHFFZsPyy4hEpAd//c+d2oNJpNyu76X250Bj2CgNl9t29mXqvFpImiG
+hcRSGP2+q2zsIeMSd0fyCFBnGAiHQ==
=a9A4
-----END PGP SIGNATURE-----

--ISKrrfpKsPiF35CV--

