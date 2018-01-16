Received: from eggs.gnu.org ([2001:4830:134:3::10]:48942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ebS0C-000843-If
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:14:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ebS08-00034G-GQ
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:14:12 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:61987)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ebS08-00033g-73
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:14:08 -0500
References: <20180113144847.8403-1-laurent@vivier.eu>
	<20180113144847.8403-2-laurent@vivier.eu>
	<8106f80a-6bd2-8ba6-125a-6d5e58fcb035@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <addf3223-da94-6573-5e87-408ec8367d4a@vivier.eu>
Date: Tue, 16 Jan 2018 15:13:50 +0100
MIME-Version: 1.0
In-Reply-To: <8106f80a-6bd2-8ba6-125a-6d5e58fcb035@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/3] linux-user: introduce functions to
 detect CPU type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: YunQiang Su <syq@debian.org>, Riku Voipio <riku.voipio@iki.fi>, Peter Maydell <peter.maydell@linaro.org>, Aaron Sierra <asierra@xes-inc.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

Le 15/01/2018 à 23:04, Richard Henderson a écrit :
> On 01/13/2018 06:48 AM, Laurent Vivier wrote:
>> From: YunQiang Su <syq@debian.org>
>>
>> Move CPU type name selection to a function,
>> and add a function to return ELF e_flags.
>>
>> [lv: splitted the patch and some cleanup in get_elf_eflags()]
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>> ---
> 
> This needs to be split.
> 
>> +int get_elf_eflags(int fd, uint32_t *eflags)
>> +{
>> +    struct elfhdr ehdr;
>> +    off_t offset;
>> +    int ret;
>> +
>> +    /* Read ELF header */
>> +    offset = lseek(fd, 0, SEEK_SET);
>> +    if (offset == (off_t) -1) {
>> +        return -1;
>> +    }
>> +    ret = read(fd, &ehdr, sizeof(ehdr));
>> +    if (ret < sizeof(ehdr)) {
>> +        return -1;
>> +    }
> 
> There is no reason to read the elf header twice -- e_flags has already been
> stored in the struct image_info.

When we set cpu_model, image_info is not initialized.

Do you propose to move cpu_init() after loader_exec()?

>> +static const char *get_cpu_model(int fd)
>> +{
>> +#if defined(TARGET_I386)
>> +#ifdef TARGET_X86_64
>> +    return "qemu64";
>> +#else
>> +    return "qemu32";
>> +#endif
> 
> This should be our opportunity to split this ifdef chain into small inline
> functions within linux-user/*/target_cpu.h.  Pass the e_flags value directly
> instead of a file descriptor.
> 

Good idea.

Thanks,
Laurent
