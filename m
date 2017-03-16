Received: from eggs.gnu.org ([2001:4830:134:3::10]:34933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1coVL2-0007HP-C4
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 09:21:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1coVKy-0001Cg-Fk
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 09:21:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55838)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1coVKy-0001Bq-9U
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 09:21:04 -0400
References: <2b3c8119-1602-28c7-eab4-296593877103@lauterbach.com>
	<099222b0-dc53-9428-ed1c-48ad497464aa@lauterbach.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <47e1f504-22e5-9855-f097-f4714b8185e3@redhat.com>
Date: Thu, 16 Mar 2017 14:21:00 +0100
MIME-Version: 1.0
In-Reply-To: <099222b0-dc53-9428-ed1c-48ad497464aa@lauterbach.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target-x86:Add GDB XML register
 description support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>, qemu-devel@nongnu.org
Cc: Khaled Jmal <khaled.jmal@lauterbach.com>, rth@twiddle.net, ehabkost@redhat.com



On 16/03/2017 14:02, Abdallah Bouassida wrote:
>>
>>  X86CPU *cpu_x86_init(const char *cpu_model)
>>  {
>>      return X86_CPU(cpu_generic_init(TYPE_X86_CPU, cpu_model));
>> @@ -3720,10 +3729,14 @@ static void
>> x86_cpu_common_class_init(ObjectClass *oc, void *data)
>>      cc->write_elf32_qemunote = x86_cpu_write_elf32_qemunote;
>>      cc->vmsd = &vmstate_x86_cpu;
>>  #endif
>> -    /* CPU_NB_REGS * 2 = general regs + xmm regs
>> -     * 25 = eip, eflags, 6 seg regs, st[0-7], fctrl,...,fop, mxcsr.
>> -     */
>> -    cc->gdb_num_core_regs = CPU_NB_REGS * 2 + 25;
>> +    cc->gdb_arch_name = x86_gdb_arch_name;
>> +#ifdef TARGET_X86_64
>> +    cc->gdb_core_xml_file = "64bit-core.xml";
>> +    cc->gdb_num_core_regs = 40;
>> +#else
>> +    cc->gdb_core_xml_file = "32bit-core.xml";
>> +    cc->gdb_num_core_regs = 32;
>> +#endif
>>  #ifndef CONFIG_USER_ONLY
>>      cc->debug_excp_handler = breakpoint_handler;
>>  #endif

Since I don't know much about the GDB XML, gdb_num_core_regs used to be
41 and 57, now it's 32 and 40.  What happens to MXCSR and XMM registers?

Paolo
