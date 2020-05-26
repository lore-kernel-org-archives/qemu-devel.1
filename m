Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E127BC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 08:03:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5A2420776
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 08:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cSMh1CHS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5A2420776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdUYi-0006RJ-R2
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 04:03:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jdUSg-0004Oq-Ru
 for qemu-devel@nongnu.org; Tue, 26 May 2020 03:57:22 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27444
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jdUSg-0002uZ-0M
 for qemu-devel@nongnu.org; Tue, 26 May 2020 03:57:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590479840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=PtUSePRBf50R/oUdD69YUYtqmxlvL02IAV21d3N/zVA=;
 b=cSMh1CHSOCKHpTgR7xFGE1lieE8tR3vH7ENSKxfwIp1Oip5VeUwERQfBTJYBlLd8HJY+wo
 5mXejJCaexTXW18UAW3+/DWbJ+/5hhfBRbAFFar7vh7U+tIEzRfKRiVefPCG3U2SHOQUsF
 vi1/wxrcSAxjJ2PdvXjkGMpMpgWWHAQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-4I9IpcrxM5KExalV00GNOg-1; Tue, 26 May 2020 03:57:19 -0400
X-MC-Unique: 4I9IpcrxM5KExalV00GNOg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C8D8800688;
 Tue, 26 May 2020 07:57:17 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-138.ams2.redhat.com [10.36.112.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A5B0F5C1BB;
 Tue, 26 May 2020 07:57:14 +0000 (UTC)
Subject: Re: [PATCH 1/2] hw/mips/mips_int: De-duplicate KVM interrupt delivery
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 chen huacai <zltjiangshi@gmail.com>, qemu-level <qemu-devel@nongnu.org>
References: <20200429082916.10669-1-f4bug@amsat.org>
 <20200429082916.10669-2-f4bug@amsat.org>
 <CABDp7VoyvX2vD6awEC-GwnEu8SW=pMPPR7mrfKCSzamrnomPKg@mail.gmail.com>
 <dc94a9f4-b6c9-97fa-4515-3e51ef9b816a@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <193e8262-fa43-2132-02ae-e8bceca86c80@redhat.com>
Date: Tue, 26 May 2020 09:57:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <dc94a9f4-b6c9-97fa-4515-3e51ef9b816a@amsat.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:14:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Huacai Chen <chenhuacai@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/05/2020 09.08, Philippe Mathieu-Daudé wrote:
> On 4/29/20 10:48 AM, chen huacai wrote:
>> Hi, Philippe,
>>
>> On Wed, Apr 29, 2020 at 4:30 PM Philippe Mathieu-Daudé
>> <f4bug@amsat.org> wrote:
>>>
>>> Refactor duplicated code in a single place.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>> ---
>>>   hw/mips/mips_int.c | 11 +++--------
>>>   1 file changed, 3 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/hw/mips/mips_int.c b/hw/mips/mips_int.c
>>> index 796730b11d..4a1bf846da 100644
>>> --- a/hw/mips/mips_int.c
>>> +++ b/hw/mips/mips_int.c
>>> @@ -47,17 +47,12 @@ static void cpu_mips_irq_request(void *opaque,
>>> int irq, int level)
>>>
>>>       if (level) {
>>>           env->CP0_Cause |= 1 << (irq + CP0Ca_IP);
>>> -
>>> -        if (kvm_enabled() && irq == 2) {
>>> -            kvm_mips_set_interrupt(cpu, irq, level);
>>> -        }
>>> -
>>>       } else {
>>>           env->CP0_Cause &= ~(1 << (irq + CP0Ca_IP));
>>> +    }
>>>
>>> -        if (kvm_enabled() && irq == 2) {
>>> -            kvm_mips_set_interrupt(cpu, irq, level);
>>> -        }
>>> +    if (kvm_enabled() && irq == 2) {
>>> +        kvm_mips_set_interrupt(cpu, irq, level);
>>>       }
>>>
>>>       if (env->CP0_Cause & CP0Ca_IP_mask) {
>>> -- 
>>> 2.21.1

Reviewed-by: Thomas Huth <thuth@redhat.com>


