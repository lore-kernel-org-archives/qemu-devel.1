Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F56C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 13:04:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7C9220870
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 13:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smartx-com.20150623.gappssmtp.com header.i=@smartx-com.20150623.gappssmtp.com header.b="f9J265HG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7C9220870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX2g1-0007YG-T4
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 09:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1jX2Ku-0000dy-PS
 for qemu-devel@nongnu.org; Fri, 08 May 2020 08:42:40 -0400
Received: from mail-vs1-xe41.google.com ([2607:f8b0:4864:20::e41]:45707)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1jX2Ks-0000n1-SD
 for qemu-devel@nongnu.org; Fri, 08 May 2020 08:42:40 -0400
Received: by mail-vs1-xe41.google.com with SMTP id e10so934383vsp.12
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 05:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=2JkY6Ys4MEndsruP5t0cw+6fU0xJWpFWnZpLDmrVxLo=;
 b=f9J265HGSZ0EFjw9MFQhPXEm/tndUbm/qo9OcYNW3OS6pyPo5y3W8C5IHyoi7riu8D
 +GZ52OsgJiWDsss3otZPo3rSPc4rhAPkNFWnh4shrwWDInOxVIB+qN1xCHHbRfVfG2cJ
 Guiz7njdXVQAziieEm7a2Px2XcLUi77ddL1CLbNIsI+UQT2PhyqSZ5B458Txz9VuWi2r
 f85MVg4IrnaXSISH6S2dfyMEEP3SEUcvRW9kXgQwXEGGph5X12VitmfK1xQqNS6WoNKr
 h+zmYPQ65+xJn3zt49oNN8S89ZxPLNAXpYaus6j8vwS9CJsOUL5FCGlfcPNm78pUCRLs
 ToVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=2JkY6Ys4MEndsruP5t0cw+6fU0xJWpFWnZpLDmrVxLo=;
 b=KoZh+VZsQXxnT002peh3gud0FwAFf9Y4m09VD8kFgwdRSOmcNj5OGcRId0/+SfAGTS
 2JV9p2bMend9V1vYzITvMzGxgPYDuBZ9Mtx4iee52qzwzxRLNhmewkwFQAOs0/qHnNog
 zMcRU8YvBUQBiDfekD1Hzk5t9DxoWZT8WiU2tRfDb5UxITe5FiPhfnDRgV6Qjxvrg/qJ
 QrnUv9UWHq3KvpIAjhfNBkr1xjbwGAsITXOx5ZvKwCSjRHVZORBttlZDVv47LqGFnr69
 wDArRTO85F0HCE0yq0/Otn/OaRyamz3BrBldE5DW0chGKvOTJwpyxSjJHc2Q97QuClrX
 aPrw==
X-Gm-Message-State: AGi0PublX6g1BYw5e/a7cuCfAtEFWTi/s5G+9MxqBudEQsxikqOGPUkf
 VsUWLDuYz1jmoBzjV20Wzb3XPZC1DK/JmVB+VrD+iA==
X-Google-Smtp-Source: APiQypKIHb6ouEmeQAj09iA2ZO9qrEQjlsf1Nr/WxK6jXejdI+QVRaPIA9IJ4s/I/olnNK6mQY5KlrwulaGnF4X9lKs=
X-Received: by 2002:a67:d61c:: with SMTP id n28mr1659888vsj.70.1588941756719; 
 Fri, 08 May 2020 05:42:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200428085122.1621-1-fengli@smartx.com>
 <20200508051441.8143-1-fengli@smartx.com>
 <20200508051441.8143-2-fengli@smartx.com>
 <CAJ+F1CK6S-M4ykYp0DapZ9q0nAD046Uim-F7cxUTYqYC5anBTA@mail.gmail.com>
In-Reply-To: <CAJ+F1CK6S-M4ykYp0DapZ9q0nAD046Uim-F7cxUTYqYC5anBTA@mail.gmail.com>
From: Li Feng <fengli@smartx.com>
Date: Fri, 8 May 2020 20:42:22 +0800
Message-ID: <CAHckoCxh5USw8bqWyn-mc6fEemnu_EEn+NWSLjG-PbuWAaAB7w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] io/channel: fix crash when qio_channel_readv_all
 return 0
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2607:f8b0:4864:20::e41;
 envelope-from=fengli@smartx.com; helo=mail-vs1-xe41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Li Feng <lifeng1519@gmail.com>, Dima Stepanov <dimastep@yandex-team.ru>,
 Kyle Zhang <kyle@smartx.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> =E4=BA=8E2020=E5=B9=B45=
