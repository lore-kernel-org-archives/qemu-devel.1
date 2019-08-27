Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B74FC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 08:39:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27B65206BA
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 08:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sIvzl3FT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27B65206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2X10-0000As-DB
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 04:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38747)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@gmail.com>) id 1i2X0I-0008Ar-8t
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 04:39:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@gmail.com>) id 1i2X0G-0007h9-RZ
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 04:39:02 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:38113)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1i2X0G-0007gK-I2
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 04:39:00 -0400
Received: by mail-ot1-x342.google.com with SMTP id r20so17907390ota.5
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 01:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=M/2CtO5GfGXvYkbQHUbPiSFehdMXak/Zr5NPhpZJ1T0=;
 b=sIvzl3FTRmLO/gL4iHq1W+kqWgriF6a0KPpPRspYoCqIPn1oEUu8kTcaVbZXVCj3vz
 BAW4+y4mz/Qrdk5a5M2GMYuHt2CnWlmDg5QkrZiD7QI7tIbTnlcs9x9M9eIPbv5zvcin
 I2/JVcY5zx2V+m4ODfMM96YdAosEXP4KFnMzYRIov+i/5Q3NSAhZRKM7G/OXlhs5IpR0
 d6EE6xiYy+V6rkY3TztBfx3qwvWHEuqY7x/cgkUnrHq/+NZxh94WW2whMElszUf2iuoO
 gKCQGQB5j5zZjfDlnyuqToOo3EN7zR9Rii5dXCXwICW6lGbD5q1oY97gko5pTimkazfm
 T8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=M/2CtO5GfGXvYkbQHUbPiSFehdMXak/Zr5NPhpZJ1T0=;
 b=rWu3tr/UlQpQx0ZSV13xzqddVA7UPtOpmi2ZKNthek0ndneRcfPBkSv2ikmd2C/Q+/
 +ZgQPFI7ENnG4qxARdlprgN1q71XqlXenTfNvrjPEfkUwYDsqsAqxZbwg83wKvEYCy40
 gkAByB5zFxXVMBd+uQNDmE5kctjev7IVDFODoHGVt5Vh2MSPUM7iZDs5IMSjGpHKdWx5
 rm5/ze355qxNK85emYU5uxZgnbMdhVY6vztMCSGR/Jwvn91piRFRTcTyioPI66WpmN6B
 MYkgh9gO8ZVtJoR0N4cgIAnEG22kyD3dKZUMgkK2B0Sx8j0qQncmXycORuEuHpBRcRDg
 sw2g==
X-Gm-Message-State: APjAAAWGG9E8j05BLUhd7crwSYQ6nA9ExaQR5nDSVCs956I4E7Ca6Jus
 v3Uomt6KiSAg7TPSSLeWAtDQgf3OxXZAu9wFpXU=
X-Google-Smtp-Source: APXvYqwURAXs6i4POX9oU0MWXQfjehDVQ2OR+u479RrmDcFkduIanSYW+gQbtB/CR7uZkTv6wFtGxgp0XjSk79dDpiM=
X-Received: by 2002:a05:6830:1109:: with SMTP id
 w9mr17965313otq.149.1566895139207; 
 Tue, 27 Aug 2019 01:38:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190827080512.2417-1-fangying1@huawei.com>
In-Reply-To: <20190827080512.2417-1-fangying1@huawei.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 27 Aug 2019 16:38:23 +0800
Message-ID: <CAKXe6SK1pZRdrigiEO1-7eONEKnfXSzhtz-EC43uWhndxFJERg@mail.gmail.com>
To: Ying Fang <fangying1@huawei.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH] qmp: Fix memory leak in
 migrate_params_test_apply
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
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Juan Quintela <quintela@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>,
 zhouyibo3@huawei.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 lcf.lichaofeng@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ying Fang <fangying1@huawei.com> =E4=BA=8E2019=E5=B9=B48=E6=9C=8827=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=884:06=E5=86=99=E9=81=93=EF=BC=9A

> Address Sanitizer shows memory leak in migrate_params_test_apply
> migration/migration.c:1253 and the stack is as bellow:
>
> Direct leak of 45 byte(s) in 9 object(s) allocated from:
>     #0 0xffffbd7fc1db in __interceptor_malloc (/lib64/libasan.so.4+0xd31d=
b)
>     #1 0xffffbd514163 in g_malloc (/lib64/libglib-2.0.so.0+0x57163)
>     #2 0xffffbd52f43b in g_strdup (/lib64/libglib-2.0.so.0+0x7243b)
>     #3 0xaaaadfa4d623 in migrate_params_test_apply
> migration/migration.c:1253
>     #4 0xaaaadfa4d623 in qmp_migrate_set_parameters
> migration/migration.c:1422
>     #5 0xaaaadfa963f3 in hmp_migrate_set_parameter monitor/hmp-cmds.c:186=
7
>     #6 0xaaaadfa8afe3 in handle_hmp_command monitor/hmp.c:1082
>     #7 0xaaaadf479c57 in qmp_human_monitor_command monitor/misc.c:140
>     #8 0xaaaadfadf87b in qmp_marshal_human_monitor_command
> qapi/qapi-commands-misc.c:1024
>     #9 0xaaaadfc7797b in do_qmp_dispatch qapi/qmp-dispatch.c:131
>     #10 0xaaaadfc7797b in qmp_dispatch qapi/qmp-dispatch.c:174
>     #11 0xaaaadfa84fff in monitor_qmp_dispatch monitor/qmp.c:120
>     #12 0xaaaadfa85bbf in monitor_qmp_bh_dispatcher monitor/qmp.c:209
>     #13 0xaaaadfd2228f in aio_bh_call util/async.c:89
>     #14 0xaaaadfd2228f in aio_bh_poll util/async.c:117
>     #15 0xaaaadfd29bc3 in aio_dispatch util/aio-posix.c:459
>     #16 0xaaaadfd21ff7 in aio_ctx_dispatch util/async.c:260
>     #17 0xffffbd50e2f7 in g_main_context_dispatch
> (/lib64/libglib-2.0.so.0+0x512f7)
>     #18 0xaaaadfd278d7 in glib_pollfds_poll util/main-loop.c:218
>     #19 0xaaaadfd278d7 in os_host_main_loop_wait util/main-loop.c:241
>     #20 0xaaaadfd278d7 in main_loop_wait util/main-loop.c:517
>     #21 0xaaaadf67b5e7 in main_loop vl.c:1806
>     #22 0xaaaadf15d453 in main vl.c:4488
>
> Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>
> Signed-off-by: Ying Fang <fangying1@huawei.com>
> ---
>  migration/migration.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 8b9f2fe30a..05e44ff7cc 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1250,11 +1250,17 @@ static void
> migrate_params_test_apply(MigrateSetParameters *params,
>
>      if (params->has_tls_creds) {
>          assert(params->tls_creds->type =3D=3D QTYPE_QSTRING);
> +        if (dest->tls_creds) {
> +            g_free(dest->tls_creds);
> +        }
>

g_free can handle NULL, no need to do the NULL check.

Thanks,
Li Qiang


>          dest->tls_creds =3D g_strdup(params->tls_creds->u.s);
>      }
>
>      if (params->has_tls_hostname) {
>          assert(params->tls_hostname->type =3D=3D QTYPE_QSTRING);
> +        if (dest->tls_hostname) {
> +            g_free(dest->tls_hostname);
> +        }
>          dest->tls_hostname =3D g_strdup(params->tls_hostname->u.s);
>      }
>
> --
> 2.19.1
>
>
>
>
