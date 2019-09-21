Return-Path: <SRS0=nDBX=XQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49290C49ED7
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 08:53:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14721205F4
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 08:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HDLcJpsq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14721205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBb98-00069m-AU
	for qemu-devel@archiver.kernel.org; Sat, 21 Sep 2019 04:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38026)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iBb7W-0004Qq-5K
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 04:51:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iBb7U-0007EM-V7
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 04:51:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39557
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iBb7U-0007Dt-R1
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 04:51:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1569055915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=XeX+526lzRr2sWL+na/ebeATRLQAEStMv8g4RbJs/C4=;
 b=HDLcJpsqOaucIM9wEFa1bpFOzKoh3zCe4j4hRbxgT3NOy4hxUDRdseU0X6LxeRQ6qIDvJF
 PFmMtDcC1O/kxQ0B0E6xfU8WF8dxuZul4+npqe1fgZJ0uVXCSFDXEw0clxSJIn8mvY6mAS
 eXbwbNpPnVXs98VTk3fmIrx39dyBiT0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-YLbEMWHINLGCcWX6zMpE2Q-1; Sat, 21 Sep 2019 04:51:53 -0400
Received: by mail-wm1-f71.google.com with SMTP id f10so2020320wmh.8
 for <qemu-devel@nongnu.org>; Sat, 21 Sep 2019 01:51:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WkRn+SG1cYnis/sqxhX3jY0ZYklpuxyiiUU/oqqir2c=;
 b=gDxpNaG0H57sP6YAUi9JpbtMwXIzRUXQjJRF2kMvcoYZ5Y6BYF2JUPxmZw6nq0zxTz
 AHWdO59jAqUPassIPKujUZGTZyyjko/x6w557/PGAF25iaVyHjpdzetiw/OsBImyrCJh
 J8jcxY9ayOSxgXkaNeJ7BzylCFC4dVkaKrQqkoKwaTwSk3oQVudbJ+OInBRVY9e29HCM
 Czs9KLM+y1iAyZoSksq7J6azEEyI9QDK8eivSfIXA+0c7cxB65zgp+CbkZuB51DZK1Ry
 toWLMtc6Qw2nxXeHHViOHRJ95YvytiGLkPK6Ozk+xZXXFw+oO76ab0fXeZXJaB2ZO6zR
 GREA==
X-Gm-Message-State: APjAAAXkRVTnOb+iDcXCsMjhvKB0bXZrGiWfcPKoew7LvqBTb0NO7uVb
 L9YN8b3nT1qzykC/JTtKKXVaWOy7mXrQYKkKBUxIgIdx4qTNJUG7G+DC547Z0zzF/E0DzhvsiGf
 HOAQ5KMuS0zEfuiw=
X-Received: by 2002:a1c:454:: with SMTP id 81mr6312393wme.119.1569055912394;
 Sat, 21 Sep 2019 01:51:52 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzYIm56ESdBzOvOJHtaC0JDbGPaOz9dGsjJRBZaqEUuCC7S/E2Ml7+5xZpccEgSWq2cxKLzUw==
X-Received: by 2002:a1c:454:: with SMTP id 81mr6312384wme.119.1569055912242;
 Sat, 21 Sep 2019 01:51:52 -0700 (PDT)
Received: from [192.168.1.40] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id r9sm6391165wra.19.2019.09.21.01.51.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Sep 2019 01:51:51 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] riscv: sifive_u: Add ethernet0 to the aliases node
To: Bin Meng <bmeng.cn@gmail.com>, Alistair Francis
 <Alistair.Francis@wdc.com>, Palmer Dabbelt <palmer@sifive.com>,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <1569044491-7875-1-git-send-email-bmeng.cn@gmail.com>
 <1569044491-7875-2-git-send-email-bmeng.cn@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <e5bb38d0-42a3-f2f6-1b39-78cd79e64df8@redhat.com>
Date: Sat, 21 Sep 2019 10:51:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1569044491-7875-2-git-send-email-bmeng.cn@gmail.com>
Content-Language: en-US
X-MC-Unique: YLbEMWHINLGCcWX6zMpE2Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/21/19 7:41 AM, Bin Meng wrote:
> U-Boot expects this alias to be in place in order to fix up the mac
> address of the ethernet node.
>=20
> This is to keep in sync with Linux kernel commit below:
> https://patchwork.kernel.org/patch/11133033/
>=20
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>=20
> Changes in v2: None
>=20
>  hw/riscv/sifive_u.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 02dd761..1ac51e3 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -270,6 +270,10 @@ static void create_fdt(SiFiveUState *s, const struct=
 MemmapEntry *memmap,
>          s->soc.gem.conf.macaddr.a, ETH_ALEN);
>      qemu_fdt_setprop_cell(fdt, nodename, "#address-cells", 1);
>      qemu_fdt_setprop_cell(fdt, nodename, "#size-cells", 0);
> +
> +    qemu_fdt_add_subnode(fdt, "/aliases");
> +    qemu_fdt_setprop_string(fdt, "/aliases", "ethernet0", nodename);
> +
>      g_free(nodename);
> =20
>      nodename =3D g_strdup_printf("/soc/ethernet@%lx/ethernet-phy@0",
> @@ -297,7 +301,6 @@ static void create_fdt(SiFiveUState *s, const struct =
MemmapEntry *memmap,
>          qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
>      }
> =20
> -    qemu_fdt_add_subnode(fdt, "/aliases");
>      qemu_fdt_setprop_string(fdt, "/aliases", "serial0", nodename);
> =20
>      g_free(nodename);
>=20


