Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C819BC4CEC9
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 06:35:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96EDA2080F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 06:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tQTWJR7F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96EDA2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBCVw-0002zS-HN
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 02:35:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50113)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iBCU7-0000ud-8E
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 02:33:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iBCF6-0002ae-4p
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 02:18:09 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34693)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iBCF5-0002aM-Vz
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 02:18:08 -0400
Received: by mail-wr1-x441.google.com with SMTP id a11so5514489wrx.1
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 23:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=vsPzizeCkKCM0ZXQfRD5g8nkR6C4t7YMykCEuvs7VvU=;
 b=tQTWJR7FjEy1z2EwKRQTp7J6zQenW8Rrhw6z/uGa9umZSCNhgB1u9SgTFj9POpOeIZ
 t3eRZ16TjILDgk0L1N5O3i0YkE3INXDJkYcAll3m9pr9BHs510r/f+eco5qJkejLftqx
 wqn/bqDGgcg7EA0PXfnEO5J6P9BhsJRgBton+FObZ04T+X9rtEozyZM8Iw38VENr9FOu
 1tumoKES3MoQOwzXsynqq/ZC3dD9UlyzhPcbi1Sz3HsUJmpy2YN0mE3kafD6qVUa3Xks
 5Ji1r0wL8r3RHHauBvtgMtXaCci80PKMVV5KEHuTqlaZ5u9m+A/O2ZbVl58UdvtRdYu/
 2Ugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=vsPzizeCkKCM0ZXQfRD5g8nkR6C4t7YMykCEuvs7VvU=;
 b=lKn+KzEUYPXJUTSY0xTlRJ72S3xDFCsvCSi6y97Db+mYKFqgzYtKi+i5XmgvQZyFcg
 gJ5jCUGMcIh0e5WMLt+K0yKn6DGJDXqvq6v2z59thSZ8Dae2/748pqf5b2FQcBA1OMet
 iUlmLz3tjSWv78IOGSLF4VDdB6aPXxWUtN9WjXHT6k7Gk1kqPnGRwx1FBX33LLghRIP4
 LP7JM9j3n3WPhiSjW/s92Wh9swBglOlAV2tfJAqeHfI341wcOJqRDbKMvus2xlLJWhhA
 MxCQUNRH2bqD5rbJFwtvBA5DIivDUWlMit/faXce8WV6NsSqrrkU/NDdl+z6hlDIrcbu
 vL9A==
X-Gm-Message-State: APjAAAUKUp1FDhVzyJO147h4R+OKpYiSMf/ccg2yamaz3gUB+2W1KWaP
 4GTjr3G8yr+KE64jNvijeWZacMCpiLGgBhj1dsI=
X-Google-Smtp-Source: APXvYqwquYIhV7Jm/qJ8Y44CH6GvZ3pPROwXuCwt+Rxizb7CJ+tZlKyxVbkc7En3jUTAohYCMcMjhYQgRgcg51HxACc=
X-Received: by 2002:a5d:4d42:: with SMTP id a2mr10938610wru.89.1568960286578; 
 Thu, 19 Sep 2019 23:18:06 -0700 (PDT)
MIME-Version: 1.0
References: <7f5dd2ac9f3504e2699f23e69bc3d8051b729832.1568925097.git.crobinso@redhat.com>
In-Reply-To: <7f5dd2ac9f3504e2699f23e69bc3d8051b729832.1568925097.git.crobinso@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 20 Sep 2019 10:17:54 +0400
Message-ID: <CAJ+F1CJQJoOxZ2Osi1unUxX2k9u2g13QFg7zWYBsU5uq1bJkDw@mail.gmail.com>
Subject: Re: [PATCH] vhost-user-gpu: Drop trailing json comma
To: Cole Robinson <crobinso@redhat.com>
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
Cc: QEMU <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 20, 2019 at 12:34 AM Cole Robinson <crobinso@redhat.com> wrote:
>
> Trailing comma is not valid json:
>
> $ cat contrib/vhost-user-gpu/50-qemu-gpu.json.in | jq
> parse error: Expected another key-value pair at line 5, column 1
>
> Signed-off-by: Cole Robinson <crobinso@redhat.com>

oh json..
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  contrib/vhost-user-gpu/50-qemu-gpu.json.in | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/vhost-user-gpu/50-qemu-gpu.json.in b/contrib/vhost-u=
ser-gpu/50-qemu-gpu.json.in
> index 658b545864..f5edd097f8 100644
> --- a/contrib/vhost-user-gpu/50-qemu-gpu.json.in
> +++ b/contrib/vhost-user-gpu/50-qemu-gpu.json.in
> @@ -1,5 +1,5 @@
>  {
>    "description": "QEMU vhost-user-gpu",
>    "type": "gpu",
> -  "binary": "@libexecdir@/vhost-user-gpu",
> +  "binary": "@libexecdir@/vhost-user-gpu"
>  }
> --
> 2.23.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

