Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC9ACA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 08:54:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 741C020679
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 08:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bwXbEUJ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 741C020679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMpvv-00051B-ID
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 04:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49565)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iMpuz-0004Vm-Sr
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 04:53:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iMpux-0006WL-DU
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 04:53:28 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46530
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iMpux-0006WA-9j
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 04:53:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571734406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Teat/O7Thvzjviv6gKgPmC90IP01JvMG/rS8O7GH+8=;
 b=bwXbEUJ0wVPUFe1ZNN/RGA0EYsFzGDHZn/ohL4n9++Z7IafqNy2VuC3rCKk1GaP11RgFUe
 O/mG/lveX/7PG2orJ9iVSwx5Ztp+SDD8bJVlcJ6BsHp0KP1lDlp+bBZ5zeK24UnoBMAXcT
 jsOxzluj4YdjY6yF8X5cC2xzE36gRdE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-ADMBJ88qML6I06wZtXkY0w-1; Tue, 22 Oct 2019 04:53:25 -0400
Received: by mail-wm1-f72.google.com with SMTP id a81so3518204wma.4
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 01:53:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=81ijpT7mXrnoP0yxcW0WPzWKgomsl4GpFfUcpIMV87k=;
 b=QQlzDSSFKO49qW1+5Tf7q17UAnpx6adJIg+gO6NM5U7Oc45mQXcKq8ZCivlaLji4GT
 J9lDACzfhli8IiSfAkiRx73wUpkNedTDw/UkFfCHcQmR4e9uj8onnG6S4lxgXhlMHqcR
 o3rDS7cNcAbBczh/Sqy/cwyPLafKvchUQb6+qxfIp/AsiCgZDFloH8lP+UsJRK6eeHO6
 xmXs4eQvIm3E5L+f6wzd8/8uCIU3pF0VOvtQJ7tE4OSR4RTi3zB3bZanwJzJOXPSXNFc
 C3xWO2GRez5uVDpnCd9AMYas++GNp8cerO9vT9erdHgRVSPn2ZL9/EjyTen9XUek3seE
 BH/w==
X-Gm-Message-State: APjAAAWqt5+Lo3MlRvugEVMMOHDBE6E23eqraFH7akqrXtzCWE3wXYV2
 OKyLkNyR2v3czfT5oTeVxqDcUKMoQC3073jMpKMx5Us4miLs4gTH14vQ3rddXfMy3iqSg+lncp4
 37We66xxKPlGzmFI=
X-Received: by 2002:a5d:638c:: with SMTP id p12mr2139307wru.136.1571734403827; 
 Tue, 22 Oct 2019 01:53:23 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwlIMk5NuX+tnaNYjjOyBBAghKOtcZ/1Ag5UhUryP6rhPBYhrNog9mcrqyCmgJobQsKFqaM0w==
X-Received: by 2002:a5d:638c:: with SMTP id p12mr2139293wru.136.1571734403574; 
 Tue, 22 Oct 2019 01:53:23 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id 79sm26272751wmb.7.2019.10.22.01.53.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2019 01:53:23 -0700 (PDT)
Subject: Re: [PATCH v3 1/4] spapr: move CPU reset after presenter creation
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20191022072246.9200-1-clg@kaod.org>
 <20191022072246.9200-2-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <71a4409c-6dc2-891b-d1c8-b60acbc94919@redhat.com>
Date: Tue, 22 Oct 2019 10:53:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191022072246.9200-2-clg@kaod.org>
Content-Language: en-US
X-MC-Unique: ADMBJ88qML6I06wZtXkY0w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/22/19 9:22 AM, C=C3=A9dric Le Goater wrote:
> spapr_realize_vcpu() is modified to call the CPU reset only after the
> the intc presenter has been created.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>   hw/ppc/spapr_cpu_core.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 3e4302c7d596..992f00da6540 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -234,13 +234,16 @@ static void spapr_realize_vcpu(PowerPCCPU *cpu, Spa=
prMachineState *spapr,
>       cpu_ppc_set_vhyp(cpu, PPC_VIRTUAL_HYPERVISOR(spapr));
>       kvmppc_set_papr(cpu);
>  =20
> -    qemu_register_reset(spapr_cpu_reset, cpu);
> -    spapr_cpu_reset(cpu);
> -
>       if (spapr_irq_cpu_intc_create(spapr, cpu, &local_err) < 0) {
> -        goto error_unregister;
> +        goto error_intc_create;
>       }
>  =20
> +    /*
> +     * FIXME: Hot-plugged CPUs are not reseted. Do it at realize.

Typo: "reset" (past tense of reset is also reset).

> +     */
> +    qemu_register_reset(spapr_cpu_reset, cpu);
> +    spapr_cpu_reset(cpu);
> +
>       if (!sc->pre_3_0_migration) {
>           vmstate_register(NULL, cs->cpu_index, &vmstate_spapr_cpu_state,
>                            cpu->machine_data);
> @@ -248,8 +251,7 @@ static void spapr_realize_vcpu(PowerPCCPU *cpu, Spapr=
MachineState *spapr,
>  =20
>       return;
>  =20
> -error_unregister:
> -    qemu_unregister_reset(spapr_cpu_reset, cpu);
> +error_intc_create:
>       cpu_remove_sync(CPU(cpu));
>   error:
>       error_propagate(errp, local_err);
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


