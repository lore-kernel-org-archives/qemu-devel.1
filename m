Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88608C00A89
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 06:30:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B11302071A
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 06:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="buJvmDHZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B11302071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaYnH-0007Bm-Jh
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 01:30:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kaYmH-0006YZ-6f
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 01:29:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38437)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kaYmF-0002rg-LR
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 01:29:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604557781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7/WiZTAvAPwM9iXeWpfNipHPbBK+gEFI/VJufqKXOkk=;
 b=buJvmDHZvzbgU3oFTa69TQ8zJUR0KHEdQsA85yaYcwz63+aDlAArHLf0IQbAzNUqdo7991
 oqBylI642shqElc/oxvcwso/xGODbPbDrOuJ7h3SGTY+dE/T0X8Wsq4cvDE0UfvwAUHgcN
 s+VcXypBMJ8HUI5/o49kHCAexvHp2rA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-cYU4WQbxNJiFu_HC3jwFMw-1; Thu, 05 Nov 2020 01:29:38 -0500
X-MC-Unique: cYU4WQbxNJiFu_HC3jwFMw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E29356C91;
 Thu,  5 Nov 2020 06:29:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-103.ams2.redhat.com
 [10.36.112.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9DF336CE51;
 Thu,  5 Nov 2020 06:29:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CF5A61132BD6; Thu,  5 Nov 2020 07:29:33 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2 5/6] macio: don't reference serial_hd() directly
 within the device
References: <20200926140216.7368-1-mark.cave-ayland@ilande.co.uk>
 <20200926140216.7368-6-mark.cave-ayland@ilande.co.uk>
 <16f13e17-37cb-a238-4e2a-9a945649cafd@redhat.com>
 <1ee5be24-277c-dda1-adc5-beae5177782a@eik.bme.hu>
 <365d15e9-0543-b906-4bc1-d04238fba5ed@redhat.com>
Date: Thu, 05 Nov 2020 07:29:33 +0100
In-Reply-To: <365d15e9-0543-b906-4bc1-d04238fba5ed@redhat.com> (Thomas Huth's
 message of "Wed, 4 Nov 2020 15:51:09 +0100")
Message-ID: <87o8kcs4du.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 22:46:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 qemu-ppc@nongnu.org, atar4qemu@gmail.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thomas Huth <thuth@redhat.com> writes:

> On 04/11/2020 15.16, BALATON Zoltan wrote:
>> On Wed, 4 Nov 2020, Thomas Huth wrote:
>>> On 26/09/2020 16.02, Mark Cave-Ayland wrote:
>>>> Instead use qdev_prop_set_chr() to configure the ESCC serial chardevs at the
>>>> Mac Old World and New World machine level.
>>>>
>>>> Also remove the now obsolete comment referring to the use of serial_hd() and
>>>> the setting of user_creatable to false accordingly.
>>>>
>>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>>> ---
>>>>  hw/misc/macio/macio.c | 4 ----
>>>>  hw/ppc/mac_newworld.c | 6 ++++++
>>>>  hw/ppc/mac_oldworld.c | 6 ++++++
>>>>  3 files changed, 12 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
>>>> index 679722628e..51368884d0 100644
>>>> --- a/hw/misc/macio/macio.c
>>>> +++ b/hw/misc/macio/macio.c
>>>> @@ -109,8 +109,6 @@ static void macio_common_realize(PCIDevice *d, Error **errp)
>>>>      qdev_prop_set_uint32(DEVICE(&s->escc), "disabled", 0);
>>>>      qdev_prop_set_uint32(DEVICE(&s->escc), "frequency", ESCC_CLOCK);
>>>>      qdev_prop_set_uint32(DEVICE(&s->escc), "it_shift", 4);
>>>> -    qdev_prop_set_chr(DEVICE(&s->escc), "chrA", serial_hd(0));
>>>> -    qdev_prop_set_chr(DEVICE(&s->escc), "chrB", serial_hd(1));
>>>>      qdev_prop_set_uint32(DEVICE(&s->escc), "chnBtype", escc_serial);
>>>>      qdev_prop_set_uint32(DEVICE(&s->escc), "chnAtype", escc_serial);
>>>>      if (!qdev_realize(DEVICE(&s->escc), BUS(&s->macio_bus), errp)) {
>>>> @@ -458,8 +456,6 @@ static void macio_class_init(ObjectClass *klass, void *data)
>>>>      k->class_id = PCI_CLASS_OTHERS << 8;
>>>>      device_class_set_props(dc, macio_properties);
>>>>      set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>>>> -    /* Reason: Uses serial_hds in macio_instance_init */
>>>> -    dc->user_creatable = false;
>>>>  }
>>>
>>> Hi Mark,
>>>
>>> the macio device can now be used to crash QEMU:
>>>
>>> $ ./qemu-system-ppc -M sam460ex -device macio-newworld
>>> Segmentation fault (core dumped)
>>>
>>> I guess we should either restore the user_creatable flag or add some sanity
>>> checks elsewhere?
>> 
>> Looks like it needs to check if pic_dev is set:
[...]
>> Maybe something like:
>> 
>> if (!pic_dev) {
>>     error_setg(errp, "some meaningful error message");
>>     return;
>> }
>> 
>> before the sysbus_connect_irq calls but unless the user can set this via 
>> the command line somehow then keeping the user_creatable = false with 
>> comment adjusted to say that this device needs to be connected by board 
>> code is probably better.
>
> Yes, as far as I can see, there is no way a user could use these devices
> from the command line - the "pic" link has to be set up by code. So I'd also
> suggest to add the user_creatable = false back again.

When you do that, add a comment that explains why.  You might want to
examine existing comments for inspiration.


