Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C117C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 12:11:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB45320772
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 12:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OLQ3F4FK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB45320772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqy4A-0003Fd-7M
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 08:11:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jqy3b-0002js-T1
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 08:11:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45854
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jqy3a-0007eD-HY
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 08:11:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593691870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S9dnObJWPYCQceCehn9KSyC1vj7+XYSa/G4rhkdLajU=;
 b=OLQ3F4FK3zzu7oqRO/Les393mr4zEy4B0Z2+McL9MKM9WGXtLy6jMaiBpgE8FYKWCeKOj9
 3apF+B49IvKmx/KFpCXa8ZriaALNd1XGyr5Aabd12pQqenXxSu8A/ZEFRqsv7NHrrOvKr+
 O6qrnbHJrnkmNmcduicZIfgfp70SD9g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-9ms0h46MPZCdoyw2Sw1d3A-1; Thu, 02 Jul 2020 08:11:06 -0400
X-MC-Unique: 9ms0h46MPZCdoyw2Sw1d3A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0027F87950C;
 Thu,  2 Jul 2020 12:11:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BFB471010404;
 Thu,  2 Jul 2020 12:11:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2C16C11384A6; Thu,  2 Jul 2020 14:11:03 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 33/46] qom: Crash more nicely on
 object_property_get_link() failure
References: <20200624164344.3778251-1-armbru@redhat.com>
 <20200624164344.3778251-34-armbru@redhat.com>
 <4e9b4972-b34e-2576-2a45-56e572c64293@redhat.com>
 <87h7uzxk2d.fsf@dusky.pond.sub.org>
Date: Thu, 02 Jul 2020 14:11:03 +0200
In-Reply-To: <87h7uzxk2d.fsf@dusky.pond.sub.org> (Markus Armbruster's message
 of "Thu, 25 Jun 2020 17:05:14 +0200")
Message-ID: <87h7uq9kx4.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 03:23:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, vsementsov@virtuozzo.com, berrange@redhat.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus Armbruster <armbru@redhat.com> writes:

> Eric Blake <eblake@redhat.com> writes:
>
>> On 6/24/20 11:43 AM, Markus Armbruster wrote:
>>> Pass &error_abort instead of NULL where the returned value is
>>> dereferenced or asserted to be non-null.
>>>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>
>>> @@ -63,8 +64,8 @@ hwaddr platform_bus_get_mmio_addr(PlatformBusDevice *pbus, SysBusDevice *sbdev,
>>>           return -1;
>>>       }
>>>   -    parent_mr = object_property_get_link(OBJECT(sbdev_mr),
>>> "container", NULL);
>>> -
>>> +    parent_mr = object_property_get_link(OBJECT(sbdev_mr), "container",
>>> +                                         &error_abort);
>>>       assert(parent_mr);
>>
>> Do we still need to keep the assert?
>
> Not really, I guess.
>
>>> +++ b/hw/ppc/spapr_pci_nvlink2.c
>>> @@ -141,9 +141,10 @@ static void spapr_phb_pci_collect_nvgpu(PCIBus *bus, PCIDevice *pdev,
>>>       if (tgt) {
>>>           Error *local_err = NULL;
>>>           SpaprPhbPciNvGpuConfig *nvgpus = opaque;
>>> -        Object *mr_gpu = object_property_get_link(po, "nvlink2-mr[0]", NULL);
>>> +        Object *mr_gpu = object_property_get_link(po, "nvlink2-mr[0]",
>>> +                                                  &error_abort);
>>>           Object *mr_npu = object_property_get_link(po, "nvlink2-atsd-mr[0]",
>>> -                                                  NULL);
>>> +                                                  &error_abort);
>>>             g_assert(mr_gpu || mr_npu);
>>
>> Likewise.
>
> I'll drop both unless somebody objects.

The second hunk needs to be dropped instead: either of the two
object_property_get_link() may fail, just not both.


