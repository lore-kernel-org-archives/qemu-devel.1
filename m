Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F059C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 09:00:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A6792088E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 09:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J3XTyZry"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A6792088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqv5K-00016n-B6
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 05:00:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jqv4R-0000h4-Ex
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 04:59:51 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57821
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jqv4P-0005rE-11
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 04:59:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593680387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wJrIK/msXF7xBKKjccnxf+nVulw/csILNSIMFsRua3c=;
 b=J3XTyZry2sUZg9yXJqfm/t7Xpj4F7RFDdakZ2h9wuaIqbT7ZV0qhf4dDk3/k0MwXFDx/+j
 p0cgDt+ZzvCZTbDecKb03Rn6Lbm0WHsRfSKTnjFddH5XXxxpeaMXiLPLqZI3q8lSfkfitT
 1Q0iJipWqvqvaGIZrBEHZ60Jbr/aiTA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-sQ_eNTBRMsaYotfSDge5pw-1; Thu, 02 Jul 2020 04:59:46 -0400
X-MC-Unique: sQ_eNTBRMsaYotfSDge5pw-1
Received: by mail-wm1-f69.google.com with SMTP id b13so25585750wme.9
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 01:59:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wJrIK/msXF7xBKKjccnxf+nVulw/csILNSIMFsRua3c=;
 b=eUZTcgF8S6T1tbRnHv7kngD7TZVFppwsd0ERx3FtuRCd+puCQKhFSU2aNoMZE1CB2P
 r00hjp1Yosw2MOcVBIXkRM2ZDP+cmQIo7BVranidaULp4wrYUNbOAcKv6ikEEYlJvG5N
 G3WKlrMhxSjBYF4WDeKPSCW2c7JB34K0NhKoLF/arsZ3xJZhUtZdAlb5vwDJXmSc8guZ
 OppKHx5eVa1Riaq+VnPF0u99PvUdFLE+UGM1hNae+FW30wCP5doszY3wksALwv7eBVsI
 0ZuFUEwPuxobsYSHSI68REP7/zfV3yagJ+X/q1sF9B3aY71p7r+Od8x/olIcqvrZ8nv1
 jp9w==
X-Gm-Message-State: AOAM5337uld5DlREfV/AJjkIWHPt1ysJza2lmLwZilihU27iJrRsaYM7
 9XXIlAtwbDOnqlsJfcnrHCYgtYkhHocRsgOxz7vyuaw9I9fpOC0UCtB1Smd/Fgai+grAVUT9PYC
 u8lmYUUq9SkDFCWk=
X-Received: by 2002:a1c:cc0d:: with SMTP id h13mr33306490wmb.168.1593680385291; 
 Thu, 02 Jul 2020 01:59:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGKVrkvYUMrupWzfmoSSjOGbJBibXAbQlk7LdbXdq3RsbOaOv5IcnUK/o9hvnnPGxj0SwYqg==
X-Received: by 2002:a1c:cc0d:: with SMTP id h13mr33306466wmb.168.1593680385035; 
 Thu, 02 Jul 2020 01:59:45 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:2cad:376b:7d21:868e?
 ([2001:b07:6468:f312:2cad:376b:7d21:868e])
 by smtp.gmail.com with ESMTPSA id p14sm11172163wrj.14.2020.07.02.01.59.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2020 01:59:44 -0700 (PDT)
Subject: Re: [PATCH v3 20/26] x86: Fix x86_cpu_new() error handling
To: Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>
References: <20200630090351.1247703-1-armbru@redhat.com>
 <20200630090351.1247703-21-armbru@redhat.com>
 <87h7uq7c42.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3f549d5f-18a2-886d-193c-052865fefff3@redhat.com>
Date: Thu, 2 Jul 2020 10:59:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <87h7uq7c42.fsf@dusky.pond.sub.org>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 04:18:28
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
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/07/20 06:51, Markus Armbruster wrote:
> Igor, Paolo, you showed me the error in v2.  Could you have a look at
> this revision?
> 
> Markus Armbruster <armbru@redhat.com> writes:
> 
>> The Error ** argument must be NULL, &error_abort, &error_fatal, or a
>> pointer to a variable containing NULL.  Passing an argument of the
>> latter kind twice without clearing it in between is wrong: if the
>> first call sets an error, it no longer points to NULL for the second
>> call.
>>
>> x86_cpu_new() is wrong that way: it passes &local_err to
>> object_property_set_uint() without checking it, and then to
>> qdev_realize().  If both fail, we'll trip error_setv()'s assertion.
>> To assess the bug's impact, we'd need to figure out how to make both
>> calls fail.  Too much work for ignorant me, sorry.
>>
>> Fix by checking for failure right away.
>>
>> Cc: Igor Mammedov <imammedo@redhat.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Richard Henderson <rth@twiddle.net>
>> Cc: Eduardo Habkost <ehabkost@redhat.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  hw/i386/x86.c | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
>> index 34229b45c7..93f7371a56 100644
>> --- a/hw/i386/x86.c
>> +++ b/hw/i386/x86.c
>> @@ -118,14 +118,16 @@ uint32_t x86_cpu_apic_id_from_index(X86MachineState *x86ms,
>>  
>>  void x86_cpu_new(X86MachineState *x86ms, int64_t apic_id, Error **errp)
>>  {
>> -    Object *cpu = NULL;
>>      Error *local_err = NULL;
>> -
>> -    cpu = object_new(MACHINE(x86ms)->cpu_type);
>> +    Object *cpu = object_new(MACHINE(x86ms)->cpu_type);
>>  
>>      object_property_set_uint(cpu, apic_id, "apic-id", &local_err);
>> +    if (local_err) {
>> +        goto out;
>> +    }
>>      qdev_realize(DEVICE(cpu), NULL, &local_err);
>>  
>> +out:
>>      object_unref(cpu);
>>      error_propagate(errp, local_err);
>>  }
> 

Yes, this looks good.  Thanks!

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo


