Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C194C33C99
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 07:33:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5947B2072E
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 07:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CaY9NgW3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5947B2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipona-0000by-Dw
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 02:33:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52605)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1ipomo-0008Jo-Jv
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 02:32:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1ipomn-0006cm-IV
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 02:32:50 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:37953)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1ipoml-0006Kc-3S; Fri, 10 Jan 2020 02:32:47 -0500
Received: by mail-wm1-x344.google.com with SMTP id u2so844837wmc.3;
 Thu, 09 Jan 2020 23:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ZzKvdGhJFsMeICXr3VtgCwst4arqpQnw5AaFK1rrQFo=;
 b=CaY9NgW3UER3bu3dElS8wzjdwHr00UPBlWVFoS0DJ1oq402wId9NpLSh31wdtTMSho
 F3IaMgTAcayqRB1xtgID2xTfNNu0BeqSW89AATaZnxqv0N2XNYZOO+1HPd9rrpMhr+LK
 lKmZrN8Hk9vLR+ChCdSaCPECbf6THHRhsb+N6tvZcaslkvcA/zGvZQ2htIHiqOioCiqI
 iVCveIKT6TH2UwSOxHvEOOEMzS38MBKTlcOned6fUhRRtRfVIXbU2KYneBr+ZPuIStAY
 g1nCVLapmEUmw+g9Ao7+ccRTasuASH0DbrEfrJFT+k5m173JYNsethuyB5xk0Oo20iRe
 PJkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ZzKvdGhJFsMeICXr3VtgCwst4arqpQnw5AaFK1rrQFo=;
 b=JFhaLF8DBB3BTW44rGVoCBw6IcIeHPy1CCc78XMNbWEwgRVUtX3wzjJWiIhilSX8Ax
 vuAUxs1dZctyaJsxJQjBzq6+htKRDu7Ienlnn2PuZg+vlAmmd8A+5aC5KqOkJmKjdyVt
 c/r2ZdVUhMjpTv0MGMx5Xowuew3lcRyQkpAWzHVEYjIR4EtXJNKAFwsIKamBVskTTZbb
 +Xd4ZYtKwm4F9fSPTrXetItFXWTQ++8RAJmtduXFwFGx5Q5yabsUwcNmX+1xwCUS3JY2
 obZzFpZ3NVe+Fw6LuSerDEjxkJJAdhQxiDXIukNd2t6YhoAB2YpDloEx2DXxlSrlkmv1
 qWPw==
X-Gm-Message-State: APjAAAXI4yD/LoBNk8Ud97m7zP/IODqY3CQ8CLMzWf9QVOZv7s8l54p5
 zBIflHRREqp0OrqRE+I5rF9gteFLYROCf07TzTk=
X-Google-Smtp-Source: APXvYqyPwr7jXwt56oDnbUds9OMqDPAyge3mbJIWb6fqMeXvmIxTRpYtauusGl0pUKooZ1Cm4+YYDKr7YvPr5Anu5OQ=
X-Received: by 2002:a05:600c:2059:: with SMTP id
 p25mr2465485wmg.161.1578641565696; 
 Thu, 09 Jan 2020 23:32:45 -0800 (PST)
MIME-Version: 1.0
References: <20200110031618.23332-1-pannengyuan@huawei.com>
In-Reply-To: <20200110031618.23332-1-pannengyuan@huawei.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 10 Jan 2020 11:32:32 +0400
Message-ID: <CAJ+F1CJtpu4ac-v-pTkm3Wc95juicCNsPA5sy6+YyCBgEfc7Qg@mail.gmail.com>
Subject: Re: [PATCH] vl: Don't mismatch g_strsplit()/g_free()
To: pannengyuan@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: qemu trival <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>, QEMU <qemu-devel@nongnu.org>,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Fri, Jan 10, 2020 at 7:17 AM <pannengyuan@huawei.com> wrote:
>
> From: Pan Nengyuan <pannengyuan@huawei.com>
>
> It's a mismatch between g_strsplit and g_free, it will cause a memory lea=
k as follow:
>
> [root@localhost]# ./aarch64-softmmu/qemu-system-aarch64 -accel help
> Accelerators supported in QEMU binary:
> tcg
> kvm
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D1207900=3D=3DERROR: LeakSanitizer: detected memory leaks
>
> Direct leak of 8 byte(s) in 2 object(s) allocated from:
>     #0 0xfffd700231cb in __interceptor_malloc (/lib64/libasan.so.4+0xd31c=
b)
>     #1 0xfffd6ec57163 in g_malloc (/lib64/libglib-2.0.so.0+0x57163)
>     #2 0xfffd6ec724d7 in g_strndup (/lib64/libglib-2.0.so.0+0x724d7)
>     #3 0xfffd6ec73d3f in g_strsplit (/lib64/libglib-2.0.so.0+0x73d3f)
>     #4 0xaaab66be5077 in main /mnt/sdc/qemu-master/qemu-4.2.0-rc0/vl.c:35=
17
>     #5 0xfffd6e140b9f in __libc_start_main (/lib64/libc.so.6+0x20b9f)
>     #6 0xaaab66bf0f53  (./build/aarch64-softmmu/qemu-system-aarch64+0x8a0=
f53)
>
> Direct leak of 2 byte(s) in 2 object(s) allocated from:
>     #0 0xfffd700231cb in __interceptor_malloc (/lib64/libasan.so.4+0xd31c=
b)
>     #1 0xfffd6ec57163 in g_malloc (/lib64/libglib-2.0.so.0+0x57163)
>     #2 0xfffd6ec7243b in g_strdup (/lib64/libglib-2.0.so.0+0x7243b)
>     #3 0xfffd6ec73e6f in g_strsplit (/lib64/libglib-2.0.so.0+0x73e6f)
>     #4 0xaaab66be5077 in main /mnt/sdc/qemu-master/qemu-4.2.0-rc0/vl.c:35=
17
>     #5 0xfffd6e140b9f in __libc_start_main (/lib64/libc.so.6+0x20b9f)
>     #6 0xaaab66bf0f53  (./build/aarch64-softmmu/qemu-system-aarch64+0x8a0=
f53)
>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>

Fixes: cbe6d6365a48bce4526c664170cda6fe738484f8

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  vl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/vl.c b/vl.c
> index 86474a55c9..2fa5cb3b9a 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -3476,7 +3476,7 @@ int main(int argc, char **argv, char **envp)
>                              gchar **optname =3D g_strsplit(typename,
>                                                           ACCEL_CLASS_SUF=
FIX, 0);
>                              printf("%s\n", optname[0]);
> -                            g_free(optname);
> +                            g_strfreev(optname);
>                          }
>                          g_free(typename);
>                      }
> --
> 2.21.0.windows.1
>
>
>


--=20
Marc-Andr=C3=A9 Lureau

