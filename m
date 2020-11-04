Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0ED1C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 14:52:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD49D2074F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 14:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aB1VljsF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD49D2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaK8y-0000Jr-Jr
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 09:52:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52222)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kaK89-0008CA-K4
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 09:51:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36380)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kaK87-0004bP-6Q
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 09:51:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604501478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ppHhLfwTQ2J2IYaukrYGQNvDH/4RiLxMMwWQ5QQC4Jc=;
 b=aB1VljsFLhcvSthKDP1Ol+PE5bA4BsJoYHP0rxlthP0NtJVg8wwuJXqV7UOja1l+Xep9Ib
 hEWAbPaHWPdaq9tlwtOBVgIHSU1F0fRpTBhjJ8lfl7CSgXLiovX3MJTBzRzNi2T0qNRVra
 t0TbA1aaSlQXAbPfQ2Ig3sgyfbII/Bw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-QTwcTvvMP_uBb8B16UQgPQ-1; Wed, 04 Nov 2020 09:51:14 -0500
X-MC-Unique: QTwcTvvMP_uBb8B16UQgPQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D21B410A0B83;
 Wed,  4 Nov 2020 14:51:12 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-151.ams2.redhat.com [10.36.112.151])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 79E3C1A340;
 Wed,  4 Nov 2020 14:51:10 +0000 (UTC)
Subject: Re: [PATCH v2 5/6] macio: don't reference serial_hd() directly within
 the device
To: BALATON Zoltan <balaton@eik.bme.hu>
References: <20200926140216.7368-1-mark.cave-ayland@ilande.co.uk>
 <20200926140216.7368-6-mark.cave-ayland@ilande.co.uk>
 <16f13e17-37cb-a238-4e2a-9a945649cafd@redhat.com>
 <1ee5be24-277c-dda1-adc5-beae5177782a@eik.bme.hu>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <365d15e9-0543-b906-4bc1-d04238fba5ed@redhat.com>
