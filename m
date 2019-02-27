Received: from eggs.gnu.org ([209.51.188.92]:52993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyzWF-0007c5-2G
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:45:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyzWE-0003St-4j
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:45:07 -0500
From: David Hildenbrand <david@redhat.com>
References: <20190227111411.22890-1-david@redhat.com>
	<20190227111411.22890-2-david@redhat.com>
	<87lg21lai8.fsf@zen.linaroharston>
	<467f1311-0534-232d-b85d-2d6e0fd47661@redhat.com>
Message-ID: <30288f51-ebcf-d0c7-ea2c-1a19a8575115@redhat.com>
Date: Wed, 27 Feb 2019 14:44:47 +0100
MIME-Version: 1.0
In-Reply-To: <467f1311-0534-232d-b85d-2d6e0fd47661@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC 1/2] tests/tcg: Allow targets to set
 the optimization level
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 27.02.19 13:42, David Hildenbrand wrote:
> On 27.02.19 12:46, Alex Benn=C3=A9e wrote:
>>
>> David Hildenbrand <david@redhat.com> writes:
>>
>>> We sometimes want basic optimizations, e.g. for constant propagation
>>> into inlined functions.
>>>
>>> Especially for inline asm with immediates;
>>
>> I agree you need this, but...
>>
>> <snip>
>>>  # Start with a blank slate, the build targets get to add stuff first
>>> -CFLAGS=3D
>>> +CFLAGS=3D-O0
>>>  QEMU_CFLAGS=3D
>>>  LDFLAGS=3D
>>>
>>> @@ -70,7 +70,7 @@ ifneq ($(TARGET_BASE_ARCH),$(TARGET_NAME))
>>>  endif
>>>
>>>  # Add the common build options
>>> -CFLAGS+=3D-Wall -O0 -g -fno-strict-aliasing
>>> +CFLAGS+=3D-Wall -g -fno-strict-aliasing
>>
>>
>> You don't need to do this - we already have EXTRA_CFLAGS which will
>> always be at the end of the compile invocation:
>>
>>   # enable vectors and optimisation to vectorise for this test
>>   vglv: CFLAGS+=3D-march=3Dz13 -m64
>>   vglv: EXTRA_CFLAGS+=3D-O2
>=20
> For whatever reason I can't get this to work. EXTRA_CFLAGS+=3D-O2 is
> always silently dropped:
>=20
> make SHELL=3D'sh -x' run-tcg-tests-s390x-linux-user
>=20
> + /home/dhildenb/git/qemu/tests/docker/docker.py cc --user 100813 --cc
> s390x-linux-gnu-gcc -i qemu:debian-s390x-cross -s
> /home/dhildenb/git/qemu -- -march=3DzEC12 -m64 -Wall -O0 -g
> -fno-strict-aliasing -march=3Dz13
> /home/dhildenb/git/qemu/tests/tcg/s390x/vlgv.c -o vlgv -static
> /home/dhildenb/git/qemu/tests/tcg/s390x/vlgv.c: In function 'vlgv':
> /home/dhildenb/git/qemu/tests/tcg/s390x/vlgv.c:8:5: warning: asm operan=
d
> 3 probably doesn't match constraints
>      asm volatile("vlgv %[r1], %[v3], 0(%[a2]), %[m4]\n"
>      ^~~
> /home/dhildenb/git/qemu/tests/tcg/s390x/vlgv.c:8:5: error: impossible
> constraint in 'asm'
>=20

vlgv: CFLAGS+=3D-march=3Dz13 -O2

However works. I am very confused now. I guess this is about evaluation
order or something like that.

--=20

Thanks,

David / dhildenb
