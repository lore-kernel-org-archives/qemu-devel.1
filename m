Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D339C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 09:37:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C88632166E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 09:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LHxayFm5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C88632166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFa3v-0003cH-08
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 05:37:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kFa2b-0002HU-Ke
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 05:35:53 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52970
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kFa2Z-0002Pn-JK
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 05:35:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599557748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TEsaTo+4WrM0UZYUBOWSxdNcNiD7j+NZtzZOFhLqDzM=;
 b=LHxayFm5/8mgkp0A76MziUDpowN2x2G2jLj9XBVy5jWgt3vyufRJm1hf7+o9nCKdle0HBi
 2QCH2kfoAczBz7d18OIitTWD0DVtPXWT61oWsLkSXhc4PPn+VlEksrEMUXz9vm8NpIyVWw
 ryDGOG31WGsRo47wHSCmS3POszOvdeA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-bgqJBckNNH-alh1EvkW2Cw-1; Tue, 08 Sep 2020 05:35:47 -0400
X-MC-Unique: bgqJBckNNH-alh1EvkW2Cw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0324A1084C85;
 Tue,  8 Sep 2020 09:35:46 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-112-122.ams2.redhat.com
 [10.36.112.122])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C4B421002D40;
 Tue,  8 Sep 2020 09:35:44 +0000 (UTC)
Subject: Re: [PATCH v5 09/10] x68: acpi: trigger SMI before sending hotplug
 Notify event to OSPM
To: Igor Mammedov <imammedo@redhat.com>
References: <20200907112348.530921-1-imammedo@redhat.com>
 <20200907112348.530921-10-imammedo@redhat.com>
 <cb3f326a-97ec-7b88-729d-eb11ed7aeb5e@redhat.com>
 <20200908093933.1b33ab5b@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <83fc69bf-cf64-06f9-522f-e5b3adebd7b7@redhat.com>
Date: Tue, 8 Sep 2020 11:35:43 +0200
MIME-Version: 1.0
In-Reply-To: <20200908093933.1b33ab5b@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 01:08:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: boris.ostrovsky@oracle.com, qemu-devel@nongnu.org, aaron.young@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/08/20 09:39, Igor Mammedov wrote:
> On Mon, 7 Sep 2020 17:17:52 +0200
> Laszlo Ersek <lersek@redhat.com> wrote:

