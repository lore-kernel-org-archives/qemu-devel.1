Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4CAC3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 15:09:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB00E208C3
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 15:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQASgSvg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB00E208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50869 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9s7T-0004js-UV
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 10:09:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43225)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1j9s6h-0003o1-If
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 10:08:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1j9s6g-0006iA-BO
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 10:08:15 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38778)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1j9s6g-0006gZ-1s
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 10:08:14 -0500
Received: by mail-wr1-x441.google.com with SMTP id t11so7448875wrw.5
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 07:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=aoQxwI8Pz+ypsaosJmUL+2ag+z5LuvEcVdunPahoJD4=;
 b=OQASgSvg3zphGp1eDKD3ohbGyaBeYvawZDjuUErv3lx9idBlCUqpztteT9G0GUyFJR
 sVYQNEit3y9h/ZWQrLHsA2qCdSi4VVioSlmjCfv/fMd3CzB5qbLTHjY0yI0BgcRB4QfA
 aQqYwXXNce3KIgmUPyI7gMtGHEN2JDaC2Xhm7PZXX0bKdRhpJwea/LuVGI/EO7Iq5EU6
 +92tM4xl+58tVK5CXNl51fQVZhhd0A1wB4pcXqqgB8C7AZh6gyzXk9f7NWsEYG6OQ5Ql
 QG6m539F4p61vitbHYIPTOGS2JU1a1RBrlGwR88OaS/GaUkzBARdtmcVfVBdtASEszcw
 070w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=aoQxwI8Pz+ypsaosJmUL+2ag+z5LuvEcVdunPahoJD4=;
 b=bXssMRePExe5uV3btQFe6OkyjTSJkQRRw1dLLk2wH85n/PVGQoa94qkpvCzUfyIkgA
 kK4X2mVN8JaN36QqqP9a8fWZD1MSz16Ajl/pDBnEr8mtkzy8uojG3bQKWkyYlpz2/OOY
 AaALzVnpQDUwfSYE4dP+A6BlMdob0Pspo8qnKOZteYFqTanQKlGSSiC83A5DZoj3DJan
 WRKLOFMx7bW+lHDbUpCorva95I6B68pdoUA7nMekqdztm8gU268NpdS4DzX8GYJcdSIF
 5OJZDyOAwg2uGhv1uKS0+cpq+1UEqhjilYiYhhpQq5/fiNdtL3JJ6Q4DgHb/UzW+69z+
 pDcA==
X-Gm-Message-State: ANhLgQ0iIfZMhhDsyjxzhd3W4/5Gv1pFdNs0N1TQuHe214w78fo0iDkB
 SMj1DavMz6OdrCxo2qic5Lin4I2v8G2nqfT+qJ4=
X-Google-Smtp-Source: ADFU+vsxxTFgzf08yV1qNo3VW66SElrQOQESAKHL63JyY/QsonJJY1tKP2XSS4nHzI8oDKLSEOYdsm23fxgoIyTjZVc=
X-Received: by 2002:a5d:62c9:: with SMTP id o9mr10974896wrv.2.1583420892716;
 Thu, 05 Mar 2020 07:08:12 -0800 (PST)
MIME-Version: 1.0
References: <20200113144848.2168018-1-marcandre.lureau@redhat.com>
 <87a74ueudt.fsf@dusky.pond.sub.org>
