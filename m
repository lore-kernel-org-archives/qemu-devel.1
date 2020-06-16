Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B3CC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 15:03:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCD6920644
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 15:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bPTVmjUT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCD6920644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlD7r-0001Jn-W6
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 11:03:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jlCii-0002UA-EI
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 10:37:48 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53253
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jlCif-0001dM-Rk
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 10:37:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592318264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2c5Wri+RHUpDn0MuyRPYVPPmdqaowYIcLWP9cT6K7DQ=;
 b=bPTVmjUTVYNjPpQDU1Owi0x7SJoN2bG+c/D5fEU+Ek83HegGhGWcT51E1uQhkszxSVmFOV
 w8C/1l6c0ArhwC3NNWQvBVhmFmvlnhPm2W9MFT45Y/6n8ZpJ+R1Qe5nJi4PN/pwxGh7Xim
 Pg9ABadBi6MtczPv0wfBesu/uwEhKY0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499--27T4Qx-PKOBhJ8Qk6sB_A-1; Tue, 16 Jun 2020 10:37:28 -0400
X-MC-Unique: -27T4Qx-PKOBhJ8Qk6sB_A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 829498CFF2B;
 Tue, 16 Jun 2020 14:37:21 +0000 (UTC)
Received: from [10.36.114.197] (ovpn-114-197.ams2.redhat.com [10.36.114.197])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 027905C1D2;
 Tue, 16 Jun 2020 14:37:00 +0000 (UTC)
Subject: Re: [PATCH v2 4/5] acpi: Enable TPM IRQ
To: Stefan Berger <stefanb@linux.ibm.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20200615142327.671546-1-stefanb@linux.vnet.ibm.com>
 <20200615142327.671546-5-stefanb@linux.vnet.ibm.com>
 <CAMxuvaxm+5Nuv2_1UTXY+-kK1CYMkxqU2pfLOxMgeDEqOjhgZA@mail.gmail.com>
 <8e11e2d6-5e02-89c0-759f-d74189421eec@linux.ibm.com>
 <ab78ab4a-a3e3-64bb-ff81-413c17c21f24@redhat.com>
 <dd1175fb-a3af-8c33-c7d5-02dd1e29e2dd@linux.ibm.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <161f92a0-9529-1c41-2ede-b4a7af85ed12@redhat.com>
Date: Tue, 16 Jun 2020 16:36:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <dd1175fb-a3af-8c33-c7d5-02dd1e29e2dd@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eric.auger@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 02:45:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, "Bonzini,
 Paolo" <pbonzini@redhat.com>, Philippe Mathieu Daude <philmd@redhat.com>,
 Marek Kedzierski <mkedzier@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Stefan,

On 6/16/20 4:05 PM, Stefan Berger wrote:
> On 6/16/20 9:01 AM, Auger Eric wrote:
>> Hi Stefan,
>>
>> On 6/15/20 7:11 PM, Stefan Berger wrote:
>>> On 6/15/20 11:13 AM, Marc-André Lureau wrote:
>>>>> diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
>>>>> index 1a2a57a21f..063a9eb42a 100644
>>>>> --- a/include/hw/acpi/tpm.h
>>>>> +++ b/include/hw/acpi/tpm.h
>>>>> @@ -24,7 +24,7 @@
>>>>>    #define TPM_TIS_ADDR_BASE           0xFED40000
>>>>>    #define TPM_TIS_ADDR_SIZE           0x5000
>>>>>
>>>>> -#define TPM_TIS_IRQ                 5
>>>>> +#define TPM_TIS_IRQ                 13
>>>
>>> Eric,
>>>
>>>   does this change have any negative side effects on ARM? If you prefer,
>>> we can split this part here up into TPM_TIS_ISA_IRQ and TPM_TIS_SYSBUS
>>> IRQ and leave the latter at '5' because we know that this is working.
>> The IRQ is not advertised in dt nor ACPI on ARM. However it is
>> advertised in the capability reg and in the vector. reg So I think this
>> should be fixed? I guess on ARM we will pick up a completely different
>> IRQ num, allocated from the platform bus slot.
> 
> 
> The specification
> 
> https://trustedcomputinggroup.org/wp-content/uploads/PC-Client-Specific-Platform-TPM-Profile-for-TPM-2p0-v1p04_r0p37_pub-1.pdf
> 
> 
> declares several fields in the Interface Capability Register (table 23,
> pdf page 89) to be mandatory and they must be set to '1'. So I would not
> want to touch those. We can set the interrupt vector register to '0' in
> case interrupts are not supported. Following the spec 0 means that no
> interrupts are supported. I will now split TPM_TIS_IRQ into
> TPM_TIS_ISA_IRQ and TPM_TIS_SYSBUS_IRQ and will in the end set
> TPM_TIS_SYSBUS_IRQ to 'disabled', indicating that IRQs are not
> supported, though they should work even though on ARM there may not be a
> driver to test this with. Does this sound ok?

Yes it does.

Thanks

Eric
> 
> 
>    Stefan
> 
> 
>>
>> Thanks
>>
>> Eric
>>>     Stefan
>>>
>>>
>>>>>    #define TPM_TIS_NUM_LOCALITIES      5     /* per spec */
>>>>>    #define TPM_TIS_LOCALITY_SHIFT      12
>>>>> -- 
>>>>> 2.24.1
>>>>>
> 
> 


