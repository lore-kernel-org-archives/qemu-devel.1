Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A84FAC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 15:36:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74158206EC
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 15:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GEHfPah3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74158206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igsQ5-0001LB-Ic
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 10:36:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60027)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1igsPR-0000wT-Cf
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 10:35:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1igsPO-0000SV-A3
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 10:35:43 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48951
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1igsPN-0000QY-Rw
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 10:35:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576510540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=naQAMzTQeMRHiC8UMIN0Vmoqttp5dU2010+BrAcB+CE=;
 b=GEHfPah3iOaE6zRXVr6DW2+I2MQWeNd+hu4ZHPGyuoVXxUt4MGRQ598tMD/HrGnIS9mrPY
 e07cirXdCWu1pY1O18f/jHK4K5G5eIl9GaDOTnIEWiPB6ZrWD3+y9pygsorQRMxhEHU62i
 ppcLprszPvdDk+Suh/ksLvp30OGcODQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-eemxLlVWMZyPzMcYm8KMkA-1; Mon, 16 Dec 2019 10:35:39 -0500
Received: by mail-wr1-f72.google.com with SMTP id u18so3892469wrn.11
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 07:35:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OZVYrTrz6Wlv7aL0MnWfnikdlEsLJ+jyxQOgXonjczQ=;
 b=F06lvys+IPCmMIWmH/rdTkdANTH7uL8kwRRz3/isyijDj1Rjv4f1NzwkZdE3T2WE2q
 8GI1WmfqKl7LHT+LspjNdg50D8xpu2jeDw0xvmKel7Ct8aviIEZdwLDNtBIlADm04NSF
 spk1odjrJwbvJNY5NOhc0N5Br4WlspB7d66+72B+eA8eSbXYN6R7TOmM/jbiNlD/eS92
 WQgdNOU5GYdKf2piCAhOjV+4wKTyHQATOwZjjizr2kZNMADgFNI10LOdW8h/Bm3Md4Zw
 cvzP2INcGJm6poNnKdi/4B+lDaDPoUVpYcJ1+Aff0TxOZUk35RMuKATti5yLzmKknGcJ
 KHKw==
X-Gm-Message-State: APjAAAUtFIY6ZkUrs+1SYYQKdGaYxhvCnMPc4YjXFvsVSQux/0CZNBkh
 xBH/nPy5SZlb78q/+q5aKkMp43txYBQfXMKfsuOKpx7tYYQ8WEAw+xhkHs7k6IMKdYXGMcg9jku
 oUc3bRytoccNr2Lg=
X-Received: by 2002:a1c:48c1:: with SMTP id v184mr32152935wma.5.1576510538203; 
 Mon, 16 Dec 2019 07:35:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqzb05ksWBrFOlfBSltAsYcfv20eFgfNDalD8v83utvayh8NRedUNBgSyw/wvFOrKPAGlWIH6Q==
X-Received: by 2002:a1c:48c1:: with SMTP id v184mr32152907wma.5.1576510537989; 
 Mon, 16 Dec 2019 07:35:37 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id a14sm23001647wrx.81.2019.12.16.07.35.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Dec 2019 07:35:37 -0800 (PST)
Subject: Re: [PATCH v3 1/2] cpu: Introduce cpu_class_set_parent_reset()
To: Greg Kurz <groug@kaod.org>, Eduardo Habkost <ehabkost@redhat.com>
References: <157650846660.354886.16810288202617432561.stgit@bahia.lan>
 <157650847239.354886.2782881118916307978.stgit@bahia.lan>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ab343508-179d-5bb8-b7f5-1ba7272175ea@redhat.com>
Date: Mon, 16 Dec 2019 16:35:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <157650847239.354886.2782881118916307978.stgit@bahia.lan>
Content-Language: en-US
X-MC-Unique: eemxLlVWMZyPzMcYm8KMkA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/16/19 4:01 PM, Greg Kurz wrote:
> Similarly to what we already do with qdev, use a helper to overload the
> reset QOM methods of the parent in children classes, for clarity.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Acked-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   hw/core/cpu.c         |    8 ++++++++
>   include/hw/core/cpu.h |    4 ++++
>   2 files changed, 12 insertions(+)
>=20
> diff --git a/hw/core/cpu.c b/hw/core/cpu.c
> index db1a03c6bbb3..fde5fd395b10 100644
> --- a/hw/core/cpu.c
> +++ b/hw/core/cpu.c
> @@ -239,6 +239,14 @@ void cpu_dump_statistics(CPUState *cpu, int flags)
>       }
>   }
>  =20
> +void cpu_class_set_parent_reset(CPUClass *cc,
> +                                void (*child_reset)(CPUState *cpu),
> +                                void (**parent_reset)(CPUState *cpu))
> +{
> +    *parent_reset =3D cc->reset;
> +    cc->reset =3D child_reset;
> +}
> +
>   void cpu_reset(CPUState *cpu)
>   {
>       CPUClass *klass =3D CPU_GET_CLASS(cpu);
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 77c6f0529903..73e9a869a41c 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -1135,6 +1135,10 @@ void cpu_exec_unrealizefn(CPUState *cpu);
>    */
>   bool target_words_bigendian(void);
>  =20
> +void cpu_class_set_parent_reset(CPUClass *cc,
> +                                void (*child_reset)(CPUState *cpu),
> +                                void (**parent_reset)(CPUState *cpu));
> +
>   #ifdef NEED_CPU_H
>  =20
>   #ifdef CONFIG_SOFTMMU
>=20


