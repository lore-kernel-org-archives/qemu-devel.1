Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E49C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 13:10:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 107FF2053B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 13:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U0kcKTBi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 107FF2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igq98-0000VQ-49
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 08:10:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40006)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1igq7z-0007fE-GB
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 08:09:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1igq7y-0002dp-E4
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 08:09:35 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25503
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1igq7y-0002bm-AJ
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 08:09:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576501773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qc4ibrP4nAwK6bD/tUj1hE6UHONdwrtV8vpp480hFK8=;
 b=U0kcKTBiA8nmEP/sAru2IsNBpYpzKu5OY8BCJw1GrafedtQ7NL/C2BlYSeJiq33a/NZQVi
 ROxdonPLjg0zdXNIhaKiYk8aw4YApEgebfOaH04Y063985JuEll51TCR8CCkh44ODAlk35
 aOjIDNV5mBPrVHmIQF8ImzIuOyutAe0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-L0KM7WfaO_S_Nc6QmVij-w-1; Mon, 16 Dec 2019 08:09:30 -0500
Received: by mail-wr1-f70.google.com with SMTP id z10so598475wrt.21
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 05:09:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5Jk6Cpq3pdn1ZWdM3Du7M0QmuQp8H64fwAOoLUEB6AA=;
 b=SrqJVSeEc/EvAQeFbwKRMO8qwwmfFvQ85N7SV+o7beRgp0c9jWouA1x0rJHxn7rKa+
 461IL2t+Vrb9Q4KRlz6f2Jea/JOSJJchbh+mms4ggOIAmcIzvJYDzQtE2dX8l2rRRyxQ
 aLbv8gCL/ebkmuFtQM2GuTa3cQOy6Nnivg4BVVnU3Ae8HEy+IHreD/ivJfMy+1hoqtZG
 Mt0ZCjrZH11qZwfcykHtDb1pDuGU5UlW/lZLrp0WPNBJdmw9xEIJpjlvDGLdHUlMoXJS
 aCNBWqj8Xrp05b3xjA2aSUGhQUoE+SZT2qQ38Gr3x1t//1b36mylLfCMHRDW1JY2wgUX
 Zv5g==
X-Gm-Message-State: APjAAAXJCz2aS/ziJGiV/iG+nqqEnwmcd2zH2WHhqf4pgizQ7QzfH+lt
 O19pfKFSxDLsV0kSQodNbioM4nowBNXEvPMDZfaxalz/Y3rM3wJhN0P4BiXiIyg/jaxovkwPp9O
 Kr8jJ7U+TX6yRujM=
X-Received: by 2002:adf:806e:: with SMTP id 101mr31411907wrk.300.1576501769478; 
 Mon, 16 Dec 2019 05:09:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqwYyxUkn02vgY6dZmRCZwsGERI4x52mCVKPdFOym4lzQgGYRZERott/od+zxPFmJAq+fK4eBQ==
X-Received: by 2002:adf:806e:: with SMTP id 101mr31411887wrk.300.1576501769266; 
 Mon, 16 Dec 2019 05:09:29 -0800 (PST)
Received: from [192.168.10.150] ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id l2sm20367946wmi.5.2019.12.16.05.09.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Dec 2019 05:09:28 -0800 (PST)
Subject: Re: [PATCH 04/12] hw/i386/pc: Remove obsolete cpu_set_smm_t typedef
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191213161753.8051-1-philmd@redhat.com>
 <20191213161753.8051-5-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a4d450dd-fa12-6a02-8225-37d467ed3628@redhat.com>
Date: Mon, 16 Dec 2019 14:09:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191213161753.8051-5-philmd@redhat.com>
Content-Language: en-US
X-MC-Unique: L0KM7WfaO_S_Nc6QmVij-w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: Stefano Stabellini <sstabellini@kernel.org>, Sergio Lopez <slp@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 xen-devel@lists.xenproject.org, Anthony Perard <anthony.perard@citrix.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/12/19 17:17, Philippe Mathieu-Daud=C3=A9 wrote:
> In commit f809c6051 we replaced the use of cpu_set_smm_t callbacks
> by using a Notifier to modify the MemoryRegion. This prototype is
> now not used anymore, we can safely remove it.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  include/hw/i386/pc.h | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index bc7d855aaa..743141e107 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -212,8 +212,6 @@ void pc_cmos_init(PCMachineState *pcms,
>                    ISADevice *s);
>  void pc_nic_init(PCMachineClass *pcmc, ISABus *isa_bus, PCIBus *pci_bus)=
;
> =20
> -typedef void (*cpu_set_smm_t)(int smm, void *arg);
> -
>  void pc_i8259_create(ISABus *isa_bus, qemu_irq *i8259_irqs);
>  void ioapic_init_gsi(GSIState *gsi_state, const char *parent_name);
> =20
>=20

Queued, thanks.

Paolo


