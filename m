Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6D9C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 15:51:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F1712223E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 15:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jkg2M/hA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F1712223E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL73B-0002xt-2z
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 11:51:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41696)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kL70D-0001R0-Hk
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 11:48:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50004)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kL70B-00012y-P7
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 11:48:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600876094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cH/24x5qQGppXUlV23liUy4LjXD36MkJ5eZbLOwR1U8=;
 b=Jkg2M/hA0EyZ6gr5QqalIr0fuZIOGt0xxbrhp4G/IT6GvMJn+u8ZO6iMwW5dDpW8ePDnob
 eky/1yYDhGTLkWnL4ICMnGuXs0UQH3kjzKisEZlPkNHoWiPEVKuFuw14eBf3c20OfwCDeH
 2sBCE5zuBzv57PCGP1v3HUzGFDKfsZw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-398FW8a5NSunG1YVO2kM2g-1; Wed, 23 Sep 2020 11:48:12 -0400
X-MC-Unique: 398FW8a5NSunG1YVO2kM2g-1
Received: by mail-wr1-f70.google.com with SMTP id g6so2069wrv.3
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2020 08:48:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cH/24x5qQGppXUlV23liUy4LjXD36MkJ5eZbLOwR1U8=;
 b=S7ak/vKA2TTjVqzN5N4T738wE/DGddJoUZjqrXJ7BAZB6ridPeDbJyrYBD2q24NGY2
 1E6Bqs0gYfE4PAqbJWuIOmSxY98kK7ZSRVvpSSectHrkAPubabL0cPpxUcwf23PUK+It
 k2HfgrwYalxYz4IY8ZJODxHVswVzZlx41bOVJYNgnVLGwq5gpuhaea3YO7VZLRTTr3wf
 MiSiYFg9dJ79IzPO+FW2lESWiTgtSmtisJjGg2aJBIpqJ5FgnTKkBReEjvQE2thmimMW
 OOlIMHVnvaOeyTbpk9yQLSxSf/XtJn5rDzkdLuhIwrVhLTQ8k5HQ+f4vl1S7iQH7yaXn
 b4AQ==
X-Gm-Message-State: AOAM533XjWHzOB+czgyuHVa0ekoozxgHe13dpLO85cZNe7iLAV5mGyRa
 yYXn1iqNRYBl97yQU5EYGw61y3MGgDQ8Tz/e1GnNvS11Rr7CN56EuRoxBhRX46j2PSNMqseRGo+
 LoJYHWA5PNr7f5oo=
X-Received: by 2002:a7b:c92c:: with SMTP id h12mr157975wml.121.1600876091331; 
 Wed, 23 Sep 2020 08:48:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxO+DDl8+wFPG6y4NdOlsmEWvAyBFtAb+EYtmhs/GgittFiQ+NbbLWamLdWca9a6v8JHlGCJw==
X-Received: by 2002:a7b:c92c:: with SMTP id h12mr157941wml.121.1600876091055; 
 Wed, 23 Sep 2020 08:48:11 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:15f1:648d:7de6:bad9?
 ([2001:b07:6468:f312:15f1:648d:7de6:bad9])
 by smtp.gmail.com with ESMTPSA id m10sm214492wmi.9.2020.09.23.08.48.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2020 08:48:10 -0700 (PDT)
Subject: Re: [PATCH v2 7/7] hw/net/can: Correct Kconfig dependencies after
 switch to meson build.
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>, qemu-devel@nongnu.org
References: <cover.1599168753.git.pisa@cmp.felk.cvut.cz>
 <dd539770e9c182125a9c3d87b9ca329121b11abc.1599168753.git.pisa@cmp.felk.cvut.cz>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9bd9046d-9a16-3c23-3044-4446a9a05b55@redhat.com>
Date: Wed, 23 Sep 2020 17:48:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <dd539770e9c182125a9c3d87b9ca329121b11abc.1599168753.git.pisa@cmp.felk.cvut.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Marek Vasut <marex@denx.de>, Vikram Garhwal <fnu.vikram@xilinx.com>,
 Jiri Novak <jnovak@fel.cvut.cz>, Stefan Hajnoczi <stefanha@gmail.com>,
 Deniz Eren <deniz.eren@icloud.com>, Markus Armbruster <armbru@redhat.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Konrad Frederic <frederic.konrad@adacore.com>,
 Jan Charvat <charvj10@fel.cvut.cz>, Jan Kiszka <jan.kiszka@siemens.com>,
 Oliver Hartkopp <socketcan@hartkopp.net>, Ondrej Ille <ondrej.ille@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/09/20 23:48, Pavel Pisa wrote:
> The original CAN_PCI config option enables multiple SJA1000 PCI boards
> emulation build. These boards bridge SJA1000 into I/O or memory
> address space of the host CPU and depend on SJA1000 emulation.

Can you explain how the mistake is related to the meson switch?

The conversion seems good:

diff --git a/hw/net/can/Makefile.objs b/hw/net/can/Makefile.objs
deleted file mode 100644
index 9f0c4ee332..0000000000
--- a/hw/net/can/Makefile.objs
+++ /dev/null
@@ -1,4 +0,0 @@
-common-obj-$(CONFIG_CAN_SJA1000) += can_sja1000.o
-common-obj-$(CONFIG_CAN_PCI) += can_kvaser_pci.o
-common-obj-$(CONFIG_CAN_PCI) += can_pcm3680_pci.o
-common-obj-$(CONFIG_CAN_PCI) += can_mioe3680_pci.o
diff --git a/hw/net/can/meson.build b/hw/net/can/meson.build
new file mode 100644
index 0000000000..c9cfeb7954
--- /dev/null
+++ b/hw/net/can/meson.build
@@ -0,0 +1,4 @@
+softmmu_ss.add(when: 'CONFIG_CAN_SJA1000', if_true: files('can_sja1000.c'))
+softmmu_ss.add(when: 'CONFIG_CAN_PCI', if_true: files('can_kvaser_pci.c'))
+softmmu_ss.add(when: 'CONFIG_CAN_PCI', if_true: files('can_pcm3680_pci.c'))
+softmmu_ss.add(when: 'CONFIG_CAN_PCI', if_true: files('can_mioe3680_pci.c'))


I queued the other six patches.

Paolo

> Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
> ---
>  hw/net/Kconfig | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/net/Kconfig b/hw/net/Kconfig
> index 225d948841..6d795ec752 100644
> --- a/hw/net/Kconfig
> +++ b/hw/net/Kconfig
> @@ -132,16 +132,15 @@ config ROCKER
>  config CAN_BUS
>      bool
>  
> -config CAN_PCI
> +config CAN_SJA1000
>      bool
>      default y if PCI_DEVICES
> -    depends on PCI
>      select CAN_BUS
>  
> -config CAN_SJA1000
> +config CAN_PCI
>      bool
>      default y if PCI_DEVICES
> -    depends on PCI
> +    depends on PCI && CAN_SJA1000
>      select CAN_BUS
>  
>  config CAN_CTUCANFD