In-Reply-To: <87a74ueudt.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 5 Mar 2020 16:08:00 +0100
Message-ID: <CAJ+F1C+GY6d8Jr+NjSMuXpX+QiMsFQ9qd-rEJyp+oF9Ld6Z1wQ@mail.gmail.com>
Subject: Re: [PATCH] console: make QMP screendump use coroutine
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Thu, Mar 5, 2020 at 3:46 PM Markus Armbruster <armbru@redhat.com> wrote:
>
> I tried to observe the main loop keeps running while the screendump does
> its work.
>
> The main loop appears to lack trace points.  Alright, if there's no
> hammer handy, I'll use a rock:
>
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index 5549f4b619..b6561a65d7 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -1661,6 +1661,7 @@ void qemu_main_loop(void)
>  #ifdef CONFIG_PROFILER
>          ti =3D profile_getclock();
>  #endif
> +        printf("*** main loop\n");
>          main_loop_wait(false);
>  #ifdef CONFIG_PROFILER
>          dev_time +=3D profile_getclock() - ti;
>
>
> First experiment: does the main loop continue to run when writing out
> the screendump blocks / would block?
>
> Observe qmp_screendump() opens the file without O_EXCL.  Great, that
> lets me block output by making it open a FIFO.
>
> Terminal#1:
>
>     $ mkfifo s
>
> Terminal#2:
>
>     $ upstream-qemu -S -display none -chardev socket,id=3Dqmp,path=3Dtest=
-qmp,server=3Don,wait=3Doff -mon mode=3Dcontrol,chardev=3Dqmp
>     *** main loop
>     *** main loop
>     *** main loop
>
> Keeps printing at a steady pace.
>
> Terminal#3:
>
>     $ socat "READLINE,history=3D$HOME/.qmp_history,prompt=3DQMP>" UNIX-CO=
NNECT:$HOME/work/images/test-qmp
>     {"QMP": {"version": {"qemu": {"micro": 50, "minor": 2, "major": 4}, "=
package": "v4.2.0-2069-g5e5ae6b644-dirty"}, "capabilities": ["oob"]}}
>     QMP>{"execute": "qmp_capabilities"}
>     {"return": {}}
>     QMP>{"execute": "screendump", "arguments": {"filename": "s"}}
>
> The printing in terminal#2 stops.  This is expected; qemu_open() calls
> open(), which blocks, because the FIFO has no reader.
>
> Terminal#1:
>
>     $ exec 4<s
>
> Now the FIFO has a reader.  Terminal#2 remains quiet.
>
> We now hang in ppm_save().  Abridged stack backtrace:
>
>     #0  0x00007ffff519d0f5 in writev () at /lib64/libc.so.6
>     #1  0x0000555555e15f61 in qio_channel_file_writev
>         (ioc=3D0x5555567bf5f0, iov=3D0x555556a441b0, niov=3D1, fds=3D0x0,=
 nfds=3D0, errp=3D0x7fffe9d81d10) at /work/armbru/qemu/io/channel-file.c:12=
3
>     #2  0x0000555555e133d3 in qio_channel_writev_full
>         (ioc=3D0x5555567bf5f0, iov=3D0x555556a441b0, niov=3D1, fds=3D0x0,=
 nfds=3D0, errp=3D0x7fffe9d81d10) at /work/armbru/qemu/io/channel.c:86
>     #3  0x0000555555e137a2 in qio_channel_writev
>         (ioc=3D0x5555567bf5f0, iov=3D0x555556a441b0, niov=3D1, errp=3D0x7=
fffe9d81d10)
>         at /work/armbru/qemu/io/channel.c:207
>     #4  0x0000555555e13696 in qio_channel_writev_all
>         (ioc=3D0x5555567bf5f0, iov=3D0x7fffe9d81bd0, niov=3D1, errp=3D0x7=
fffe9d81d10)
>         at /work/armbru/qemu/io/channel.c:171
>     #5  0x0000555555e139b1 in qio_channel_write_all
>         (ioc=3D0x5555567bf5f0, buf=3D0x555556b05200 "", buflen=3D1920, er=
rp=3D0x7fffe9d81d10) at /work/armbru/qemu/io/channel.c:257
>     #6  0x0000555555cd74ff in ppm_save
>         (fd=3D22, image=3D0x5555568ffdd0, errp=3D0x7fffe9d81d10)
>         at /work/armbru/qemu/ui/console.c:336
>     #7  0x0000555555cd77e6 in qmp_screendump
>         (filename=3D0x555556ea0900 "s", has_device=3Dfalse, device=3D0x0,=
 has_head=3Dfalse, head=3D0, errp=3D0x7fffe9d81d10) at /work/armbru/qemu/ui=
/console.c:401
>
> A brief inspection of qio_channel_file_writev() and
> qio_channel_writev_all() suggests this might work if you make the output
> file descriptor non-blocking.

Right, the goal was rather originally to fix rhbz#1230527. We got
coroutine IO by accident, and I was too optimistic about default
behaviour change ;) I will update the patch.

>
>     $ head -c 1 <&4 | hexdump -C
>     00000000  50                                                |P|
>     00000001
>
> Still quiet.
>
>     $ cat <&4 >/dev/null
>
> The printing resumes.
>
>     $ exec 4<&-
>
>
> Second experiment: does the main loop continue to run while we wait for
> graphic_hw_update_done()?
>
> Left as an exercise for the patch submitter ;)
>
>

With your main loop printf, one printf in graphic_hw_update() and one
in graphic_hw_update_done() ? (rather part of testing commit
4d6316218bf7bf3b8c7c7165b072cc314511a7a7, soon 4y old!)

--=20
Marc-Andr=C3=A9 Lureau

