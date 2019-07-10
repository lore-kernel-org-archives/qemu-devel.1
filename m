Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8832C74A35
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 20:02:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 855A82064B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 20:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mu9vIuyz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 855A82064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlInj-0002LU-SF
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 16:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50328)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marcandre.lureau@gmail.com>) id 1hlIjv-0003bL-P0
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 15:58:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1hlIjt-00030W-Rn
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 15:58:55 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46918)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1hlIjr-0002xe-Uz
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 15:58:52 -0400
Received: by mail-wr1-x443.google.com with SMTP id z1so3709928wru.13
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 12:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=c7/zaN0KO/y2YvJzj/ZBEPu0BAlV46axYU/E3JaEBWw=;
 b=mu9vIuyzduUHt8JZAqTyyTtM3+SrxKffEw1y36RXZzUfrNOC7TonWusn1L+p4OmCJV
 khkK5IdPZC1YeAEzaYlKegzPLZT/EO1mQ/k5YhVGjkugpkwNVNja5pNzXYBYG5+U6s8+
 LXttH0Hqo+91qvTCIS7zw4qbKn7rMrS72QKmXEWxMW9fCWFGjwabs5MSQLVXQgmCVnBY
 TW/1Cy7PmfXSpfhTwyJ0cbRr6DvGIQNZiEG3C+Cqkj6gzDSXNPyXng0G/dqGt6edOcwc
 9VRJTX6HgiW2/2vaNMqh44MVnXjX904dgQWsSe+VVqXjfr/cmHUflEhYRzHaMy1YWrLX
 jtWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=c7/zaN0KO/y2YvJzj/ZBEPu0BAlV46axYU/E3JaEBWw=;
 b=G9pSRzTz5zCZ1h9djdDhmEGyOf1V9LwTLjaF1nWHrf2/5j3bLFwvFa569BhD0GM2sL
 B+0gTo8OfXy8UshcFUZGXPqgVQJ4HlP9malWxOgsULafRdZm80ORB1sT7BrbNTdoA889
 wRs8zR7OEJQxeBRqY8eU9d1+DL+S4V7ZCGOLLTZe1WM2FoKdoUOzNw6c+loVFqVH1I/l
 khDvoj5m4ZqodrFC4afCHvhIWYdzclt1cy6vSZyFjWnfC4BpaKm4guNpgmCumWun/8Ls
 jLWzfwEf5QxEOc4MZ4AQW2nzv0X/JW0aTTeLbc7fT6AXofoovDYpgmnbbVMgzqVqZgdj
 CPjw==
X-Gm-Message-State: APjAAAXhkKNCCZYi21RtxODLUcVDjj4+We1j/ALKeM2iTKIWnwRw9Esw
 FkWkQHqHceaMsJTW+IY6Tx5Ir5zv12vYKoesmKeaQCO8
X-Google-Smtp-Source: APXvYqx8bZ+n7nzrguzHmgWEcZH6leAhICYoY9EZuQNGFiQkBNon3035/GY6431z+Z2fU6KMc/7YagF8BO7NyXx1ELY=
X-Received: by 2002:adf:ea8b:: with SMTP id s11mr32294900wrm.100.1562788730657; 
 Wed, 10 Jul 2019 12:58:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1562695780.git.DirtY.iCE.hu@gmail.com>
 <d4f8933c22ec6cce1ca0f65d01c42ef974aee9c9.1562695780.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <d4f8933c22ec6cce1ca0f65d01c42ef974aee9c9.1562695780.git.DirtY.iCE.hu@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 10 Jul 2019 23:58:38 +0400
Message-ID: <CAJ+F1CKefJn4M7Kmr+Qyv0J4hiuMVnTyr_Vvc5HT1+q70+9EZQ@mail.gmail.com>
To: =?UTF-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <dirty.ice.hu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH 05/11] paaudio: do not move stream when
 sink/source name is specified
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
Cc: QEMU <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 9, 2019 at 10:53 PM K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <dirty.i=
ce.hu@gmail.com> wrote:
>
> Unless we disable stream moving, pulseaudio can easily move the stream
> on connect, effectively ignoring the source/sink specified by the user.
>
> Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.com=
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  audio/paaudio.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/audio/paaudio.c b/audio/paaudio.c
> index cc3a34c2ea..24d98b344a 100644
> --- a/audio/paaudio.c
> +++ b/audio/paaudio.c
> @@ -517,6 +517,11 @@ static pa_stream *qpa_simple_new (
>  #endif
>          | PA_STREAM_AUTO_TIMING_UPDATE;
>
> +    if (dev) {
> +        /* don't move the stream if the user specified a sink/source */
> +        flags |=3D PA_STREAM_DONT_MOVE;
> +    }
> +
>      if (dir =3D=3D PA_STREAM_PLAYBACK) {
>          r =3D pa_stream_connect_playback(stream, dev, attr, flags, NULL,=
 NULL);
>      } else {
> --
> 2.22.0
>
>


--
Marc-Andr=C3=A9 Lureau

