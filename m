Received: from eggs.gnu.org ([2001:4830:134:3::10]:60882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dhK1U-0006cq-EI
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 14:23:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dhK1R-0007Ay-At
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 14:23:32 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:55772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dhK1R-0007A5-0w
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 14:23:29 -0400
References: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
	<1500040339-119465-15-git-send-email-imammedo@redhat.com>
	<5bec6275-8e15-16c7-8d23-2975a563c78f@twiddle.net>
	<20170717124146.5ae39d2b@nial.brq.redhat.com>
	<f32dbe33-4a99-cf79-e41c-4a1accacda64@suse.de>
	<20170717172322.54bd6888@nial.brq.redhat.com>
	<20170814100036.28160651@nial.brq.redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <8acf5254-0d52-201c-800e-1911fee08931@vivier.eu>
Date: Mon, 14 Aug 2017 20:23:10 +0200
MIME-Version: 1.0
In-Reply-To: <20170814100036.28160651@nial.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 14/28] m68k: replace cpu_m68k_init() with
 cpu_generic_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Thomas Huth <huth@tuxfamily.org>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

Le 14/08/2017 à 10:00, Igor Mammedov a écrit :
> On Mon, 17 Jul 2017 17:23:22 +0200
> Igor Mammedov <imammedo@redhat.com> wrote:
> 
>> On Mon, 17 Jul 2017 17:05:15 +0200
>> Andreas Färber <afaerber@suse.de> wrote:
>>
>>> Am 17.07.2017 um 12:41 schrieb Igor Mammedov:  
>>>> On Sat, 15 Jul 2017 08:08:58 -1000
>>>> Richard Henderson <rth@twiddle.net> wrote:
>>>>     
>>>>> On 07/14/2017 03:52 AM, Igor Mammedov wrote:    
>>>>>> @@ -230,6 +230,8 @@ static void m68k_cpu_realizefn(DeviceState *dev, Error **errp)
>>>>>>       M68kCPUClass *mcc = M68K_CPU_GET_CLASS(dev);
>>>>>>       Error *local_err = NULL;
>>>>>>   
>>>>>> +    register_m68k_insns(&cpu->env);
>>>>>> +      
>>>>>
>>>>> I think it would make more sense to do this during m68k_tcg_init.
>>>>>    
>>>> it seems that m68k_cpu_initfn accesses 'env' via some global,
>>>> while cpu_mk68k_init() used to access concrete pointer of just created cpu,
>>>>
>>>> how about moving register_m68k_insns() to m68k_cpu_initfn(), instead?
>>>> it should be equivalent to what cpu_mk68k_init() used to do.    
>>>
>>> As a general note, realize should be re-entrant. Can't tell from the
>>> above diff whether that is the case here.  
>> Looking at
>>
>> void register_m68k_insns (CPUM68KState *env)                                     
>> {                                                                                
>>     /* Build the opcode table only once to avoid                                 
>>        multithreading issues. */                                                 
>>     if (opcode_table[0] != NULL) {                                               
>>         return;                                                                  
>>     }
>>
>> it is save to use multiple times,
>>
>> also looking further in it:
>>
>> #define BASE(name, opcode, mask) \                                               
>>     register_opcode(disas_##name, 0x##opcode, 0x##mask)                          
>> #define INSN(name, opcode, mask, feature) do { \                                 
>>     if (m68k_feature(env, M68K_FEATURE_##feature)) \                             
>>         BASE(name, opcode, mask); \                                              
>>     } while(0)                                                                   
>>     BASE(undef,     0000, 0000);                                                 
>>     INSN(arith_im,  0080, fff8, CF_ISA_A);
>>
>> INSN macro depends on enabled features, it might work with current code that
>> has no user settable features but it will break once that is available.
>>
>> So I retract my suggestion to move register_m68k_insns() into m68k_cpu_initfn()
>> and keep it as it's in this patch (in m68k_cpu_realizefn()),
>> that way features theoretically set between initfn(and m68k_tcg_init) and realize() will
>> have effect on created cpu and we won't have to fix it in future.
> 
> Richard, Laurent,
> 
> Do you agree with keeping register_m68k_insns() in realize()?
> 

I agree.

Acked-by: Laurent Vivier <laurent@vivier.eu>
