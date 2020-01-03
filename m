Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6723DC2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 16:33:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32B1E222C3
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 16:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B9yCW79T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32B1E222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inPtB-0001fq-92
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 11:33:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43096)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1inPsH-00012w-7P
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 11:32:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1inPsF-00056N-Px
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 11:32:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47990
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1inPsF-00053G-K5
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 11:32:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578069151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q/DVtYN+sSmlpTsOAB9KCiC4eS/HC+/tdWCXyXkqMQU=;
 b=B9yCW79TK4AMciwdL1OJdbpTKKHv9O/QS8gtMZTtFFiyS/fM1VyfiDQZLkwj3bjuAN9JEQ
 fBozkwcOdjXZgELfEibzl7vydN6brm3lYGs+ABup+on74EU2U+8EaSqcfVlVvIZr32aR7B
 GEoNMajsMXfWaXjyLcmLQws4iOLRdkk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-Q80sMYhjMTKuub9agYYKHA-1; Fri, 03 Jan 2020 11:32:27 -0500
Received: by mail-wr1-f70.google.com with SMTP id y7so23357270wrm.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2020 08:32:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tJqk1lUDSTbhLlDXFsBpAnW/QY4RyD4gsgMHE/iSEcg=;
 b=btwNz9Vp2BxbGlMP9mWB/aE2FdNGCW1KtJq3rZ8DQRGwKkApyvRPU9B8bhxH1K2S55
 HqPoQjSFwCQ5kgcPC2fSmRAHoZqSEwyYHQ2156+a6zC7q11NRUEesBROm8B7ZSwimxoX
 Td6oTD+cClZ4a2piY5B+e0JVf2H7935rxtomduaH/fc6tnD8OcbuXyBWcR0FYRQ92uWi
 KO6KrmWNYF9BR8MUqQ6MUpr0B6v8fBJzDVVo2wcJiH1ed2sYMh69ErIg9ORpm8qnwe0J
 WjC52NyxRPF4IB227sgyzyF9+Ht6HZEhj41L4BMMwqDk8Is8aPVhLyBWk0fIZSjLyCLu
 KYoA==
X-Gm-Message-State: APjAAAUsrk77J/POMxGRTD2BWTSAucdAbE1oyt5+BEa9wg1P53qV64rF
 rsKcY8s6Xy8tN8gG4EXlPppXo54GND1Aocfyfd2Sdo0BvEvHGe3Uk0/dxEri1qHYP1LVfCWyIqo
 9glRIVxolzq9hlHM=
X-Received: by 2002:a7b:cb97:: with SMTP id m23mr20146513wmi.37.1578069146256; 
 Fri, 03 Jan 2020 08:32:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqxq98MYAscfAnCmcVkUtAER8NIrHYHGozVq/Ck8UT6Nrz7mVmBp15ae7t4Lm4XHbsG+qFqOEw==
X-Received: by 2002:a7b:cb97:: with SMTP id m23mr20146496wmi.37.1578069146036; 
 Fri, 03 Jan 2020 08:32:26 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id j2sm12930047wmk.23.2020.01.03.08.32.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2020 08:32:25 -0800 (PST)
Subject: Re: [PATCH v6 09/21] libqos: split qos-test and libqos makefile vars
To: "Oleinik, Alexander" <alxndr@bu.edu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20191129213424.6290-1-alxndr@bu.edu>
 <20191129213424.6290-10-alxndr@bu.edu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a491b772-a990-128b-8d25-e73666c7c269@redhat.com>
Date: Fri, 3 Jan 2020 17:32:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191129213424.6290-10-alxndr@bu.edu>
Content-Language: en-US
X-MC-Unique: Q80sMYhjMTKuub9agYYKHA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/29/19 10:34 PM, Oleinik, Alexander wrote:
> Most qos-related objects were specified in the qos-test-obj-y variable.
> qos-test-obj-y also included qos-test.o which defines a main().
> This made it difficult to repurpose qos-test-obj-y to link anything
> beside tests/qos-test against libqos. This change separates objects that
> are libqos-specific and ones that are qos-test specific into different
> variables.
>=20
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

