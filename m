Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98062C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 00:45:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 620C9206DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 00:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VcR6KXCW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 620C9206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtKge-0000ge-Lx
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 20:45:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49106)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jtKeX-00070i-SO
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 20:43:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58418
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jtKeV-0001mf-PU
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 20:43:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594255383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HC4ZhD5xH1OoGbJtx9xSSEoRAmbLPFa1Dv6pfKxMs7E=;
 b=VcR6KXCWH2f4wmUqPxqpEHVIZyQtvFkZgmfQRkCZSX/w9TwVJBDq58+y89MtUDnMUTibmi
 X8MdNxFo/76/4PEMzeddXvEOhWfNdL9BOhWboTbdfcv+ZxqwiabR4UmVMvE/Koly2seFKF
 SWfPa6BZh/b5/8dln5oXK7AVXFWfwE4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-4vEQpbxYO8up8krntD8wpA-1; Wed, 08 Jul 2020 04:38:32 -0400
X-MC-Unique: 4vEQpbxYO8up8krntD8wpA-1
Received: by mail-wr1-f71.google.com with SMTP id c6so32126156wru.7
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 01:38:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=HC4ZhD5xH1OoGbJtx9xSSEoRAmbLPFa1Dv6pfKxMs7E=;
 b=ultzke/EeHsPmmKTTpolHPeXiI5AT36Ip5jx++0QGJmm7cOQGUYZOSyvP+kVon16/X
 2kA5BNG/t4mqdhQ4G8qvZQ+TbtAN4c3o/2zVJWsjqZazfPl03JHQEaJOt9/Kw16ehof8
 Ro0TcCoU9oNKIQ6MI6FRWELV/kIX8Rr7Bf6z98U+MjQK2luRqfArGew6CoKzxKw5hfZI
 fzDVHFOAjHYghyD1JV/dQ4cEPGOt1WNoJbhuppqmOVKVlcyGy77VeT+n+xufETiKGbzY
 Mx2d26vsx5K13TEMn8Cnk0HoB6T307F9XxI51mWKmepndzd5/uD/ykHWMe/NgWC8WZcz
 S7/Q==
X-Gm-Message-State: AOAM532zi2bBLIEochZtyZpfJOjok938ATa01kk6CDuZ+Id6o81UYMe7
 EfKoQ/9XmxDlAS+j2nEQk4jHwk8H/g+C+mBvHVIvIfir7hcC0Aw4hW+e695eDdttoddnLAJhjiD
 1qvlPSEmCo1nXFJE=
X-Received: by 2002:a1c:e18a:: with SMTP id y132mr8035542wmg.27.1594197511500; 
 Wed, 08 Jul 2020 01:38:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxgUDDk10LCrh+Y+igZ17IJ1fnWT3avve9iqKvPNaZY3A5qAZVgU8OG8wYe236fvIjIUYbiXg==
X-Received: by 2002:a1c:e18a:: with SMTP id y132mr8035511wmg.27.1594197511237; 
 Wed, 08 Jul 2020 01:38:31 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id k18sm4678752wrx.34.2020.07.08.01.38.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2020 01:38:30 -0700 (PDT)
Subject: Re: [PATCH] cpu: Add starts_halted() method
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <20200707204333.261506-1-bauerman@linux.ibm.com>
 <20200707214917.GX7276@habkost.net> <87y2nu3nxq.fsf@morokweng.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <c53b36b7-ee7b-bb66-8220-cce788fd631d@redhat.com>
Date: Wed, 8 Jul 2020 10:38:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87y2nu3nxq.fsf@morokweng.localdomain>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Thiago,

