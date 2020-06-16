Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57EBBC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 12:46:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 258242080D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 12:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NVBIXmLY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 258242080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlAz5-00018a-EJ
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 08:46:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jlAyK-0000fV-5L
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 08:45:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29850
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jlAyI-0007J6-1n
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 08:45:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592311544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zjo8yG+ZCurhZfERnbf9gRDcBaXo626Ho26XCcJmk88=;
 b=NVBIXmLYbS2atjxQtMVMrQCSy5ovqrW2KTOj4xlP42njTZCaBjDRtyH/GUZ1wW12MYbTRo
 RBkIYDaKZbzbe+inezA8P5yODP3kkN2yKimXhN5k8mRXYBnSdd5fqrVdh8ycV8oY7jVjqc
 JdlMzD72jMd/OGsSiZ4xLWwO6h3pdQ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-mwBd8TW8NKeJwcJ2DteukA-1; Tue, 16 Jun 2020 08:45:42 -0400
X-MC-Unique: mwBd8TW8NKeJwcJ2DteukA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD5F0873439;
 Tue, 16 Jun 2020 12:45:41 +0000 (UTC)
Received: from [10.36.114.197] (ovpn-114-197.ams2.redhat.com [10.36.114.197])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0BC887CAB9;
 Tue, 16 Jun 2020 12:45:36 +0000 (UTC)
Subject: Re: [PATCH v2 2/5] tpm: Extend TPMIfClass with get_irqnum() function
To: Stefan Berger <stefanb@linux.ibm.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20200615142327.671546-1-stefanb@linux.vnet.ibm.com>
 <20200615142327.671546-3-stefanb@linux.vnet.ibm.com>
 <CAMxuvayUv9zpnzW93pcQXCFpFX5BZ7ZSRNvJ_XRgLPiyjfa_pQ@mail.gmail.com>
 <9bd4cd70-1e0a-68be-fb83-9604cd7aba12@linux.ibm.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <239d60ae-8c10-68fd-036b-69ef1be3c644@redhat.com>
Date: Tue, 16 Jun 2020 14:45:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <9bd4cd70-1e0a-68be-fb83-9604cd7aba12@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 02:46:07
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
Cc: "Bonzini, Paolo" <pbonzini@redhat.com>,
 Philippe Mathieu Daude <philmd@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Marek Kedzierski <mkedzier@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Stefan,

On 6/15/20 5:44 PM, Stefan Berger wrote:
> On 6/15/20 11:11 AM, Marc-André Lureau wrote:
>> Hi
>>
>> On Mon, Jun 15, 2020 at 6:23 PM Stefan Berger
>> <stefanb@linux.vnet.ibm.com> wrote:
>>> From: Stefan Berger <stefanb@sbct-2.pok.ibm.com>
>>>
>>> Implement get_irqnum() as part of the TPMIfClass to be get the assigned
>> ^^ to get
>>
>>> IRQ number.
>>>
>> Since it is TIS ISA specific (at least for now), perhaps a dedicated
>> tpm_tis_get_irq_num() is more appropriate?
> 
> 
> There's no caller from ARM at the moment but at least it is preparing it
> to support getting the IRQ number since it also allows passing it in via
> command lie. So it wouldn't have any side-effects on ARM for as long as
> no extra code was added there. And once sysbus was to use it, it would
> funnel through the same tpm_get_irqnum code. Other option is to drop the
> parts for sysbus entirely.

As there is no caller on ARM side, I think I would leave the ops
undefined for the sysbus device. But as already reported it does not
break anything on ARM side.

Thanks

