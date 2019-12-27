Return-Path: <SRS0=GTQb=2R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DE4C2D0C3
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Dec 2019 21:47:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB26720740
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Dec 2019 21:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KhmUyqXW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB26720740
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39055 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ikxSH-0003vw-Hf
	for qemu-devel@archiver.kernel.org; Fri, 27 Dec 2019 16:47:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54001)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ikxPt-0002v6-3k
 for qemu-devel@nongnu.org; Fri, 27 Dec 2019 16:45:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ikxPr-0005Hb-T4
 for qemu-devel@nongnu.org; Fri, 27 Dec 2019 16:45:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47685
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ikxPr-0005Fn-Er
 for qemu-devel@nongnu.org; Fri, 27 Dec 2019 16:45:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577483102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hmbc9ZLKA4lyNlXb4Mp9QVKNZbDD5QoaM2f7T/+jMrg=;
 b=KhmUyqXWuWJ1zJIJBpR28mYt4Gwt/tPIA/kR7Ylf3KXQxVqmzPhnKvSSfEyqUiR5JJ6crh
 F0v+171TPSArMARM5L6oLqpOgUtl6zi8Q686oHTijx4PJiIMiEqrdviQgqj4hCRoH5LxHe
 96SJBDWb7cP5bAb/sGVro5D6XT/yDBc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-4U83wrRGMaa7sWIYaGfzRg-1; Fri, 27 Dec 2019 16:44:59 -0500
Received: by mail-wr1-f70.google.com with SMTP id z14so14543193wrs.4
 for <qemu-devel@nongnu.org>; Fri, 27 Dec 2019 13:44:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eHhU0ykQiE9dJ4DGpJIPGvyaJ/cwOCNG9yskkZAS2K0=;
 b=kpIQ95XTmXFh3s+NBnf3wy9Mws2FJ3KDxL7En+gtlJ8pDqdRZjioItZAFmkA6Ufj6F
 6tqgccp7oC9+nsiNTCNbXY2x0aiF8GB9QdXEdxQOilo/tqrIreWpQvqpXkKHCXj7eved
 90Jkv7PkspUWx2dR+JsCHdh+DBFDMkCV32wS+iGU0sH0RqYfeg0byC0jkGShiRRNZUzH
 NtnwJfSJ7qnXpmVFgycW/TpMbUc0iYSrr/a7gLrUqo/RixSNAeXOPtUR59OL8ewy/sFM
 8qVbG30PAgQs3zcajrRdvhcyHrdzDwq72LfHf6/No0BYUJVCu+INGRPdu6R/Mw7nGUzD
 XroA==
X-Gm-Message-State: APjAAAXLzrwCkD8ulAiyE/AszAxK2XnYHiH5M8S3OhUCG8hz4djQLh4O
 2YPW/cTdwT/2DrB+e9wAYLPT/sRsjm6KsRzTlge4DWWzeUTbaORriA/9GaZXBk8T3H94zisVgcu
 vgsahhuJQDsD/RT0=
X-Received: by 2002:adf:e3cd:: with SMTP id k13mr49556707wrm.338.1577483098318; 
 Fri, 27 Dec 2019 13:44:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqzxgoQpV8XoKLA0K4WRE/zn/lbR6vSbizIVxpNXqzU+P3VOjKxSIigPbU+14gPCFUyvPT4MSg==
X-Received: by 2002:adf:e3cd:: with SMTP id k13mr49556692wrm.338.1577483098041; 
 Fri, 27 Dec 2019 13:44:58 -0800 (PST)
Received: from [192.168.1.25] (abayonne-654-1-186-92.w92-134.abo.wanadoo.fr.
 [92.134.161.92])
 by smtp.gmail.com with ESMTPSA id b137sm12867884wme.26.2019.12.27.13.44.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Dec 2019 13:44:57 -0800 (PST)
Subject: Re: [PATCH v2] target/i386: Fix handling of k_gs_base register in
 32-bit mode in gdbstub
To: "Marek Dolata - mkdolata@us.ibm.com" <mkdolata@us.ibm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <62c3c3385b014ce1a6ca07f88973bf95@us.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2defe319-c1ed-922a-c375-6fda1ed68292@redhat.com>
Date: Fri, 27 Dec 2019 22:44:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <62c3c3385b014ce1a6ca07f88973bf95@us.ibm.com>
Content-Language: en-US
X-MC-Unique: 4U83wrRGMaa7sWIYaGfzRg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 Doug Gale <doug16k@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Marek,

Thanks for Cc'ing the maintainers :)

Still the same error occurs:

   Applying: target/i386: Fix handling of k_gs_base register in 32-bit=20
mode in gdbstub
   error: corrupt patch at line 21
   Patch failed at 0001 target/i386: Fix handling of k_gs_base register=20
in 32-bit mode in gdbstub

Please use a version number when you repost a patch, this is patch v2=20
(next should be v3).

On 12/27/19 9:07 PM, Marek Dolata - mkdolata@us.ibm.com wrote:
> Fixes: corrects clobbering of registers appearing after k_gs_base
>=20
> Buglink: https://bugs.launchpad.net/qemu/+bug/1857640
>=20
> Signed-off-by: Marek Dolata <mkdolata@us.ibm.com=20
> <mailto:mkdolata@us.ibm.com>>
>=20
> ---
>=20
> target/i386/gdbstub.c | 4 ++--
>=20
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
>=20
> index aef25b70f1..572ead641c 100644
>=20
> --- a/target/i386/gdbstub.c
>=20
> +++ b/target/i386/gdbstub.c
>=20
> @@ -350,15 +350,15 @@ int x86_cpu_gdb_write_register(CPUState *cs,=20
> uint8_t *mem_buf, int n)
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 env->segs[R_GS].base =3D ldl_p(mem_=
buf);
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 4;
>=20
> -#ifdef TARGET_X86_64
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0 case IDX_SEG_REGS + 8:
>=20
> +#ifdef TARGET_X86_64
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (env->hflags & HF_CS64_MASK) {
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 env->kernelgsbase =3D l=
dq_p(mem_buf);
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 8;
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 env->kernelgsbase =3D ldl_p(mem_buf=
);
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 4;
>=20
> #endif
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 4;
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0case IDX_FP_REGS + 8:
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cpu_set_fpuc(env, ldl_p(mem_buf));
>=20
> --=20
>=20
> 2.24.1
>=20