On 7/8/20 1:28 AM, Thiago Jung Bauermann wrote:
> 
> Hello Eduardo,
> 
> Eduardo Habkost <ehabkost@redhat.com> writes:
> 
>> On Tue, Jul 07, 2020 at 05:43:33PM -0300, Thiago Jung Bauermann wrote:
>>> PowerPC sPAPRs CPUs start in the halted state, but generic QEMU code
>>> assumes that CPUs start in the non-halted state. spapr_reset_vcpu()
>>> attempts to rectify this by setting CPUState::halted to 1. But that's too
>>> late for hotplugged CPUs in a machine configured with 2 or mor threads per
>>> core.
>>>
>>> By then, other parts of QEMU have already caused the vCPU to run in an
>>> unitialized state a couple of times. For example, ppc_cpu_reset() calls
>>> ppc_tlb_invalidate_all(), which ends up calling async_run_on_cpu(). This
>>> kicks the new vCPU while it has CPUState::halted = 0, causing QEMU to issue
>>> a KVM_RUN ioctl on the new vCPU before the guest is able to make the
>>> start-cpu RTAS call to initialize its register state.
>>>
>>> This doesn't seem to cause visible issues for regular guests, but on a
>>> secure guest running under the Ultravisor it does. The Ultravisor relies on
>>> being able to snoop on the start-cpu RTAS call to map vCPUs to guests, and
>>> this issue causes it to see a stray vCPU that doesn't belong to any guest.
>>>
>>> Fix by adding a starts_halted() method to the CPUState class, and making it
>>> return 1 if the machine is an sPAPR guest.
>>>
>>> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>> [...]
>>> +static uint32_t ppc_cpu_starts_halted(void)
>>> +{
>>> +    SpaprMachineState *spapr =
>>> +        (SpaprMachineState *) object_dynamic_cast(qdev_get_machine(),
>>> +                                                  TYPE_SPAPR_MACHINE);
>>
>> Wouldn't it be simpler to just implement this as a MachineClass
>> boolean field?  e.g.:

Class boolean field certainly sounds better, but I am not sure this
is a property of the machine. Rather the arch? So move the field
to CPUClass? Maybe not, let's discuss :)

>>
>> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> 
> Yes, indeed it would. Thanks for this patch. I just tested and it
> also solves the problem (except for the nit mentioned below).
> 
> Tested-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> 
> Should I submit a proper patch with these changes (with you as the
> author)?
> 
>> ---
>> diff --git a/include/hw/boards.h b/include/hw/boards.h
>> index 426ce5f625..ffadc7a17d 100644
>> --- a/include/hw/boards.h
>> +++ b/include/hw/boards.h
>> @@ -215,6 +215,7 @@ struct MachineClass {
>>      bool nvdimm_supported;
>>      bool numa_mem_supported;
>>      bool auto_enable_numa;
>> +    bool cpu_starts_halted;
>>      const char *default_ram_id;
>>
>>      HotplugHandler *(*get_hotplug_handler)(MachineState *machine,
>> diff --git a/hw/core/cpu.c b/hw/core/cpu.c
>> index 0f23409f1d..08dd504034 100644
>> --- a/hw/core/cpu.c
>> +++ b/hw/core/cpu.c
>> @@ -252,6 +252,7 @@ static void cpu_common_reset(DeviceState *dev)
>>  {
>>      CPUState *cpu = CPU(dev);
>>      CPUClass *cc = CPU_GET_CLASS(cpu);
>> +    MachineState *machine = object_dynamic_cast(qdev_get_machine(), TYPE_MACHINE);
> 
> I had to add a (MachineState *) cast here to get the code to compile.

Btw why not use MACHINE(qdev_get_machine()) ?

> 
>>
>>      if (qemu_loglevel_mask(CPU_LOG_RESET)) {
>>          qemu_log("CPU Reset (CPU %d)\n", cpu->cpu_index);
>> @@ -259,7 +260,7 @@ static void cpu_common_reset(DeviceState *dev)
>>      }
>>
>>      cpu->interrupt_request = 0;
>> -    cpu->halted = 0;
>> +    cpu->halted = machine ? MACHINE_GET_CLASS(machine)->cpu_starts_halted : 0;
>>      cpu->mem_io_pc = 0;
>>      cpu->icount_extra = 0;
>>      atomic_set(&cpu->icount_decr_ptr->u32, 0);
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index f6f034d039..d16ec33033 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -4487,6 +4487,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
>>      mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power9_v2.0");
>>      mc->has_hotpluggable_cpus = true;
>>      mc->nvdimm_supported = true;
>> +    mc->cpu_starts_halted = true;
>>      smc->resize_hpt_default = SPAPR_RESIZE_HPT_ENABLED;
>>      fwc->get_dev_path = spapr_get_fw_dev_path;
>>      nc->nmi_monitor_handler = spapr_nmi;
>>
>>> +
>>> +    /*
>>> +     * In sPAPR, all CPUs start halted. CPU0 is unhalted from the machine level
>>> +     * reset code and the rest are explicitly started up by the guest using an
>>> +     * RTAS call.
>>> +     */
>>> +    return spapr != NULL;
>>> +}
>>> +
> 
> 
> --
> Thiago Jung Bauermann
> IBM Linux Technology Center
> 


