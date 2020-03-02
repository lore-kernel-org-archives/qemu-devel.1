Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3582AC3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 22:03:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E120E21739
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 22:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kt0ySDTr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E120E21739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8t9a-00073L-5A
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 17:03:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51133)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j8t8o-0006at-1c
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 17:02:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j8t8l-0001vL-Gv
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 17:02:21 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36621)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j8t8k-0001sf-ED
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 17:02:18 -0500
Received: by mail-wr1-x444.google.com with SMTP id j16so1822951wrt.3
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 14:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=2XVsU7NlxPY/siBEGCjSoCIqKrh/MuM3bn8b9Lkxdvo=;
 b=Kt0ySDTrYQL9+2AIxSat9P/dQGGAjHQwK5ubG0h1KUILwGixiFmBGDMlAaiicctMMQ
 yzJ7QICyZAcuDViqDtkiol+w/iJEafxTQQA+CCQRk4Ih8TWFGwWIv8uU8m6T28VT89Fv
 7WmkAPVNp6ifH3u55SrrNXa7Gp/QrWX92JFmP1ukLKY0eB8mqWPtbibXcbqQKx/xerBF
 4WhMZ4v7RU42INFFUbQs5rJu6iof+gEyscb67A/vgwGXRtUuvmrbaMbDkTazemIcFsvy
 x5jm3T5FQEFKp1xFYYN27HhfHJsd7TAgz5Yx3nCIy5RLSZO+dDqJwWADQ3lw+ZZ6Gj6J
 Ny4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=2XVsU7NlxPY/siBEGCjSoCIqKrh/MuM3bn8b9Lkxdvo=;
 b=l07TCfK5pGki/cfBh7TSRUyEx2MB8pSCWGHgLU/2Scv7FKw7+LvvPgUS7ZA7QN4xcu
 O1PNCKXo/TDotWbS+0TgEtjiDyU8/YRZglEgy2pyz9OirlJuSIw5Zctlc3GCIXQOx1KV
 kefIwHUBP68Tdrg3Bb2JzHYGzFHJsbq8g311+YeGPNuHEb6VhbTs8/2OitaTJzqQpesa
 HdvxFuova3ElWr4KBqMvWL01Z7EIAPPfEa2gsg1KvhRZO3g5LbXE4YH188i5udKRONZb
 8GClVVtKSE8927TbF0s1qgl8x2FsaLnG8hTVza/EwnYRpYPox1wpyLxxFVXwJUlvYB2j
 UMOQ==
X-Gm-Message-State: ANhLgQ0SonkfbHqPWZImHa5HGN/8N/ckCaqNH8AiAjZSG8uyS9zBJPyB
 rXsK6JtJ5xjNfIYt6p2IJg/A3g==
X-Google-Smtp-Source: ADFU+vs0OhOtQgyOj8e8Td+L6V56g0PuReIsIV+5L8+QEFYV0xihS5Tk5WukGsglje9SFtPKJeD3gg==
X-Received: by 2002:adf:e90d:: with SMTP id f13mr1704142wrm.0.1583186536640;
 Mon, 02 Mar 2020 14:02:16 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c11sm29608281wrp.51.2020.03.02.14.02.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 14:02:15 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 70CFA1FF87;
 Mon,  2 Mar 2020 22:02:14 +0000 (GMT)
References: <20200302181907.32110-1-alex.bennee@linaro.org>
 <20200302181907.32110-8-alex.bennee@linaro.org>
User-agent: mu4e 1.3.9; emacs 27.0.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH  v1 07/10] configure: fix check for libzstd
In-reply-to: <20200302181907.32110-8-alex.bennee@linaro.org>
Date: Mon, 02 Mar 2020 22:02:14 +0000
Message-ID: <874kv68lg9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Fixes: 3a67848134d0
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  configure | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/configure b/configure
> index 7b373bc0bb8..caa65f58831 100755
> --- a/configure
> +++ b/configure
> @@ -2464,7 +2464,7 @@ fi
>  # zstd check
>=20=20
>  if test "$zstd" !=3D "no" ; then
> -    if $pkg_config --exist libzstd ; then
> +    if $pkg_config --exists libzstd ; then

Dropping this patch as it breaks the build even more!

  CC      migration/block.o

/home/travis/build/stsquad/qemu/migration/multifd-zstd.c:24:5: error: unkno=
wn type name =E2=80=98ZSTD_CStream=E2=80=99

     ZSTD_CStream *zcs;

     ^

/home/travis/build/stsquad/qemu/migration/multifd-zstd.c:26:5: error: unkno=
wn type name =E2=80=98ZSTD_DStream=E2=80=99

     ZSTD_DStream *zds;

     ^

