Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57681C4BA10
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 14:00:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F7C22467B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 14:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HHnYdK47"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F7C22467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6xF2-0004lo-F3
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 09:00:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59735)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j6xED-0004KZ-3y
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 08:59:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j6xEC-0004FO-16
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 08:59:57 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38777
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j6xEB-0004B5-Sz
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 08:59:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582725594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nutq8pWQ4DbLwEkuplX5FkWrGv3bAKsEZSJGtZhVTDw=;
 b=HHnYdK47xonO3UvMLD7hSxNU2yI/mIVxFYtA9Hbqdko39NuQ2XOp2a+SpkeOeIDaESAUpF
 tpeVKlgzifq4pFQm84z1EDbEnhvjxgNYgawOjCb710663IrTLtLoaEYzYHTiw4sTbPPAQy
 OtoyLolNPmZBeRZaWuxarSoOWGKYxoY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-wFFF_e3eOeazX2d8m_J4CA-1; Wed, 26 Feb 2020 08:59:52 -0500
X-MC-Unique: wFFF_e3eOeazX2d8m_J4CA-1
Received: by mail-wm1-f71.google.com with SMTP id 7so693815wmf.9
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 05:59:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=V4QUyJv4C6xbCs209mrGYmO8QASS/5kRXtglVGq++x4=;
 b=gWVRt/2Qz0cUMpe/LEsiKqws6K5Kc2+/V9bcPa9gV5oPCXm2xcbEVj3ERmLSDVqCiq
 E2fpJs5Td9nl+48irfJtc3BOzi5Pln6Aq1CEip8Y0od6XRqpthGM//XETXIqIJ90N46/
 cMSd+v4c6QAjhWpsFJsJAJFiq4sftuDr63M0xo/Ck9DXdCHPyKSOLA/XHmdEwAdVu6h0
 c48VqCZ0CFteH4W41npNW+MCsiXpoIvcKZdRL8iIivlee93hU5PK/oHZfRA+q3ZLZPHF
 S7fPmvcN3jZZx5OlrgI4+qikv3P08VpLDkzOddmvXAXV0zvI/frvTU0StBX4WdwqhdQ4
 gDOQ==
X-Gm-Message-State: APjAAAW/nPiKm+BCcb3u/y0hnX2u9HFAytlIU7sJKp/pT4ClPFVUhF0V
 XRF8FwzuIaQpXkN4xd8jDZVU3nfPxlNXvXj1iH3MG++G4qfr8CFma26SPY5sWR5RpfPqz7g9jcs
 uE2CYg9L8kb3hkJU=
X-Received: by 2002:a7b:cc95:: with SMTP id p21mr151348wma.184.1582725591468; 
 Wed, 26 Feb 2020 05:59:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqxRwe2Ycf4Sqaebvv7DzUI/z+1sQvk663DkoEvyzTIi1befT41XjwAQIf8RExLPQJcRFNk8mw==
X-Received: by 2002:a7b:cc95:: with SMTP id p21mr151313wma.184.1582725591192; 
 Wed, 26 Feb 2020 05:59:51 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id t187sm3228615wmt.25.2020.02.26.05.59.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2020 05:59:50 -0800 (PST)
Subject: Re: [PATCH v3 12/19] tests/plugin: prevent uninitialized warning
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200225124710.14152-1-alex.bennee@linaro.org>
 <20200225124710.14152-13-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <39f4a2a5-01d2-2f1d-6519-da8429a6dd3b@redhat.com>
Date: Wed, 26 Feb 2020 14:59:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200225124710.14152-13-alex.bennee@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: fam@euphon.net, Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 robert.foley@linaro.org, kuhn.chenqun@huawei.com, stefanb@linux.vnet.ibm.com,
 peter.puhov@linaro.org, richard.henderson@linaro.org, f4bug@amsat.org,
 robhenry@microsoft.com, marcandre.lureau@redhat.com,
 aaron@os.amperecomputing.com, cota@braap.org, stefanha@redhat.com,
 Euler Robot <euler.robot@huawei.com>, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/25/20 1:47 PM, Alex Benn=C3=A9e wrote:
> From: Chen Qun <kuhn.chenqun@huawei.com>
>=20
> According to the glibc function requirements, we need initialise

GLib?

>   the variable. Otherwise there will be compilation warnings:
>=20
> glib-autocleanups.h:28:3: warning: =E2=80=98out=E2=80=99 may be
> used uninitialized in this function [-Wmaybe-uninitialized]
>     g_free (*pp);
>     ^~~~~~~~~~~~
>=20
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Message-Id: <20200206093238.203984-1-kuhn.chenqun@huawei.com>
> [AJB: uses Thomas's single line allocation]
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tests/plugin/bb.c   | 6 +++---
>   tests/plugin/insn.c | 3 +--
>   2 files changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/tests/plugin/bb.c b/tests/plugin/bb.c
> index f30bea08dcc..df19fd359df 100644
> --- a/tests/plugin/bb.c
> +++ b/tests/plugin/bb.c
> @@ -22,9 +22,9 @@ static bool do_inline;
>  =20
>   static void plugin_exit(qemu_plugin_id_t id, void *p)
>   {
> -    g_autofree gchar *out;
> -    out =3D g_strdup_printf("bb's: %" PRIu64", insns: %" PRIu64 "\n",
> -                          bb_count, insn_count);
> +    g_autofree gchar *out =3D g_strdup_printf(
> +        "bb's: %" PRIu64", insns: %" PRIu64 "\n",
> +        bb_count, insn_count);
>       qemu_plugin_outs(out);
>   }
>  =20
> diff --git a/tests/plugin/insn.c b/tests/plugin/insn.c
> index 0a8f5a0000e..a9a6e412373 100644
> --- a/tests/plugin/insn.c
> +++ b/tests/plugin/insn.c
> @@ -44,8 +44,7 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct q=
emu_plugin_tb *tb)
>  =20
>   static void plugin_exit(qemu_plugin_id_t id, void *p)
>   {
> -    g_autofree gchar *out;
> -    out =3D g_strdup_printf("insns: %" PRIu64 "\n", insn_count);
> +    g_autofree gchar *out =3D g_strdup_printf("insns: %" PRIu64 "\n", in=
sn_count);
>       qemu_plugin_outs(out);
>   }
>  =20
>=20


