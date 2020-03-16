Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4382C18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:35:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A16BD20663
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5Z8fGav"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A16BD20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDsi0-0001Ig-LI
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 12:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49661)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jDr5L-00007w-Aa
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:51:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jDr5K-00085O-9E
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:51:19 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33088)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jDr5K-0007tp-1Q
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:51:18 -0400
Received: by mail-wr1-x441.google.com with SMTP id a25so21606977wrd.0
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 07:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=EBA2kBnuWIbZxYq1IozPBlavq7ho+4yFZxgtcTzlqMM=;
 b=m5Z8fGavUhGGyLfX0PzBZDYHeEfUf5hzVkFzioL5oE8Js7fNG7xg1HAM64OeYx6Xlu
 avw9mCH6HZPOQWoVtlV+S3rFIZ2LvmkhxJ2k6a7wtP3XquLnMnz1g4zrPlnheJX4waGG
 m5Q0IrBEwkn6NTC/+Io8A81VvOEStNFjFKqzVa5BpLLLGHrHTKA6zeVeA+0thSe1td+I
 imhaPfZgxkXVNGZ22hhEFmGjWrY/kSF1O2DGd87KxyeTWjoCF21dsb3LjCr3RiU7gFUC
 zCUIqWZwCK3rQJd2fQtF9728wJCKRAdZgpfKaU8a27HoqNl6rc9l3adsLakfd7KTx6kG
 xIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=EBA2kBnuWIbZxYq1IozPBlavq7ho+4yFZxgtcTzlqMM=;
 b=dnxnn4+RinMuYTISUx4EpEMQmif6Nlxl5DKtBD0B89evgLmKE3ywAzEVK+SFgWByiz
 +T8Z68+kwDcYh6wpThoCwaQccvtG55qjmfniRtw3MwzPIucVyq8fM6q46yrw6kdDcLLK
 GMa4B91Vv1eGfWMWA/AEZq26e5srdDW3DXWdvEV75476QPaHxFT8kSQjuWk2JiZmqXLJ
 iTT8Id7GsqrndQnVnpts0h6d/GmFbD2oaXtU0SlTmqUphaOmOu1hhrPW0cGgCPriPjy2
 KGoYlCx5Xd9jgh6rFzrftdztXhO167W5+rju4lNsUMT7xtpbyEPIGSU/Zg341M2Rz8LG
 wNBQ==
X-Gm-Message-State: ANhLgQ1O3iKrVEFmSMJQsCoftpkfnC0Pe7sBIl+RRl+qWQ9CyN14wCZN
 7lYjRsWBeqU+Kn/KZ/64HSKfrLk2w7PE0R0rPvM=
X-Google-Smtp-Source: ADFU+vsmPUmAFZNXCupcgzplpXJcX1MCYgHXmUmwVhROtqxZjkAav4Td7dQ6QNhwwaYVJX6UjAV6aweJM/iCTJviI3E=
X-Received: by 2002:adf:cc85:: with SMTP id p5mr35908613wrj.196.1584370275751; 
 Mon, 16 Mar 2020 07:51:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200315144653.22660-1-armbru@redhat.com>
 <20200315144653.22660-3-armbru@redhat.com>
In-Reply-To: <20200315144653.22660-3-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 16 Mar 2020 15:51:03 +0100
Message-ID: <CAJ+F1CJ_wUSvv4ZmybaeQxJnUe3RyFHgTnLo=EzYzOJqVq6emA@mail.gmail.com>
Subject: Re: [PATCH v3 02/34] qapi: Belatedly update doc comment for @wait
 deprecation
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
Cc: QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Sun, Mar 15, 2020 at 3:48 PM Markus Armbruster <armbru@redhat.com> wrote=
:
>
> Commit a9b305ba29 "socket: allow wait=3Dfalse for client socket"
> deprecated use of @wait for client socket chardevs, but neglected to
> update char.json's doc comment.  Make up for that.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  qapi/char.json | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/qapi/char.json b/qapi/char.json
> index 6907b2bfdb..daceb20f84 100644
> --- a/qapi/char.json
> +++ b/qapi/char.json
> @@ -258,6 +258,7 @@
>  # @server: create server socket (default: true)
>  # @wait: wait for incoming connection on server
>  #        sockets (default: false).
> +#        Silently ignored with server: false.  This use is deprecated.
>  # @nodelay: set TCP_NODELAY socket option (default: false)
>  # @telnet: enable telnet protocol on server
>  #          sockets (default: false)
> --
> 2.21.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

