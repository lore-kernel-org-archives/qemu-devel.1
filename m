Received: from eggs.gnu.org ([2001:4830:134:3::10]:49551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dstwh-0004qN-Mq
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 12:58:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dstwe-0003dN-M3
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 12:58:27 -0400
Received: from mail-pf0-x22d.google.com ([2607:f8b0:400e:c00::22d]:46696)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dstwe-0003d6-Fv
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 12:58:24 -0400
Received: by mail-pf0-x22d.google.com with SMTP id e199so1742012pfh.3
	for <qemu-devel@nongnu.org>; Fri, 15 Sep 2017 09:58:24 -0700 (PDT)
References: <20170914183516.19537-1-richard.henderson@linaro.org>
	<20170914183516.19537-5-richard.henderson@linaro.org>
	<3897b0b2-8da9-8921-1380-57380e6f0879@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2db5e483-771c-db9e-2e5c-39ddd8cee811@linaro.org>
Date: Fri, 15 Sep 2017 09:58:19 -0700
MIME-Version: 1.0
In-Reply-To: <3897b0b2-8da9-8921-1380-57380e6f0879@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 04/10] disas: Support the Capstone
 disassembler library
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

On 09/14/2017 09:46 PM, Philippe Mathieu-Daudé wrote:
>>   +static bool cap_disas(disassemble_info *info, uint64_t pc, size_t size)
> 
> I'd rather use:
> 
> ..,, target_ulong code, ...
>> +{
> 
> uint64_t pc = (uint64_t)code;

Why?

> 
>> +    bool ret = false;
> 
> Isn't it cleaner to have a stubs/disas_capstone.c?
> 
>> +#ifdef CONFIG_CAPSTONE

If this one function warranted a separate file of its own, maybe, but certainly
not without that.

>> +    cap_mode += (info->endian == BFD_ENDIAN_BIG ? CS_MODE_BIG_ENDIAN
>> +                 : CS_MODE_LITTLE_ENDIAN);
>> +
> 
>     assert(size); ?

The existing disassembler doesn't have it.  So, no?

>     err = cs_open(info->cap_arch, cap_mode, &handle);
>     if (err != CS_ERR_OK) {
>         (*info->fprintf_func)(info->stream, "Capstone: %s\n",
>                               cs_strerror(err));

No.  Or not without extra limits.  We don't want 100k instances of this error
as we dump all of the hunks for "-d in_asm".

We'd be assuming the distro didn't do anything silly wrt compiling with "diet"
mode or with only the host cpu enabled.  I really don't know what to do about
such an eventuality except continue to fall back to the binutils code.

>> +    cbuf = buf = g_malloc(size);
> 
>     if (buf == NULL) {
>         goto err2;
>     }

g_malloc cannot fail.

> 
>     cs_free(insn, 1);
> err2:
> 
>> +    g_free(buf);
>> + err1:

Oops, yes.

>> +
>> +    if (s.info.cap_arch >= 0 && cap_disas(&s.info, (uintptr_t)code, size)) {
> 
> (target_ulong)(uintptr_t)code, ?

Why?  Even if I did change the type of the argument?
The extra cast would be implied by the language.

>>   +    /* ??? Capstone requires that we copy the data into a host-addressable
>> +       buffer first and has no call-back to read more.  Therefore we need
>> +       an estimate of buffer size.  This will work for most RISC, but we'll
>> +       need to figure out something else for variable-length ISAs.  */
>> +    if (s.info.cap_arch >= 0 && cap_disas(&s.info, pc, 4 * nb_insn)) {
> 
> .., MIN(16 * nb_insn, TARGET_PAGE_SIZE))) ?

That's no better than what I have; it simply prints more.  I need a *real*
solution.  It will probably involve not re-using cap_disas but writing code
just for the monitor.


r~
