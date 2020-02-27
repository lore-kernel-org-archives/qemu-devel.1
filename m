Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6525C11D3D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 17:23:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 906AF21D7E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 17:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O2AygNJ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 906AF21D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7MsH-0007ZY-PK
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 12:23:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50306)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlureau@redhat.com>) id 1j7Mqt-0006TW-8s
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 12:21:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1j7Mqs-0003QM-7w
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 12:21:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51208
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1j7Mqs-0003Om-3c
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 12:21:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582824090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g1Dq87ha8NSh+JjOHr86pvMgso8CBLwoJ4nFqfRMXuk=;
 b=O2AygNJ74v8pDl5G2u5cpl19YucuUAp+wxPojYaQnfKkanMmuV5RNAs8/OhYqxjOx8ibt0
 fEMUTG3sI08q8I9FM/s7gFU5O9azpkmhfcnQ8AgLMbQUjWCJbgU5EWTJJ+nnP34Y+8uVMD
 dFbmR8A+e8zrJUaaHQGeeBx22IJl8/Q=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-MEhZ_kXgOmizMAfjUq4A_g-1; Thu, 27 Feb 2020 12:21:26 -0500
X-MC-Unique: MEhZ_kXgOmizMAfjUq4A_g-1
Received: by mail-oi1-f198.google.com with SMTP id c22so1988428oic.20
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 09:21:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=g1Dq87ha8NSh+JjOHr86pvMgso8CBLwoJ4nFqfRMXuk=;
 b=NJKtjU6ZuodQ7hVQQUTX6SvUyKxYLwLaf294h1anyIF33/dY6gZlNC3VYovfMBqzxS
 N38iUWQb600EouqOOCw3gdc3Y5SXAXX2oAipsVDQSYrNofHPvaRC3CiUPY9CkupDj9bw
 dgDVLc7VeQvJime+BJ1l02PNmA8am0cxT3CVdyyEoO8AUbkAoP2L1mKLeNLZTnG9c/5L
 wqNJBLjEc2TyGYI5HFcJ0V1DKzkh+QVEXniqYDXoB+seXtS4B5PU0IGLXC7oCuzetLcK
 Wb3uECtdZ9oyIx6p7qKlFiBySsZu5aA3gH4DyiDS86NjxXLfIqAFcR14zJLxp2jfqQCh
 9ufg==
X-Gm-Message-State: APjAAAW75HtfYGgPfzylvnoFYaUbXYD3HnWRwtb9riOrKDzb5miMDcTu
 s/qSFUbNovId1IphkLzLs4nfv7Q8hjkWPSugT7TwbdE7RN4E93G5jT/HQKYwg3B9tqS6SOufmlp
 Vy9L6KR2ZxJBm5vn5crsWPA77DdHyXAg=
X-Received: by 2002:a9d:730e:: with SMTP id e14mr3559otk.62.1582824085793;
 Thu, 27 Feb 2020 09:21:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqxDRSngCcr694+/MxJwjqtQkdfSfmg3zO9g8X4teJ5KtXewsYb8aCZcFg8D8y5WRkWpkKzh2jU0GzIHgEX8Q3c=
X-Received: by 2002:a9d:730e:: with SMTP id e14mr3535otk.62.1582824085573;
 Thu, 27 Feb 2020 09:21:25 -0800 (PST)
MIME-Version: 1.0
References: <20200227163101.414-1-philmd@redhat.com>
 <20200227163101.414-6-philmd@redhat.com>
In-Reply-To: <20200227163101.414-6-philmd@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 27 Feb 2020 18:21:14 +0100
Message-ID: <CAMxuvay_a6oihjoPU0B_t04Yn=dqwCK_WC2CdtWu65xgG9ubKA@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] qga: Fix a memory leak
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
> The string returned by g_win32_error_message() has to be
> deallocated with g_free().
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  qga/channel-win32.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/qga/channel-win32.c b/qga/channel-win32.c
> index c86f4388db..774205e017 100644
> --- a/qga/channel-win32.c
> +++ b/qga/channel-win32.c
> @@ -302,8 +302,8 @@ static gboolean ga_channel_open(GAChannel *c, GAChann=
elMethod method,
>                             OPEN_EXISTING,
>                             FILE_FLAG_NO_BUFFERING | FILE_FLAG_OVERLAPPED=
, NULL);
>      if (c->handle =3D=3D INVALID_HANDLE_VALUE) {
> -        g_critical("error opening path %s: %s", newpath,
> -                   g_win32_error_message(GetLastError()));
> +        g_autofree gchar *emsg =3D g_win32_error_message(GetLastError())=
;
> +        g_critical("error opening path %s: %s", newpath, emsg);
>          return false;
>      }
>
> --
> 2.21.1
>


