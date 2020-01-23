Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63B8C33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 07:53:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71CC024655
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 07:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MgZRQOJY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71CC024655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuXJN-0002a5-A0
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 02:53:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46211)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iuXFf-00064e-2s
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:50:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iuXFd-0004kT-TN
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:50:07 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51010
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1iuXFd-0004j6-PO
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:50:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579765805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mKqx2YPb53jH1em0A3pwg7wtWGyVWSkU9wtcIYmfLcY=;
 b=MgZRQOJYQ+rO0OxjuQhLS2lb6N8R07XQaRHB8pnoHrwuJeMPS/4l57xFcsLlmh4wkFphpm
 1FPc9MEjSphEfbGNkk6gzEV4HByxon6KFH6NdVuw501UrLFlYyeyqZm1/QGIFkm9luezdJ
 mfb5M67ZuMguVculmfQ9uYy/ZBhICgQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-ygUhgGKjMcetBbTusnFDtg-1; Thu, 23 Jan 2020 02:50:02 -0500
Received: by mail-wm1-f70.google.com with SMTP id t17so263550wmi.7
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 23:50:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:content-transfer-encoding:from:mime-version
 :subject:date:message-id:references:cc:in-reply-to:to;
 bh=+2d4PZbdq/8DFiz/Cd6rj1VjCrL1MHH7Pkn6aeH3PTQ=;
 b=IEPEvyiLomqMi1+pF85PQDYdHceKY8EZCLR8o+Vs+SO7l3p2HtrmFsO/FVa8RwZn9A
 y6Z39aUJ9wU2MdgXsk+wu/NI0tg7ESm3uw1LFm5e8zdGLCbEbMR/EPPtrRF+DlmV50wX
 XnXgclFLMD9EiyCM/sd4pidE9teM1cjQR7mC1nFmpRTjQWshff95W5PYZlzxz3jIZQ8r
 hQ/2PmxV2NXjW3xXW+hwfoFEL8R2Tb3aJOGl8aee3tmL2YccZnjUPF+BfMWRkHXjisvL
 g3dfAqK5Wj9SzWtpzwURKi2c5JRvzMJZItNzLPFxk0NmwHL3cSoQtHSTFRNjNY4ALWhj
 C3mg==
X-Gm-Message-State: APjAAAUhUbVw4mhw/rzO9fgevrkWQ5Iuse0mE2neILVLVa+SDxeCLvb3
 y/DFqcQ2iJAlMjFsiKGcW5ey2AHdpchSKb1On7ibUjVFWp7erq3SlNmbWUW6T8RHNPuQ4Zuo3EZ
 r4RgFzeiwThT0AbA=
X-Received: by 2002:a05:600c:21c6:: with SMTP id
 x6mr2658374wmj.177.1579765801450; 
 Wed, 22 Jan 2020 23:50:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqxzZYZe2qZaI3mhEQF4uVOERgVKuYmOU9vBO4dbymGb5wQIgwTLZZRUQVcOchOaBItj7a2NLQ==
X-Received: by 2002:a05:600c:21c6:: with SMTP id
 x6mr2658349wmj.177.1579765801224; 
 Wed, 22 Jan 2020 23:50:01 -0800 (PST)
Received: from [192.168.3.122] (p5B0C685B.dip0.t-ipconnect.de. [91.12.104.91])
 by smtp.gmail.com with ESMTPSA id
 d10sm1971979wrw.64.2020.01.22.23.50.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jan 2020 23:50:00 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] target/s390x/translate: Do not leak stack address in
 translate_one()
Date: Thu, 23 Jan 2020 08:49:59 +0100
Message-Id: <12E45A4A-BACA-4CEB-98F4-B346FE2CC317@redhat.com>
References: <20200123070533.19699-1-thuth@redhat.com>
In-Reply-To: <20200123070533.19699-1-thuth@redhat.com>
To: Thomas Huth <thuth@redhat.com>
X-Mailer: iPhone Mail (17C54)
X-MC-Unique: ygUhgGKjMcetBbTusnFDtg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> Am 23.01.2020 um 08:05 schrieb Thomas Huth <thuth@redhat.com>:
>=20
> =EF=BB=BFThe code in translate_one() leaks a stack address via "s->field"=
 parameter:
>=20
> static DisasJumpType translate_one(CPUS390XState *env, DisasContext *s)
> {
>     DisasJumpType ret =3D DISAS_NEXT;
>     DisasFields f;
>     [...]
>     s->fields =3D &f;
>     [...]
>     return ret;
> }
>=20
> It's currently harmless since the caller does not seem to use "fields"
> anymore, but let's better play safe (and please static code analyzers)
> by setting the fields back to NULL before returning.
>=20
> Buglink: https://bugs.launchpad.net/qemu/+bug/1661815
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: David Hildenbrand <david@redhat.com>

> ---
> target/s390x/translate.c | 2 ++
> 1 file changed, 2 insertions(+)
>=20
> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index 4292bb0dd0..9122fb36da 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -6435,6 +6435,8 @@ static DisasJumpType translate_one(CPUS390XState *e=
nv, DisasContext *s)
>     }
> #endif
>=20
> +    s->fields =3D NULL;
> +
>     /* Advance to the next instruction.  */
>     s->base.pc_next =3D s->pc_tmp;
>     return ret;
> --=20
> 2.18.1
>=20


