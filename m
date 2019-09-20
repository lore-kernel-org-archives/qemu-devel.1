Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAAF9C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 08:55:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B16742086A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 08:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUxxr/6f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B16742086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBEhg-0002nQ-RE
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 04:55:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48988)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iBEgk-0002G1-IP
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 04:54:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iBEgj-0005yP-Lk
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 04:54:50 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37662)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iBEgj-0005xx-Gv
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 04:54:49 -0400
Received: by mail-wr1-x443.google.com with SMTP id i1so5903741wro.4
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 01:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=dP7OQeqeMQNd5WG8a5+y7bXTxipjH8tauZxGITo00Zc=;
 b=kUxxr/6ftJMWWgbG22T+tMAtg3214w2ZYCN5akq9Fb22sKLkIWjAWjiAzhygXYo3Xv
 8MYZa6RXReW5e5yzVAyxczCg/73IhjEUFL8zN3Osef6HILa5EhLoxtYAMR16S8QpxmsM
 i0+GiTZbp0oI3eKIHxMwM8qBiHwBKK2AVPSrAVUSUXlb/iLtMVaA7hZ1lJ5OVaD0arrx
 s4BUWGObNjiTajvknXXejrScz80pnVDrMXQgCe7r82LHsz9yh59co+rKrxf+9F+TV6nP
 lvSIpMeODLZFBPnJVnIeETiGR7a94WPVQui+sr1FGxNwAgZLIwJ96dvFzaqQzHcj4a+A
 seWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=dP7OQeqeMQNd5WG8a5+y7bXTxipjH8tauZxGITo00Zc=;
 b=j7AnP+4nbLMnA2MvYME34xb6CXopyM76IYA+UnYOJXK5ofBmwkFw4209PNxz2VLoPA
 ZnuuPQ9Kj2eom6hDkyH7g2smS4T/1QpDKRDj+tlcGDHRbq4XzyorTdnQ20me0aRSDAB6
 fqOm+s+Y2ORFNdqar2Dq/w71j2bjdHO1MyCI7T5yt0HnL6dSW2piYL+ZDtRq6I31gzjd
 V2KD6+Lnmqa4m6BGJTfQdU+/Bhur3/mA5dAcVwYOPRJA4uo8p+CzPwF4sVJdbWDWGQOJ
 AHddFNJv9ZEeJCeWQDwygw5+NAouwXPC4AnP41grnl7pTUyFbZc9diYq1NJG+z2VY1JP
 /adA==
X-Gm-Message-State: APjAAAUMxoCD+83ECk+ZyjrTNfmO2x865j0Erg0XlnNJZbLkPYSMEm0Y
 gbSO1x/MPKxeLUcAvGd44Vo=
X-Google-Smtp-Source: APXvYqzsB5HmgrfJNQfRA3Ed6FLPmjT2oIq0uwn9cXa48neixJYgbH5Ecm0ne/CEo4BIXoB82wGHgg==
X-Received: by 2002:a5d:4b4e:: with SMTP id w14mr10721033wrs.191.1568969688581; 
 Fri, 20 Sep 2019 01:54:48 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id g11sm1284243wmh.45.2019.09.20.01.54.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2019 01:54:47 -0700 (PDT)
Date: Fri, 20 Sep 2019 09:54:46 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [Qemu-devel] [PATCH] libvhost-user-glib: use
 g_main_context_get_thread_default()
Message-ID: <20190920085446.GE14365@stefanha-x1.localdomain>
References: <20190917122512.15320-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9l24NVCWtSuIVIod"
Content-Disposition: inline
In-Reply-To: <20190917122512.15320-1-johannes@sipsolutions.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: qemu-devel@nongnu.org, Johannes Berg <johannes.berg@intel.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--9l24NVCWtSuIVIod
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 17, 2019 at 02:25:12PM +0200, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>=20
> If we use NULL, we just get the main program default mainloop
> here. Using g_main_context_get_thread_default() has basically
> the same effect, but it lets us start different devices in
> different threads with different mainloops, which can be useful.
>=20
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  contrib/libvhost-user/libvhost-user-glib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--9l24NVCWtSuIVIod
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2Ek9YACgkQnKSrs4Gr
c8in4gf/WyXaIKG/1v8+Xs5TxboI1i/HOkdzPQ1DgnhWMkAG0JEhcpa+xAran9Nj
0+Mpai1nhIP/+ZiLV7Fsl+VSN/Z9wy6X0JGe8JcFdx9afNgFR+orSFnjA9inbSgb
WbMvpB0NsK4gM72iI0CWUEoruyPWrk8pqtukCpUSMx6g5WpvCgPLj46G0Xa7tM18
rviLgahtaOnR364T6ydP6bh9k9ZpVxhJYmFHRoZO1xQuZsiyyuVngS6YLvdzWKNw
Uq5W0OgiC9OEcXZs/ap4VA/UYuGZ1iQtHGPiBIc35sDR1tjJ8ECkLy6kAcVa7YGt
Jj6aiGcNgRETSdOtMmJwuT5tLc77TA==
=V6Gj
-----END PGP SIGNATURE-----

--9l24NVCWtSuIVIod--

