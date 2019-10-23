Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A50CA9EB9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 13:49:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A868C20663
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 13:49:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A868C20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNH0m-0004dA-CY
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 09:49:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48881)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iNGuk-0000kE-8L
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 09:43:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iNGuh-0003eN-Fc
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 09:43:02 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:33181)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iNGuf-0003dv-Dk; Wed, 23 Oct 2019 09:42:59 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MPaQU-1iaw8m0x9u-00MaYj; Wed, 23 Oct 2019 15:42:50 +0200
Subject: Re: [PATCH 2/3] event_notifier: avoid dandling file descriptor in
 event_notifier_cleanup
To: Frediano Ziglio <fziglio@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
References: <20191023122652.2999-1-fziglio@redhat.com>
 <20191023122652.2999-2-fziglio@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <3dafc0c5-bdb2-6345-961f-4ff6691bafeb@vivier.eu>
Date: Wed, 23 Oct 2019 15:42:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191023122652.2999-2-fziglio@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:6nnb/F2ItGS/DZN6kICWRGUKQWHiXMPP2NdimF5ChuDcVKE9oaW
 /pEyu3pNLOdA5zhpxPwhzGHpKIqNgRRKeSRYyZsS8vJgscuJKRzAhV/stVrYejplv70MVrY
 VU4Hy3O8LYvYqT5d9USWuZWGO2+XusXa1Uo3GNMJAFMflT3Fekr269WKEAXXQsnf/OfOujw
 yUUlAfzamr9rcK4CKpo4A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NqbEz8nkdwQ=:WKBriyCui7qgSHDiWRyjnd
 H/hs0dMhyUrvH43jpySi35TGfR8cwy+lA+KkDVJ0uZyd32ttmrgscTOKjDImkIWtBtaQF+ZeI
 S4rilzFJk3E7lyJaUizW4v9dlWztjv0unr0/HJNY169Q7UOWmG5Q6ZMloS/1/KnHetP38FZ5a
 AV4PM/y6ktq1US6eNAUBCSqeJnxPPREzsWoewBTdhgdaHN4OoHE39JHw3F9Js2NYYxiiDoDie
 IMdupdjOzEzHcqqlWcWC6nGjRlr4+sfsTsvudpgNEXQKbOEwpYH4ZpoAQyQyToKr5FjcvXBqW
 cHPln3Iayp6+MRaUpKD4YAyocAtCjepUJ6BKs3/4jT3B9xE2ayCRgwSNQfwy+5v1+jeZNzmm6
 00hDncxQrHEXwxiDwSbyqkOZRTaR+gZ/aRNt+tyteuVYITDms/JnJE6oH7wtOkq7Yf93Ftk9o
 CK9BBd5cvYRWiZtUYrlwPiB43GfIkzGFnbwgTfChFIqVz8iGM9ArgR32d4khqvrwNwf4t6E6V
 XWqvtt928WwOugOhJW70oC/3RHKCvNAj2jMYTaGCOh1IUDZ4NEAwZXOfvWqnQN6AcS+s7BWNW
 lpuiTbdbh5Op3VUlylDRPM0o5LsHm7QhDND76JC24jB0yq4e8K/R1mnAhx9nB4sLlIKBzi4RT
 SsSK+dfZGp35i6RZE5zBjy8Cc7b7xHg1OGDn1zUzGBwCqdIjn8WqrjThQHT2DGjSdlq8e+SHs
 EOyShMthLKmw3vCFxSviL0yHMpjSdHyPlUixBf72lXsTCf2MltLp1U7x0jeYD+7bHunHO3Yy5
 ELWGFZmsBrz1pa8y2yqrI7rImzcfAXy0Uv3ViSWBtfbU33P7vMZAo4fKtWL17SHujrADnTicL
 DhfT088wYP5GQL+5Q9wsED7XFUBCSO9EY+yhXnRuk=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.134
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 23/10/2019 à 14:26, Frediano Ziglio a écrit :
> If rfd is equal to wfd the file descriptor is closed but
> rfd will still have the closed value.
> The EventNotifier structure should not be used again after calling
> event_notifier_cleanup or should be initialized again but make
> sure to not have dandling file descriptors around.
> 
> Signed-off-by: Frediano Ziglio <fziglio@redhat.com>
> ---
>  util/event_notifier-posix.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/util/event_notifier-posix.c b/util/event_notifier-posix.c
> index 73c4046b58..00d93204f9 100644
> --- a/util/event_notifier-posix.c
> +++ b/util/event_notifier-posix.c
> @@ -80,8 +80,8 @@ void event_notifier_cleanup(EventNotifier *e)
>  {
>      if (e->rfd != e->wfd) {
>          close(e->rfd);
> -        e->rfd = -1;
>      }
> +    e->rfd = -1;
>      close(e->wfd);
>      e->wfd = -1;
>  }
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

