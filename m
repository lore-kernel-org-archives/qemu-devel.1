Received: from eggs.gnu.org ([2001:4830:134:3::10]:55030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <smolov@ispras.ru>) id 1dsX49-00080Q-UK
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 12:32:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <smolov@ispras.ru>) id 1dsX44-000720-TK
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 12:32:37 -0400
Received: from bran.ispras.ru ([83.149.199.196]:42568 helo=smtp.ispras.ru)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <smolov@ispras.ru>) id 1dsX44-00070I-KY
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 12:32:32 -0400
Message-ID: <59BAAF1D.8070801@ispras.ru>
Date: Thu, 14 Sep 2017 19:32:29 +0300
From: Sergey Smolov <smolov@ispras.ru>
MIME-Version: 1.0
References: <59B7EBC5.9060908@ispras.ru>
	<CAFEAcA-to=vWWBHoxZRX-ExcbDe0OTMwpHunE7HXaYA0GE+ccw@mail.gmail.com>
	<59B7F503.8010703@ispras.ru>
	<CAFEAcA97i97_aoq8xNKtP8Z+i-u5Hq+_e6N80=T=WspSEW+A7A@mail.gmail.com>
	<59B8DE5A.9000301@ispras.ru>
	<CAFEAcA8UTVr-jO4Eh=uaUokYBhF0EYTuBoXdLyrKZ=GrjPFtmQ@mail.gmail.com>
	<0c3db1e3-1638-cfbe-8c97-0d1aa87547b0@imgtec.com>
	<59BA88D1.9080202@ispras.ru>
	<CAFEAcA_HRwa_XFv8M3h_5dK0p6Xiuu1FfF32TPOhEop80wT30A@mail.gmail.com>
	<59BA8F4E.6060600@ispras.ru>
	<5cea7ccd-97b3-ecbf-22c1-72b329c467fc@imgtec.com>
In-Reply-To: <5cea7ccd-97b3-ecbf-22c1-72b329c467fc@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] MIPS 'move' insn emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>


On 14.09.2017 17:23, Yongbok Kim wrote:
>
> On 14/09/2017 15:16, Sergey Smolov wrote:
>> On 14.09.2017 16:58, Peter Maydell wrote:
>>> At translate time it is generating some extra code which at runtime
>>> will call the helper_trace_reg_access() function, passing it the
>>> values in the registers at this point. This will result in poor
>>> performance if you do it for frequently executed instructions.
> Yes indeed. it will be hitting the performance critically the instruction
> is quite often used. :)
>
>> Ok, thank you.
>>
>>> That looks like it ought to work. Check you really did save all your
>>> files in your editor before compiling? :-)
>> Yes, I did. These warnings are very suspicious, because they come with
>> strange numbers of MIPS GPR registers that I receive for my program.
>>
>> Here is the program:
>>
>> .text
>>      addiu $8, $zero, 0x7
>>      move $9, $8
>>      sll $8, $8, 3
>>      add $8, $8, $9
>>
>> Here is the log that helper functions provide:
>>
>> $0 00000007
>> $7 00000007
>> $0 00000038
>> $0 0000003f
>>
>> The first value is register name, the second is the value to be written.
>> Values are ok, but I expect to see $8 and $9  registers here.
>>
>>> PS: there's no point passing the env pointer into the function if
>>> you're not going to use it...
> Yes you're right. I had further use of the env but it has been chopped for
> the example.
>
>> I thought that I need to pass env pointer to helper function because of
>> some convention. Again, thank you for the note.
>>
> Sergey,
>
> The reason why your modification is failed is because you passed wrong
> argument. Remember that you are not just calling the helper function from
> translate.c but you are generating some code to let call the helper
> function on run time. You have to create a temporal TCGv to pass the
> register number.
> You could do it like,
> TCGv_i32 tmp = tcg_const_i32(rd)
> gen_helper_trace_reg_access(cpu_env, tmp, cpu_gpr[rs);
> tcg_temp_free_i32(tmp);
>
> or simply use the predefined macro and fix the order of the arguments.
>
> gen_helper_0e1i(trace_reg_access, cpu_gpr[rs], rd);
>
> Regards,
> Yongbok

It helps!

Thank you both for detailed explanations:-)

-- 
Sincerely yours,
Sergey Smolov
