Received: from eggs.gnu.org ([2001:4830:134:3::10]:49529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fGljX-0008D0-Ho
	for qemu-devel@nongnu.org; Thu, 10 May 2018 09:35:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fGljT-0006Ev-DY
	for qemu-devel@nongnu.org; Thu, 10 May 2018 09:35:47 -0400
References: <CAFEAcA-pjg34=bPe7EiYN6oYC_3xuMCyiucPwZrka2Fxxrk3DQ@mail.gmail.com>
	<20180109170113.20768-1-michael@walle.cc>
	<1a4554ccbdae089bdb0a0a3ae0799b20@walle.cc>
	<f2b761e0-cf29-835d-988f-98382d24f3c1@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0bcfa9d2-3d1b-dc91-8e14-76c8e84ad425@redhat.com>
Date: Thu, 10 May 2018 15:35:40 +0200
MIME-Version: 1.0
In-Reply-To: <f2b761e0-cf29-835d-988f-98382d24f3c1@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Michael Walle <michael@walle.cc>, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, Programmingkid <programmingkidx@gmail.com>

On 09/05/2018 21:45, Philippe Mathieu-Daud=C3=A9 wrote:
> On 02/01/2018 06:09 AM, Michael Walle wrote:
>>
>> Hi Peter,
>>
>> do you apply this patch? Or do I have to send a pull request?
>=20
> Cc'ing Paolo.

Please send a pull request.

Paolo

>>
>> -michael
>>
>> Am 2018-01-09 18:01, schrieb Michael Walle:
>>> Writing to these registers may raise an interrupt request. Actually,
>>> this prevents the milkymist board from starting.
>>>
>>> Cc: qemu-stable@nongnu.org
>>> Signed-off-by: Michael Walle <michael@walle.cc>
>=20
> Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>=20
>>> ---
>>> =C2=A0target/lm32/op_helper.c | 4 ++++
>>> =C2=A01 file changed, 4 insertions(+)
>>>
>>> diff --git a/target/lm32/op_helper.c b/target/lm32/op_helper.c
>>> index 30f670eee8..a766a1ece4 100644
>>> --- a/target/lm32/op_helper.c
>>> +++ b/target/lm32/op_helper.c
>>> @@ -102,12 +102,16 @@ void HELPER(wcsr_dc)(CPULM32State *env, uint32_=
t
>>> dc)
>>>
>>> =C2=A0void HELPER(wcsr_im)(CPULM32State *env, uint32_t im)
>>> =C2=A0{
>>> +=C2=A0=C2=A0=C2=A0 qemu_mutex_lock_iothread();
>>> =C2=A0=C2=A0=C2=A0=C2=A0 lm32_pic_set_im(env->pic_state, im);
>>> +=C2=A0=C2=A0=C2=A0 qemu_mutex_unlock_iothread();
>>> =C2=A0}
>>>
>>> =C2=A0void HELPER(wcsr_ip)(CPULM32State *env, uint32_t im)
>>> =C2=A0{
>>> +=C2=A0=C2=A0=C2=A0 qemu_mutex_lock_iothread();
>>> =C2=A0=C2=A0=C2=A0=C2=A0 lm32_pic_set_ip(env->pic_state, im);
>>> +=C2=A0=C2=A0=C2=A0 qemu_mutex_unlock_iothread();
>>> =C2=A0}
>>>
>>> =C2=A0void HELPER(wcsr_jtx)(CPULM32State *env, uint32_t jtx)
>>
