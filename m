Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE5AC49ED9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 10:30:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33B0720692
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 10:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HP4FItSt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33B0720692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8MMz-0007Jw-CX
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 06:30:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54723)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1i8MIa-00040v-HU
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 06:26:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1i8MIZ-0001Rh-4R
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 06:26:00 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55656)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1i8MIW-0001Qg-Tt
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 06:25:57 -0400
Received: by mail-wm1-x341.google.com with SMTP id g207so6815581wmg.5
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 03:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=efv0O1j2ykxEUq+1vA38jCrLUmrb0t0N9/UPuowAhgM=;
 b=HP4FItSt6C4MRk3f3/tX1frv1q7WcDtZ2GyP0hfyhP4QrNjw+/xkZkJ6gjX746mJwk
 e/UPswMGc+uDkjZvtS7pxSzmP2rmAhETcGQ4LjoChMVIFqYGvG+sYIahz6lY6ewzRofI
 wrtS6cot/aDbfq+Qoxibj4B9DCyZfaz/+4W2+vVLHwLmCOFINsY2aqJEWSlu/S0NT+OH
 faESpQPmPba6ElWLJMuxUs9Z4EKocR/Y6OMcjlDiUFUFDWS9kYgG/tQ3zpfiHINnGkn9
 OtdJPk+0p//1qVBLZdZTPQXyQkCuM6A9djcGg9enk9/xQ0R4DMAL7GzJy2AbiJZOE1np
 QRUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=efv0O1j2ykxEUq+1vA38jCrLUmrb0t0N9/UPuowAhgM=;
 b=hY0GSbVdZqVMYvGp1dPzJzVuS5u7AhT3iZee/hATvVry9VC0oM38+GazlsPs/fmXvQ
 HjbFR+xQ2o+ymXD+/2IZ33ZeiFQQoDtSRNJI70ttFM6KMEowpFpVv1tCfKtP8x4o2ReQ
 mfqwhVHgCHwpLn6QLyehKg4L3xDSGenL1PSxMmbq5ABAFZ0Nt73wncPO7rbGDJY6mS31
 LmBDEe6Ie8psvqr0KiRut26HMTmjymCXfQ9oyk8I1htrND2bygcYU93a+raw6p1Ja+Fh
 nl6ONm7ttD8vzwMUGdWEPFQbOtDP0J89vTWwQHOeWiZIeg337VLZTE4uO9nQrtIV6d+u
 Qzfg==
X-Gm-Message-State: APjAAAVTII7hm4msguB3uzELSc7FU3/UpzGFnGK9GWVKV4lPHST8PbZ1
 DEfR8ablLLywQO7F2RaKgI4=
X-Google-Smtp-Source: APXvYqxiIfcBZtlwcXAUbEbxCR/PKYblWyLbCxL24WzbfiWMzWWUegtSr1Nir5Y2EJ9lR3Cn0Ll4UQ==
X-Received: by 2002:a1c:f002:: with SMTP id a2mr2687254wmb.113.1568283954228; 
 Thu, 12 Sep 2019 03:25:54 -0700 (PDT)
Received: from localhost (178.165.130.7.wireless.dyn.drei.com. [178.165.130.7])
 by smtp.gmail.com with ESMTPSA id o22sm43672591wra.96.2019.09.12.03.25.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2019 03:25:53 -0700 (PDT)
Date: Thu, 12 Sep 2019 12:25:51 +0200
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190912102551.GA23174@stefanha-x1.localdomain>
References: <20190830093056.12572-1-stefanha@redhat.com>
 <20190830184445.GF3694@habkost.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
In-Reply-To: <20190830184445.GF3694@habkost.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [PATCH] memory: fetch pmem size in get_file_size()
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
Cc: Haozhong Zhang <haozhong.zhang@intel.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 qemu-devel@nongnu.org, Junyan He <junyan.he@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2019 at 03:44:45PM -0300, Eduardo Habkost wrote:
> On Fri, Aug 30, 2019 at 10:30:56AM +0100, Stefan Hajnoczi wrote:
> > Neither stat(2) nor lseek(2) report the size of Linux devdax pmem
> > character device nodes.  Commit 314aec4a6e06844937f1677f6cba21981005f389
> > ("hostmem-file: reject invalid pmem file sizes") added code to
> > hostmem-file.c to fetch the size from sysfs and compare against the
> > user-provided size=3DNUM parameter:
> >=20
> >   if (backend->size > size) {
> >       error_setg(errp, "size property %" PRIu64 " is larger than "
> >                  "pmem file \"%s\" size %" PRIu64, backend->size,
> >                  fb->mem_path, size);
> >       return;
> >   }
> >=20
> > It turns out that exec.c:qemu_ram_alloc_from_fd() already has an
> > equivalent size check but it skips devdax pmem character devices because
> > lseek(2) returns 0:
> >=20
> >   if (file_size > 0 && file_size < size) {
> >       error_setg(errp, "backing store %s size 0x%" PRIx64
> >                  " does not match 'size' option 0x" RAM_ADDR_FMT,
> >                  mem_path, file_size, size);
> >       return NULL;
> >   }
> >=20
> > This patch moves the devdax pmem file size code into get_file_size() so
> > that we check the memory size in a single place:
> > qemu_ram_alloc_from_fd().  This simplifies the code and makes it more
> > general.
> >=20
> > This also fixes the problem that hostmem-file only checks the devdax
> > pmem file size when the pmem=3Don parameter is given.  An unchecked
> > size=3DNUM parameter can lead to SIGBUS in QEMU so we must always fetch
> > the file size for Linux devdax pmem character device nodes.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>=20
> Paolo, do you want to queue this, or should it go through my
> memory backend queue?

Ping for Paolo

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl16HS8ACgkQnKSrs4Gr
c8jssAgAmjB4R3lceqn8sHuti0xzFIXaxomyP8TZ93VSANwcHEyDYaH9Q0GAylmt
Za1gXslX0QArPEo13/U0o4q+726v/w8wDd179mTUDnzQLKFUtDXy3SAeuP6He3/3
yeCN89d5Ve6hKVkHvkxHvnA/gaFgoANQYKi2NxS+wm1phtxSxe8WVG2+8GDTiHmA
zjHknmkHBqf55CMRntWlMLt0U5mMWpNPhfLu0hT/sQiUzsYR2vEipyl1DP7xj2A7
2FusfI1h6S+SLyeVU94Y2bFCXtq8Jf79dv+5MecG7pPVTNW+ooTOnmnXkFYq7VjR
cP9L+iJ/DqGaAjCaoi1QJS4wRpwA1g==
=fVmO
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--

