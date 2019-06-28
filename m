Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F78C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 09:25:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 236AE20665
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 09:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTnRCc+f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 236AE20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgn8M-0004fh-53
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 05:25:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45206)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hgn4l-00022i-EB
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 05:21:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hgn4d-0001tB-Pq
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 05:21:43 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40992)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hgn4W-0001mB-FJ
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 05:21:33 -0400
Received: by mail-wr1-x444.google.com with SMTP id c2so5478171wrm.8
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 02:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=eRCtcLoaEBcf/bHy9g0FT0h38F0lwsJcB2f17cYZJyo=;
 b=kTnRCc+fWAk77GJvjVz4ssYxREMbOsWwrq7/YW5AZGGqpkmaOtMCbXkn3PiIOye1Oy
 qfwRYXQZGxcIf4pAbIN166X1/htKIZfEtLaOp61FatvkP+gOyURnLSQQt+Ohou8TaC3O
 0qVmb4SYfTM+Rk+Q24ondZhyWBpF/Kkza9/+sBdrDcA6a7e6bYVQWg4gW/8CtiYPJZDo
 omM8GNbaW1Ne2BdaC6pAV3dQtGMMS5iwMkZrJooQgjrg2QfU7JZzMmCcLliTKXaDklLR
 AB0KLp9nHOnT5qgSlbQY3VdX6noYxXND2AJ9UmpiP1VBEbhodfv1bwru9Feyvb7YmvGn
 vKPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=eRCtcLoaEBcf/bHy9g0FT0h38F0lwsJcB2f17cYZJyo=;
 b=hRGRB0Si/Ltm7cAXYyyhDzeIkv3/kRVc5zFKKO4JjLIcbnZLpa4aFBqqjSRVJnNpJs
 0U0+pH7rU7QvCZCAa7Ra22f2RBlMLpyBti9yXUy0mV9UIujeLM8T15w+i7mFSdMfYIs7
 DKc/ApxzhMRLs2QfcMXkCSXDVF85lq5BwBEzuu+pXsWPmZF0QFuGNS/MTqSTDP4nTRcr
 CcTG8LRL7GymSC1vkcB11N4ktahNNYTtBlnhNqdYpGtxZ7qKobYjIVkKqc/u5MO5/US8
 BZcJVlsbnCM6BylcdD6Iu06xKzwzdh4zAaSObUfoA5gzAbjI5tyxAcdV1QPHB/hKnt7b
 Akdg==
X-Gm-Message-State: APjAAAWgDq9bk85Sr2bf9AtEmJQD5fbJi1azsvR7TspsK9YZBydxssok
 FBLcOQ0E4mL7Vk141NNPEUQ=
X-Google-Smtp-Source: APXvYqzMVZU4c+icS9eXSKbobpPo570dFXXQ2X1pbFqfzFlFWlJ9fJAGK4QFYXIBPH5nbXr3RW2grw==
X-Received: by 2002:adf:e691:: with SMTP id r17mr7222210wrm.67.1561713689308; 
 Fri, 28 Jun 2019 02:21:29 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id 32sm3142782wra.35.2019.06.28.02.21.28
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 28 Jun 2019 02:21:28 -0700 (PDT)
Date: Fri, 28 Jun 2019 10:21:27 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190628092127.GC3316@stefanha-x1.localdomain>
References: <20190613050937.124903-1-aik@ozlabs.ru>
 <35361394-42ba-dcf0-6fe2-5a0a538d1440@redhat.com>
 <d20e26db-7157-d9bd-c707-d7f4443396c0@ozlabs.ru>
 <20190614093306.GG10957@stefanha-x1.localdomain>
 <3f3a9055-429e-5930-ef20-468d27373e8c@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="zCKi3GIZzVBPywwA"
Content-Disposition: inline
In-Reply-To: <3f3a9055-429e-5930-ef20-468d27373e8c@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH qemu] loader: Trace loaded images
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--zCKi3GIZzVBPywwA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2019 at 12:10:48PM +0200, Philippe Mathieu-Daud=E9 wrote:
> On 6/14/19 11:33 AM, Stefan Hajnoczi wrote:
> > On Fri, Jun 14, 2019 at 10:13:04AM +1000, Alexey Kardashevskiy wrote:
> >>
> >>
> >> On 13/06/2019 23:08, Philippe Mathieu-Daud=E9 wrote:
> >>> Hi Alexey,
> >>>
> >>> On 6/13/19 7:09 AM, Alexey Kardashevskiy wrote:
> >>>> This adds a trace point which prints every loaded image. This includ=
es
> >>>> bios/firmware/kernel/initradmdisk/pcirom.
> >>>>
> >>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >>>> ---
> >>>>
> >>>> The example for a pseries guest:
> >>>>
> >>>> loader_write_rom slof.bin: @0x0 size=3D0xe22e0 ROM=3D0
> >>>> loader_write_rom phdr #0: /home/aik/t/vml4120le: @0x400000 size=3D0x=
13df000 ROM=3D0
> >>>> loader_write_rom /home/aik/t/le.cpio: @0x1ad0000 size=3D0x9463a00 RO=
M=3D0
> >>>
> >>> I find the "ROM=3D0" part confuse, maybe you can change to "ROM:false=
".
> >>
> >> How? I mean I can do that in the code as rom->isrom?"true":"false" and
> >> make trace point accept "%s" but it is quite ugly and others seem to
> >> just use %d for bool.
> >=20
> > Yes, %d is the convention for bool.  Perhaps you can name it "is_rom"
> > instead of "ROM".  That way the name communicates that this is a boolean
> > value.
>=20
> I agree a boolean is easier to parse for trace analyzer tools than a
> "true/false" string.
>=20
> Stefan, is it possible to add a boolean format string to the backends?
> For example the 'log' backend would log it as "true"/"false".

Yes.  The format string in trace-events is not used by all trace
backends, and they are free to do whatever they like (e.g. by looking at
the C types of the trace event arguments).

Stefan

--zCKi3GIZzVBPywwA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0V3BcACgkQnKSrs4Gr
c8iFTAf/W4XtU/1Zgyx1d9zhTTnM9NwYHvAmMABOitVtoxMprQDLdh+5jSfPwfSl
y9u852xHNx5NwMEYv1k2jtCjoYp+LwPwvjJHLWlgob41wnegxDJKJGd7nFkPVdCP
T6tVlLd9tjWxOG64UOpVYXSFSkVm4XEulJqmU2AktWqzGPkP6j6MLl/6NLAyH6ED
UCeyOcrWHqrUj/quXVfhbqQLGMvDE1LOYG7oSHbaE7NSiR93ggu1CuJc3cl6KBwU
2MkSKxOIhnqatT/PqzETUbliropCSFcQDvkt2bVRd3qnKW3qSulUNC6PGlz4jKjI
kcQ9NSJd4fb70Wt3izXBJb6m7qv5jQ==
=PgDa
-----END PGP SIGNATURE-----

--zCKi3GIZzVBPywwA--