Eric
> 
> 
>>
>>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>>> ---
>>>   hw/tpm/tpm_tis_isa.c    |  9 +++++++++
>>>   hw/tpm/tpm_tis_sysbus.c |  9 +++++++++
>>>   include/sysemu/tpm.h    | 10 ++++++++++
>>>   3 files changed, 28 insertions(+)
>>>
>>> diff --git a/hw/tpm/tpm_tis_isa.c b/hw/tpm/tpm_tis_isa.c
>>> index 30ba37079d..63b62f4c21 100644
>>> --- a/hw/tpm/tpm_tis_isa.c
>>> +++ b/hw/tpm/tpm_tis_isa.c
>>> @@ -80,6 +80,14 @@ static enum TPMVersion
>>> tpm_tis_isa_get_tpm_version(TPMIf *ti)
>>>       return tpm_tis_get_tpm_version(s);
>>>   }
>>>
>>> +static uint8_t tpm_tis_isa_get_irqnum(TPMIf *ti)
>>> +{
>>> +    TPMStateISA *isadev = TPM_TIS_ISA(ti);
>>> +    TPMState *s = &isadev->state;
>>> +
>>> +    return s->irq_num;
>>> +}
>>> +
>>>   static void tpm_tis_isa_reset(DeviceState *dev)
>>>   {
>>>       TPMStateISA *isadev = TPM_TIS_ISA(dev);
>>> @@ -148,6 +156,7 @@ static void tpm_tis_isa_class_init(ObjectClass
>>> *klass, void *data)
>>>       dc->reset = tpm_tis_isa_reset;
>>>       tc->request_completed = tpm_tis_isa_request_completed;
>>>       tc->get_version = tpm_tis_isa_get_tpm_version;
>>> +    tc->get_irqnum = tpm_tis_isa_get_irqnum;
>>>   }
>>>
>>>   static const TypeInfo tpm_tis_isa_info = {
>>> diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
>>> index eced1fc843..6cf45e5057 100644
>>> --- a/hw/tpm/tpm_tis_sysbus.c
>>> +++ b/hw/tpm/tpm_tis_sysbus.c
>>> @@ -80,6 +80,14 @@ static enum TPMVersion
>>> tpm_tis_sysbus_get_tpm_version(TPMIf *ti)
>>>       return tpm_tis_get_tpm_version(s);
>>>   }
>>>
>>> +static uint8_t tpm_tis_sysbus_get_irqnum(TPMIf *ti)
>>> +{
>>> +    TPMStateSysBus *sbdev = TPM_TIS_SYSBUS(ti);
>>> +    TPMState *s = &sbdev->state;
>>> +
>>> +    return s->irq_num;
>>> +}
>>> +
>>>   static void tpm_tis_sysbus_reset(DeviceState *dev)
>>>   {
>>>       TPMStateSysBus *sbdev = TPM_TIS_SYSBUS(dev);
>>> @@ -137,6 +145,7 @@ static void tpm_tis_sysbus_class_init(ObjectClass
>>> *klass, void *data)
>>>       dc->reset = tpm_tis_sysbus_reset;
>>>       tc->request_completed = tpm_tis_sysbus_request_completed;
>>>       tc->get_version = tpm_tis_sysbus_get_tpm_version;
>>> +    tc->get_irqnum = tpm_tis_sysbus_get_irqnum;
>>>   }
>>>
>>>   static const TypeInfo tpm_tis_sysbus_info = {
>>> diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
>>> index 03fb25941c..b94a8a2b16 100644
>>> --- a/include/sysemu/tpm.h
>>> +++ b/include/sysemu/tpm.h
>>> @@ -41,6 +41,7 @@ typedef struct TPMIfClass {
>>>       enum TpmModel model;
>>>       void (*request_completed)(TPMIf *obj, int ret);
>>>       enum TPMVersion (*get_version)(TPMIf *obj);
>>> +    uint8_t (*get_irqnum)(TPMIf *obj);
>>>   } TPMIfClass;
>>>
>>>   #define TYPE_TPM_TIS_ISA            "tpm-tis"
>>> @@ -74,4 +75,13 @@ static inline TPMVersion tpm_get_version(TPMIf *ti)
>>>       return TPM_IF_GET_CLASS(ti)->get_version(ti);
>>>   }
>>>
>>> +static inline uint8_t tpm_get_irqnum(TPMIf *ti)
>>> +{
>>> +    if (!ti || !TPM_IF_GET_CLASS(ti)->get_irqnum) {
>>> +        return 0;
>>> +    }
>>> +
>>> +    return TPM_IF_GET_CLASS(ti)->get_irqnum(ti);
>>> +}
>>> +
>>>   #endif /* QEMU_TPM_H */
>>> -- 
>>> 2.24.1
>>>
> 


