Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC92BC3567B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 17:23:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A5A9246A1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 17:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gQhwG8Tq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A5A9246A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7Mt3-0008W9-NT
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 12:23:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50589)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlureau@redhat.com>) id 1j7MsC-0007eH-73
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 12:22:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1j7MsB-0006Dj-92
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 12:22:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30586
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1j7MsB-0006Br-4u
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 12:22:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582824174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yW0BKahmLAfPH4sFf7uE3N+3qPvGxIYuT1kgrkDqoOw=;
 b=gQhwG8TqMl7xtP2/Xk+oo0r2kU59lgOW0+uBXSwG/j8Rd5CcMUZYH1PtGnwSv5/NWqw0XG
 eT58rL25Q1v807fUjreJTne7a/K0xdMW5ELCtn6FX2u7Wofga1PX6X/skEQGfKwfP45AqU
 naSNFS2slyjy1V6JDMZiyO4fdPJQmQc=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-nFLXaDRvNAi2yCsTXnrxvQ-1; Thu, 27 Feb 2020 12:22:43 -0500
X-MC-Unique: nFLXaDRvNAi2yCsTXnrxvQ-1
Received: by mail-ot1-f69.google.com with SMTP id e11so108533otq.1
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 09:22:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=yW0BKahmLAfPH4sFf7uE3N+3qPvGxIYuT1kgrkDqoOw=;
 b=nTdqb8n+AXI4Oa0WuCCFI83mrac44wM87xzvGx+GBpEeQ8XDmvvy6E0TNz98briDGT
 PE1KZkwZ+3j4BFDDW6WisAUrRHTiME+VgCPC+1az0zx6/BA+Ug3ko+7pUwf/IZJ52OMn
 AoeFmhsGrLovRLpRhPqCDpKWIpUCxKtiuFlpctqgxdmAsL4ShP8IWx/LuyCoYPc4+uG8
 6RjqFkLc75yq3BYmaviDAk+pFz9FLTaPqpebb8EGayRMrzQUDbuokciSZbpFgvN6wq61
 FPulmy8ScgWrezskEFWmG0o/gpQzozr/zp4hagw/CJ3Jzb1ZWfZ5LNCYsv7cQqJ7g5gd
 LeEQ==
X-Gm-Message-State: APjAAAUNzSjstBEU7KM6tks2LZKtdwTS7iZN0i5lzhv+wBVFGGEKaWbE
 EJQA8h1p3T+yf4TLq0hs6JDEDjV94pBhZddh52K3EzVrvPFvy/d5nj+/O4TxrpXhNN4JMubq41n
 VBkXYfaUCAve2CroQsx8f1WVi4gjQOr0=
X-Received: by 2002:a05:6808:487:: with SMTP id z7mr105131oid.46.1582824162047; 
 Thu, 27 Feb 2020 09:22:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqx5beJzSdeaAXwlWDs+/bBPAS5INZI7ZBYUCriFi+xpZ7BDgZUEL9Dke12qZDtciyuewKS8rBZSfwrtU/DuMiY=
X-Received: by 2002:a05:6808:487:: with SMTP id z7mr105110oid.46.1582824161787; 
 Thu, 27 Feb 2020 09:22:41 -0800 (PST)
MIME-Version: 1.0
References: <20200227163101.414-1-philmd@redhat.com>
 <20200227163101.414-5-philmd@redhat.com>
In-Reply-To: <20200227163101.414-5-philmd@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 27 Feb 2020 18:22:30 +0100
Message-ID: <CAMxuvayLYP--wLfFr2G9fjNUw8xxRSycYPGNgOfJa6a3VvJbcg@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] util/osdep: Improve error report by calling
 error_setg_win32()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Stefan Weil <sw@weilnetz.de>, qemu-devel <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 27, 2020 at 5:32 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Use error_setg_win32() which adds a hint similar to strerror(errno)).
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  util/osdep.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/util/osdep.c b/util/osdep.c
> index ef40ae512a..144e217cb9 100644
> --- a/util/osdep.c
> +++ b/util/osdep.c
> @@ -82,8 +82,8 @@ static int qemu_mprotect__osdep(void *addr, size_t size=
, int prot)
>      DWORD old_protect;
>
>      if (!VirtualProtect(addr, size, prot, &old_protect)) {
> -        error_report("%s: VirtualProtect failed with error code %ld",
> -                     __func__, GetLastError());
> +        g_autofree gchar *emsg =3D g_win32_error_message(GetLastError())=
;
> +        error_report("%s: VirtualProtect failed: %s", __func__, emsg);
>          return -1;
>      }
>      return 0;
> @@ -506,12 +506,12 @@ int socket_init(void)
>  {
>  #ifdef _WIN32
>      WSADATA Data;
> -    int ret, err;
> +    int ret;
>
>      ret =3D WSAStartup(MAKEWORD(2, 2), &Data);
>      if (ret !=3D 0) {
> -        err =3D WSAGetLastError();
> -        error_report("WSAStartup: %d", err);
> +        g_autofree gchar *emsg =3D g_win32_error_message(WSAGetLastError=
());
> +        error_report("WSAStartup: %s", emsg);
>          return -1;
>      }
>      atexit(socket_cleanup);
> --
> 2.21.1
>


