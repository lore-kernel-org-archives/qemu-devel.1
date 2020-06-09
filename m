Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A3CC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 11:16:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DE30207ED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 11:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GaEw5OKb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DE30207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jicEl-0003wQ-Ad
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 07:16:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jic9X-00059e-Iv
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 07:10:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37733
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jic9W-0001o2-UY
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 07:10:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591701046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TysuOc5GXylf1UUaen/G81fkeOnuEfcp2+jvnmZ+bCw=;
 b=GaEw5OKblin3Wfa203BH+/tlsxjxq/fqyNohbanzKGVp1hrWOCvG5Lfp30KG+rIPuKwC9R
 wkCzWoR/zk9nTeAbRNakJ3xgpwEqtai9jxFkaC4DljG79wI4wySR9HpwT5+wMlxumwm7Xp
 jpeaXaXcdJ9lPJhRt6Ujse0i2f00/As=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-q0xcmFw-PmeBjuVe17cGJg-1; Tue, 09 Jun 2020 07:10:43 -0400
X-MC-Unique: q0xcmFw-PmeBjuVe17cGJg-1
Received: by mail-wr1-f71.google.com with SMTP id w4so8495493wrl.13
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 04:10:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TysuOc5GXylf1UUaen/G81fkeOnuEfcp2+jvnmZ+bCw=;
 b=dORvG1DLoiyxCK5clF59qb3jIVQrA7AmF1WT7eB0mL3oilPNIDn7exbDzAw3VCqbUj
 fTDqUqiC1tSasOLgcEnNK2ScKLE+X7VUk5p2Nfv8HFU3mLbTrvE+nbOxYQf7p8sqYI9D
 gOL6rLb4u3dEGtgqP/MarM/WRusC++1YUvy4GQI8UlXjf7LeJ7UyXs3R0pjmcJ26NQ7q
 1yTOTd3PvRC97OetNkNuqC2aoaHr5bUbi7XxKvh2iKecz6WtT6tb0gmc1EI1Jy22i1fk
 zARM7He55GiM7sDnNnuapWmwl42domqD2wr48DN5cbtWG9qyJexZSWhJIhdF4nfFlQBn
 GEmQ==
X-Gm-Message-State: AOAM531AvM3EmMgsIxlRDMR9Y6rJwh4Aw8TyS3MGBJsC75gVIkd7Gq0v
 k5AHGnlvcYhCAq7WjWKFrglmemUT4Rtv6LfKnO9553c94uGSKHQhEi0eCCd8fXrUSSFSJ0CYtGc
 HD1eQOZ+AYoWmi3g=
X-Received: by 2002:a7b:cb91:: with SMTP id m17mr3627204wmi.126.1591701042667; 
 Tue, 09 Jun 2020 04:10:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYXhhkklLh5/jP4wI4AWv8kJypOFv0T2ku7XSwlUIkFk2HE1PSObyt3ACvqwUvh1wPJYEGWA==
X-Received: by 2002:a7b:cb91:: with SMTP id m17mr3627155wmi.126.1591701042347; 
 Tue, 09 Jun 2020 04:10:42 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.172.168])
 by smtp.gmail.com with ESMTPSA id q1sm2521908wmc.15.2020.06.09.04.10.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2020 04:10:41 -0700 (PDT)
Subject: Re: [RFC PATCH 20/35] hw/intc/i8259: Emit warning when old code is
 used
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200608160044.15531-1-philmd@redhat.com>
 <20200608160044.15531-21-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <71b5e461-88f6-eab2-f46a-e8aa4783debd@redhat.com>
Date: Tue, 9 Jun 2020 13:10:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200608160044.15531-21-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 01:38:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 Magnus Damm <magnus.damm@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 xen-devel@lists.xenproject.org, qemu-riscv@nongnu.org,
 Stafford Horne <shorne@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <rth@twiddle.net>,
 "Daniel P . Berrange" <berrange@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/06/20 18:00, Philippe Mathieu-Daudé wrote:
> This code hasn't been QOM'ified yet. Warn the user.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/intc/i8259.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
> index 51b27f6a34..9d9609cdab 100644
> --- a/hw/intc/i8259.c
> +++ b/hw/intc/i8259.c
> @@ -30,6 +30,7 @@
>  #include "qemu/log.h"
>  #include "hw/isa/i8259_internal.h"
>  #include "trace.h"
> +#include "hw/qdev-deprecated.h"
>  
>  /* debug PIC */
>  //#define DEBUG_PIC
> @@ -414,6 +415,8 @@ qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq)
>      ISADevice *isadev;
>      int i;
>  
> +    qdev_warn_deprecated_function_used();
> +
>      irq_set = g_new0(qemu_irq, ISA_NUM_IRQS);
>  
>      isadev = i8259_init_chip(TYPE_I8259, bus, true);
> 

This one is okay too.

Paolo


