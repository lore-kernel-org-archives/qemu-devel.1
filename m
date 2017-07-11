Received: from eggs.gnu.org ([2001:4830:134:3::10]:46301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dUvBN-00063B-M0
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:26:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dUvBJ-0007P5-I4
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:26:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57852)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dUvBJ-0007Ot-94
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:26:25 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4CE9EC045776
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 13:26:24 +0000 (UTC)
References: <20170706101611.27031-1-marcandre.lureau@redhat.com>
	<20170706101611.27031-7-marcandre.lureau@redhat.com>
	<c661a649-e438-e80b-baf4-b44ee6612ca3@redhat.com>
	<145552423.49242900.1499767479720.JavaMail.zimbra@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <2f412e1e-88b2-9d30-db7e-0bd5e84b58e5@redhat.com>
Date: Tue, 11 Jul 2017 15:25:58 +0200
MIME-Version: 1.0
In-Reply-To: <145552423.49242900.1499767479720.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 6/7] scripts/dump-guest-memory.py: add
 vmcoreinfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, anderson@redhat.com, imammedo@redhat.com

On 07/11/17 12:04, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>
> ----- Original Message -----
>> On 07/06/17 12:16, Marc-Andr=C3=A9 Lureau wrote:
>>> Add vmcoreinfo ELF note if vmcoreinfo device is ready.
>>>
>>> To help the python script, add a little global vmcoreinfo_gdb
>>> structure, that is populated with vmcoreinfo_gdb_update().
>>>
>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

>>> @@ -181,6 +183,7 @@ static void vmcoreinfo_realize(DeviceState *dev, =
Error
>>> **errp)
>>>          return;
>>>      }
>>>
>>> +    vmcoreinfo_gdb_helper =3D VMCOREINFO(dev);
>>>      qemu_register_reset(vmcoreinfo_handle_reset, dev);
>>>  }
>>>
>>>
>>
>> I guess we don't build QEMU with link-time optimization at the
>> moment.
>>
>> With link-time optimization, I think gcc might reasonably optimize
>> away the assignment to "vmcoreinfo_gdb_helper", and
>> "vmcoreinfo_gdb_helper" itself. This is why I suggested "volatile":
>>
>> static VMCoreInfoState * volatile vmcoreinfo_gdb_helper;
>>
>> Do you think volatile is only superfluous, or do you actively dislike
>> it for some reason?
>
> Yeah, I am not convinced volatile is the best way, but nor is static.
>
> Let's export it?

Volatile guarantees that the assignment will take place according to the
behavior of the "abstract C machine" described by ISO C. From ISO C99,

  6.7.3 Type qualifiers

  6 An object that has volatile-qualified type may be modified in ways
    unknown to the implementation or have other unknown side effects.
    Therefore any expression referring to such an object shall be
    evaluated strictly according to the rules of the abstract machine,
    as described in 5.1.2.3. Furthermore, at every sequence point the
    value last stored in the object shall agree with that prescribed by
    the abstract machine, except as modified by the unknown factors
    mentioned previously. [116] What constitutes an access to an object
    that has volatile-qualified type is implementation-defined.

  Footnote 116: A volatile declaration may be used to describe an object
                corresponding to a memory-mapped input/output port or an
                object accessed by an asynchronously interrupting
                function. Actions on objects so declared shall not be
                "optimized out" by an implementation or reordered except
                as permitted by the rules for evaluating expressions.

So basically if you can find the symbol somehow, it will always have the
right value, due to the volatile qualifier, regardless of the
optimizations the compiler did.

Internal vs. external linkage ("static" vs. "extern") is a different
question; it might affect whether you find the symbol at all. IME,
symbols for objects with internal linkage are preserved, if: (a) you
don't strip the final binary, and (b) gcc doesn't optimize the variable
away.

With link-time / full program optimization, gcc is entitled to optimize
away variables with external linkage too, so "extern" in itself is not
bulletproof. Volatile is more important.

Given volatile, I'm sort of neutral on extern vs. static. However, if
you make the variable extern, that makes abuse from other source files
easier. (The variable should only be looked at with gdb.) This is also
why I originally suggested to limit the scope of even the static
variable to function scope -- this way abuse would completely be
prevented (nothing else could access the variable even from the same
translation unit), and gdb would still find the variable (IME).

Thanks
Laszlo
