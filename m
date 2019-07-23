Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18AA5C7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 15:08:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7CDA218F0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 15:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfQ0vwe6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7CDA218F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpwPF-0008FH-4U
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 11:08:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41367)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <liq3ea@gmail.com>) id 1hpwP4-0007qP-D1
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 11:08:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@gmail.com>) id 1hpwP3-0004Ms-6O
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 11:08:34 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:42344)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1hpwP2-0004MN-Ps
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 11:08:32 -0400
Received: by mail-oi1-x242.google.com with SMTP id s184so32539141oie.9
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 08:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/iTt+9nSqWNgdV2vBd4O093xQ1fyHVkBFdVnJGJFV1U=;
 b=VfQ0vwe69OFJzEsmG5NGJnZHQ/HZMNgYeguxEwsPPDboYb/Ys3CQgalwCIfS/rBn+n
 aH97rT6E/jI1ijaXYIGcgKdVwyGiUlbGjnHliBCJKlxnanP72/amuWoD36Clmig0BQgw
 yj3NbyIlSBbCayDX7jwOv4aWQ6vaMvixB9faK7a9IYO4JeNa1qMYp+UTE+OC/Z056RjW
 X8LSfFmBuHj+1Ix7yVRkEYPlywh1T15qmha1UlTW2jvIBiJQ3XYFg64PeyjAJJumcGiG
 A6X5kNUdZ+Krpo1Wi/Blvsqkv7o3EID8Vt7QQsRbPdpV1KC5FMV+AyMoy3VRzGEHcbPQ
 6c1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/iTt+9nSqWNgdV2vBd4O093xQ1fyHVkBFdVnJGJFV1U=;
 b=j3i8X4v77p/j37it5r5g/2bk6/GoUzkCVm1K6Sfwdnr6e7Q29tKFkADqXcMfVzjrgo
 0tgpYfxm2rLelnjg2eTdFCdUZXBKAhPxFgzykGubIpwXvf+ugyNJ56vDcrSWPtljmGw2
 8ep87x5yBWM9eeAjvgE1VBaOyfzGWvqeUSx6e8xNmF3gD1JeAOnZZY/Bfn3bIJwa4TNM
 6kIK2VW9YRqEgJmJ7Gf7zz+ShqpC57pVAR3y+x6tA4UshDVrmoRqOISGpISnRJ5h2/8r
 4kpHAKhKKW8uR+Qxej80PtiJ3AhKtXYAu1GgTq7Gx010pCzZ/G84Mj8yhldNhxJ0DGwS
 chBQ==
X-Gm-Message-State: APjAAAUNVemm608k9EjzRU4cjqAt/n67VXSmPMz62T7JdMQLAfd9rXui
 p6uY+LSvNDojqiY33j6bC1Z/9u+6ij1sTf9gLSE=
X-Google-Smtp-Source: APXvYqyw02bu6TlBs8wS1iRIUo3ltmfpP6YZVjypzY5WesRTrK4nU+2Y5vK+Ez/G7MyfFwuflmg6c7jC6sFXIXmipUc=
X-Received: by 2002:aca:fd4e:: with SMTP id b75mr38797926oii.129.1563894511967; 
 Tue, 23 Jul 2019 08:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190723104754.29324-1-ppandit@redhat.com>
 <20190723104754.29324-3-ppandit@redhat.com>
In-Reply-To: <20190723104754.29324-3-ppandit@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 23 Jul 2019 23:07:55 +0800
Message-ID: <CAKXe6SLjDXD3oo7it4GCvFy2TZ53tH2eRJxm=KXfr6NRC5nbmQ@mail.gmail.com>
To: P J P <ppandit@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v4 2/3] qemu-bridge-helper: move repeating
 code in parse_acl_file
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
Cc: Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Prasad J Pandit <pjp@fedoraproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

P J P <ppandit@redhat.com> =E4=BA=8E2019=E5=B9=B47=E6=9C=8823=E6=97=A5=E5=
=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=886:50=E5=86=99=E9=81=93=EF=BC=9A

> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> Move repeating error handling sequence in parse_acl_file routine
> to an 'err' label.
>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
>

Reviewed-by: Li Qiang <liq3ea@gmail.com>


> ---
>  qemu-bridge-helper.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
>
> Reviewed v3:
>   ->
> https://lists.nongnu.org/archive/html/qemu-devel/2019-07/msg00247.html
>
> diff --git a/qemu-bridge-helper.c b/qemu-bridge-helper.c
> index e90c22f07d..91a02f9611 100644
> --- a/qemu-bridge-helper.c
> +++ b/qemu-bridge-helper.c
> @@ -92,9 +92,7 @@ static int parse_acl_file(const char *filename, ACLList
> *acl_list)
>
>          if (arg =3D=3D NULL) {
>              fprintf(stderr, "Invalid config line:\n  %s\n", line);
> -            fclose(f);
> -            errno =3D EINVAL;
> -            return -1;
> +            goto err;
>          }
>
>          *arg =3D 0;
> @@ -111,9 +109,7 @@ static int parse_acl_file(const char *filename,
> ACLList *acl_list)
>
>          if (!g_str_equal(cmd, "include") && strlen(arg) >=3D IFNAMSIZ) {
>              fprintf(stderr, "name `%s' too long: %zu\n", arg,
> strlen(arg));
> -            fclose(f);
> -            errno =3D EINVAL;
> -            return -1;
> +            goto err;
>          }
>
>          if (strcmp(cmd, "deny") =3D=3D 0) {
> @@ -139,15 +135,18 @@ static int parse_acl_file(const char *filename,
> ACLList *acl_list)
>              parse_acl_file(arg, acl_list);
>          } else {
>              fprintf(stderr, "Unknown command `%s'\n", cmd);
> -            fclose(f);
> -            errno =3D EINVAL;
> -            return -1;
> +            goto err;
>          }
>      }
>
>      fclose(f);
> -
>      return 0;
> +
> +err:
> +    fclose(f);
> +    errno =3D EINVAL;
> +    return -1;
> +
>  }
>
>  static bool has_vnet_hdr(int fd)
> --
> 2.21.0
>
>