/home/travis/build/stsquad/qemu/migration/multifd-zstd.c:28:5: error: unkno=
wn type name =E2=80=98ZSTD_inBuffer=E2=80=99

     ZSTD_inBuffer in;

     ^

/home/travis/build/stsquad/qemu/migration/multifd-zstd.c:29:5: error: unkno=
wn type name =E2=80=98ZSTD_outBuffer=E2=80=99

     ZSTD_outBuffer out;

     ^

/home/travis/build/stsquad/qemu/migration/multifd-zstd.c: In function =E2=
=80=98zstd_send_setup=E2=80=99:

/home/travis/build/stsquad/qemu/migration/multifd-zstd.c:55:14: error: impl=
icit declaration of function =E2=80=98ZSTD_createCStream=E2=80=99 [-Werror=
=3Dimplicit-function-declaration]

     z->zcs =3D ZSTD_createCStream();

              ^

/home/travis/build/stsquad/qemu/migration/multifd-zstd.c:55:5: error: neste=
d extern declaration of =E2=80=98ZSTD_createCStream=E2=80=99 [-Werror=3Dnes=
ted-externs]

     z->zcs =3D ZSTD_createCStream();

     ^

/home/travis/build/stsquad/qemu/migration/multifd-zstd.c:55:12: error: assi=
gnment makes pointer from integer without a cast [-Werror=3Dint-conversion]

     z->zcs =3D ZSTD_createCStream();

            ^

/home/travis/build/stsquad/qemu/migration/multifd-zstd.c:62:11: error: impl=
icit declaration of function =E2=80=98ZSTD_initCStream=E2=80=99 [-Werror=3D=
implicit-function-declaration]

     res =3D ZSTD_initCStream(z->zcs, migrate_multifd_zstd_level());

           ^

/home/travis/build/stsquad/qemu/migration/multifd-zstd.c:62:5: error: neste=
d extern declaration of =E2=80=98ZSTD_initCStream=E2=80=99 [-Werror=3Dneste=
d-externs]

     res =3D ZSTD_initCStream(z->zcs, migrate_multifd_zstd_level());

     ^

/home/travis/build/stsquad/qemu/migration/multifd-zstd.c:64:9: error: impli=
cit declaration of function =E2=80=98ZSTD_freeCStream=E2=80=99 [-Werror=3Di=
mplicit-function-declaration]

         ZSTD_freeCStream(z->zcs);

         ^

/home/travis/build/stsquad/qemu/migration/multifd-zstd.c:64:9: error: neste=
d extern declaration of =E2=80=98ZSTD_freeCStream=E2=80=99 [-Werror=3Dneste=
d-externs]

/home/travis/build/stsquad/qemu/migration/multifd-zstd.c: In function =E2=
=80=98zstd_send_prepare=E2=80=99:

/home/travis/build/stsquad/qemu/migration/multifd-zstd.c:120:11: error: req=
uest for member =E2=80=98dst=E2=80=99 in something not a structure or union

     z->out.dst =3D z->zbuff;

           ^

/home/travis/build/stsquad/qemu/migration/multifd-zstd.c:121:11: error: req=
uest for member =E2=80=98size=E2=80=99 in something not a structure or union

     z->out.size =3D z->zbuff_len;

           ^

/home/travis/build/stsquad/qemu/migration/multifd-zstd.c:122:11: error: req=
uest for member =E2=80=98pos=E2=80=99 in something not a structure or union

     z->out.pos =3D 0;

           ^

/home/travis/build/stsquad/qemu/migration/multifd-zstd.c:125:9: error: unkn=
own type name =E2=80=98ZSTD_EndDirective=E2=80=99

         ZSTD_EndDirective flush =3D ZSTD_e_continue;

         ^

/home/travis/build/stsquad/qemu/migration/multifd-zstd.c:125:35: error: =E2=
=80=98ZSTD_e_continue=E2=80=99 undeclared (first use in this function)

         ZSTD_EndDirective flush =3D ZSTD_e_continue;

                                   ^

/home/travis/build/stsquad/qemu/migration/multifd-zstd.c:125:35: note: each=
 undeclared identifier is reported only once for each function it appears in

/home/travis/build/stsquad/qemu/migration/multifd-zstd.c:128:21: error: =E2=
=80=98ZSTD_e_flush=E2=80=99 undeclared (first use in this function)

             flush =3D ZSTD_e_flush;

                     ^

