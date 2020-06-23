Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E7DC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 08:58:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92B3C20723
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 08:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sq+Hygix"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92B3C20723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnelT-0001Bu-02
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 04:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jnekL-0008LU-Nm
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 04:57:37 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45990
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jnekI-0006YP-Sj
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 04:57:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592902653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PwnNkSSLNm21MzqVaxdTINJqwXdipq/VGsfWclkg5wk=;
 b=Sq+HygixVJslHBb8G+/9p4qi+BXls+LFXkgMBlKYKitLKBg7urjScC2bmMkOMcb5KDqSZg
 02114mc/OOs0JsMiESjffLx4qNIFZvMlGWErphVjncO5yBs5+UpB+UDazLoOR+de/V/TIM
 TqMuFg6icEtl3ZnFzVaKWcX2PW99DoI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-QzDdPiAAP_eByibKIpzufA-1; Tue, 23 Jun 2020 04:57:31 -0400
X-MC-Unique: QzDdPiAAP_eByibKIpzufA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 644C11005512;
 Tue, 23 Jun 2020 08:57:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CF18E5C660;
 Tue, 23 Jun 2020 08:57:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4E699113846D; Tue, 23 Jun 2020 10:57:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v3 1/5] qdev: Introduce DEFINE_PROP_RESERVED_REGION
References: <20200611151209.22547-1-eric.auger@redhat.com>
 <20200611151209.22547-2-eric.auger@redhat.com>
 <87k0zzz6nt.fsf@dusky.pond.sub.org>
 <f0ec7470-d683-1bfd-103d-54c57ebd3863@redhat.com>
Date: Tue, 23 Jun 2020 10:57:15 +0200
In-Reply-To: <f0ec7470-d683-1bfd-103d-54c57ebd3863@redhat.com> (Auger Eric's
 message of "Tue, 23 Jun 2020 10:22:47 +0200")
Message-ID: <87r1u6jh1w.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 02:54:39
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
Cc: peter.maydell@linaro.org, jean-philippe@linaro.org, mst@redhat.com,
 qemu-devel@nongnu.org, peterx@redhat.com, qemu-arm@nongnu.org,
 pbonzini@redhat.com, bbhushan2@marvell.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Auger Eric <eric.auger@redhat.com> writes:

> Hi Markus,
>
> On 6/22/20 1:22 PM, Markus Armbruster wrote:
>> Eric Auger <eric.auger@redhat.com> writes:
>> 
>>> Introduce a new property defining a reserved region:
>>> <low address>, <high address>, <type>.
>>>
>>> This will be used to encode reserved IOVA regions.
>>>
>>> For instance, in virtio-iommu use case, reserved IOVA regions
>>> will be passed by the machine code to the virtio-iommu-pci
>>> device (an array of those). The type of the reserved region
>>> will match the virtio_iommu_probe_resv_mem subtype value:
>>> - VIRTIO_IOMMU_RESV_MEM_T_RESERVED (0)
>>> - VIRTIO_IOMMU_RESV_MEM_T_MSI (1)
>>>
>>> on PC/Q35 machine, this will be used to inform the
>>> virtio-iommu-pci device it should bypass the MSI region.
>>> The reserved region will be: 0xfee00000, 0xfeefffff, 1.
>>>
>>> On ARM, we can declare the ITS MSI doorbell as an MSI
>>> region to prevent MSIs from being mapped on guest side.
>>>
>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
[...]
>>> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
>>> index cc924815da..15b84adbee 100644
>>> --- a/hw/core/qdev-properties.c
>>> +++ b/hw/core/qdev-properties.c
[...]
>>> +static void set_reserved_region(Object *obj, Visitor *v, const char *name,
>>> +                                void *opaque, Error **errp)
>>> +{
>>> +    DeviceState *dev = DEVICE(obj);
>>> +    Property *prop = opaque;
>>> +    ReservedRegion *rr = qdev_get_prop_ptr(dev, prop);
>>> +    Error *local_err = NULL;
>>> +    const char *endptr;
>>> +    char *str;
>>> +    int ret;
>>> +
>>> +    if (dev->realized) {
>>> +        qdev_prop_set_after_realize(dev, name, errp);
>>> +        return;
>>> +    }
>>> +
>>> +    visit_type_str(v, name, &str, &local_err);
>>> +    if (local_err) {
>>> +        error_propagate(errp, local_err);
>>> +        return;
>>> +    }
>>> +
>>> +    ret = qemu_strtou64(str, &endptr, 16, &rr->low);
>>> +    if (ret) {
>>> +        error_setg(errp, "Failed to decode reserved region low addr");
>>> +        error_append_hint(errp,
>>> +                          "should be an address in hexadecimal\n");
>> 
>> Comes out like this:
>> 
>>     qemu-system-x86_64: -device ...: Failed to decode reserved region low addr
>>     should be an address in hexadecimal
>> 
>> I'd capitalize the other way, to get
>> 
>>     qemu-system-x86_64: -device ...: failed to decode reserved region low addr
>>     Should be an address in hexadecimal
>> 
>> Note: output is made up; I failed at figuring out how to use the new
>> property.  An example in PATCH 4's commit message might help.
> OK I will add one example. In practice in the virtio-iommu case the
> property is not really meant to be passed by the end-user but should be
> set by the machine code. However I have just tested from the cmd line
> and it looks using commas as separators is a bad idea because it
> collides with ',' separating properties. So if you're OK I will change
> the comma into ':'.

Please do.

[...]


