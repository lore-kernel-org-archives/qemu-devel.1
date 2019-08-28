Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2B7C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 09:03:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 874C82173E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 09:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qxtxhAGQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 874C82173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2trY-0004J6-08
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 05:03:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36501)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1i2tpA-0003Qo-0M
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 05:01:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1i2tp4-00054R-2O
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 05:01:03 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54517)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1i2tp3-00052E-Jc
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 05:00:58 -0400
Received: by mail-wm1-x343.google.com with SMTP id t6so1876267wmj.4
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 02:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=i/8h2K6T8jQK+t4Gs2yfTTlQSIxkANYrX6kvQTRq1KI=;
 b=qxtxhAGQcXWXx57nkiCKUIn92mKiaPjiTAMWOA1QyWBVaHMjE2rG6ULwZL3FRLzjJd
 DJi7rJWPf7HELj75VHXKnSSWqTp8JOcgvPoYpoteH81rlX+4TmZ4uqT4Gw1Ib+96Qln7
 5YzdxdRqm6diCNG1wZcA9KK2rNO63RsMc0M31C67V/7DPyiO9guiyeXrb8RE+pyRnDBe
 xvCsVq/SAZ2QCl54cmsMmPraH4cHWULyCRQBaAHayVga7RWDl+Fih9JlFLtxF52qgWut
 7M3ZzdThRd5/QBRblVbM85OMzxup12rX/KyTQn/T3rGnsImhHX2Lipzu/GDN2FNAQCOb
 mqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=i/8h2K6T8jQK+t4Gs2yfTTlQSIxkANYrX6kvQTRq1KI=;
 b=PmSPbXxabQCrlqx+2nNmoXZobHFlEQ0KAoH9GeXmbbeIBfdQBeUg3+LMQRLWWKu4rC
 9N0t4Gqey5JnN3pYBo2NX8xJ4GT659W/XMq0JDSMokqBKLnjPJ56sCfUbkgnBRG1nAUj
 g6IfBHfpU7MJEuFAgp0aziFjCXP1EgcK6zfNJtbHMGr4iZgim5UJCqhyuoIZK6hnunSV
 I6sEDjl5FXsgr0VlcrjWG4Bqhod5jukmMUI8U/yEoHkZX+Uo4bDDMLADNgAKVpizeKqw
 2xOHupyPev3nVepjleJEV0ijwUsi25AGGvI20+WYsoEU5XniIQ0fklZS26w7t/l57PPu
 aVEw==
X-Gm-Message-State: APjAAAUibtbiX+aebw3Ipj3H/KHQ6mBVYiw95BlCZlMRqW0U4LidL/OZ
 QmJzgCw4zPwS4RLnYjis1jw=
X-Google-Smtp-Source: APXvYqxIsK8wd1XD/TS7i1nricPdsf3gCni15s+N5e4GpYWQlDeObtdFesF7TlTAIxmY5r7vfTiW+Q==
X-Received: by 2002:a05:600c:2056:: with SMTP id
 p22mr3398100wmg.155.1566982855917; 
 Wed, 28 Aug 2019 02:00:55 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id g26sm1487841wmh.32.2019.08.28.02.00.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 02:00:54 -0700 (PDT)
Date: Wed, 28 Aug 2019 10:00:53 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Message-ID: <20190828090053.GB5573@stefanha-x1.localdomain>
References: <20190823163931.7442-1-berrange@redhat.com>
 <20190823163931.7442-4-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9zSXsLTf0vkW971A"
Content-Disposition: inline
In-Reply-To: <20190823163931.7442-4-berrange@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [PATCH 3/4] docs: document use of automatic
 cleanup functions in glib
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
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--9zSXsLTf0vkW971A
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2019 at 05:39:30PM +0100, Daniel P. Berrang=E9 wrote:
> Document the use of g_autofree and g_autoptr in glib for automatic
> freeing of memory, or other resource cleanup (eg mutex unlocking).
>=20
> Signed-off-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> ---
>  CODING_STYLE.md | 101 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 101 insertions(+)

With Eric's suggestion:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--9zSXsLTf0vkW971A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1mQsUACgkQnKSrs4Gr
c8j6mAgApjLhf3xRDycB6r1C0PhcrrZ6aWGcoQnMogK0lykXMoz4KA2ms7Mo4ZtS
BKHiD3BNDj/JWRA+/1gYMlWvM9NcN8OuQknvULrjgIyif1O1W0YWx3ZS1BfFyiIu
2lLW9gNaQPyWNnlpFAhIaBAYXhV/tx6c/BU3OKIWc0dA69Sb+loGTeJUN66hA4KJ
26ZI36AlBPgJG8cOmS8xVgubvSDzpEqWAJ52gz9Xfpr/w0tjyIECHKuLHK8ihS8O
44Ov3cdSrbiwjzsFQkviswoECLlcpjwaJOTQMhYkqSAsza6MznQpVQ6vBLs3/E9d
1hOhYrSPpSjdIKHf1F1f7plIIa3IoA==
=gZVN
-----END PGP SIGNATURE-----

--9zSXsLTf0vkW971A--

