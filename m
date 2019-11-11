Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD861C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 17:08:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98AF220818
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 17:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VR1hifC4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98AF220818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUDAe-0003Bs-6j
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 12:08:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49123)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iUD8N-0001JB-Hv
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 12:05:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iUD8K-0007IU-Sb
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 12:05:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58359
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1iUD8K-0007I8-6X
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 12:05:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573491943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KA9DKMVimEe8OjrOxf8MOVaIlrFf1AOioc1lcdJVL1Q=;
 b=VR1hifC4WgY3ZaIn/KSyO6qlH+cp8NnMV8HrLrZAFCMtJO1jEQrivzaTKKqejTC1MDDyj6
 tegfVtHaX6QllBg4xX2JmUnC5XnvNgGTeq81IxmvzvK2hobd5rXy4wy7OSp/uu9enBn0pr
 H2lWxEFQlXLI9He86JrNl3BSL5nciEs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-tjeWhDjPOEKV3JeNd2xxXw-1; Mon, 11 Nov 2019 12:05:40 -0500
Received: by mail-wr1-f70.google.com with SMTP id y3so10276585wrm.12
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2019 09:05:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:content-transfer-encoding:from:mime-version
 :subject:date:message-id:references:cc:in-reply-to:to;
 bh=AMWPqkj/6NDaVSfzlhGevtcgOrANMPQjhHmiJ6rX6kM=;
 b=KCkvRyTtHlmQAVmrk6PWf0XszC4NUbHdYVzkToN+OWt2m45FZjPNIs8oH/botP79vC
 PPMRsGk26dy7JC86G88HYkwmtyGDEHiS0fYqP5CecxQoS/p0qlF3Ay8sBgyg4O12ZR+H
 +PMpid27ucmX/Mw+0pgrgOWIYouwYOHlrmECA4/FoAuaDcrhN4GSs7ciwqbMkkr8zF/I
 hMod85OkrAJoI1YDY4af/46TGZDkuF2760EyJFMx/barRrRQpZFMppD33qss73vUNiev
 rfYO+oNaKenAloc55VdtzJLGk1scxCvlfvU2DTHOvIPS9z8iapLnit0gHKmmaHfRO4u2
 A7JQ==
X-Gm-Message-State: APjAAAW+5qvDAE/6i6FUZWm0veDmTD1Kxyej/ipntSzbwrOfjcQ89wOr
 OHiGCudR1Pmt8Ob6tY32oVr8PeHtb37RYSQ5HK1f7cXQS5+wjLCIPtIp5yg3/Uc+RRa3JL+NYmS
 FWUFRkjlg6+JlE0Q=
X-Received: by 2002:a1c:96d5:: with SMTP id y204mr20639403wmd.63.1573491938990; 
 Mon, 11 Nov 2019 09:05:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqzG6DWq/+foxDNuFxk1WDhKg339zCI/0lHHTohe5/BcEXcLN/xANTRU5FVMTQKdUNlisJSoEw==
X-Received: by 2002:a1c:96d5:: with SMTP id y204mr20639378wmd.63.1573491938739; 
 Mon, 11 Nov 2019 09:05:38 -0800 (PST)
Received: from [192.168.3.122] (p5B0C62A5.dip0.t-ipconnect.de. [91.12.98.165])
 by smtp.gmail.com with ESMTPSA id
 d7sm4925994wrx.11.2019.11.11.09.05.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Nov 2019 09:05:38 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] s390x: Properly fetch the short psw on diag308 subc 0/1
Date: Mon, 11 Nov 2019 18:05:37 +0100
Message-Id: <5B7A4B70-BF58-4760-AD97-4BAB7EDDF01D@redhat.com>
References: <20191111152808.13371-1-frankja@linux.ibm.com>
In-Reply-To: <20191111152808.13371-1-frankja@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>
X-Mailer: iPhone Mail (17A878)
X-MC-Unique: tjeWhDjPOEKV3JeNd2xxXw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, qemu-devel@nongnu.org,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> Am 11.11.2019 um 16:28 schrieb Janosch Frank <frankja@linux.ibm.com>:
>=20
> =EF=BB=BFWe need to actually fetch the cpu mask and set it. As we invert =
the
> short psw indication in the mask, SIE will report a specification
> exception, if it wasn't present in the reset psw.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
> target/s390x/cpu.c | 12 ++++++++++--
> target/s390x/cpu.h |  1 +
> 2 files changed, 11 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index 736a7903e2..40aa42e092 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -76,8 +76,16 @@ static bool s390_cpu_has_work(CPUState *cs)
> static void s390_cpu_load_normal(CPUState *s)
> {
>     S390CPU *cpu =3D S390_CPU(s);
> -    cpu->env.psw.addr =3D ldl_phys(s->as, 4) & PSW_MASK_ESA_ADDR;
> -    cpu->env.psw.mask =3D PSW_MASK_32 | PSW_MASK_64;
> +    uint64_t spsw =3D ldq_phys(s->as, 0);
> +
> +    cpu->env.psw.mask =3D spsw & 0xffffffff80000000UL;

ULL

> +    /*
> +     * Invert short psw indication, so SIE will report a specification
> +     * exception if it was not set.
> +     */

It would be interesting to know how the PSW mask in the PGM old PSW looks l=
ike on LPAR. IOW, =E2=80=9Eyou forgot to set the short indication, here is =
an exception. see, the short indication is set now.=E2=80=9C Sounds weird, =
most probably nobody cares.

> +    cpu->env.psw.mask ^=3D PSW_MASK_SHORTPSW;
> +    cpu->env.psw.addr =3D spsw & 0x7fffffffUL;

Eventually also ULL

> +
>     s390_cpu_set_state(S390_CPU_STATE_OPERATING, cpu);
> }
> #endif
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index 947553386f..2c687185f1 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -261,6 +261,7 @@ extern const struct VMStateDescription vmstate_s390_c=
pu;
> #define PSW_MASK_EXT            0x0100000000000000ULL
> #define PSW_MASK_KEY            0x00F0000000000000ULL
> #define PSW_SHIFT_KEY           52
> +#define PSW_MASK_SHORTPSW    0x0008000000000000ULL
> #define PSW_MASK_MCHECK         0x0004000000000000ULL
> #define PSW_MASK_WAIT           0x0002000000000000ULL
> #define PSW_MASK_PSTATE         0x0001000000000000ULL
> --=20
> 2.20.1
>=20

Looks good to me

Reviewed-by: David Hildenbrand <david@redhat.com>


