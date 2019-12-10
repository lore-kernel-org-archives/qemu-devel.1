Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9E9C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 07:47:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6520B20726
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 07:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iFBZitUZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6520B20726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieaEh-00010j-HI
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 02:47:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50636)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ieaE0-0000Or-81
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 02:46:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ieaDz-0004Ky-9A
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 02:46:28 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28367
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ieaDz-0004Km-5W
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 02:46:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575963986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QQ25A+0pF6nBtpKg+xD9aL/MQYr2cTEedC/jGQsZ8+s=;
 b=iFBZitUZRaSRHQuYExnUinAX2K7emYMHRmNeZ9Hr9I/LL8EUoaCyp3eziR2LdUkNr6S7CZ
 yzdvZ3XULuQybfTumpr54l2ZuWqOw6FSgUX5+OPyKEnpoCsirTkUUN87IAnAcsAxOAITzp
 lCTmMxmHsy7st1IaewKF6TW5KIqZsec=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-ithDc0n9MNCoT2odDZWUFg-1; Tue, 10 Dec 2019 02:46:25 -0500
Received: by mail-wr1-f72.google.com with SMTP id h30so8598276wrh.5
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 23:46:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uGM1ba9buYPlDv6UNhIOch/jwXPlXBPyZOgkBtSLCUc=;
 b=lPp32K8CTiV/JXYnvJmI+j9V31K8XqaG474OHoFIG1Ul0Fnz3LrLZJhjma4EKzPLae
 /i33OtBdyBcPcvKhlPMhklIipE+K8WS6PrvnL9pHQ6EX/XFLAbQZhB+a6E+AX9CP+EKe
 IWXi7TqlAmmsCY8mdHbPBOmWo34uUWDRh5DJyhMPynj1bGYgOYnYVzq5EIWgVVFh16rV
 r5CpC6zt+psi9/o0OfMjMoXaFRAWzpKFaAGBFB4wqNKq1bCq0OrWcBoIG9T0TyKp7MEJ
 O3CZzezjuTMBBPQ9L+OzCenA4HlGP49Y4jyxTpob3z2ulaO100I/OD0nsCJeukWUJMBI
 UGdQ==
X-Gm-Message-State: APjAAAXva9qZChUmVYG4Y46v7UvaiP/CfrdyDx8QJvGLyQei+bZK9WSQ
 NLNuXX7VPZASUCV/VI2eSLdqlJd0Ubt5IQl2MTvawc9JAdi2JyCxy/l39HVEw7d71AKDmb+p5if
 gwwfY4J50Tn2IZ1E=
X-Received: by 2002:adf:fe90:: with SMTP id l16mr1573601wrr.265.1575963983867; 
 Mon, 09 Dec 2019 23:46:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqyPqb4pu90PhO5DPn7WRh8fYb9z0Xkfu9+f6MI0m2F8V0HAHpepGctWm9QUthFMsSE4Y16dnA==
X-Received: by 2002:adf:fe90:: with SMTP id l16mr1573584wrr.265.1575963983687; 
 Mon, 09 Dec 2019 23:46:23 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id a16sm2286767wrt.37.2019.12.09.23.46.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2019 23:46:23 -0800 (PST)
Subject: Re: [PATCH] riscv/sifive_u: fix a memory leak in soc_realize()
To: pannengyuan@huawei.com, palmer@dabbelt.com, Alistair.Francis@wdc.com,
 sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de
References: <1575962077-28800-1-git-send-email-pannengyuan@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <eed2a144-0253-8435-6e81-991f71acc602@redhat.com>
Date: Tue, 10 Dec 2019 08:46:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1575962077-28800-1-git-send-email-pannengyuan@huawei.com>
Content-Language: en-US
X-MC-Unique: ithDc0n9MNCoT2odDZWUFg-1
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
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/10/19 8:14 AM, pannengyuan@huawei.com wrote:
> From: Pan Nengyuan <pannengyuan@huawei.com>
>=20
> Fix a minor memory leak in riscv_sifive_u_soc_realize()
>=20
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> ---
>   hw/riscv/sifive_u.c | 1 +
>   1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 0140e95..0e12b3c 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -542,6 +542,7 @@ static void riscv_sifive_u_soc_realize(DeviceState *d=
ev, Error **errp)
>           SIFIVE_U_PLIC_CONTEXT_BASE,
>           SIFIVE_U_PLIC_CONTEXT_STRIDE,
>           memmap[SIFIVE_U_PLIC].size);
> +    g_free(plic_hart_config);
>       sifive_uart_create(system_memory, memmap[SIFIVE_U_UART0].base,
>           serial_hd(0), qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_U_UART0_=
IRQ));
>       sifive_uart_create(system_memory, memmap[SIFIVE_U_UART1].base,
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


