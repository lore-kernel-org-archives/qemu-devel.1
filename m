Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8881C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 08:44:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E46E22CF7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 08:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="q/PB0MYU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E46E22CF7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i54QA-0000GS-Mj
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 04:44:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53722)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bishara@daynix.com>) id 1i54Oa-0007p2-Dn
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 04:42:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bishara@daynix.com>) id 1i54OZ-0007o1-3V
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 04:42:36 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:45265)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bishara@daynix.com>) id 1i54OY-0007nh-Uq
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 04:42:35 -0400
Received: by mail-io1-xd41.google.com with SMTP id f12so16582049iog.12
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 01:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PFWC4XGIDHYKeQ8nZ+pzU6kHSUpBvVvtHcN/SnFiTFg=;
 b=q/PB0MYUMa4rr8nR+cS68coCKloLaBAB4/MDkYoNs/XWgTj/lkKQ/chqU92/LZHjP6
 Jn58oLXZwf2G7xit2Z6F3xh18XJiZavFEa1qJNlhsAZlevwJW7ExHZbjdVlFLgRlSu0z
 Ym0aTjfTj+tuuK9tsbVdg7tnupgAOw8f9CpvhCojV/e0OY7RlDhj9xNmf/ANNk9gwS5X
 fS/KgSeZ0RwCqQBTbuck6v87upvTDgYN2hjfmeVENstx03wata8VToQQ0GX9+XszR993
 z4S+19RTwNIpLXPdOGBvZWxgFDwJHVALeqNWqp08MBQHz+UxcRYlX3dWpXG37nqbQ0ML
 EI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PFWC4XGIDHYKeQ8nZ+pzU6kHSUpBvVvtHcN/SnFiTFg=;
 b=OMVlIGKwiLmSM6Pz2kKjrhvLnffwDdic3onen4R8VZD4pTfwKEHNEVsJEBd8A8eZBj
 bW3J4/7vzSk0EcxMTlVhO0/jqkdBx46e2i4QvmDWDdxgbtyt/7Uzm8YZowcXRoztTlbS
 GmzmNA0VDXxZ3NXTjKx1ll7RelAqo+qO1syCUisQFzHUAH+ucUEn35eYdClBAYiKQT5C
 VZM43D1LJIN8eFJWKTZaSlW1O7f9z+sUZ4Z/LAKdSiR14mN3a9JDquDnQpccZa7L9kt0
 JYgLiPI44roYH/vBbI9rkMmn9BSuSR9bhuOO63VRdlVt4BNCGDwBBA2/N00pExBJK+SY
 FnFw==
X-Gm-Message-State: APjAAAXI1HLYrrlGr+Phdqqq19g01ZLBlvynboC0KBKgak97anevo+Cv
 ZJUbwkUvzMp+2bXfLYgBl3SS9foX8GlqMynwsmcxPQWU
X-Google-Smtp-Source: APXvYqzNPZ2U4JJy6nZ6Ft8HjsbZ77/ApOQ1T4pLiqGggEszh40jJ7KHubSHamMRbt2uR6pr/2xbOuxggEHOeRmbcJs=
X-Received: by 2002:a05:6638:2aa:: with SMTP id
 d10mr34952585jaq.89.1567500154023; 
 Tue, 03 Sep 2019 01:42:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190819131620.1302-1-bishara@daynix.com>
 <20190819131620.1302-2-bishara@daynix.com>
In-Reply-To: <20190819131620.1302-2-bishara@daynix.com>
From: Bishara AbuHattoum <bishara@daynix.com>
Date: Tue, 3 Sep 2019 11:42:23 +0300
Message-ID: <CADyT_0XyVicwHGGKscO-=OtJYhnxPuTcDPvoOfzBOkdZ0QL-rQ@mail.gmail.com>
To: QEMU Developers <qemu-devel@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d41
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH 1/1] qga-win: network-get-interfaces
 command name field bug fix
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
Cc: Yan Vugenfirer <yan@daynix.com>, Basil Salman <basil@daynix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PING

On Mon, Aug 19, 2019 at 4:28 PM Bishara AbuHattoum <bishara@daynix.com>
wrote:

> Network interface name is fetched as an encoded WCHAR array, (wide
> character), then it is decoded using the guest's CP_ACP Windows code
> page, which is the default code page as configure in the guest's
> Windows, then it is returned as a byte array, (char array).
>
> As stated in the BZ#1733165, when renaming a network interface to a
> Chinese name and invoking this command, the returned name field has
> the (\ufffd) value for each Chinese character the name had, this
> value is an indication that the code page does not have the decoding
> information for the given character.
>
> This bug is a result of using the CP_ACP code page for decoding which
> is an interchangeable code page, instead CP_UTF8 code page should be
> used for decoding the network interface's name.
>
> https://bugzilla.redhat.com/show_bug.cgi?id=1733165
>
> Signed-off-by: Bishara AbuHattoum <bishara@daynix.com>
> ---
>  qga/commands-win32.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 6b67f16faf..64b1c754b0 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -1387,12 +1387,12 @@ static IP_ADAPTER_ADDRESSES
> *guest_get_adapters_addresses(Error **errp)
>  static char *guest_wctomb_dup(WCHAR *wstr)
>  {
>      char *str;
> -    size_t i;
> +    size_t str_size;
>
> -    i = wcslen(wstr) + 1;
> -    str = g_malloc(i);
> -    WideCharToMultiByte(CP_ACP, WC_COMPOSITECHECK,
> -                        wstr, -1, str, i, NULL, NULL);
> +    str_size = WideCharToMultiByte(CP_UTF8, 0, wstr, -1, NULL, 0, NULL,
> NULL);
> +    /* add 1 to str_size for NULL terminator */
> +    str = g_malloc(str_size + 1);
> +    WideCharToMultiByte(CP_UTF8, 0, wstr, -1, str, str_size, NULL, NULL);
>      return str;
>  }
>
> --
> 2.17.2
>
>
>
