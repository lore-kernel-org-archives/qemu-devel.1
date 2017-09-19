Received: from eggs.gnu.org ([2001:4830:134:3::10]:58487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1duNNx-0001zK-La
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:36:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1duNNt-0001lz-MV
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:36:41 -0400
Received: from mail-io0-x22f.google.com ([2607:f8b0:4001:c06::22f]:48722)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1duNNt-0001l7-If
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:36:37 -0400
Received: by mail-io0-x22f.google.com with SMTP id n69so1275556ioi.5
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 11:36:37 -0700 (PDT)
References: <20170914183516.19537-1-richard.henderson@linaro.org>
	<53de205c-7c24-426c-129a-7cce7ca67210@amsat.org>
	<0a265b7a-c84f-fefc-41e6-0276dfc131b8@linaro.org>
	<917e90c5-ddbc-bd55-d2ff-f780dab1063a@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0c7827df-c9d4-8dad-a38c-4881ce7dd22b@linaro.org>
Date: Tue, 19 Sep 2017 13:36:33 -0500
MIME-Version: 1.0
In-Reply-To: <917e90c5-ddbc-bd55-d2ff-f780dab1063a@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 00/10] Support the Capstone disassembler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>
Cc: qemu-devel@nongnu.org

On 09/19/2017 12:30 PM, Philippe Mathieu-Daudé wrote:
> On 09/19/2017 01:13 PM, Richard Henderson wrote:
>> [ Just saw this, so missed adding tags to the v2 patch set. ]
>>
>> On 09/14/2017 11:53 PM, Philippe Mathieu-Daudé wrote:
>>> At least this msg disappeared:
>>>
>>> "Disassembler disagrees with translator over instruction decoding"
>>
>> It's back in v2.
>>
>>> For i386, arm, mips32/64:
>>> Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>
>> Which patches?  Which mips versions?
> 
> full series, Malta board default cpu
> 
>> Can you, by any chance, test micro-mips?  I'm certain I've got that wrong in
>> the v1 patch, and thus I dropped the mips patch from v2.  But in theory
>> capstone supports umips too and should be trivially fixable.
> 
> $ mipsel-softmmu/qemu-system-mipsel -machine malta -cpu M14Kc -append "ttyS0
> rw" -nographic -d in_asm -kernel vmlinux -initrd initrd.gz
> 
>  IN: kernel_entry
>  0x801039e0:  syscall   0x3f004
>  0x801039e4:  b 0x8011406c
> -0x801039e8:  addu      t2,zero,ra
> -0x801039ec:  c0        0x900028
> -0x801039f0:  0x1f7108
> -0x801039f4:  syscall   0xbf004
> +0x801039e8:  addu         $t2, $zero, $ra

This is indicative of the other bug that I fixed in v2, where we would silently
ignore unknown instructions.

>From this and the other hunks it would appear that either (1) I messed up the
CS_MODE_* bits for mips or (2) the capstone backend for mips is not in terribly
good shape.

I think I was right to drop the patch from v2.


r~
