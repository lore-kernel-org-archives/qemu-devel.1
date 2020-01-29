Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CEB5C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 21:55:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA85A206D5
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 21:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dzKKYgBd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA85A206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwvJV-0005e1-3f
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 16:55:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39654)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gshan@redhat.com>) id 1iwvIS-0004x1-Ni
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:54:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gshan@redhat.com>) id 1iwvIQ-0001MZ-Nu
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:54:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47746
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <gshan@redhat.com>) id 1iwvIQ-0001M3-JK
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:54:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580334889;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2caJ/6uS2IIJxFpAJghqrpPksPreFo/O+EejdndpHkc=;
 b=dzKKYgBdJHwnLgmy34eweXMezbUPQ7ZyYC6s7k4465vuoA08gJsAmUEtj/wQq7Ymj6eqru
 mPwty/nrbZXTdSQs9RCx9XP6DO/+28942Aatnt1OsB1whKqa1V/DLRwHABm/DJQFZvFh08
 RodWC1ntDnuq+uIi8N6NNSr4f3g5mYg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-OvNL_kj3OkSqqFG-cnZIwQ-1; Wed, 29 Jan 2020 16:54:48 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13B8A1882CC9;
 Wed, 29 Jan 2020 21:54:47 +0000 (UTC)
Received: from localhost.localdomain (vpn2-54-25.bne.redhat.com [10.64.54.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 78D8884BB8;
 Wed, 29 Jan 2020 21:54:41 +0000 (UTC)
Subject: Re: [RFC PATCH] hw/arm/virt: Support NMI injection
To: Julien Thierry <jthierry@redhat.com>, qemu-arm@nongnu.org
References: <20191219040612.28431-1-gshan@redhat.com>
 <d972631d-7db7-b6d5-61b8-244ae2c85882@redhat.com>
 <f4699b81-26ac-fcd4-d3fc-f6e055beeb65@redhat.com>
 <9f82206e-0852-ae17-8c77-01d2a5cea97d@redhat.com>
 <51a83889-f2ef-5403-6661-710cfa1ffe01@redhat.com>
From: Gavin Shan <gshan@redhat.com>
Message-ID: <4a517e53-9a7c-903a-9fbc-e1aab1cccefb@redhat.com>
Date: Thu, 30 Jan 2020 08:54:37 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <51a83889-f2ef-5403-6661-710cfa1ffe01@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: OvNL_kj3OkSqqFG-cnZIwQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Reply-To: Gavin Shan <gshan@redhat.com>
Cc: peter.maydell@linaro.org, drjones@redhat.com, aik@ozlabs.ru, maz@kernel.org,
 qemu-devel@nongnu.org, eric.auger@redhat.com, shan.gavin@gmail.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/29/20 6:57 PM, Julien Thierry wrote:
> On 1/29/20 3:46 AM, Gavin Shan wrote:
>> On 1/28/20 7:29 PM, Julien Thierry wrote:

.../...

>>
>> Julien, thanks for the explanation. The question we're not sure if NMI should
>> be injected on receiving HMP/QMP "nmi" command. It means it's not clear what
>> behavior we should have for this command on ARM. However, I have one more
>> unrelated question: "pseudo" NMI on ARM64 should be PPI? I mean SPI can't
>> be "pseudo" NMI.
>>
> 
> I'm not sure I understand why you say "SPI can't be "pseudo" NMI". Currently both PPI and SPI are supported in the "pseudo" NMI scheme. Do you think that should not be the case? If so, can you elaborate?
> 
> Thanks,
> 

Julien, NMI interrupt is connected to the system by request_nmi() where we have
a check as below. -EINVAL will be returned from request_nmi() on those interrupts
whose descriptors aren't marked with IRQ_NOAUTOEN. SPI falls into this category.
Please refer to below code snippet extracted from gic_irq_domain_map() for more
details.

kernel/irq/manage.c::request_nmi()

int request_nmi(unsigned int irq, irq_handler_t handler,
                 unsigned long irqflags, const char *name, void *dev_id)
{
	:
         if (!desc || irq_settings_can_autoenable(desc) ||
             !irq_settings_can_request(desc) ||
             WARN_ON(irq_settings_is_per_cpu_devid(desc)) ||
             !irq_supports_nmi(desc))
		return -EINVAL;
	:
}


acpi_register_gsi
    irq_create_fwspec_mapping
       irq_domain_alloc_irqs
          __irq_domain_alloc_irqs
             irq_domain_alloc_irqs_hierarchy
                gic_irq_domain_alloc                  # irq_domain_ops::alloc
                   gic_irq_domain_map

drivers/irqchip/irq-gic-v3.c::gic_irq_domain_map()

static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
                               irq_hw_number_t hw)
{
	:
        switch (__get_intid_range(hw)) {
         case PPI_RANGE:
         case EPPI_RANGE:
                 irq_set_percpu_devid(irq);
                 irq_domain_set_info(d, irq, hw, chip, d->host_data,
                                     handle_percpu_devid_irq, NULL, NULL);
                 irq_set_status_flags(irq, IRQ_NOAUTOEN);                      <<<< this flag
                 break;

         case SPI_RANGE:
         case ESPI_RANGE:
                 irq_domain_set_info(d, irq, hw, chip, d->host_data,
                                     handle_fasteoi_irq, NULL, NULL);
                 irq_set_probe(irq);
                 irqd_set_single_target(irq_desc_get_irq_data(irq_to_desc(irq)));
                 break;
            :
	}
         :
}

Thanks,
Gavin


