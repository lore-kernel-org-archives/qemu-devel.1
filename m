Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B68BCA9ECB
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 18:31:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBF61216F4
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 18:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITlgVWVX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBF61216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQFE7-0007ti-U6
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 14:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58617)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iQFBx-0006lB-IF
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 14:29:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iQFBs-0000NB-2z
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 14:29:04 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34274)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iQFBr-0000MN-QV
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 14:28:59 -0400
Received: by mail-wr1-x443.google.com with SMTP id e6so5523008wrw.1
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2019 11:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=x+lzxHk+3Ht5CGOZStAjDSfqmq16VF6wAXQE9G4x8zA=;
 b=ITlgVWVX17pcAhEsg5ORyR1ZCckqO4xH8yEO1LE3HbtUZMLwrJQymlBC+14vBI7tGQ
 LSE2KRIACJrYpksF0AhSRCaXGt8NSyUkCtittrH3M0d9IQsj86vpNep6j4DSJrVXcqS9
 e/7Nt//GdRMIpZOi2/AiuYveXVN+ER7o4r56dRvarNkgpSOOkqJ4I6qvu/lUsjSectZ8
 lF99XHgetjQLMOv7Obxnmiu5mB+p2kN+Y1DGUUBV+kx/Q19sdxQYiRmKEKJECoZMmMTh
 kmnatNsxwOr1b1JPaWUo68tkLagvVfoVcxwYSLjEYZHamGSuCameo0O9CvzMNVbBFKQH
 7YOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=x+lzxHk+3Ht5CGOZStAjDSfqmq16VF6wAXQE9G4x8zA=;
 b=J3nNO+7gLx2kux/VWLKG0dwQMAHebw2oR7/p0Mbi0neZk9NHT2ICrptXRdMvW5pwGw
 yOaWuY7mtjqt3Fom68r8x8hWTB6NWU+hqUO97kwQVfT9CBwXaP/7Ox7zU9LNH6VI3glA
 V0b9pRpde4UQgnDg26XVDrnaq9FN6hYmrjm0tjczBT7Uf+ewonAPGTUIEbmNHOALmaQS
 /EXKcM5lMkpVAvHLWW72R/O5onGjm5oHl4W5knJ0R5CwrkkLMp5CmaNlu0eFe/dkKF4z
 lyVzZ6NzBKoUKBKEzBSjl7W/n7uGPWt1xj5Bu+nQwv+vn8awELUncZ3OfHN4t1uKnfUK
 S2CQ==
X-Gm-Message-State: APjAAAXClgY9gTsPA35k95yUBQy0wPrrLHoWa9d1lzXdVj2cQjH6seo2
 09HhrOj5lmFtJgH/UzFicLRghsFD084fyQiY4EM=
X-Google-Smtp-Source: APXvYqyiicgvRjzo997gzkT0Bx8WExHfx1SLhiKDFk8nI4ZYdf5Tv6zUDASczUaDohAaAAO99m9yqJ6v50o5IKxJWtw=
X-Received: by 2002:a5d:6892:: with SMTP id h18mr6588650wru.370.1572546538007; 
 Thu, 31 Oct 2019 11:28:58 -0700 (PDT)
MIME-Version: 1.0
References: <20191017123438.87703-1-basil@daynix.com>
 <20191017123438.87703-2-basil@daynix.com>
In-Reply-To: <20191017123438.87703-2-basil@daynix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 31 Oct 2019 19:28:46 +0100
Message-ID: <CAJ+F1C+YLWXubJGaThO1_iZu3EVVqPc5v_NhLFqA6LcE0kfHdg@mail.gmail.com>
Subject: Re: [PATCH 1/1] qga: Add "guest-get-memory-block-info" to blacklist
To: Basil Salman <basil@daynix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Yan Vugenfirer <yan@daynix.com>, QEMU <qemu-devel@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 17, 2019 at 2:35 PM Basil Salman <basil@daynix.com> wrote:
>
> From: Basil Salman <bsalman@redhat.com>
>
> Memory block commands are only supported for linux with sysfs,
> "guest-get-memory-block-info" was not in blacklist for other
> cases.
>
> Reported on:
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1751431
>
> Signed-off-by: Basil Salman <bsalman@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  qga/commands-posix.c | 3 ++-
>  qga/commands-win32.c | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index dfc05f5b8a..1c1a165dae 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -2730,7 +2730,8 @@ GList *ga_command_blacklist_init(GList *blacklist)
>              "guest-suspend-hybrid", "guest-network-get-interfaces",
>              "guest-get-vcpus", "guest-set-vcpus",
>              "guest-get-memory-blocks", "guest-set-memory-blocks",
> -            "guest-get-memory-block-size", NULL};
> +            "guest-get-memory-block-size", "guest-get-memory-block-info"=
,
> +            NULL};
>          char **p =3D (char **)list;
>
>          while (*p) {
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 6b67f16faf..1c9ec9c094 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -1894,7 +1894,7 @@ GList *ga_command_blacklist_init(GList *blacklist)
>          "guest-suspend-hybrid",
>          "guest-set-vcpus",
>          "guest-get-memory-blocks", "guest-set-memory-blocks",
> -        "guest-get-memory-block-size",
> +        "guest-get-memory-block-size", "guest-get-memory-block-info",
>          NULL};
>      char **p =3D (char **)list_unsupported;
>
> --
> 2.17.2
>
>


--=20
Marc-Andr=C3=A9 Lureau