>>    1              Method (CSCN, 0, Serialized)
>>    2              {
>>    3                  Acquire (\_SB.PCI0.PRES.CPLK, 0xFFFF)
>>    4                  Name (CNEW, Package (0xFF){})
>>    5                  Local_Uid = Zero
>>    6                  Local_HasJob = One
>>    7                  While ((Local_HasJob == One))
>>    8                  {
>>    9                      Local_HasJob = Zero
>>   10                      Local_HasEvent = One
>>   11                      Local_NumAddedCpus = Zero
>>   12                      While (((Local_HasEvent == One) && (Local_Uid < 0x08)))
>>   13                      {
>>   14                          Local_HasEvent = Zero
>>   15                          \_SB.PCI0.PRES.CSEL = Local_Uid
>>   16                          \_SB.PCI0.PRES.CCMD = Zero
>>   17                          If ((\_SB.PCI0.PRES.CDAT < Local_Uid))
>>   18                          {
>>   19                              Break
>>   20                          }
>>   21
>>   22                          If ((Local_NumAddedCpus == 0xFF))
>>   23                          {
>>   24                              Local_HasJob = One
>>   25                              Break
>>   26                          }
>>   27
>>   28                          Local_Uid = \_SB.PCI0.PRES.CDAT
>>   29                          If ((\_SB.PCI0.PRES.CINS == One))
>>   30                          {
>>   31                              CNEW [Local_NumAddedCpus] = Local_Uid
>>   32                              Local_NumAddedCpus++
>>   33                              Local_HasEvent = One
>>   34                          }
>>   35                          ElseIf ((\_SB.PCI0.PRES.CRMV == One))
>>   36                          {
>>   37                              CTFY (Local_Uid, 0x03)
>>   38                              \_SB.PCI0.PRES.CRMV = One
>>   39                              Local_HasEvent = One
>>   40                          }
>>   41
>>   42                          Local_Uid++
>>   43                      }
>>   44
>>   45                      If ((Local_NumAddedCpus > Zero))
>>   46                      {
>>   47                          \_SB.PCI0.SMI0.SMIC = 0x04
>>   48                      }
>>   49
>>   50                      Local_CpuIdx = Zero
>>   51                      While ((Local_CpuIdx < Local_NumAddedCpus))
>>   52                      {
>>   53                          Local_Uid = DerefOf (CNEW [Local_CpuIdx])
>>   54                          CTFY (Local_Uid, One)
>>   55                          Debug = Local_Uid
>>   56                          \_SB.PCI0.PRES.CSEL = Local_Uid
>>   57                          \_SB.PCI0.PRES.CINS = One
>>   58                          Local_CpuIdx++
>>   59                      }
>>   60                  }
>>   61
>>   62                  Release (\_SB.PCI0.PRES.CPLK)
>>   63              }
>>
>> When we take the Break on line 25, then:
>>
>> (a) on line 25, the following equality holds:
>>
>>   Local_Uid == CNEW[Local_NumAddedCpus - 1] + 1
>>
>> (b) on line 60, the following equality holds:
>>
>>   Local_Uid == CNEW[Local_NumAddedCpus - 1]
>>
>> This means that, when we write Local_Uid to CSEL on line 15 again, then:
>>
>> - we effectively re-investigate the last-cached CPU (with selector value
>>   CNEW[Local_NumAddedCpus - 1])
>>
>> - rather than resuming the scanning right after it -- that is, with
>>   selector value (CNEW[Local_NumAddedCpus - 1] + 1) --, in the spirit of
>>   line 42.
>>
>> My question is: is this "rewind" intentional?
>>
>> Now, I don't see a functionality problem with this, as on line 57, we
>> clear the pending insert event for the last-cached CPU, so when we
>> re-check it, the "get pending" command will simply seek past it.
>>
>> But I'd like to understand if this is *precisely* your intent, or if
>> it's an oversight and it just ends up working OK.
> it's the later (it should not have any adverse effects) so I didn't care
> much about restarting from the last processed CPU.
>
> how about moving
>
>   22                          If ((Local_NumAddedCpus == 0xFF))
>   23                          {
>   24                              Local_HasJob = One
>   25                              Break
>   26                          }
>
> right after
>   40                          }
>   41
>   42                          Local_Uid++
>
> instead of adding extra 'if' at the end of outer loop?

That only seems to save a CSEL write on line 15, during the first
iteration of the outer loop. And we would still re-select the last
selector from CNEW, in the second iteration of the outer loop.

But, again, there's no bug; I just wanted to understand your intent.

Can you please squash the following patch:

> diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
> index 12839720018e..8dd4d8ebbf55 100644
> --- a/hw/acpi/cpu.c
> +++ b/hw/acpi/cpu.c
> @@ -601,6 +601,15 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
>                      aml_append(while_ctx, aml_increment(cpu_idx));
>                  }
>                  aml_append(while_ctx2, while_ctx);
> +                /*
> +                 * If another batch is needed, then it will resume scanning
> +                 * exactly at -- and not after -- the last CPU that's currently
> +                 * in CPU_ADDED_LIST. In other words, the last CPU in
> +                 * CPU_ADDED_LIST is going to be re-checked. That's OK: we've
> +                 * just cleared the insert event for *all* CPUs in
> +                 * CPU_ADDED_LIST, including the last one. So the scan will
> +                 * simply seek past it.
> +                 */
>              }
>              aml_append(method, while_ctx2);
>              aml_append(method, aml_release(ctrl_lock));

With that:

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

I'll also follow up with test results for this patch (meaning a lowered
"max_cpus_per_pass").

Thanks!
Laszlo


