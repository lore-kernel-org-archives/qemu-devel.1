Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E7FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 11:57:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 951C920663
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 11:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="guyzqjAy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 951C920663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdYD2-0002Kn-PN
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 07:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdYC3-0001Ge-9j
 for qemu-devel@nongnu.org; Tue, 26 May 2020 07:56:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21152
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdYC2-0005fF-FO
 for qemu-devel@nongnu.org; Tue, 26 May 2020 07:56:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590494185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qDiKNskY0Xk6GNZAad3n84krLKJiT2g8YZ2uMYr9HvI=;
 b=guyzqjAy/hwun533FGBbiChiEffPiIUkIRwMp9bww8lNJDHZPloSSrkp1JrhdSiTqNhQr1
 IFkCAg2knyYc8n47TTajPgqPyrUidZ7NBUlIIom76w2OUJ8wWs6oAk7ptetiAHUqYrxWqn
 GD3SI2fhnoqTwNMWoPJo3p0UV3XghCc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-IroX5K_0Pausnge40rtJMw-1; Tue, 26 May 2020 07:56:24 -0400
X-MC-Unique: IroX5K_0Pausnge40rtJMw-1
Received: by mail-ed1-f71.google.com with SMTP id bm11so8788605edb.8
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 04:56:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=qDiKNskY0Xk6GNZAad3n84krLKJiT2g8YZ2uMYr9HvI=;
 b=NTH/8flzDpWF9CDTLK+7QjjolqQ+Hyqlwbtbt3Kvx5DVV3D1Jy7EoLW4131PfAphDx
 akYddBvt2sbtMU1YlR5Knjl/O+RKMo4mDRXi8s7wEUkm4//GH/LB2S/pltPnQ0ju/ycm
 zZsLBCdqP9uoUK/lTEz7khYu4eb4EQwh5L5wdVSHYT7mCqWZrEIr6EXsn+EiZH/awhS1
 4IY2fixO132v9nnd+SPWE9VP8jry/FWOiL4vQIQqB+U5+jshPWx2eN1iiLK5VtSWMBq+
 Tk0QiAbZpUlz51QlJJzf9y5L/4HbaF0Bg08Jf3yUtyTloGZ9x1alO/Bgmx86RZQMA8WU
 lOwQ==
X-Gm-Message-State: AOAM531Kcfpt7pwkXHTXndckgifguIYo8SPrqWPK1U5z8QFtNJVrn0uC
 xTUmZ5gQKuBiDljytGrzzJvOKqw+aZoAV7PQlqq+dM5a8YFLLCUZndsHUPqEZviAY0exI87mQ2a
 srCQkNKMK5nq7aDo=
X-Received: by 2002:a17:906:8d0:: with SMTP id
 o16mr817201eje.196.1590494182552; 
 Tue, 26 May 2020 04:56:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzX3e2BVqkkOoK0isDrM7iUxNO0/FW9C2FPvKMwjnGwEzyiTWNWqZxWDu9hUPnejZ7+USczEA==
X-Received: by 2002:a17:906:8d0:: with SMTP id
 o16mr817189eje.196.1590494182385; 
 Tue, 26 May 2020 04:56:22 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id si16sm18000562ejb.101.2020.05.26.04.56.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2020 04:56:21 -0700 (PDT)
Subject: Re: [PATCH 13/55] hw/ppc: Eliminate two superfluous QOM casts
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200519145551.22836-1-armbru@redhat.com>
 <20200519145551.22836-14-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <2f0fc6d2-c74b-e7f1-6021-73222571acd6@redhat.com>
Date: Tue, 26 May 2020 13:56:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200519145551.22836-14-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:19:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/19/20 4:55 PM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/ppc/mac_newworld.c | 4 ++--
>  hw/ppc/mac_oldworld.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
> index 69281d7834..2d069dcc59 100644
> --- a/hw/ppc/mac_newworld.c
> +++ b/hw/ppc/mac_newworld.c
> @@ -122,7 +122,7 @@ static void ppc_core99_init(MachineState *machine)
>      long kernel_size, initrd_size;
>      UNINHostState *uninorth_pci;
>      PCIBus *pci_bus;
> -    NewWorldMacIOState *macio;
> +    PCIDevice *macio;
>      bool has_pmu, has_adb;
>      MACIOIDEState *macio_ide;
>      BusState *adb_bus;
> @@ -375,7 +375,7 @@ static void ppc_core99_init(MachineState *machine)
>      pci_bus = PCI_HOST_BRIDGE(uninorth_pci)->bus;
>  
>      /* MacIO */
> -    macio = NEWWORLD_MACIO(pci_create(pci_bus, -1, TYPE_NEWWORLD_MACIO));
> +    macio = pci_create(pci_bus, -1, TYPE_NEWWORLD_MACIO);
>      dev = DEVICE(macio);
>      qdev_prop_set_uint64(dev, "frequency", tbfreq);
>      qdev_prop_set_bit(dev, "has-pmu", has_pmu);
> diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
> index cfc2eae1d9..f73ec5f3a9 100644
> --- a/hw/ppc/mac_oldworld.c
> +++ b/hw/ppc/mac_oldworld.c
> @@ -94,7 +94,7 @@ static void ppc_heathrow_init(MachineState *machine)
>      uint32_t kernel_base, initrd_base, cmdline_base = 0;
>      int32_t kernel_size, initrd_size;
>      PCIBus *pci_bus;
> -    OldWorldMacIOState *macio;
> +    PCIDevice *macio;
>      MACIOIDEState *macio_ide;
>      SysBusDevice *s;
>      DeviceState *dev, *pic_dev;
> @@ -278,7 +278,7 @@ static void ppc_heathrow_init(MachineState *machine)
>      ide_drive_get(hd, ARRAY_SIZE(hd));
>  
>      /* MacIO */
> -    macio = OLDWORLD_MACIO(pci_create(pci_bus, -1, TYPE_OLDWORLD_MACIO));
> +    macio = pci_create(pci_bus, -1, TYPE_OLDWORLD_MACIO);
>      dev = DEVICE(macio);
>      qdev_prop_set_uint64(dev, "frequency", tbfreq);
>      object_property_set_link(OBJECT(macio), OBJECT(pic_dev), "pic",
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


