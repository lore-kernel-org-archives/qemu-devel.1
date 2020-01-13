Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFA3C33CA9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 17:08:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E57062084D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 17:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DrFHhbyg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E57062084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir3Ce-0000yz-T7
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 12:08:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32920)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ir39o-0004yW-SW
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 12:05:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ir39l-0004lr-Hs
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 12:05:38 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41188
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ir39l-0004jv-7W
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 12:05:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578935136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8akm5y2JIK+SIsf38zIVKEGwGAeiQntPbaAnvyKf3TU=;
 b=DrFHhbygzS0OCRSTDCEzkJvfDaOKL4UpHgnfZ8p6sEQr2A+SWRA/ItALTtxw3uXuoiKTcJ
 8wHWwLkzzd8Ahp4/Jptg+cszrOyRszAAhQW44lD+HxOEvAU1QrtzaK5QlHQf+rfX3+sw+v
 P7j+COTchXvY9JUJpWWhLSXaqcBYYPI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-C3HcSvHDPxO3xxvuBWX8Ww-1; Mon, 13 Jan 2020 12:05:34 -0500
Received: by mail-wm1-f72.google.com with SMTP id g26so1386388wmk.6
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 09:05:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3eLu5EnOB+WxW6gFtG3qisQpnTYPKy0enAl1ThZM8Wc=;
 b=k8dPKC4VWaTyrFA5R+GAdt6KqL0CaUVyroc7HErKzLpoDiO6ctT9DJLAiQC91BtGX3
 yzcbB1jbiLdHKxX2GR5dnfi5RNVZRNRh8SfyB1YExw3LUKjGSW5AZZY1M4H33+iIQhpU
 EvNt6Mt1V4qM/gdSTFWk6wIa3YSGcXbAwCINr6esqdaeowfPj1kOw50AmjBj7YWVm1Z+
 xAvgWwbsNgcKORPtDusSiP84cFPyFmJW5lG4KxgL3vNjAtpfSaYzpn3u3xFpRIQ6paQQ
 6bY6eM89wpT24yXqb4jrELcDqeFX8FzhsEfBjVJgL/oMfVoN23iwNGELoHtraYeB883z
 pcrA==
X-Gm-Message-State: APjAAAUqxfpM2QfUx2oTZP6zu3oBGJadi2gpJOas2MY8TA+fLRkr694F
 0VuHeH0YHaVBqiuO+UzAPHqi8D5r10YkGp5/8zM7OwFAGZGZ9jpfvuBD0EzLs20kOMQvt5F9fDC
 YOZJvEypWKBlWRw0=
X-Received: by 2002:a1c:7203:: with SMTP id n3mr20531533wmc.119.1578935133678; 
 Mon, 13 Jan 2020 09:05:33 -0800 (PST)
X-Google-Smtp-Source: APXvYqxYMsarVlfIbB0za7AuFgeL+t2Vna2+WiFKEyyrZUPs0zlssOQLalmn50iARH8XI8jyd5eiFw==
X-Received: by 2002:a1c:7203:: with SMTP id n3mr20531490wmc.119.1578935133375; 
 Mon, 13 Jan 2020 09:05:33 -0800 (PST)
Received: from [192.168.1.24] (lfbn-mon-1-1519-115.w92-167.abo.wanadoo.fr.
 [92.167.83.115])
 by smtp.gmail.com with ESMTPSA id h8sm16523814wrx.63.2020.01.13.09.05.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jan 2020 09:05:32 -0800 (PST)
Subject: Re: [PATCH] arm/gicv3: update virtual irq state after IAR register
 read
To: Jeff Kubascik <jeff.kubascik@dornerworks.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200113154607.97032-1-jeff.kubascik@dornerworks.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7260d4ef-7d51-44c3-95d0-2c88c6e2eb63@redhat.com>
Date: Mon, 13 Jan 2020 18:05:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200113154607.97032-1-jeff.kubascik@dornerworks.com>
Content-Language: en-US
X-MC-Unique: C3HcSvHDPxO3xxvuBWX8Ww-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Stewart Hildebrand <Stewart.Hildebrand@dornerworks.com>,
 Jarvis Roach <Jarvis.Roach@dornerworks.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/13/20 4:46 PM, Jeff Kubascik wrote:
> The IAR0/IAR1 register is used to acknowledge an interrupt - a read of th=
e
> register activates the highest priority pending interrupt and provides it=
s
> interrupt ID. Activating an interrupt can change the CPU's virtual interr=
upt
> state - this change makes sure the virtual irq state is updated.
>=20
> Signed-off-by: Jeff Kubascik <jeff.kubascik@dornerworks.com>
> ---
> Hello,
>=20
> I am using the ARMv8 version of QEMU configured with the gicv3 interrupt
> controller to run the Xen hypervisor with RTEMS as a guest VM (AArch32). =
I
> have noticed that when Xen injects a virtual irq to the guest VM, the gue=
st
> gets stuck in the interrupt handler.
>=20
> The guest's interrupt handler does the following in order:
>    - Reads IAR1 to acknowledge the interrupt and get the INTID
>    - Unmasks interrupts by clearing the I bit in the CPSR register
>    - Dispatches the interrupt to the appropriate driver
>    - Restores the I bit in the CPSR state
>    - Writes the INTID to EOIR1 to drop priority and deactivate the interr=
upt
>=20
> However, when the I bit was cleared, QEMU immediately raised the same
> virtual interrupt again. This process repeated itself indefinitely.
>=20
> The read of the IAR1 register should activate the interrupt and prevent i=
t
> from firing again. However, the gicv3 device code wasn't updating the
> irq_line_state, so the CPU_INTERRUPT_VIRQ flag remained set. Therefore, w=
hen
> I bit was cleared, the CPU immediately switched to the exception handler.
>=20
> I have tested this patch, and it works for Xen with both an AArch64 Linux
> guest and an AArch32 RTEMS guest.
>=20
> Sincerely,
> Jeff Kubascik
> ---
>   hw/intc/arm_gicv3_cpuif.c | 3 +++
>   1 file changed, 3 insertions(+)
>=20
> diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
> index a254b0ce87..08e000e33c 100644
> --- a/hw/intc/arm_gicv3_cpuif.c
> +++ b/hw/intc/arm_gicv3_cpuif.c
> @@ -664,6 +664,9 @@ static uint64_t icv_iar_read(CPUARMState *env, const =
ARMCPRegInfo *ri)
>  =20
>       trace_gicv3_icv_iar_read(ri->crm =3D=3D 8 ? 0 : 1,
>                                gicv3_redist_affid(cs), intid);
> +
> +    gicv3_cpuif_virt_update(cs);
> +
>       return intid;
>   }
>  =20
>=20

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>


