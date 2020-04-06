Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC42C2BA19
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:21:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B63A6206F8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tnBkf3vl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B63A6206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLOss-0006Qp-RN
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 06:21:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51080)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jLOpt-0001EF-AM
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:18:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jLOps-00078z-1v
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:18:33 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42459)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jLOpr-000781-6K
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:18:31 -0400
Received: by mail-wr1-x442.google.com with SMTP id h15so16710618wrx.9
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 03:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=5JuzwMCSXXr41L/anyvQm5p4YcGZqqqbcaJ3C3Ka1gQ=;
 b=tnBkf3vllxpr5luH0jIEv5kgYyztBQnnC47bPkQPurzw2DRamnIU8WXegRteT8c9iM
 4RQbANVlu4qp3cPQbsoqaMN4O1xDtDhk2oW2jyE07RJexgx7m8vNWK9WZifOa55qwiYj
 Kyk7TKJiES2cty6FWt2IkIbC5Z0G0kGT75QpVd2vut2LZBScRzta3/JlEkVN+2oeO3bx
 WCGTYpNiK7d3gsbqi82RsZCuX7gfW1VEFJombSmJzW08gU1b5Lp2eHBYBhbTt8o8sC8t
 7eYSOEXJS7m/aQdDA2mpnzOei2xmOOxnOI7ck3okHbRZ0d90uwntpZLGpbZNF0Mocufa
 USlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=5JuzwMCSXXr41L/anyvQm5p4YcGZqqqbcaJ3C3Ka1gQ=;
 b=ElGbEl6cBogNU1nV0oxgFtkkMyprpLQu1qZttrJuR7nSc2xejJ/MBXx61st7G+vIBs
 uroJkskvoCczJetYwKRBQ2XtDFptCRrkhp6x9hOV8rBoZGdocX/YhjB+AKkMG6OrPJIg
 cSim0bdnZGpU1mBYJhdzR0POEuDYyP+y1VBnQ0YSljSZTtYrKpyaBUvVkyT177rWz9OK
 JOoshkkeCkYgwkZmVfl4XWwraL8xw1Io10Qe/2LB5GUWq4YwVBfHKxkhG9+0TepNQ2Yj
 CABzzT1X+BoaR5hvfbWGhyIVjk9K0ePzJryw4k/Ic+IkLfssS9WuJmLZwuHa6nzltX1T
 tURA==
X-Gm-Message-State: AGi0PuZ91tmJTky53wOveoDM2iwzsGGoAb8Wtv3s8yUqVxO6fJCTy8I2
 KcI36I6aWig6oxQ9QRo+2PQyyfI+42i6E0eTHGQ=
X-Google-Smtp-Source: APiQypII+IapDL748+sL0Yp2DBQ/zv2qAiDovS5N7ugIhIzYKppCxG3mHSUQJ0evllJxeQCtf+vkdAxzoK+VbvVox4Q=
X-Received: by 2002:adf:f841:: with SMTP id d1mr10883687wrq.381.1586168309481; 
 Mon, 06 Apr 2020 03:18:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200404153340.164861-1-clg@kaod.org>
In-Reply-To: <20200404153340.164861-1-clg@kaod.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 6 Apr 2020 12:18:17 +0200
Message-ID: <CAJ+F1CL8ayBSz2wouZZ2R=w7nqW8QqVT1V1ji27fsBxK9z20-w@mail.gmail.com>
Subject: Re: [PATCH] qom/object: Fix object_child_foreach_recursive() return
 value
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Peter Crosthwaite <peter.crosthwaite@xilinx.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On Sat, Apr 4, 2020 at 5:34 PM C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> When recursing, the return value of do_object_child_foreach() is not
> taken into account.
>
> Cc: Peter Crosthwaite <peter.crosthwaite@xilinx.com>
> Fixes: d714b8de7747 ("qom: Add recursive version of object_child_for_each=
")
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  qom/object.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/qom/object.c b/qom/object.c
> index 1812f792247d..b68a707a5e65 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -1057,7 +1057,10 @@ static int do_object_child_foreach(Object *obj,
>                  break;
>              }
>              if (recurse) {
> -                do_object_child_foreach(child, fn, opaque, true);
> +                ret =3D do_object_child_foreach(child, fn, opaque, true)=
;
> +                if (ret !=3D 0) {
> +                    break;
> +                }
>              }
>          }
>      }
> --
> 2.25.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

