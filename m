Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF097C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 15:25:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76E81208E4
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 15:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGIcA5Xl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76E81208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhyB4-0001gJ-QC
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 11:25:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38630)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <liq3ea@gmail.com>) id 1hhy8x-0000F0-JQ
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 11:23:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@gmail.com>) id 1hhy8w-0005AU-2q
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 11:22:59 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:35918)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1hhy8v-00058O-SK
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 11:22:58 -0400
Received: by mail-oi1-x244.google.com with SMTP id w7so10255866oic.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 08:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Xc9OjD0nUZ+3Mqa2kPNjAatVz38BK5YDMcw7B/DRoyc=;
 b=mGIcA5Xlik0/ssiJbwCjzI1bwXwNfwAz+Fx2EqVSr/Cc8+owSVYXGOYE9FWdlzwpn3
 TBS5kQSURe/Sp2YtYXNpd4uGT/LVdaC7IsWVVMj8hlmL+R1S4siKieroezkTgvT9tclE
 ovMzS4G/bP0m5HDOUcA+oul/QmDHqUCbN7fFxLUFYFCaGr0aoKPt3eW30ayqoqIc4RLY
 JY6YSKfSfDtkx12yLroKtpJH619CWXMZIogt7LA6oLRVTJyulnu9nsA39HdRGsqOhCnF
 MGB8vlhCmm7ME61XrbkGnn3KqURHkbvfDguZLttTSwSVAS4+LYoZqZM8eZA7fzD3VYkE
 e+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Xc9OjD0nUZ+3Mqa2kPNjAatVz38BK5YDMcw7B/DRoyc=;
 b=RDmxr3Mw054x2hqIi8rr2Hwf70AHNuBlBwzwq2Utjdh76+YwfXySrP4GvawejdIep4
 IwJ0jbsxNqYd3jKMow65oxlAcVLJMyYIe6j+iZ8tiMAXeZ4gAyrDY1QPmz7vvPef8AGC
 gB6a5po0i93T07zhu0bKGhOMnitsZLTKn3KSSzSwGI1iKoroD89Dw7c+m09t0fbfKUcY
 6BKa2XUNUammnfqNbjxf6fI82H0vx0knnV43NdHqD97U4vDgnNx4roZP8ssn+1+XzwYu
 A9J/SHaYJCkfSSyRuNn6l/jcGIpb7nsH3XBYdVXND7KEwtkLUyNIPPo3X2C+9Di54ogk
 MJYA==
X-Gm-Message-State: APjAAAXIZU8hV7fyx7Uqy8pfmH8J4mq4otfAiBJWyREx5lzohxWzGBhk
 Wv+QcXK3zLVIwQc9sFoxpuHKVzLGnuSD8xJHWdxooZdNjmA=
X-Google-Smtp-Source: APXvYqyNp96ftwG+b/B2Vw5SAVlofebKAm6GGaUhlBQDFwx+Zal1MOMrEgORr21NNU9Fb4CGoUfK0HbwVaE2s9PdBGA=
X-Received: by 2002:a54:4f97:: with SMTP id g23mr7056273oiy.97.1561994574757; 
 Mon, 01 Jul 2019 08:22:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190701123558.30512-1-ppandit@redhat.com>
 <20190701123558.30512-2-ppandit@redhat.com>
In-Reply-To: <20190701123558.30512-2-ppandit@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 1 Jul 2019 23:22:18 +0800
Message-ID: <CAKXe6SLZ0eAZ5++soLkFiH6gNMRqJfO7Y5JYmFtopnCqk_61Cw@mail.gmail.com>
To: P J P <ppandit@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v3 1/3] qemu-bridge-helper: restrict
 interface name to IFNAMSIZ
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
Cc: Riccardo Schirone <rschiron@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>,
 Prasad J Pandit <pjp@fedoraproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

P J P <ppandit@redhat.com> =E4=BA=8E2019=E5=B9=B47=E6=9C=881=E6=97=A5=E5=91=
=A8=E4=B8=80 =E4=B8=8B=E5=8D=888:38=E5=86=99=E9=81=93=EF=BC=9A

> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> The network interface name in Linux is defined to be of size
> IFNAMSIZ(=3D16), including the terminating null('\0') byte.
> The same is applied to interface names read from 'bridge.conf'
> file to form ACL rules. If user supplied '--br=3Dbridge' name
> is not restricted to the same length, it could lead to ACL bypass
> issue. Restrict interface name to IFNAMSIZ, including null byte.
>
> Reported-by: Riccardo Schirone <rschiron@redhat.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  qemu-bridge-helper.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> Update v3: use g_str_equal() and %zu for strlen()
>   -> https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg00072.html
>
> diff --git a/qemu-bridge-helper.c b/qemu-bridge-helper.c
> index f9940deefd..e90c22f07d 100644
> --- a/qemu-bridge-helper.c
> +++ b/qemu-bridge-helper.c
> @@ -109,6 +109,13 @@ static int parse_acl_file(const char *filename,
> ACLList *acl_list)
>          }
>          *argend =3D 0;
>
> +        if (!g_str_equal(cmd, "include") && strlen(arg) >=3D IFNAMSIZ) {
> +            fprintf(stderr, "name `%s' too long: %zu\n", arg,
> strlen(arg));
> +            fclose(f);
> +            errno =3D EINVAL;
> +            return -1;
> +        }
> +
>

g_str_equal is not consistent style with the other 'strcmp' in this file.
With g_str_equal or strcmp:

Reviewed-by: Li Qiang <liq3ea@gmail.com>




>          if (strcmp(cmd, "deny") =3D=3D 0) {
>              acl_rule =3D g_malloc(sizeof(*acl_rule));
>              if (strcmp(arg, "all") =3D=3D 0) {
> @@ -259,6 +266,10 @@ int main(int argc, char **argv)
>          usage();
>          return EXIT_FAILURE;
>      }
> +    if (strlen(bridge) >=3D IFNAMSIZ) {
> +        fprintf(stderr, "name `%s' too long: %zu\n", bridge,
> strlen(bridge));
> +        return EXIT_FAILURE;
> +    }
>
>      /* parse default acl file */
>      QSIMPLEQ_INIT(&acl_list);
> --
> 2.21.0
>
>
