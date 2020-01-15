Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844BAC32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 17:05:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 548272077B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 17:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bxPSgiX0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 548272077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irm78-0004Kt-0j
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 12:05:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40907)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1irm3S-0000Oi-Gr
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 12:02:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1irm3P-0000VI-Eo
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 12:02:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57619
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1irm3P-0000UZ-8i
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 12:02:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579107721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U5paBSLchFHHXW+J/DcGuJqZGvvDHAZONPXpbu3DorA=;
 b=bxPSgiX07sRSWsU4tIs6TxRA0vYMsciAag+VwsS0gr791lR0KUnz84CHOFpQClLDOoQFH8
 ZCEMVt78SIf4j9XMXTQkUOqC1DIfuTZYJ/ozXUeQ7bbbGIeGXHgtBmcyUktbQr1v9RBUcv
 HMqwPj8h1yFstgZbR9sLmUu2NNQ/WnI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-BiPX80OMMrmmpU4xAv-0mw-1; Wed, 15 Jan 2020 12:01:56 -0500
Received: by mail-wr1-f69.google.com with SMTP id f15so8296058wrr.2
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 09:01:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LhWMIVC5oRNbmAyTFCvbEV7dT3PSMSbntTTT8hLVXwA=;
 b=IMTmrPHEr4JHN9dIaQY9l0LxN6E4jIdHaZLJ0342CkQuNyXrnJuwE7Z8Xcy6Iz7jC6
 YctG0eZpRrUjuL5LgwoGn9zXTTnKqMfNBEHmqQHpZYMpHVTqQzw7UAxkP9jpa6YyOH4H
 EEQWGkJGhHcfWKMTv4mL5en8wPSRmVuBSSDCGyOGVhUNZF2MJxoYMrjWs9RxTIru1nyg
 4iLrpBC1tYlmRBAgx2cqAnEFe+B24L3+KAm1sJYQC/ePBnm2tnyyTuyoVqRU50ke/H7t
 xXk1dy3u/PlCbhyW43AyNrizYQZv6yJq6PfOccY3q4n38TI1OZ7/9GeatEuJd5ULYhga
 SQJA==
X-Gm-Message-State: APjAAAWOzgLkB8k1+XGBkUcgTpFJOl+mM1yVXWEORTCJx9SxJiQIYjCc
 106fYNFc5KKyQUg46gwXQM3rImLTONLfBOftArmWePfzSA3uA2k3QZBbHaR/DR1CO5TIWrXFDNZ
 ocGe+LYAymhxaDKw=
X-Received: by 2002:a1c:2187:: with SMTP id h129mr918006wmh.44.1579107715235; 
 Wed, 15 Jan 2020 09:01:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqy9X4eu+SEDuSfFvllwB9jiXKj1l8I19x9fC7npeLI6pHmynDcB3EE8HE7+TO7ExwqbyDJH3w==
X-Received: by 2002:a1c:2187:: with SMTP id h129mr917986wmh.44.1579107715040; 
 Wed, 15 Jan 2020 09:01:55 -0800 (PST)
Received: from [192.168.1.24] (lfbn-mon-1-1519-115.w92-167.abo.wanadoo.fr.
 [92.167.83.115])
 by smtp.gmail.com with ESMTPSA id u18sm24967405wrt.26.2020.01.15.09.01.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2020 09:01:54 -0800 (PST)
Subject: Re: [PATCH v2 70/86] ppc:virtex_ml507: remove unused arguments
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-71-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4e20ed9b-5704-8693-f747-7ceb1752b679@redhat.com>
Date: Wed, 15 Jan 2020 18:01:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1579100861-73692-71-git-send-email-imammedo@redhat.com>
Content-Language: en-US
X-MC-Unique: BiPX80OMMrmmpU4xAv-0mw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: edgar.iglesias@gmail.com, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/15/20 4:07 PM, Igor Mammedov wrote:
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> CC: david@gibson.dropbear.id.au
> CC: qemu-ppc@nongnu.org
> CC: edgar.iglesias@gmail.com
> ---
>   hw/ppc/virtex_ml507.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
> index 6862552..651d8db 100644
> --- a/hw/ppc/virtex_ml507.c
> +++ b/hw/ppc/virtex_ml507.c
> @@ -89,10 +89,7 @@ static void mmubooke_create_initial_mapping(CPUPPCStat=
e *env,
>       tlb->PID =3D 0;
>   }
>  =20
> -static PowerPCCPU *ppc440_init_xilinx(ram_addr_t *ram_size,
> -                                      int do_init,
> -                                      const char *cpu_type,
> -                                      uint32_t sysclk)
> +static PowerPCCPU *ppc440_init_xilinx(const char *cpu_type, uint32_t sys=
clk)
>   {
>       PowerPCCPU *cpu;
>       CPUPPCState *env;
> @@ -213,7 +210,7 @@ static void virtex_init(MachineState *machine)
>       int i;
>  =20
>       /* init CPUs */
> -    cpu =3D ppc440_init_xilinx(&ram_size, 1, machine->cpu_type, 40000000=
0);
> +    cpu =3D ppc440_init_xilinx(machine->cpu_type, 400000000);
>       env =3D &cpu->env;
>  =20
>       if (env->mmu_model !=3D POWERPC_MMU_BOOKE) {
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


