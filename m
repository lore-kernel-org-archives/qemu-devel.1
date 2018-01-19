Received: from eggs.gnu.org ([2001:4830:134:3::10]:38879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1ecdHm-0007Wm-4M
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 15:29:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1ecdHh-0006q1-Ln
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 15:29:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1ecdHh-0006pP-D3
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 15:29:09 -0500
References: <20180119162554.27270-1-marcandre.lureau@redhat.com>
	<0bf279e2-0f90-06ee-2779-1a3f67665ecf@redhat.com>
	<86c60f49-bdf9-c3a5-7c0e-c05f6dd11db5@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <8bb55134-b48c-94ab-40f7-91c64943905f@redhat.com>
Date: Fri, 19 Jan 2018 21:29:00 +0100
MIME-Version: 1.0
In-Reply-To: <86c60f49-bdf9-c3a5-7c0e-c05f6dd11db5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] dump-guest-memory.py: fix python 2
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

On 01/19/18 20:48, Eric Blake wrote:
> On 01/19/2018 01:18 PM, Laszlo Ersek wrote:
>> On 01/19/18 17:25, Marc-Andr=C3=A9 Lureau wrote:
>>> Python GDB support may use Python 2 or 3.
>>>
>>> Inferior.read_memory() may return a 'buffer' with Python 2 or a
>>> 'memoryview' with Python 3 (see also
>>> https://sourceware.org/gdb/onlinedocs/gdb/Inferiors-In-Python.html)
>>>
>>> The elf.add_vmcoreinfo_note() method expects a "bytes" object. Wrap
>>> the returned memory with bytes(), which works with both 'memoryview'
>>> and 'buffer'.
>>>
>=20
> If I understand it, the issue stems from the fact that vmcoreinfo is a
> bytes buffer under python2, but a memoryview under python3.  Let's
> compare the patches:
>=20
> The V1 patch:
> https://lists.gnu.org/archive/html/qemu-devel/2018-01/msg04010.html
>=20
>>
>>          if vmcoreinfo:
>> -            self.elf.add_vmcoreinfo_note(vmcoreinfo.tobytes())
>> +            # Python 2.7 returns a buffer
>> +            vmciview =3D memoryview(vmcoreinfo)
>> +            self.elf.add_vmcoreinfo_note(vmciview.tobytes())
>=20
> did an unconditional memoryview(vmcoreinfo) followed by a .tobytes()
> call. Under python 2.7, vmcoreinfo is converted from a buffer to a
> memoryview, then back to bytes; under python 3, memoryview(vmcoreinfo)
> is a no-op (since it is already a memory view), then that is converted
> to bytes; the double conversion was necessary because bytes.tobytes()
> doesn't exist.  But python 2.6 doesn't have the memoryview conversion,
> so we've excluded older python users.
>=20
> Now looking at the V2 patch:
>=20
>=20
>>> @@ -564,7 +564,7 @@ shape and this command should mostly work."""
>>> =20
>>>          vmcoreinfo =3D self.phys_memory_read(addr, size)
>>>          if vmcoreinfo:
>>> -            self.elf.add_vmcoreinfo_note(vmcoreinfo.tobytes())
>>> +            self.elf.add_vmcoreinfo_note(bytes(vmcoreinfo))
>=20
> Under python2, and bytes(buffer) is still bytes; under python3,
> vmcoreinfo is a memoryview but bytes(buffer) is equivalent to
> buffer.to_bytes().  We've avoided the intermediate conversion through
> memoryview, and thus work regardless of python version.

Heh, "semantics" :)

>=20
>> Ugh, can you please point me to the v1->v2 difference?
>=20
> Hope that helped (and hope I got it right, I'm learning as well from
> this thread).
>=20

It sure helped a lot, thank you very much! In fact, you've done all the
review work, so technically, "R-b: Laszlo" would be misappropriation.
Can you give your R-b?

I'll manage an "I agree" statement:

Acked-by: Laszlo Ersek <lersek@redhat.com>

Thanks!
Laszlo
