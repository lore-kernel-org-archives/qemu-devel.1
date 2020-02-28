Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D99C3F2D1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 10:24:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69D902469F
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 10:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ErKD3UmJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69D902469F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7cpB-0002FI-JY
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 05:24:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59231)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlureau@redhat.com>) id 1j7coX-0001n2-OA
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:24:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1j7coW-0001PP-8c
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:24:13 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23544
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1j7coW-0001PC-3U
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:24:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582885451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RkPiR9lv2uyp1qaPqDpOB3fbNamtSf/yhv749dzP71I=;
 b=ErKD3UmJmu0fA0hFL8zp268auLPeitGIcbPXfDJ9AW7tiinGf00FGcXsYc4yhx7HVvldM5
 NZ33rkiJUe7rw5GT3jXeKFJuD+bZi+Uv7lunJT7k6Wbt4lVP1ceaj6QYtWe7yq1EbFOyzm
 4FO59geZIVvT30aLQN9vknpRc/20yyY=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-9D_gZ-fZMY-XutHLc7frbQ-1; Fri, 28 Feb 2020 05:24:09 -0500
X-MC-Unique: 9D_gZ-fZMY-XutHLc7frbQ-1
Received: by mail-ot1-f71.google.com with SMTP id d16so1495352otf.5
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 02:24:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=RkPiR9lv2uyp1qaPqDpOB3fbNamtSf/yhv749dzP71I=;
 b=mTDLzN/f9v8tWE+8Syf93BMPQWKMXODxcgnqLOH4zcnqIGy1F8emlzwd9BNrm5lChr
 ejvO4jY/YrUKzbap+gjjRvHnD2Tnt73jFn3908mcac0oH7qbxS/SXsFQcD9goJRhc8k4
 I0mh96jQiXdkaYtQuyM/n6ETRBgsALOrdByGt+u9ykYD99/tYNoR6do57X0Ki8HlApwJ
 mctlNuMLjZxq4NH7IdpKQTBx4T+ZCggwM8fr9+CvbLgPGezE+X56j2ReylossLBrI8PG
 EuoWJnP7+h6THosXM6AyHdRAtrM3aZNoqwnagpM4Ovh2724hs6KBXbM0VzfzB2PNGeVT
 WKAQ==
X-Gm-Message-State: APjAAAX4B4+EDyaerVX6mnYZ1L0bsQdMMdSZln9Ogb4jmboPu2F44EWs
 VkaoQxAcPN6ZOjGB+ZgzaJ7pq02LxvaaeYgpVUypOFpsAqEmHmyLuKBOiSxLI/B/wsdONYSRfFv
 O4jteyzFOfNyXf3XcEd7/DCEogBi26ug=
X-Received: by 2002:aca:3805:: with SMTP id f5mr2612827oia.6.1582885448867;
 Fri, 28 Feb 2020 02:24:08 -0800 (PST)
X-Google-Smtp-Source: APXvYqwBsojn90q3ynt7xGi04SLQcni8APaq+bwTkR3BGzRN1k8JMXw4mlWAWnJz4tEVWuAGtcLiPNKsiBGoZssYXbs=
X-Received: by 2002:aca:3805:: with SMTP id f5mr2612817oia.6.1582885448626;
 Fri, 28 Feb 2020 02:24:08 -0800 (PST)
MIME-Version: 1.0
References: <20200228100726.8414-1-philmd@redhat.com>
 <20200228100726.8414-4-philmd@redhat.com>
In-Reply-To: <20200228100726.8414-4-philmd@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 28 Feb 2020 11:23:57 +0100
Message-ID: <CAMxuvawyv=gSjQNApqGwhwz_V18GrNmJ1s5KnJg=zKLtpeXuRQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] qga: Improve error report by calling
 error_setg_win32()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Feb 28, 2020 at 11:07 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Use error_setg_win32() which adds a hint similar to strerror(errno)).
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> v3: Keep slog() in qmp_guest_shutdown() (Marc-Andr=C3=A9)
> ---
>  qga/channel-win32.c  | 3 ++-
>  qga/commands-win32.c | 8 +++++---
>  2 files changed, 7 insertions(+), 4 deletions(-)

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


>
> diff --git a/qga/channel-win32.c b/qga/channel-win32.c
> index c86f4388db..99648c95b6 100644
> --- a/qga/channel-win32.c
> +++ b/qga/channel-win32.c
> @@ -308,7 +308,8 @@ static gboolean ga_channel_open(GAChannel *c, GAChann=
elMethod method,
>      }
>
>      if (method =3D=3D GA_CHANNEL_ISA_SERIAL && !SetCommTimeouts(c->handl=
e,&comTimeOut)) {
> -        g_critical("error setting timeout for com port: %lu",GetLastErro=
r());
> +        g_autofree gchar *emsg =3D g_win32_error_message(GetLastError())=
;
> +        g_critical("error setting timeout for com port: %s", emsg);
>          CloseHandle(c->handle);
>          return false;
>      }
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 2461fd19bf..9c744d6405 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -315,8 +315,9 @@ void qmp_guest_shutdown(bool has_mode, const char *mo=
de, Error **errp)
>      }
>
>      if (!ExitWindowsEx(shutdown_flag, SHTDN_REASON_FLAG_PLANNED)) {
> -        slog("guest-shutdown failed: %lu", GetLastError());
> -        error_setg(errp, QERR_UNDEFINED_ERROR);
> +        g_autofree gchar *emsg =3D g_win32_error_message(GetLastError())=
;
> +        slog("guest-shutdown failed: %s", emsg);
> +        error_setg_win32(errp, GetLastError(), "guest-shutdown failed");
>      }
>  }
>
> @@ -1319,7 +1320,8 @@ static DWORD WINAPI do_suspend(LPVOID opaque)
>      DWORD ret =3D 0;
>
>      if (!SetSuspendState(*mode =3D=3D GUEST_SUSPEND_MODE_DISK, TRUE, TRU=
E)) {
> -        slog("failed to suspend guest, %lu", GetLastError());
> +        g_autofree gchar *emsg =3D g_win32_error_message(GetLastError())=
;
> +        slog("failed to suspend guest: %s", emsg);
>          ret =3D -1;
>      }
>      g_free(mode);
> --
> 2.21.1
>


