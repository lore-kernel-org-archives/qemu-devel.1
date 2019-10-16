Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94AF8FA372A
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 18:50:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E6812053B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 18:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlQ7HdLt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E6812053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKoNI-0005W1-Pi
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 14:50:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56662)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iKoLv-00047y-R6
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 14:48:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iKoLu-0007t6-Ge
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 14:48:55 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39109)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iKoLu-0007sr-AO
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 14:48:54 -0400
Received: by mail-wr1-x444.google.com with SMTP id r3so29283054wrj.6
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 11:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=9O0u6YVnpLQOP4EQEFtWOx7TLcl52BTlsDdo8E+vhi8=;
 b=RlQ7HdLtVTteIEFY0VfyGtYZn+8pdCkHKlRdl8ioCoSYq2dJ+KagVsXcUVlBN9I54n
 Xut74oIfbD4nquykREkW1KT1cOTrvanOnPQMv6eXtQv0hw00OJsP6RYRHzTJHinltvot
 BfdQYyF7st/RrlZ3rekUzexziXTSMdBRU0v0W1LhUA+bYf2nxc+Q0PcxBa3hH/CB6yk3
 2kyZ1QEmATtFmKDu4jO/d29CNfSkW4XWYRx41+NNLZCY6Z9nhqWnx0eJ7DsSnQrbhaox
 Y7xMLM2a8AoIb6NXq2rWBUgQCbGB2QVSo3GZfH78H+l1tteFaAX8Xzb4KTcQl+8Q7GoP
 laUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=9O0u6YVnpLQOP4EQEFtWOx7TLcl52BTlsDdo8E+vhi8=;
 b=J8F6EZSWVyLmvQkpCrAPEWKadezfyORQDQ+K7D44vKlIBbwxTIcwyUClD8P/4+lMsQ
 xifoQrLFb2xrUYUbdGAJPGs1g7LrTdWbpUmXUMCrlPmC43HP9hFzXKsxAcIii6XVaT3K
 5bMOkZhHZ+z/dlilkNDRxU3cEFTVkRkp30tSOcLaR++cRxU1hDrcEtvlhgaVccZFIfLH
 jnNguZT3q+CbV6Ufv9dXE9ejB3mb3lmoBrJitJjvLXagWmFwpFqxXE+hXLGo53k8fGUC
 Ru5DgSBqhF0+psfHQzYCFmDTqEMOrmM2OmPWEXMUb8ivO6ZbyrMn8KPDl86fLrlXbHcH
 bGtg==
X-Gm-Message-State: APjAAAUXUxQfXQ3/2JDhl3SEaIyMHsSbVryaqEDFDaIM2yxFn6zu8d/A
 p1IT81Wwd8TjYNvQGdIdzOo=
X-Google-Smtp-Source: APXvYqw4+lAnSB+tJ2JHm9eyPV4yD6XWTcjxCo8O30ICOJGu99+dtZxuxs2M1e3nIiItngS2JXMUXQ==
X-Received: by 2002:adf:8123:: with SMTP id 32mr4153100wrm.300.1571251733011; 
 Wed, 16 Oct 2019 11:48:53 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id s10sm18482015wrr.5.2019.10.16.11.48.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2019 11:48:51 -0700 (PDT)
Date: Wed, 16 Oct 2019 19:48:50 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [PATCH] checkpatch: sugguest to use qemu_real_host_page_size
 instead of getpagesize() or sysconf(_SC_PAGESIZE)
Message-ID: <20191016184850.GB15027@stefanha-x1.localdomain>
References: <20191016012432.22731-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="xXmbgvnjoT4axfJE"
Content-Disposition: inline
In-Reply-To: <20191016012432.22731-1-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: thuth@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com, philmd@redhat.com,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--xXmbgvnjoT4axfJE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2019 at 09:24:32AM +0800, Wei Yang wrote:
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> CC: David Gibson <david@gibson.dropbear.id.au>
> ---
>  scripts/checkpatch.pl | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index aa9a354a0e..4b360ed310 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2915,6 +2915,12 @@ sub process {
>  		if ($line =3D~ /\bbzero\(/) {
>  			ERROR("use memset() instead of bzero()\n" . $herecurr);
>  		}
> +		if ($line =3D~ /getpagesize\(\)/) {
> +			ERROR("use qemu_real_host_page_size instead of getpagesize()\n" . $he=
recurr);
> +		}
> +		if ($line =3D~ /sysconf\(_SC_PAGESIZE\)/) {
> +			ERROR("use qemu_real_host_page_size instead of sysconf(_SC_PAGESIZE)\=
n" . $herecurr);
> +		}
>  		my $non_exit_glib_asserts =3D qr{g_assert_cmpstr|
>  						g_assert_cmpint|
>  						g_assert_cmpuint|

Just wanted to say thank you for extending checkpatch.pl!  We don't do
it enough but it's the best way to extend QEMU coding style because it's
automated :).

Stefan

--xXmbgvnjoT4axfJE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2nZhIACgkQnKSrs4Gr
c8hmeAf8CSo3OvjNDawOcKgnMPT3pj0+rjz0dpzsu7OCy+UGIc217fHxv++/gMUw
/Oca1ygSf5UBF3PV4OKTyU99iC/89hqKq2YGt8HCos0en/q9E3GTSdycU0TGA4HF
apOqn4TXbroXVGVekw5ZPKonkyCAH6Z3tjoPTfPrBmYCcDSdCtyxkKxOaM28qHZc
SVua/GrsioXzPLGpwSMn1c76nKmuhPmV+cFP58EvtriKyJMf/Qqc6rMgfe7V29ph
E/gUymKFyAg9Bi0V40wiPcWOwL0icdhiFOVKxJBVvQYn1f2ctJ/IGt+3m2GNR/V3
tpyNgGyHLmwcArW2RJCg4HeVO0+A0Q==
=wC6W
-----END PGP SIGNATURE-----

--xXmbgvnjoT4axfJE--

