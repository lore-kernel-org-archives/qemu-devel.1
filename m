Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF0DC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 18:17:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99BC82098B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 18:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bhldiAKr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99BC82098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUwCc-0000Sr-DT
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 14:17:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1kUwB5-0008JK-4p
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 14:16:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27322)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1kUwB2-0006bJ-9D
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 14:16:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603217762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W1VZVVPJBLu8inTjcLiESc1K8yWJTOObiYSpHxtx2bI=;
 b=bhldiAKrZHz3wNW8Yr6LQndW8gIhVM6xuZZzoeVA1QYtnaJwd8H1cRNbmTuRYLhdDxOVFu
 AnWh3/AWcXqMmATec8m6oXEWXBamiKs2PIbTlrhWxz/ZGps9KtMR0vVciRUI03xONjevQG
 kBOuhV6q4C7/2Z+iOpj+iW23J5WGOy4=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-3bqnR5MROjyMuyJwCjcBzA-1; Tue, 20 Oct 2020 14:15:58 -0400
X-MC-Unique: 3bqnR5MROjyMuyJwCjcBzA-1
Received: by mail-ot1-f69.google.com with SMTP id o60so1340141ota.7
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 11:15:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=W1VZVVPJBLu8inTjcLiESc1K8yWJTOObiYSpHxtx2bI=;
 b=uoEYFEceQxAJfUDO4Dwvdl5ZhSeXlnvcxgt85+KjSXODgUfn0wMWTg7EA/2ZTkitde
 rzgbNH1SsW6F5XQF+5PFcqOJQBxmiYF5hArsa7GJ/DbZrWlEsd9ia3guIm8SRfcpdugS
 iY1bd6A2bizKsVN0JZYhCHU4zhmcmdjMzSmJC7/t3O8NejM8bcwHChDIQ+lJ97e92zU/
 VqZvPfAsaIx3A82dc18B0JHYkrh36DiGbkLz1nKbOBheqZkCTxl4uyPGX4Dzq1U5t5hr
 ulNX1wP4QiyZgpyB6zziSmMkEqv4I2mR+2KEB/j0tWCj/OCmg261c5ayK3oyyVLpqKcb
 iNbA==
X-Gm-Message-State: AOAM533SimC+ljGrRs9q2y+vnR4jSWP9/mvxBIpOYKEUdcAtXRSuhjXJ
 3zImaEs+U3LYqc685bBDnDgL5p+CCqFh0NWniF4I1JYwngZJOS+q625lDo3GEodxST3Or2wpEZK
 uTFqLpB1zRvUMe93hht/76xy578S+ADc=
X-Received: by 2002:aca:49ce:: with SMTP id w197mr2841349oia.56.1603217757777; 
 Tue, 20 Oct 2020 11:15:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNnFwPYsRhRyZzvz85mk8nVZI1yzFpNFtXpGn0l+ffGMDnbuXigC2ORuaJnQOwWM7c4q/a5iaR5iJv8gnRhtI=
X-Received: by 2002:aca:49ce:: with SMTP id w197mr2841331oia.56.1603217757523; 
 Tue, 20 Oct 2020 11:15:57 -0700 (PDT)
MIME-Version: 1.0
References: <20201020172742.1483258-1-jsnow@redhat.com>
 <20201020172742.1483258-21-jsnow@redhat.com>
In-Reply-To: <20201020172742.1483258-21-jsnow@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Tue, 20 Oct 2020 21:15:40 +0300
Message-ID: <CAMRbyyuiqFK2biX5ADrx0cDJ1V-naiOHJ7TKD1M-rGFnFH6c4g@mail.gmail.com>
Subject: Re: [PULL 20/21] python/qemu/qmp.py: re-raise OSError when encountered
To: John Snow <jsnow@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=nsoffer@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=nsoffer@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:15:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block <qemu-block@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 20, 2020 at 8:52 PM John Snow <jsnow@redhat.com> wrote:
>
> Nested if conditions don't change when the exception block fires; we
> need to explicitly re-raise the error if we didn't intend to capture and
> suppress it.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Message-id: 20201009175123.249009-3-jsnow@redhat.com
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  python/qemu/qmp.py | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/python/qemu/qmp.py b/python/qemu/qmp.py
> index d911999da1..4969e5741c 100644
> --- a/python/qemu/qmp.py
> +++ b/python/qemu/qmp.py
> @@ -165,14 +165,15 @@ def __get_events(self, wait: Union[bool, float] =3D=
 False) -> None:
>          """
>
>          # Check for new events regardless and pull them into the cache:
> -        self.__sock.setblocking(False)
>          try:
> +            self.__sock.setblocking(False)

This change is not required. The idiom is:

     do stuff
     try:
         something
     finally:
         undo stuff

If do stuff failed, there is no need to undo it.

socket.setblocking() should not fail with EAGAIN, so it
does not need to be inside the try block.

>              self.__json_read()
>          except OSError as err:
> -            if err.errno =3D=3D errno.EAGAIN:
> -                # No data available
> -                pass
> -        self.__sock.setblocking(True)
> +            # EAGAIN: No data available; not critical
> +            if err.errno !=3D errno.EAGAIN:
> +                raise

In python 3 this can be simplified to:

   try:
       self.__json_read()
   except BlockingIOError:
       pass

https://docs.python.org/3.6/library/exceptions.html#BlockingIOError

> +        finally:
> +            self.__sock.setblocking(True)
>
>          # Wait for new events, if needed.
>          # if wait is 0.0, this means "no wait" and is also implicitly fa=
lse.
> --
> 2.26.2

Nir


