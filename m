Received: from eggs.gnu.org ([2001:4830:134:3::10]:60561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eS1Ym-0001vg-29
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:10:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eS1Yh-0000sf-LC
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:10:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42068)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eS1Yh-0000rj-DZ
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:10:51 -0500
References: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA8J53A93+SQz01W13gRCX-ecw0v+8JTaRqwmrUeFjqaJA@mail.gmail.com>
	<51174e3a-12d3-f3e0-2d76-b776e0fe62b6@redhat.com>
	<e7994a8d-3a02-99c7-d919-c940aa4bc066@redhat.com>
	<40dbaff2-918c-bba6-2a70-7c5f9b19cb66@vivier.eu>
	<0d3d6598-608c-0079-426f-7455a92de7d8@vivier.eu>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <64440fda-1799-f50d-21ed-dc898e08d82f@redhat.com>
Date: Thu, 21 Dec 2017 15:10:46 +0100
MIME-Version: 1.0
In-Reply-To: <0d3d6598-608c-0079-426f-7455a92de7d8@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] out of bounds in set_cc_op()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Richard Henderson <rth@twiddle.net>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On 21/12/2017 14:32, Laurent Vivier wrote:
> Le 21/12/2017 =C3=A0 14:07, Laurent Vivier a =C3=A9crit=C2=A0:
>> Le 21/12/2017 =C3=A0 13:49, Thomas Huth a =C3=A9crit=C2=A0:
>>> On 20.12.2017 22:56, Paolo Bonzini wrote:
>>>> On 20/12/2017 20:20, Peter Maydell wrote:
>>>>> On the x86/sanitizer build, new runtime errors:
>>>>>   GTESTER check-qtest-m68k
>>>>> /home/petmay01/linaro/qemu-for-merges/target/m68k/translate.c:230:1=
2:
>>>>> runtime error: index -1 out of bounds for type 'const uint8_t [11]'
>>>>>
>>>>> ...and similar fails on one or two boards on most of the other
>>>>> guest architectures.
>>>>
>>>> These are preexisting bugs, now exposed by the boot-serial-test.
>>>> Thomas, can you identify the architectures that have a problem and
>>>> notify the maintainers?  In the meanwhile I'll keep the boot-serial-=
test
>>>> enhancements queued locally, and remove them from the pull request.
>>>
>>>  Laurent, Richard,
>>>
>>> looks like old_op is -1 when set_cc_op() is called here for the first
>>> time. The problem can be reproduced by running the mini-kernel direct=
ly.
>>> Just get http://people.redhat.com/~thuth/m68k-uart.bin and run QEMU l=
ike
>>> this:
>>>
>>>  qemu-system-m68k -nographic -kernel  ~/tmp/m68k-uart.bin -serial non=
e
>>>
>>> That kernel only contains these few instructions:
>>>
>>>   0x41, 0xf9, 0xfc, 0x06, 0x00, 0x00,     /* lea 0xfc060000,%a0 */
>>>   0x10, 0x3c, 0x00, 0x54,                 /* move.b #'T',%d0 */
>>>   0x11, 0x7c, 0x00, 0x04, 0x00, 0x08,     /* move.b #4,8(%a0) */
>>>   0x11, 0x40, 0x00, 0x0c,                 /* move.b %d0,12(%a0) */
>>>   0x60, 0xfa                              /* bra.s  loop */
>>>
>>> The problem occurs during the second instruction (i.e. the first move=
.b).
>>>
>>> Do you have any ideas where this -1 in s->cc_op could come from?
>>
>> I think it comes from CCOp: it's the value of CC_OP_DYNAMIC.
>>
>> We should not use it to access cc_op_live[].
>>
>> I try to find a fix, but I think Richard knows this better than me.
>=20
> This should fix the problem, but I'd like Richard checks it...
>=20
> diff --git a/target/m68k/translate.c b/target/m68k/translate.c
> index b60909222c..721b5801da 100644
> --- a/target/m68k/translate.c
> +++ b/target/m68k/translate.c
> @@ -225,6 +225,11 @@ static void set_cc_op(DisasContext *s, CCOp op)
>      s->cc_op =3D op;
>      s->cc_op_synced =3D 0;
>=20
> +    if (old_op =3D=3D CC_OP_DYNAMIC) {
> +        tcg_gen_discard_i32(QREG_CC_OP);
> +        return;
> +    }

This tcg_gen_discard_i32 is correct, but all flags were potentially live
and can be discarded if the new op uses it(*).  So I'd replace "return"
with "old_op =3D CC_OP_FLAGS".

Paolo

	(*) in fact it's always true that all flags can be discarded.
	    Only discarding some is an optimization to limit the number
	    of generated ops.

>      /* Discard CC computation that will no longer be used.
>         Note that X and N are never dead.  */
>      dead =3D cc_op_live[old_op] & ~cc_op_live[op];
>=20
>=20
> Thanks,
> Laurent
>=20
