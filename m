Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8D5CA9ED5
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 08:40:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B77C220717
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 08:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUE7PlpV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B77C220717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRuO4-0003I8-R7
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 03:40:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37549)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iRuNJ-0002qn-VU
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 03:39:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iRuNI-0007SK-Nq
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 03:39:41 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:34916)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iRuNI-0007S2-G4
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 03:39:40 -0500
Received: by mail-ot1-x343.google.com with SMTP id z6so16954717otb.2
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2019 00:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=3Ibht2ZGgmjCZdw8YE+tl1KwUcravJHzspUU9kHAlgQ=;
 b=EUE7PlpVd/UHmJpIglWOX9BjCZZlzFgPQtAptSkFmSZXbfLnyvmmv2AtJ5pOlfBl8/
 Z4de4JxgtwgpCGYhOsRLSKUBe4wlPZFHovCgy91bs1F24q7GT9T3ku6pbnbKbRMbF1CY
 md+lk1XkGbpLmT+TuqrN9QbkrruesKuV6KFK8zaYPf4gsp7sL9VCgL57EkZGU7bEmggr
 EVFPWZYAkow77Y2kk4weMO3/77jrljraQpc9FaXki3Kl91Ow/67kxYB5rTL53akqHllb
 xPFWOYN8CuodPj8pXiMPpdr1Wh+WnUKhT0RTViADnyTNvrrtuLieC3+pG1jNdd6nFd2P
 gvyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=3Ibht2ZGgmjCZdw8YE+tl1KwUcravJHzspUU9kHAlgQ=;
 b=tWjjMXq6K90YK1Nc2KX8I7kRCW0XkLjm11lXsHI1s72eLh7GPIkMHNVjdKJy4fg97y
 cCcXaiC0dVkhAP+hf5oEsUZqZBcTP9tayfgnGayl75entzG377/a2pOhFgRPqu3Bh00z
 GpJa9q2gFwHYyrq/iZWJm5q31Tr+lkW+5CnXHU1BOq98O6A5DZKPDvv6UHk1lTGFKgHE
 8YimGH/nVyz8kSFpdOJmNqchdEDKYqllPw6Hx9+hzxuZCljyM7wH1EgKSQvKuh46bv9T
 nWTMRZJYfy5IugsSdXCGjV5hoa5f6EXe8I44Gze4OsCI00VEF7PJvdQCZijLgJAaALJm
 4HdA==
X-Gm-Message-State: APjAAAUsx8wXYgBdPlmLYKtEJ7Drd5DjoZ9Ay0OZ/IWc3kCM+4G83Hmv
 I+k/iUykV0uk5qNHjNzuv/aRzpdYwR2Xv9LYt1E=
X-Google-Smtp-Source: APXvYqzHMpBbx+PqB87I6YiTAgj//5njwYJX88Jkqv0zQwnQTIO4yf+gPFpXjBOUABSUWoch0oHhnebrIku8o7uFu4M=
X-Received: by 2002:a05:6830:81:: with SMTP id a1mr8377719oto.64.1572943179719; 
 Tue, 05 Nov 2019 00:39:39 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:5e89:0:0:0:0:0 with HTTP;
 Tue, 5 Nov 2019 00:39:39 -0800 (PST)
In-Reply-To: <20191029212430.20617-6-mrolnik@gmail.com>
References: <20191029212430.20617-1-mrolnik@gmail.com>
 <20191029212430.20617-6-mrolnik@gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 5 Nov 2019 09:39:39 +0100
Message-ID: <CAL1e-=gKGJC4X9aNtj1SL7+s5UryNtEF81YcG4kvhjPNP247Kw@mail.gmail.com>
Subject: Re: [PATCH v35 05/13] target/avr: Add instruction translation -
 Arithmetic and Logic Instructions
To: Michael Rolnik <mrolnik@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000007aadee0596955f9a"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: "thuth@redhat.com" <thuth@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dovgaluk@ispras.ru" <dovgaluk@ispras.ru>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "philmd@redhat.com" <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000007aadee0596955f9a
Content-Type: text/plain; charset="UTF-8"