Date: Wed, 4 Nov 2020 15:51:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1ee5be24-277c-dda1-adc5-beae5177782a@eik.bme.hu>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 armbru@redhat.com, qemu-ppc@nongnu.org, atar4qemu@gmail.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/11/2020 15.16, BALATON Zoltan wrote:
> On Wed, 4 Nov 2020, Thomas Huth wrote:
>> On 26/09/2020 16.02, Mark Cave-Ayland wrote:
>>> Instead use qdev_prop_set_chr() to configure the ESCC serial chardevs at the
>>> Mac Old World and New World machine level.
>>>
>>> Also remove the now obsolete comment referring to the use of serial_hd() and
>>> the setting of user_creatable to false accordingly.
>>>
>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>> ---
>>>  hw/misc/macio/macio.c | 4 ----
>>>  hw/ppc/mac_newworld.c | 6 ++++++
>>>  hw/ppc/mac_oldworld.c | 6 ++++++
>>>  3 files changed, 12 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
>>> index 679722628e..51368884d0 100644
>>> --- a/hw/misc/macio/macio.c
>>> +++ b/hw/misc/macio/macio.c
>>> @@ -109,8 +109,6 @@ static void macio_common_realize(PCIDevice *d, Error **errp)
>>>      qdev_prop_set_uint32(DEVICE(&s->escc), "disabled", 0);
>>>      qdev_prop_set_uint32(DEVICE(&s->escc), "frequency", ESCC_CLOCK);
>>>      qdev_prop_set_uint32(DEVICE(&s->escc), "it_shift", 4);
>>> -    qdev_prop_set_chr(DEVICE(&s->escc), "chrA", serial_hd(0));
>>> -    qdev_prop_set_chr(DEVICE(&s->escc), "chrB", serial_hd(1));
>>>      qdev_prop_set_uint32(DEVICE(&s->escc), "chnBtype", escc_serial);
>>>      qdev_prop_set_uint32(DEVICE(&s->escc), "chnAtype", escc_serial);
>>>      if (!qdev_realize(DEVICE(&s->escc), BUS(&s->macio_bus), errp)) {
>>> @@ -458,8 +456,6 @@ static void macio_class_init(ObjectClass *klass, void *data)
>>>      k->class_id = PCI_CLASS_OTHERS << 8;
>>>      device_class_set_props(dc, macio_properties);
>>>      set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>>> -    /* Reason: Uses serial_hds in macio_instance_init */
>>> -    dc->user_creatable = false;
>>>  }
>>
>> Hi Mark,
>>
>> the macio device can now be used to crash QEMU:
>>
>> $ ./qemu-system-ppc -M sam460ex -device macio-newworld
>> Segmentation fault (core dumped)
>>
>> I guess we should either restore the user_creatable flag or add some sanity
>> checks elsewhere?
> 
> Looks like it needs to check if pic_dev is set:
> 
> $ gdb --args ./qemu-system-ppc -M sam460ex -device macio-newworld
> (gdb) r
> Thread 1 "qemu-system-ppc" received signal SIGSEGV, Segmentation fault.
> 0x0000555555c3d65a in qdev_get_named_gpio_list (dev=0x0, name=0x0)
>     at ../hw/core/qdev.c:456
> 456	    QLIST_FOREACH(ngl, &dev->gpios, node) {
> (gdb) bt
> #0  0x0000555555c3d65a in qdev_get_named_gpio_list (dev=0x0, name=0x0)
>     at ../hw/core/qdev.c:456
> #1  0x0000555555c3e349 in qdev_get_gpio_in_named (dev=<optimized out>,
>     name=<optimized out>, n=36) at ../hw/core/qdev.c:532
> #2  0x00005555559c690f in macio_newworld_realize (d=<optimized out>,
>     errp=0x7fffffffda40) at ../hw/misc/macio/macio.c:301
> #3  0x0000555555946334 in pci_qdev_realize (qdev=0x555556b578e0,
>     errp=<optimized out>) at ../hw/pci/pci.c:2125
> #4  0x0000555555c3f1ff in device_set_realized (obj=<optimized out>,
>     value=true, errp=0x7fffffffdb50) at ../hw/core/qdev.c:886
> [...]
> (gdb) up
> #1  0x0000555555c3e349 in qdev_get_gpio_in_named (dev=<optimized out>,
>     name=<optimized out>, n=36) at ../hw/core/qdev.c:532
> 532	    NamedGPIOList *gpio_list = qdev_get_named_gpio_list(dev, name);
> (gdb)
> #2  0x00005555559c690f in macio_newworld_realize (d=<optimized out>,
>     errp=0x7fffffffda40) at ../hw/misc/macio/macio.c:301
> 301	    sysbus_connect_irq(sysbus_dev, 0, qdev_get_gpio_in(pic_dev,
> (gdb) l 285
> 280	    .read = timer_read,
> 281	    .write = timer_write,
> 282	    .endianness = DEVICE_LITTLE_ENDIAN,
> 283	};
> 284
> 285	static void macio_newworld_realize(PCIDevice *d, Error **errp)
> 286	{
> 287	    MacIOState *s = MACIO(d);
> 288	    NewWorldMacIOState *ns = NEWWORLD_MACIO(d);
> 289	    DeviceState *pic_dev = DEVICE(ns->pic);
> (gdb)
> 290	    Error *err = NULL;
> 291	    SysBusDevice *sysbus_dev;
> 292	    MemoryRegion *timer_memory = NULL;
> 293
> 294	    macio_common_realize(d, &err);
> 295	    if (err) {
> 296	        error_propagate(errp, err);
> 297	        return;
> 298	    }
> 299
> (gdb)
> 300	    sysbus_dev = SYS_BUS_DEVICE(&s->escc);
> 301	    sysbus_connect_irq(sysbus_dev, 0, qdev_get_gpio_in(pic_dev,
> 302	                                                       NEWWORLD_ESCCB_IRQ));
> 303	    sysbus_connect_irq(sysbus_dev, 1, qdev_get_gpio_in(pic_dev,
> 304	                                                       NEWWORLD_ESCCA_IRQ));
> 305
> 306	    /* OpenPIC */
> 307	    sysbus_dev = SYS_BUS_DEVICE(ns->pic);
> 308	    memory_region_add_subregion(&s->bar, 0x40000,
> 309	                                sysbus_mmio_get_region(sysbus_dev, 
> 0));
> 
> Maybe something like:
> 
> if (!pic_dev) {
>     error_setg(errp, "some meaningful error message");
>     return;
> }
> 
> before the sysbus_connect_irq calls but unless the user can set this via 
> the command line somehow then keeping the user_creatable = false with 
> comment adjusted to say that this device needs to be connected by board 
> code is probably better.

Yes, as far as I can see, there is no way a user could use these devices
from the command line - the "pic" link has to be set up by code. So I'd also
suggest to add the user_creatable = false back again.

 Thomas