/home/travis/build/stsquad/qemu/migration/multifd-zstd.c:130:14: error: req=
uest for member =E2=80=98src=E2=80=99 in something not a structure or union

         z->in.src =3D iov[i].iov_base;

              ^

/home/travis/build/stsquad/qemu/migration/multifd-zstd.c:131:14: error: req=
uest for member =E2=80=98size=E2=80=99 in something not a structure or union

         z->in.size =3D iov[i].iov_len;

              ^

/home/travis/build/stsquad/qemu/migration/multifd-zstd.c:132:14: error: req=
uest for member =E2=80=98pos=E2=80=99 in something not a structure or union

         z->in.pos =3D 0;

              ^

/home/travis/build/stsquad/qemu/migration/multifd-zstd.c:143:19: error: imp=
licit declaration of function =E2=80=98ZSTD_compressStream2=E2=80=99 [-Werr=
or=3Dimplicit-function-declaration]

             ret =3D ZSTD_compressStream2(z->zcs, &z->out, &z->in, flush);

                   ^

/home/travis/build/stsquad/qemu/migration/multifd-zstd.c:143:13: error: nes=
ted extern declaration of =E2=80=98ZSTD_compressStream2=E2=80=99 [-Werror=
=3Dnested-externs]

             ret =3D ZSTD_compressStream2(z->zcs, &z->out, &z->in, flush);

             ^

/home/travis/build/stsquad/qemu/migration/multifd-zstd.c:144:35: error: req=
uest for member =E2=80=98size=E2=80=99 in something not a structure or union

         } while (ret > 0 && (z->in.size - z->in.pos > 0)

                                   ^

/home/travis/build/stsquad/qemu/migration/multifd-zstd.c:144:48: error: req=
uest for member =E2=80=98pos=E2=80=99 in something not a structure or union

         } while (ret > 0 && (z->in.size - z->in.pos > 0)

                                                ^

/home/travis/build/stsquad/qemu/migration/multifd-zstd.c:145:36: error: req=
uest for member =E2=80=98size=E2=80=99 in something not a structure or union

                          && (z->out.size - z->out.pos > 0));

                                    ^

/home/travis/build/stsquad/qemu/migration/multifd-zstd.c:145:50: error: req=
uest for member =E2=80=98pos=E2=80=99 in something not a structure or union

                          && (z->out.size - z->out.pos > 0));

                                                  ^

