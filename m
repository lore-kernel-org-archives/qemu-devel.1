Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C9BC352BE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 12:02:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65B292078E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 12:02:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65B292078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPPhF-0002iI-HR
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 08:02:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51401)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dovgaluk@ispras.ru>) id 1jPPgf-0002JO-1S
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 08:01:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1jPPgd-0003IP-OE
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 08:01:36 -0400
Received: from mail.ispras.ru ([83.149.199.45]:42018)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1jPPgd-0003Fl-GI
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 08:01:35 -0400
Received: from [192.168.0.183] (unknown [62.118.151.149])
 by mail.ispras.ru (Postfix) with ESMTPSA id 760F9CD464;
 Fri, 17 Apr 2020 15:01:31 +0300 (MSK)
Subject: Re: [PATCH] hw/arm/virt: Add DT property /secure-chosen/kaslr-seed
To: Peter Maydell <peter.maydell@linaro.org>,
 Jerome Forissier <jerome@forissier.org>
References: <20200410153916.17718-1-jerome@forissier.org>
 <CAFEAcA-JpeYgDwKRarWwggrU5XX7eWsdVy1ngLn538rC6J75vg@mail.gmail.com>
From: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Message-ID: <37b74bfc-bf61-450a-21d1-43fbdeaa400a@ispras.ru>
Date: Fri, 17 Apr 2020 15:01:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-JpeYgDwKRarWwggrU5XX7eWsdVy1ngLn538rC6J75vg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 83.149.199.45
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 17.04.2020 13:18, Peter Maydell wrote:
> On Fri, 10 Apr 2020 at 18:02, Jerome Forissier <jerome@forissier.org> wrote:
>> This commit generates a random seed to be used by the secure OS for
>> ASLR when the machine is secure. The seed is a 64-bit random value
>> exported via the DT in /secure-chosen/kaslr-seed. This interface is
>> used by OP-TEE [1].
>>
>> [1] https://github.com/OP-TEE/optee_os/commit/ef262691fe0e
> The kernel devicetree documentation documents this as a generic
> property of /chosen -- should we be providing a /chosen/kaslr-seed
> too ?
>
>> Signed-off-by: Jerome Forissier <jerome@forissier.org>
>> ---
>> +static void create_secure_kaslr_seed(VirtMachineState *vms)
>> +{
>> +    Error *err = NULL;
>> +    uint64_t seed;
>> +
>> +    if (qcrypto_random_bytes(&seed, sizeof(seed), &err)) {
>> +        error_free(err);
>> +        return;
>> +    }
> Since this is exposed to the guest I'm wondering if we should
> use qemu_guest_getrandom() (which lets you make the randomness
> deterministic for the benefit of record-and-replay). But I'm
> not sure if that function is usable before the guest has even
> started running. Pavel, could you answer that?

Yes, usage of deterministic functions is possible before machine is running,

because replay_configure is executed before machine initialization.


>
>> +    qemu_fdt_setprop_u64(vms->fdt, "/secure-chosen", "kaslr-seed", seed);
>> +}
>> +
>>   static void machvirt_init(MachineState *machine)
>>   {
>>       VirtMachineState *vms = VIRT_MACHINE(machine);
>> @@ -1837,6 +1850,7 @@ static void machvirt_init(MachineState *machine)
>>       if (vms->secure) {
>>           create_secure_ram(vms, secure_sysmem);
>>           create_uart(vms, VIRT_SECURE_UART, secure_sysmem, serial_hd(1));
>> +        create_secure_kaslr_seed(vms);
> This is implicitly relying on create_uart() having created
> the "/secure-chosen" node. I think it would be better now
> that we have multiple things we might want to put there if we
> just pulled the "create /secure-chosen" code out to the
> create_fdt() function so we do it at the same place we
> create "/chosen". (You can do that as a simple patch of its own
> that comes before this one in the patchseries.)
>
>>       }
>>
>>       vms->highmem_ecam &= vms->highmem && (!firmware_loaded || aarch64);
> thanks
> -- PMM