> ---
>   tests/Makefile.include | 71 +++++++++++++++++++++---------------------
>   1 file changed, 36 insertions(+), 35 deletions(-)
>=20
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 3669fd1dc3..031240df4b 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -703,52 +703,53 @@ tests/test-crypto-block$(EXESUF): tests/test-crypto=
-block.o $(test-crypto-obj-y)
>  =20
>   libqgraph-obj-y =3D tests/libqos/qgraph.o
>  =20
> -libqos-obj-y =3D $(libqgraph-obj-y) tests/libqos/pci.o tests/libqos/fw_c=
fg.o
> -libqos-obj-y +=3D tests/libqos/malloc.o
> -libqos-obj-y +=3D tests/libqos/libqos.o
> -libqos-spapr-obj-y =3D $(libqos-obj-y) tests/libqos/malloc-spapr.o
> +libqos-core-obj-y =3D $(libqgraph-obj-y) tests/libqos/pci.o tests/libqos=
/fw_cfg.o
> +libqos-core-obj-y +=3D tests/libqos/malloc.o
> +libqos-core-obj-y +=3D tests/libqos/libqos.o
> +libqos-spapr-obj-y =3D $(libqos-core-obj-y) tests/libqos/malloc-spapr.o
>   libqos-spapr-obj-y +=3D tests/libqos/libqos-spapr.o
>   libqos-spapr-obj-y +=3D tests/libqos/rtas.o
>   libqos-spapr-obj-y +=3D tests/libqos/pci-spapr.o
> -libqos-pc-obj-y =3D $(libqos-obj-y) tests/libqos/pci-pc.o
> +libqos-pc-obj-y =3D $(libqos-core-obj-y) tests/libqos/pci-pc.o
>   libqos-pc-obj-y +=3D tests/libqos/malloc-pc.o tests/libqos/libqos-pc.o
>   libqos-pc-obj-y +=3D tests/libqos/ahci.o
>   libqos-usb-obj-y =3D $(libqos-spapr-obj-y) $(libqos-pc-obj-y) tests/lib=
qos/usb.o
>  =20
>   # Devices
> -qos-test-obj-y =3D tests/qos-test.o $(libqgraph-obj-y)
> -qos-test-obj-y +=3D $(libqos-pc-obj-y) $(libqos-spapr-obj-y)
> -qos-test-obj-y +=3D tests/libqos/e1000e.o
> -qos-test-obj-y +=3D tests/libqos/i2c.o
> -qos-test-obj-y +=3D tests/libqos/i2c-imx.o
> -qos-test-obj-y +=3D tests/libqos/i2c-omap.o
> -qos-test-obj-y +=3D tests/libqos/sdhci.o
> -qos-test-obj-y +=3D tests/libqos/tpci200.o
> -qos-test-obj-y +=3D tests/libqos/virtio.o
> -qos-test-obj-$(CONFIG_VIRTFS) +=3D tests/libqos/virtio-9p.o
> -qos-test-obj-y +=3D tests/libqos/virtio-balloon.o
> -qos-test-obj-y +=3D tests/libqos/virtio-blk.o
> -qos-test-obj-y +=3D tests/libqos/virtio-mmio.o
> -qos-test-obj-y +=3D tests/libqos/virtio-net.o
> -qos-test-obj-y +=3D tests/libqos/virtio-pci.o
> -qos-test-obj-y +=3D tests/libqos/virtio-pci-modern.o
> -qos-test-obj-y +=3D tests/libqos/virtio-rng.o
> -qos-test-obj-y +=3D tests/libqos/virtio-scsi.o
> -qos-test-obj-y +=3D tests/libqos/virtio-serial.o
> +libqos-obj-y =3D $(libqgraph-obj-y)
> +libqos-obj-y +=3D $(libqos-pc-obj-y) $(libqos-spapr-obj-y)
> +libqos-obj-y +=3D tests/libqos/e1000e.o
> +libqos-obj-y +=3D tests/libqos/i2c.o
> +libqos-obj-y +=3D tests/libqos/i2c-imx.o
> +libqos-obj-y +=3D tests/libqos/i2c-omap.o
> +libqos-obj-y +=3D tests/libqos/sdhci.o
> +libqos-obj-y +=3D tests/libqos/tpci200.o
> +libqos-obj-y +=3D tests/libqos/virtio.o
> +libqos-obj-$(CONFIG_VIRTFS) +=3D tests/libqos/virtio-9p.o
> +libqos-obj-y +=3D tests/libqos/virtio-balloon.o
> +libqos-obj-y +=3D tests/libqos/virtio-blk.o
> +libqos-obj-y +=3D tests/libqos/virtio-mmio.o
> +libqos-obj-y +=3D tests/libqos/virtio-net.o
> +libqos-obj-y +=3D tests/libqos/virtio-pci.o
> +libqos-obj-y +=3D tests/libqos/virtio-pci-modern.o
> +libqos-obj-y +=3D tests/libqos/virtio-rng.o
> +libqos-obj-y +=3D tests/libqos/virtio-scsi.o
> +libqos-obj-y +=3D tests/libqos/virtio-serial.o
>  =20
>   # Machines
> -qos-test-obj-y +=3D tests/libqos/aarch64-xlnx-zcu102-machine.o
> -qos-test-obj-y +=3D tests/libqos/arm-imx25-pdk-machine.o
> -qos-test-obj-y +=3D tests/libqos/arm-n800-machine.o
> -qos-test-obj-y +=3D tests/libqos/arm-raspi2-machine.o
> -qos-test-obj-y +=3D tests/libqos/arm-sabrelite-machine.o
> -qos-test-obj-y +=3D tests/libqos/arm-smdkc210-machine.o
> -qos-test-obj-y +=3D tests/libqos/arm-virt-machine.o
> -qos-test-obj-y +=3D tests/libqos/arm-xilinx-zynq-a9-machine.o
> -qos-test-obj-y +=3D tests/libqos/ppc64_pseries-machine.o
> -qos-test-obj-y +=3D tests/libqos/x86_64_pc-machine.o
> +libqos-obj-y +=3D tests/libqos/aarch64-xlnx-zcu102-machine.o
> +libqos-obj-y +=3D tests/libqos/arm-imx25-pdk-machine.o
> +libqos-obj-y +=3D tests/libqos/arm-n800-machine.o
> +libqos-obj-y +=3D tests/libqos/arm-raspi2-machine.o
> +libqos-obj-y +=3D tests/libqos/arm-sabrelite-machine.o
> +libqos-obj-y +=3D tests/libqos/arm-smdkc210-machine.o
> +libqos-obj-y +=3D tests/libqos/arm-virt-machine.o
> +libqos-obj-y +=3D tests/libqos/arm-xilinx-zynq-a9-machine.o
> +libqos-obj-y +=3D tests/libqos/ppc64_pseries-machine.o
> +libqos-obj-y +=3D tests/libqos/x86_64_pc-machine.o
>  =20
>   # Tests
> +qos-test-obj-y =3D tests/qos-test.o
>   qos-test-obj-y +=3D tests/ac97-test.o
>   qos-test-obj-y +=3D tests/ds1338-test.o
>   qos-test-obj-y +=3D tests/e1000-test.o
> @@ -780,7 +781,7 @@ check-unit-y +=3D tests/test-qgraph$(EXESUF)
>   tests/test-qgraph$(EXESUF): tests/test-qgraph.o $(libqgraph-obj-y)
>  =20
>   check-qtest-generic-y +=3D tests/qos-test$(EXESUF)
> -tests/qos-test$(EXESUF): $(qos-test-obj-y)
> +tests/qos-test$(EXESUF): $(qos-test-obj-y) $(libqos-obj-y)
>  =20
>   tests/qmp-test$(EXESUF): tests/qmp-test.o
>   tests/qmp-cmd-test$(EXESUF): tests/qmp-cmd-test.o
>=20


