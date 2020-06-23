Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497F3C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 12:49:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F0CC2072E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 12:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sNhfcqRn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F0CC2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jniN1-0001va-8s
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 08:49:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43410)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jniMI-0001WE-9w
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 08:49:02 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43214)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jniMG-0004GV-MA
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 08:49:02 -0400
Received: by mail-wr1-x441.google.com with SMTP id l10so20392097wrr.10
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 05:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=J69IgmxjkIOTi83uOhZappd83iXHzV0ytMdtJWW8SUM=;
 b=sNhfcqRnEDT7By7EQ/MLOYf+LEw1fqVXmPNBNYEmgM8oRRY6k1zzxFSa9MIK0+/0tA
 V13L3QoJJBa1xHNxJQ9+y7u2v3VFYX2ju3pgNyMcSFNzlWVDjKQYok+G69frCW2rm0oA
 Er/blRiyOL+PetTZM7bW5Gad1JogyjsWmHy9ooKEkNxFWvRzxYrJbaSjIFOlSXyPEbW/
 zTJjuehn2uwD/WPcW1d9YrtmkMgYxMchXp0s3OxZNHF8VomBMBF9QjM1CFvzxgLygWIG
 Ek0iOEJ3VYMKmKz71jMDUOfaSHeXDzNH/swVArgzLMPhqlyVC3Jm8kI9Y/XlpGMbEQjG
 aaqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=J69IgmxjkIOTi83uOhZappd83iXHzV0ytMdtJWW8SUM=;
 b=EAurBRkoAFEh5eZliDyqGpTPZd9q/PGHBoftD83GnJZj81dKsc38ikAKWXuclVrmDa
 CEhy6eetMicfqiy20utnVTE5n3Ak878XsHvGVnRt+kLlnQ9CB/hDnWN2VJgqCoDXpBcl
 02Dlm3RCm+4xZl+lyWwfzKaxxKcbQ+rXRQgdygaIdaGy0TTCBnIYoE2Ay8cKUmsLlizz
 UhYUrWBF1LMoWjyrdnrFnM1qZW52CH85pp5J81PudtR1IC20XwHZyzUJ1FkcmJORX/G9
 Raq+FNhZxhlfAd1AiDe2F7oiKtkWOInW/opyogAbvdBsOfcpVtQAvvt60RBw8Q5EDXvn
 SZFg==
X-Gm-Message-State: AOAM532ZroNSeZFE/2w92rlP0mGiU6qz8HwvOoGGh5TQ0LxFG/Pno13N
 jMySSabFGJuBlmqGZtMuvQ0=
X-Google-Smtp-Source: ABdhPJyXO6cEjtI8aSbbyPQTJ9LWmhq5TrojSuEP5xJzRQ1na6Cset186LUtLDCI3ht0kNwcZxFRGA==
X-Received: by 2002:adf:ed47:: with SMTP id u7mr21529701wro.201.1592916539262; 
 Tue, 23 Jun 2020 05:48:59 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id v7sm22710818wrp.45.2020.06.23.05.48.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 05:48:58 -0700 (PDT)
Date: Tue, 23 Jun 2020 13:48:57 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Roman Bolshakov <r.bolshakov@yadro.com>
Subject: Re: [PATCH] configure: Don't warn about lack of PIE on macOS
Message-ID: <20200623124857.GH36568@stefanha-x1.localdomain>
References: <20200601124257.32057-1-r.bolshakov@yadro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PNpeiK4tTqhYOExY"
Content-Disposition: inline
In-Reply-To: <20200601124257.32057-1-r.bolshakov@yadro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=stefanha@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--PNpeiK4tTqhYOExY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 01, 2020 at 03:42:57PM +0300, Roman Bolshakov wrote:
> ld64 is making PIE executables for 10.7 and above by default, as
> documented in ld(1).
>=20
> Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
> ---
>  configure | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/configure b/configure
> index af2ba83f0e..6dddbca4b2 100755
> --- a/configure
> +++ b/configure
> @@ -2137,6 +2137,8 @@ elif compile_prog "-Werror -fPIE -DPIE" "-pie"; then
>    QEMU_CFLAGS=3D"-fPIE -DPIE $QEMU_CFLAGS"
>    QEMU_LDFLAGS=3D"-pie $QEMU_LDFLAGS"
>    pie=3D"yes"
> +elif test "$darwin" =3D "yes"; then
> +  pie=3D"yes"

Hi Roman,
I'm wondering why the elif above doesn't detect the presence of PIE
automatically?

  elif compile_prog "-Werror -fPIE -DPIE" "-pie"; then
    QEMU_CFLAGS=3D"-fPIE -DPIE $QEMU_CFLAGS"
    QEMU_LDFLAGS=3D"-pie $QEMU_LDFLAGS"
    pie=3D"yes"

Can this code be tweaked to cover macOS too?

Also CCing Peter Maydell in case he wants to merge this patch directly
into qemu.git.

Stefan

--PNpeiK4tTqhYOExY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7x+jgACgkQnKSrs4Gr
c8jNOAgAjei8nSXjJ4TNswhtbmkVufUX9h49VhelEJid6jMNErAHAKwqzduPKRJR
gU+I+wpwBCCzDp/6kKrDG1RYU5Hq2aCt2abDw8V3YdUYhBlkK4qkM67W8ZRuBmw4
6UMUHUhU1AHy45/dgGqpURufrzLyA5/ND5PYelwUI8GlNgTN5dmpGwzS2j9EFUvL
FYCm+j740LjXdaIrfwIoaMEGusxGvPLYS24wT6xrcwWvcm89opSq6asjV3VbX9ZY
HckqdzTgmVNRNlqX9Se3MA7GHBKrR2cehasOTkoJbuZrrCl1pZJIRz5MtVtAgiF0
MlsnyqCiALeuk5SZOOL/ye2X4rjI0g==
=CZG9
-----END PGP SIGNATURE-----

--PNpeiK4tTqhYOExY--

