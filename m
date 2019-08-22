Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C111C3A5A3
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 14:46:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A04D233A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 14:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hfj6YtK4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A04D233A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0oLv-0008Oa-2P
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 10:46:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35361)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1i0oJw-0006eT-0X
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 10:44:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1i0oJu-0003z9-Vp
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 10:44:11 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34865)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1i0oJu-0003yo-PX
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 10:44:10 -0400
Received: by mail-wr1-x441.google.com with SMTP id k2so5711738wrq.2
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 07:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=5nggAeqAhxEheH08wEzIhrGmIxfJKarZVyPSLZ0EsIU=;
 b=Hfj6YtK4RKn7HQGwBds8W5/WuWrHEvyBTtJ9Xka/lphqed5H6IG+sb8SU1FBAcq/UL
 KFDgll8eAur8WI2sUORxXYzm9SAha3+vpdy3AIbX6ePnSpRyQaxoMgR1GxboVdQZ5tKL
 UpKcq5dL+owGljUbw++sDJn4DQF55Z6YkemQhvXl8i7M2aR+jlDh6DhUMzwdZTrRW+yk
 KNv37KHWzJFkU0/VlKtUDDWGBLBA4iXIMcYJ3jiEQiZ31k2hn4yqIzzlwzxobcs/XkQW
 NZz+XbvwZBu01fTyxAbYA8roz3e8X7r4gcVad5vw5t3I08bcUaU0iSpI+XTAR1ccI30K
 l+8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=5nggAeqAhxEheH08wEzIhrGmIxfJKarZVyPSLZ0EsIU=;
 b=dklSbTbV8ydkJbuynVvOm+NWRMtxTzcRSsxbpjkvahWbwKlzKLCxRXnDkGDRfIMcAb
 W8+IVD084BxiCgxMFQN/7ZIiBmyobqymSbJEJxVCs66MIM948L7dU03+kUb0RM6U5Ecq
 3RYMiifXUUKYaVtvFdpkjak0YJX7Uihg8vUj5i3IXhD0pOuqv+reHFaHjck7+9034YQs
 tJb280l/OT4SR+6qxoC2LCL/axnBlrQ9SDB+5mkgmYrjkx9CmYs6XqZbhnMpGT3NuK/O
 QmRlgMh3JAp3L557l32vvlY76Lr2iM6sxqjXhrEtXs3MRjgqZh39Nn9yKhWFv9/GOIcP
 oZZQ==
X-Gm-Message-State: APjAAAXmPDmTQif7Mbadc0wzxUXT6MMh8Qi1KHixPHg+PBpEf5MfUIZ1
 DJ9eWUpxf4U2QOnJyuACQdk=
X-Google-Smtp-Source: APXvYqz3WuYx5vWLEcCywzTTgsutMwBhi0SgiF9/NAHeL7SOMOLAtBgbdMVKVEVxgfmXncXUq7Qtig==
X-Received: by 2002:a5d:4fc4:: with SMTP id h4mr48077032wrw.64.1566485049096; 
 Thu, 22 Aug 2019 07:44:09 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id a23sm6089560wma.24.2019.08.22.07.44.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2019 07:44:08 -0700 (PDT)
Date: Thu, 22 Aug 2019 15:44:07 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Vanderson Martins do Rosario <vandersonmr2@gmail.com>
Message-ID: <20190822144407.GN20491@stefanha-x1.localdomain>
References: <20190815023725.2659-1-vandersonmr2@gmail.com>
 <20190815023725.2659-2-vandersonmr2@gmail.com>
 <20190815144036.GG10996@stefanha-x1.localdomain>
 <CAMzYVD2pqphWChXPXCCuC9R3NcOHGz5yojLkT_+CMYbNdc4F=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/JIF1IJL1ITjxcV4"
Content-Disposition: inline
In-Reply-To: <CAMzYVD2pqphWChXPXCCuC9R3NcOHGz5yojLkT_+CMYbNdc4F=Q@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v1 1/2] accel/tcg: adding integration with
 linux perf
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--/JIF1IJL1ITjxcV4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2019 at 04:01:48PM -0300, Vanderson Martins do Rosario wrot=
e:
> On Thu, Aug 15, 2019 at 11:40 AM Stefan Hajnoczi <stefanha@gmail.com> wro=
te:
> > On Wed, Aug 14, 2019 at 11:37:24PM -0300, vandersonmr wrote:
> > > +void start_jitdump_file(void)
> > > +{
> > > +    GString *dumpfile_name =3D g_string_new(NULL);;
> > > +    g_string_printf(dumpfile_name, "./jit-%d.dump", getpid());
> >
> > Simpler:
> >
> >   gchar *dumpfile_name =3D g_strdup_printf("./jit-%d.dump", getpid());
> >   ...
> >   g_free(dumpfile_name);
> >
> > > +    dumpfile =3D fopen(dumpfile_name->str, "w+");
> >
> > getpid() and the global dumpfile variable make me wonder what happens
> > with multi-threaded TCG?
> >
>=20
> I did some tests and it appears to be working fine with multi-threaded TC=
G.
> tcg_exec_init should execute only once even in multi-threaded TCG, right?
> If so, we are going to create only one jitdump file. Also, both in Windows
> and Linux/POSIX fwrites is thread-safe, thus we would be safely updating
> the jitdump file. Does it make sense?

append_load_in_jitdump_file() calls fwrite() multiple times.  What
guarantees they will not be interleaved when multiple threads call this
function?

Stefan

--/JIF1IJL1ITjxcV4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1eqjYACgkQnKSrs4Gr
c8jI8QgAoFMaInYLI2mzafETIlwQwPsrNqz4v1VJporgUnSMLQXSuOGrSwA3e2hy
Li/oVx5ZfB89OYkCXnP53tjaCEbypweMpOqzY7fS3kSkFVv4RYyUMR29QLm9/yMF
iY1IFZ5fUAPGc4vciiFOAT3dhMcaydnEN7W/4eOSXXVX2UJG3BJHC35kWJW/aAjg
ZOPFEMSl6oALQSXohoANqg6M/0JQMwfrnvvnnks44Fgzu6UlTKwY9l7z7Apmh4Oi
SfTMZuSIgYuSkbuOa8oU1okrF7/HgkYBO8HjKSHTq7jNie94wDLzBJhBoJ7VFzqC
kGZfdRqE19/k8ZuSBRflQa1wK/n39Q==
=5eQz
-----END PGP SIGNATURE-----

--/JIF1IJL1ITjxcV4--