/home/travis/build/stsquad/qemu/migration/multifd-zstd.c:146:30: error: req=
uest for member =E2=80=98size=E2=80=99 in something not a structure or union

         if (ret > 0 && (z->in.size - z->in.pos > 0)) {

                              ^

/home/travis/build/stsquad/qemu/migration/multifd-zstd.c:146:43: error: req=
uest for member =E2=80=98pos=E2=80=99 in something not a structure or union

         if (ret > 0 && (z->in.size - z->in.pos > 0)) {

                                           ^

/home/travis/build/stsquad/qemu/migration/multifd-zstd.c:157:33: error: req=
uest for member =E2=80=98pos=E2=80=99 in something not a structure or union

     p->next_packet_size =3D z->out.pos;

                                 ^

/home/travis/build/stsquad/qemu/migration/multifd-zstd.c: In function =E2=
=80=98zstd_recv_setup=E2=80=99:

/home/travis/build/stsquad/qemu/migration/multifd-zstd.c:199:14: error: imp=
licit declaration of function =E2=80=98ZSTD_createDStream=E2=80=99 [-Werror=
=3Dimplicit-function-declaration]

     z->zds =3D ZSTD_createDStream();

              ^

/home/travis/build/stsquad/qemu/migration/multifd-zstd.c:199:5: error: nest=
ed extern declaration of =E2=80=98ZSTD_createDStream=E2=80=99 [-Werror=3Dne=
sted-externs]

     z->zds =3D ZSTD_createDStream();

     ^

/home/travis/build/stsquad/qemu/migration/multifd-zstd.c:199:12: error: ass=
ignment makes pointer from integer without a cast [-Werror=3Dint-conversion]

     z->zds =3D ZSTD_createDStream();

            ^

/home/travis/build/stsquad/qemu/migration/multifd-zstd.c:206:11: error: imp=
licit declaration of function =E2=80=98ZSTD_initDStream=E2=80=99 [-Werror=
=3Dimplicit-function-declaration]

     ret =3D ZSTD_initDStream(z->zds);

           ^

/home/travis/build/stsquad/qemu/migration/multifd-zstd.c:206:5: error: nest=
ed extern declaration of =E2=80=98ZSTD_initDStream=E2=80=99 [-Werror=3Dnest=
ed-externs]

     ret =3D ZSTD_initDStream(z->zds);

     ^

/home/travis/build/stsquad/qemu/migration/multifd-zstd.c:208:9: error: impl=
icit declaration of function =E2=80=98ZSTD_freeDStream=E2=80=99 [-Werror=3D=
implicit-function-declaration]

         ZSTD_freeDStream(z->zds);

         ^

/home/travis/build/stsquad/qemu/migration/multifd-zstd.c:208:9: error: nest=
ed extern declaration of =E2=80=98ZSTD_freeDStream=E2=80=99 [-Werror=3Dnest=
ed-externs]

/home/travis/build/stsquad/qemu/migration/multifd-zstd.c: In function =E2=
=80=98zstd_recv_pages=E2=80=99:

/home/travis/build/stsquad/qemu/migration/multifd-zstd.c:281:10: error: req=
uest for member =E2=80=98src=E2=80=99 in something not a structure or union

     z->in.src =3D z->zbuff;

          ^

/home/travis/build/stsquad/qemu/migration/multifd-zstd.c:282:10: error: req=
uest for member =E2=80=98size=E2=80=99 in something not a structure or union

     z->in.size =3D in_size;

          ^

/home/travis/build/stsquad/qemu/migration/multifd-zstd.c:283:10: error: req=
uest for member =E2=80=98pos=E2=80=99 in something not a structure or union

     z->in.pos =3D 0;

          ^

/home/travis/build/stsquad/qemu/migration/multifd-zstd.c:288:15: error: req=
uest for member =E2=80=98dst=E2=80=99 in something not a structure or union

         z->out.dst =3D iov->iov_base;

               ^

/home/travis/build/stsquad/qemu/migration/multifd-zstd.c:289:15: error: req=
uest for member =E2=80=98size=E2=80=99 in something not a structure or union

         z->out.size =3D iov->iov_len;

               ^

/home/travis/build/stsquad/qemu/migration/multifd-zstd.c:290:15: error: req=
uest for member =E2=80=98pos=E2=80=99 in something not a structure or union

         z->out.pos =3D 0;

               ^

/home/travis/build/stsquad/qemu/migration/multifd-zstd.c:301:19: error: imp=
licit declaration of function =E2=80=98ZSTD_decompressStream=E2=80=99 [-Wer=
ror=3Dimplicit-function-declaration]

             ret =3D ZSTD_decompressStream(z->zds, &z->out, &z->in);

                   ^

/home/travis/build/stsquad/qemu/migration/multifd-zstd.c:301:13: error: nes=
ted extern declaration of =E2=80=98ZSTD_decompressStream=E2=80=99 [-Werror=
=3Dnested-externs]

             ret =3D ZSTD_decompressStream(z->zds, &z->out, &z->in);

             ^

/home/travis/build/stsquad/qemu/migration/multifd-zstd.c:302:35: error: req=
uest for member =E2=80=98size=E2=80=99 in something not a structure or union

         } while (ret > 0 && (z->in.size - z->in.pos > 0)

                                   ^

/home/travis/build/stsquad/qemu/migration/multifd-zstd.c:302:48: error: req=
uest for member =E2=80=98pos=E2=80=99 in something not a structure or union

         } while (ret > 0 && (z->in.size - z->in.pos > 0)

                                                ^

/home/travis/build/stsquad/qemu/migration/multifd-zstd.c:303:36: error: req=
uest for member =E2=80=98pos=E2=80=99 in something not a structure or union

                          && (z->out.pos < iov->iov_len));

                                    ^

/home/travis/build/stsquad/qemu/migration/multifd-zstd.c:304:31: error: req=
uest for member =E2=80=98pos=E2=80=99 in something not a structure or union

         if (ret > 0 && (z->out.pos < iov->iov_len)) {

                               ^

/home/travis/build/stsquad/qemu/migration/multifd-zstd.c:314:27: error: req=
uest for member =E2=80=98pos=E2=80=99 in something not a structure or union

         out_size +=3D z->out.pos;

                           ^

cc1: all warnings being treated as errors

/home/travis/build/stsquad/qemu/rules.mak:69: recipe for target 'migration/=
multifd-zstd.o' failed

make: *** [migration/multifd-zstd.o] Error 1

make: *** Waiting for unfinished jobs....

rm tests/qemu-iotests/socket_scm_helper.o

>          zstd_cflags=3D"$($pkg_config --cflags libzstd)"
>          zstd_libs=3D"$($pkg_config --libs libzstd)"
>          LIBS=3D"$zstd_libs $LIBS"


--=20
Alex Benn=C3=A9e