=E6=9C=888=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=888:32=E5=86=99=E9=81=
=93=EF=BC=9A
>
> Hi
>
> On Fri, May 8, 2020 at 7:14 AM Li Feng <fengli@smartx.com> wrote:
> >
> > Root cause:
> > From `man recvmsg`, the RETURN VALUE says:
> > These  calls return the number of bytes received, or -1 if an error occ=
urred.
> > In the event of an error, errno is set to indicate the error.
> > The return value will be 0 when the peer has performed an orderly shutd=
own.
> >
> > When an error happens, the socket will be closed, and recvmsg return 0,
> > then error_setg will trigger a crash.
> >
> > This unit test could reproduce this issue:
> > tests/test-char -p /char/socket/client/reconnect-error/unix
>
> Current master doesn't trigger the backtrace, it's only after your patch =
2.
Yes. However, the issue did exist in the master code base.
The test case in patch 2 revealed this issue.

>
> >
> > The core file backtrace is :
> >
> > (gdb) bt
> >     #0  0x00007ffff5ac3277 in raise () from /lib64/libc.so.6
> >     #1  0x00007ffff5ac4968 in abort () from /lib64/libc.so.6
> >     #2  0x00005555555aaa94 in error_handle_fatal (errp=3D<optimized out=
>, err=3D0x7fffec0012d0) at util/error.c:40
> >     #3  0x00005555555aab6d in error_setv (errp=3D0x555555802a08 <error_=
abort>, src=3D0x5555555c4280 "io/channel.c", line=3D148,
> >         func=3D0x5555555c4580 <__func__.17489> "qio_channel_readv_all",=
 err_class=3DERROR_CLASS_GENERIC_ERROR,
> >         fmt=3D<optimized out>, ap=3D0x7ffff423bae0, suffix=3D0x0) at ut=
il/error.c:73
> >     #4  0x00005555555aacf0 in error_setg_internal (errp=3Derrp@entry=3D=
0x555555802a08 <error_abort>,
> >         src=3Dsrc@entry=3D0x5555555c4280 "io/channel.c", line=3Dline@en=
try=3D148,
> >         func=3Dfunc@entry=3D0x5555555c4580 <__func__.17489> "qio_channe=
l_readv_all",
> >         fmt=3Dfmt@entry=3D0x5555555c43a0 "Unexpected end-of-file before=
 all bytes were read") at util/error.c:97
> >     #5  0x000055555556c25c in qio_channel_readv_all (ioc=3D<optimized o=
ut>, iov=3D<optimized out>, niov=3D<optimized out>,
> >         errp=3D0x555555802a08 <error_abort>) at io/channel.c:147
> >     #6  0x000055555556c29a in qio_channel_read_all (ioc=3D<optimized ou=
t>, buf=3D<optimized out>, buflen=3D<optimized out>,
> >         errp=3D<optimized out>) at io/channel.c:247
> >     #7  0x000055555556ad22 in char_socket_ping_pong (ioc=3D0x7fffec0008=
c0) at tests/test-char.c:732
> >     #8  0x000055555556ae12 in char_socket_client_server_thread (data=3D=
data@entry=3D0x55555582e350) at tests/test-char.c:891
> >     #9  0x00005555555a95b6 in qemu_thread_start (args=3D<optimized out>=
) at util/qemu-thread-posix.c:519
> >     #10 0x00007ffff5e61e25 in start_thread () from /lib64/libpthread.so=
.0
> >     #11 0x00007ffff5b8bbad in clone () from /lib64/libc.so.6
> >
> > Signed-off-by: Li Feng <fengli@smartx.com>
> > ---
> >  io/channel.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/io/channel.c b/io/channel.c
> > index e4376eb0bc..1a4a505f01 100644
> > --- a/io/channel.c
> > +++ b/io/channel.c
> > @@ -144,8 +144,6 @@ int qio_channel_readv_all(QIOChannel *ioc,
> >
> >      if (ret =3D=3D 0) {
> >          ret =3D -1;
> > -        error_setg(errp,
> > -                   "Unexpected end-of-file before all bytes were read"=
);
>
> Nack, this code is fine.
>
> The problem is that the test case doesn't expect a disconnect in
> char_socket_ping_pong().
Yes, in the test case I try to inject an error in char_socket_ping_pong.
Any concerns about these two patches?
>
> --
> Marc-Andr=C3=A9 Lureau

