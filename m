Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28153C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 13:27:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4FBA20674
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 13:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZiiDCLvs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4FBA20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyEmX-0001ki-82
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 09:27:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jyElq-0000um-Q3
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 09:26:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28209
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jyElp-000180-5M
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 09:26:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595424412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uJC4GIX+nGhAhxODYBvJGLRCLaTNMVYU1BJVMof6Jfk=;
 b=ZiiDCLvs1Dc0lxMSPTHbJ9lW1fcYn8a+WrandveAyX27AIW/8+s7nUdZoi4k7lm/8xtIgn
 VJxG9WY0y5AtVLMEk4WRnamrpE8Pm0ArgMa+Feek/pjR+G1sly9IBM9OWUMS4f+V+OzbGS
 6Lieuq4Z1kQSwNWpZRTzUUP8E+CFM+0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-oHP21d7COZSBxZ-e74pxhg-1; Wed, 22 Jul 2020 09:26:50 -0400
X-MC-Unique: oHP21d7COZSBxZ-e74pxhg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92B0957;
 Wed, 22 Jul 2020 13:26:49 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-113-129.ams2.redhat.com
 [10.36.113.129])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A16BE78540;
 Wed, 22 Jul 2020 13:26:48 +0000 (UTC)
Subject: Re: [PATCH 1/6] x86: lpc9: let firmware negotiate 'CPU hotplug with
 SMI' features
From: Laszlo Ersek <lersek@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200720141610.574308-1-imammedo@redhat.com>
 <20200720141610.574308-2-imammedo@redhat.com>
 <00b7e32c-36ad-a71a-00da-d1f0d9977e79@redhat.com>
Message-ID: <2d97286a-2e8e-dd6b-822c-58959d0a74e2@redhat.com>
Date: Wed, 22 Jul 2020 15:26:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <00b7e32c-36ad-a71a-00da-d1f0d9977e79@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=lersek@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 00:40:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: boris.ostrovsky@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/22/20 14:03, Laszlo Ersek wrote:
> On 07/20/20 16:16, Igor Mammedov wrote:
>> It will allow firmware to notify QEMU that firmware requires SMI
>> being triggered on CPU hot[un]plug, so that it would be able to account
>> for hotplugged CPU and relocate it to new SMM base and/or safely remove
>> CPU on unplug.
>>
>> Using negotiated features, follow up patches will insert SMI upcall
>> into AML code, to make sure that firmware processes hotplug before
>> guest OS would attempt to use new CPU.
>>
>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>> ---
>>  include/hw/i386/ich9.h |  2 ++
>>  hw/i386/pc.c           |  5 ++++-
>>  hw/isa/lpc_ich9.c      | 12 ++++++++++++
>>  3 files changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/hw/i386/ich9.h b/include/hw/i386/ich9.h
>> index a98d10b252..d1bb3f7bf0 100644
>> --- a/include/hw/i386/ich9.h
>> +++ b/include/hw/i386/ich9.h
>> @@ -247,5 +247,7 @@ typedef struct ICH9LPCState {
>>  
>>  /* bit positions used in fw_cfg SMI feature negotiation */
>>  #define ICH9_LPC_SMI_F_BROADCAST_BIT            0
>> +#define ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT          1
>> +#define ICH9_LPC_SMI_F_CPU_HOT_UNPLUG_BIT       2
>>  
>>  #endif /* HW_ICH9_H */
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index 3d419d5991..57d50fad6b 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -97,7 +97,10 @@
>>  #include "fw_cfg.h"
>>  #include "trace.h"
>>  
>> -GlobalProperty pc_compat_5_0[] = {};
>> +GlobalProperty pc_compat_5_0[] = {
>> +    { "ICH9-LPC", "x-smi-cpu-hotplug", "off" },
>> +    { "ICH9-LPC", "x-smi-cpu-hotunplug", "off" },
>> +};
>>  const size_t pc_compat_5_0_len = G_N_ELEMENTS(pc_compat_5_0);
>>  
>>  GlobalProperty pc_compat_4_2[] = {
>> diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
>> index cd6e169d47..c9305080b5 100644
>> --- a/hw/isa/lpc_ich9.c
>> +++ b/hw/isa/lpc_ich9.c
>> @@ -373,6 +373,14 @@ static void smi_features_ok_callback(void *opaque)
>>          /* guest requests invalid features, leave @features_ok at zero */
>>          return;
>>      }
>> +    if (!(guest_features & BIT_ULL(ICH9_LPC_SMI_F_BROADCAST_BIT)) &&
>> +        guest_features & (BIT_ULL(ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT) |
>> +                          BIT_ULL(ICH9_LPC_SMI_F_CPU_HOT_UNPLUG_BIT))) {
>> +        /* cpu hot-[un]plug with SMI requires SMI broadcast,
>> +         * leave @features_ok at zero
>> +         */
>> +        return;
>> +    }
>>  
>>      /* valid feature subset requested, lock it down, report success */
>>      lpc->smi_negotiated_features = guest_features;
>> @@ -747,6 +755,10 @@ static Property ich9_lpc_properties[] = {
>>      DEFINE_PROP_BOOL("noreboot", ICH9LPCState, pin_strap.spkr_hi, true),
>>      DEFINE_PROP_BIT64("x-smi-broadcast", ICH9LPCState, smi_host_features,
>>                        ICH9_LPC_SMI_F_BROADCAST_BIT, true),
>> +    DEFINE_PROP_BIT64("x-smi-cpu-hotplug", ICH9LPCState, smi_host_features,
>> +                      ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT, true),
>> +    DEFINE_PROP_BIT64("x-smi-cpu-hotunplug", ICH9LPCState, smi_host_features,
>> +                      ICH9_LPC_SMI_F_CPU_HOT_UNPLUG_BIT, true),
>>      DEFINE_PROP_END_OF_LIST(),
>>  };
>>  
>>
> 
> (1) I think that, at this time, the default value for
> "x-smi-cpu-hotunplug" should be false. Accordingly, the
> "x-smi-cpu-hotunplug" compat property should be dropped.
> 
> The reason is that in this series, QEMU won't actually learn to handle
> CPU hot-unplug with SMI. We shouldn't advertize support for it.
> 
> We should only recognize the feature, so that the QMP command can rely
> on it for rejecting hot-unplug attempts. If (later) we have a more
> advanced OVMF binary with unplug support (so that OVMF would try to
> negotiate unplug), but the user runs it on QEMU-5.1 (or more precisely
> with an 5.1 machine type), which will support plug, but not unplug, then
> QEMU should reject the device_del QMP command.
> 
> In brief, we need both properties because we want both device_add and
> device_del to fail gracefully, but the default values (and accordingly
> the compat properties) should reflect the actual feature support. So
> unplug should default to false at this point.

With (1) updated:

Reviewed-by: Laszlo Ersek <lersek@redhat.com>


