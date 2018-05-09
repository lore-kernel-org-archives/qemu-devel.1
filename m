Received: from eggs.gnu.org ([2001:4830:134:3::10]:54532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGV1z-0005iO-5w
	for qemu-devel@nongnu.org; Wed, 09 May 2018 15:45:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGV1y-0005hY-Cv
	for qemu-devel@nongnu.org; Wed, 09 May 2018 15:45:43 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <CAFEAcA-pjg34=bPe7EiYN6oYC_3xuMCyiucPwZrka2Fxxrk3DQ@mail.gmail.com>
	<20180109170113.20768-1-michael@walle.cc>
	<1a4554ccbdae089bdb0a0a3ae0799b20@walle.cc>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f2b761e0-cf29-835d-988f-98382d24f3c1@amsat.org>
Date: Wed, 9 May 2018 16:45:33 -0300
MIME-Version: 1.0
In-Reply-To: <1a4554ccbdae089bdb0a0a3ae0799b20@walle.cc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] lm32: take BQL before writing IP/IM
 register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Walle <michael@walle.cc>, peter.maydell@linaro.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, Programmingkid <programmingkidx@gmail.com>

On 02/01/2018 06:09 AM, Michael Walle wrote:
> 
> Hi Peter,
> 
> do you apply this patch? Or do I have to send a pull request?

Cc'ing Paolo.

> 
> -michael
> 
> Am 2018-01-09 18:01, schrieb Michael Walle:
>> Writing to these registers may raise an interrupt request. Actually,
>> this prevents the milkymist board from starting.
>>
>> Cc: qemu-stable@nongnu.org
>> Signed-off-by: Michael Walle <michael@walle.cc>

Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>> ---
>>  target/lm32/op_helper.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/target/lm32/op_helper.c b/target/lm32/op_helper.c
>> index 30f670eee8..a766a1ece4 100644
>> --- a/target/lm32/op_helper.c
>> +++ b/target/lm32/op_helper.c
>> @@ -102,12 +102,16 @@ void HELPER(wcsr_dc)(CPULM32State *env, uint32_t
>> dc)
>>
>>  void HELPER(wcsr_im)(CPULM32State *env, uint32_t im)
>>  {
>> +    qemu_mutex_lock_iothread();
>>      lm32_pic_set_im(env->pic_state, im);
>> +    qemu_mutex_unlock_iothread();
>>  }
>>
>>  void HELPER(wcsr_ip)(CPULM32State *env, uint32_t im)
>>  {
>> +    qemu_mutex_lock_iothread();
>>      lm32_pic_set_ip(env->pic_state, im);
>> +    qemu_mutex_unlock_iothread();
>>  }
>>
>>  void HELPER(wcsr_jtx)(CPULM32State *env, uint32_t jtx)
> 
