Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA64C5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 16:24:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A92F2067B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 16:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLFBCofd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A92F2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSO6m-0002co-Ls
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 11:24:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33447)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iSO4W-0000Ru-E5
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 11:22:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iSO4V-0007FR-9D
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 11:22:16 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35976)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iSO4V-0007Ex-0p
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 11:22:15 -0500
Received: by mail-wm1-x341.google.com with SMTP id c22so4114296wmd.1
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 08:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=7BTQBnDX4onCg4KGh0b/HmtpKP3H7NS6TBv8ecrWTHU=;
 b=JLFBCofd56i8edVn7D1xStuiAHMLtq0dYcxEIczRfFJ1/qbVLpvdmP+CPSSzYWezzi
 ueK+IwDIMoqvD+LmsjSzDAHs6trBAl4bS3nCrfRgd1cX/NlsHxozcmxe12Y67y0CUlmF
 E6itxrxKVk8WbXU9/eC0f4r+0eU7P8hYWNhxz3zS2QHBYGmGbZC5/ZW9THkl1ubuJGRg
 LYa6qiSsAuGXA5xls3mB9s3QjW2v9vF3JKWuy6gG0uJIvcx7k5vlHFK2cDGMcdOoSwQH
 XihYeAHZLKL12HQQlebugMdK/IINu7AcUduNscOAyOU3PwG5WKEZ6WUjsT9CxZvqtDwV
 WY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=7BTQBnDX4onCg4KGh0b/HmtpKP3H7NS6TBv8ecrWTHU=;
 b=BKl+w3Eky6NX3T/7g5YSrUGA/chEJFIpwBbYODK/+quDMZa1t1mQjFTWIPh/DJTgrH
 2W0Ibm4CZkiDjyUZ6fjIhmBwYdIxJBmSMmBZudLnqhngBMYUPDKP5/O5nCLZkFE/7Bwe
 x7bkJ0VxgePKsKBvKsiwxPAUvyVt1+iscQQr7b2FP3r2QeVVmza9JmOaw+UfdVeTatTc
 J4b2V3PngRNE05hrno43NDnvLqjw7ihus5yJUnpDrUgcjEnE/sJ24SHk7oi+D0/aDT1z
 PVGylAXXz8AtiQq3o3rBCswKrQR5ZaT9WbFo3VG51KiYV1eOjzIC0wLiT+O53VX4T8eR
 7L0A==
X-Gm-Message-State: APjAAAX6lBQP5s79q+0O880RsyE4m6VK+YRmjtF1IrOqUmzdmhLfvpf5
 1ja3FcEj6ByJe+1+P7bS6Ow=
X-Google-Smtp-Source: APXvYqxydsMpIuM3+1JysFQ+qj37vst9O1ERU2NwLBd1SVOwVfjCysQ4ZMJv3KUy8z5y9gsKAT7Syw==
X-Received: by 2002:a05:600c:294e:: with SMTP id
 n14mr3238930wmd.18.1573057333875; 
 Wed, 06 Nov 2019 08:22:13 -0800 (PST)
Received: from localhost (178.165.129.116.wireless.dyn.drei.com.
 [178.165.129.116])
 by smtp.gmail.com with ESMTPSA id l2sm23356699wrt.15.2019.11.06.08.22.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2019 08:22:13 -0800 (PST)
Date: Wed, 6 Nov 2019 17:22:11 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Subject: Re: [PATCH v4 05/20] libqtest: Add a layer of abstraciton to send/recv
Message-ID: <20191106162211.GG340561@stefanha-x1.localdomain>
References: <20191030144926.11873-1-alxndr@bu.edu>
 <20191030144926.11873-6-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="4eRLI4hEmsdu6Npr"
Content-Disposition: inline
In-Reply-To: <20191030144926.11873-6-alxndr@bu.edu>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--4eRLI4hEmsdu6Npr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2019 at 02:49:52PM +0000, Oleinik, Alexander wrote:
> @@ -360,6 +383,7 @@ void qtest_quit(QTestState *s)
>      g_free(s);
>  }
> =20
> +
>  static void socket_send(int fd, const char *buf, size_t size)
>  {
>      size_t offset;
[...]
> diff --git a/tests/libqtest.h b/tests/libqtest.h
> index c9e21e05b3..31267fc915 100644
> --- a/tests/libqtest.h
> +++ b/tests/libqtest.h
> @@ -728,5 +728,4 @@ bool qtest_probe_child(QTestState *s);
>   * Set expected exit status of the child.
>   */
>  void qtest_set_expected_status(QTestState *s, int status);
> -
>  #endif

Please avoid whitespace changes.

Otherwise:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--4eRLI4hEmsdu6Npr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3C8zMACgkQnKSrs4Gr
c8hFIgf7BkDJTGFkYqKYoSdG4jZsff7jkEJGBUsAs3izPAKlMIJlHbC28gXD2X1t
zfltoj7MKxySxLlLIvr+z23c7Jt9WQhwN7R3GRuBnZMZFJsgTT576MaLzdh3SShY
rCT+8C3JpseHLicC0ggHeKPA97X8DfOIYrFyFMUP+b3oFJLt0eWeq0ZY6/T/zVCO
s4TNTIDymv0sm+sGUXQxD16cYPcMXTLU89eK5NegpEUrHMDakx6gVWt0QN2i/uUi
Dr0heDbO1JKuzMzLmZKwQysJXQ4d7g84H/Tvc5nimN/SO+jDrqAhGCHfhcuXqwsp
9WNETdVB5omvrLHAe6Cih7zr2I6R1A==
=T3hN
-----END PGP SIGNATURE-----

--4eRLI4hEmsdu6Npr--