>
>
> +
> +/*
> + *  This instruction performs 8-bit x 8-bit -> 16-bit signed
> multiplication
> + *  and shifts the result one bit left.
> + */
> +static bool trans_FMULSU(DisasContext *ctx, arg_FMULSU *a)
> +{
> +    if (!avr_have_feature(ctx, AVR_FEATURE_MUL)) {
> +        return true;
> +    }
> +
> +    TCGv R0 = cpu_r[0];
> +    TCGv R1 = cpu_r[1];
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv Rr = cpu_r[a->rr];
> +    TCGv R = tcg_temp_new_i32();
> +    TCGv t0 = tcg_temp_new_i32();
> +
> +    tcg_gen_ext8s_tl(t0, Rd); /* make Rd full 32 bit signed */
> +    tcg_gen_mul_tl(R, t0, Rr); /* R = Rd * Rr */
> +    tcg_gen_andi_tl(R, R, 0xffff); /* make it 16 bits */
> +
> +    tcg_gen_shri_tl(cpu_Cf, R, 15); /* Cf = R(15) */
> +    tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_Zf, R, 0); /* Zf = R == 0 */
> +
> +    tcg_gen_shli_tl(R, R, 1);
> +
> +    tcg_gen_andi_tl(R0, R, 0xff);
> +    tcg_gen_shri_tl(R1, R, 8);
> +    tcg_gen_andi_tl(R1, R1, 0xff);
> +
> +    tcg_temp_free_i32(t0);
> +    tcg_temp_free_i32(R);
> +
> +    return true;
> +}
> +


Hi, Michael.

The way I understand the spec is that a->rd and a->rd must be between 16
and 23:

https://www.microchip.com/webdoc/avrassembler/avrassembler.wb_FMULSU.html

Is my interpretation right? If yes, where is the corresponding part in the
implementation?

Yours, Aleksandar


>

--0000000000007aadee0596955f9a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><br>
+<br>
+/*<br>
+ *=C2=A0 This instruction performs 8-bit x 8-bit -&gt; 16-bit signed multi=
plication<br>
+ *=C2=A0 and shifts the result one bit left.<br>
+ */<br>
+static bool trans_FMULSU(DisasContext *ctx, arg_FMULSU *a)<br>
+{<br>
+=C2=A0 =C2=A0 if (!avr_have_feature(ctx, AVR_FEATURE_MUL)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 TCGv R0 =3D cpu_r[0];<br>
+=C2=A0 =C2=A0 TCGv R1 =3D cpu_r[1];<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv Rr =3D cpu_r[a-&gt;rr];<br>
+=C2=A0 =C2=A0 TCGv R =3D tcg_temp_new_i32();<br>
+=C2=A0 =C2=A0 TCGv t0 =3D tcg_temp_new_i32();<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_ext8s_tl(t0, Rd); /* make Rd full 32 bit signed */<b=
r>
+=C2=A0 =C2=A0 tcg_gen_mul_tl(R, t0, Rr); /* R =3D Rd * Rr */<br>
+=C2=A0 =C2=A0 tcg_gen_andi_tl(R, R, 0xffff); /* make it 16 bits */<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_shri_tl(cpu_Cf, R, 15); /* Cf =3D R(15) */<br>
+=C2=A0 =C2=A0 tcg_gen_setcondi_tl(TCG_COND_<wbr>EQ, cpu_Zf, R, 0); /* Zf =
=3D R =3D=3D 0 */<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_shli_tl(R, R, 1);<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_andi_tl(R0, R, 0xff);<br>
+=C2=A0 =C2=A0 tcg_gen_shri_tl(R1, R, 8);<br>
+=C2=A0 =C2=A0 tcg_gen_andi_tl(R1, R1, 0xff);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(t0);<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(R);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+</blockquote><div><br></div><div>Hi, Michael.</div><div><br></div><div>The=
 way I understand the spec is that a-&gt;rd and a-&gt;rd must be between 16=
 and 23:</div><div><br></div><div><a href=3D"https://www.microchip.com/webd=
oc/avrassembler/avrassembler.wb_FMULSU.html">https://www.microchip.com/webd=
oc/avrassembler/avrassembler.wb_FMULSU.html</a><br></div><div><br></div><di=
v>Is my interpretation right? If yes, where is the corresponding part in th=
e implementation?</div><div><br></div><div>Yours, Aleksandar</div><div><br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex"><br>
</blockquote>

--0000000000007aadee0596955f9a--

