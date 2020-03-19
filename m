Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E874C4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 08:50:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD61020732
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 08:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AhfVDuvJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD61020732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEqt6-00068x-3U
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 04:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56377)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jEqsL-0005cF-Eh
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 04:50:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jEqsK-0005FZ-Fx
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 04:50:01 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:52528)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jEqsK-0005FF-Bn
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 04:50:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584607800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zrJKCcj+IZ/yJoo0JstvYo7jn6IdTFTCk7QBF+SSpwk=;
 b=AhfVDuvJNJQv9PvdO4LEJcV+bakqa8QBfO/nYUcKFi+BhfG3arG3QAPXfiUm9o2h8FKNXj
 mECaMA2/EwyLX8PhysgHo+d+y9Xd+SN7gByMYA91pWBOk60VF3OZ+vlI0SLoU+tphEUJpP
 OZ/V/xlNalnZ+fEa64riOhjI6Mv9PS4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-ORqZbsxuMxaI3rHZoAtYqw-1; Thu, 19 Mar 2020 04:49:58 -0400
X-MC-Unique: ORqZbsxuMxaI3rHZoAtYqw-1
Received: by mail-wm1-f70.google.com with SMTP id g26so705872wmk.6
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 01:49:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zrJKCcj+IZ/yJoo0JstvYo7jn6IdTFTCk7QBF+SSpwk=;
 b=lmkYH3bGudveipJqmiAm5WYxNc4uImR4iW7hhaZk0J48Jey4UEpMlpLTnjHQGHB9+2
 c5Rod0th6hCL47bnd3rCe7BCffxZjaPeLCKz188E1UlRf2M+NdF4e+WUctU8vWsXcwGy
 lyO17hvGiSeZcXBidwsLMyUPnijKvEyF/ZFJZWvNZZIEqedqZMy4cENNfiD5uRu4FgGi
 EOUCuHXpzIgXuPFj/UTskD9ICV8dM9IfXNstEsXa5aduuWcVGbhoDPpUcuOwqga2UAAc
 URrp5mo52aE7BuGB78XXpsuDk0wJoEb0vDSsrROIwUjot4gYC1IpZRKJLT9tMbEY7vOd
 Rfiw==
X-Gm-Message-State: ANhLgQ3ErBaWQ1ESyVpQKjvSUZJO9Qn2+Edrk/860plPZjNQObVv6Fvg
 QgWF5fQdmEv1fVjEykyzxxQJgEFoHwsHJO+Jt4vhpkGtBwCgOkl2MOD4dkbPeGxD+DuYzBNqOce
 4TkBz7EzOOpDJSy0=
X-Received: by 2002:a1c:1b4c:: with SMTP id b73mr2326478wmb.17.1584607797624; 
 Thu, 19 Mar 2020 01:49:57 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvrveRzwPllv3481S8j/FKnGQVLNtv4FzBSSYOXyMyiokUzSZ+FSKOQbwoUb/FwqTUkfPTl1Q==
X-Received: by 2002:a1c:1b4c:: with SMTP id b73mr2326455wmb.17.1584607797366; 
 Thu, 19 Mar 2020 01:49:57 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.15.43])
 by smtp.gmail.com with ESMTPSA id i1sm2315742wrq.89.2020.03.19.01.49.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2020 01:49:56 -0700 (PDT)
Subject: Re: [PATCH 00/13] microvm: add acpi support
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200319080117.7725-1-kraxel@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2ed586e7-d7a1-77b2-ecc6-01b6fb38d72e@redhat.com>
Date: Thu, 19 Mar 2020 09:49:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200319080117.7725-1-kraxel@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/03/20 09:01, Gerd Hoffmann wrote:
> I know that not supporting ACPI in microvm is intentional.  If you still
> don't want ACPI this is perfectly fine, you can use the usual -no-acpi
> switch to toggle ACPI support.

Could we change -no-acpi into a "-machine acpi=..." property?  Then it
can have type OnOffAuto and we can decide whether to enable it by
default or not for microvm.

Also, can you confirm that it builds without CONFIG_I440FX and
CONFIG_Q35?  You probably need to add "imply ACPI" and possibly some
'#include "config-devices.h"' and '#ifdef CONFIG_ACPI' here and there.

Paolo

> These are the advantages you are going to loose then:
> 
>   (1) virtio-mmio device discovery without command line hacks (tweaking
>       the command line is a problem when not using direct kernel boot).
>   (2) Better IO-APIC support, we can use IRQ lines 16-23.
>   (3) ACPI power button (aka powerdown request) works.
>   (4) machine poweroff (aka S5 state) works.
> 
> Together with seabios patches for virtio-mmio support this allows to
> boot standard fedora images (cloud, coreos, workstation live) with the
> microvm machine type.


