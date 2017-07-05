Received: from eggs.gnu.org ([2001:4830:134:3::10]:40932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dSi7Y-0006EU-L9
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 07:05:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dSi7U-0000zT-Je
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 07:05:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35832)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dSi7U-0000zE-9k
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 07:05:20 -0400
References: <20170629132310.18865-1-marcandre.lureau@redhat.com>
	<20170629132310.18865-7-marcandre.lureau@redhat.com>
	<bbc74cf4-4d61-8ad3-7a33-0e6c49490892@redhat.com>
	<CAJ+F1CJvcwE0ed9ui8Z09ia5h29BXVEjQ7vbiJhSjkR09Kn7DA@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <33ed5b7d-28e2-f5b0-7e76-96852786139c@redhat.com>
Date: Wed, 5 Jul 2017 13:05:14 +0200
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CJvcwE0ed9ui8Z09ia5h29BXVEjQ7vbiJhSjkR09Kn7DA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 6/7] scripts/dump-guest-memory.py: add
 vmcoreinfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Dave Anderson <anderson@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 07/05/17 11:58, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Wed, Jul 5, 2017 at 2:22 AM, Laszlo Ersek <lersek@redhat.com> wrote:
>> On 06/29/17 15:23, Marc-Andr=C3=A9 Lureau wrote:
>>> Add vmcoreinfo ELF note if vmcoreinfo device is ready.
>>>
>>> To help the python script, add a little global vmcoreinfo_gdb
>>> structure, that is populated with vmcoreinfo_gdb_update().
>>>
>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>> ---
>>>  scripts/dump-guest-memory.py | 32 ++++++++++++++++++++++++++++++++
>>>  include/hw/acpi/vmcoreinfo.h |  1 +
>>>  hw/acpi/vmcoreinfo.c         | 16 ++++++++++++++++
>>>  3 files changed, 49 insertions(+)
>>>
>>> diff --git a/scripts/dump-guest-memory.py b/scripts/dump-guest-memory=
.py
>>> index f7c6635f15..16c3d7cb10 100644
>>> --- a/scripts/dump-guest-memory.py
>>> +++ b/scripts/dump-guest-memory.py
>>> @@ -120,6 +120,20 @@ class ELF(object):
>>>          self.segments[0].p_filesz +=3D ctypes.sizeof(note)
>>>          self.segments[0].p_memsz +=3D ctypes.sizeof(note)
>>>
>>> +
>>> +    def add_vmcoreinfo_note(self, vmcoreinfo):
>>> +        """Adds a vmcoreinfo note to the ELF dump."""
>>> +        chead =3D type(get_arch_note(self.endianness, 0, 0))
>>> +        header =3D chead.from_buffer_copy(vmcoreinfo[0:ctypes.sizeof=
(chead)])
>>> +        note =3D get_arch_note(self.endianness,
>>> +                             header.n_namesz - 1, header.n_descsz)
>>> +        ctypes.memmove(ctypes.pointer(note), vmcoreinfo, ctypes.size=
of(note))
>>> +        header_size =3D ctypes.sizeof(note) - header.n_descsz
>>> +
>>> +        self.notes.append(note)
>>> +        self.segments[0].p_filesz +=3D ctypes.sizeof(note)
>>> +        self.segments[0].p_memsz +=3D ctypes.sizeof(note)
>>> +
>>>      def add_segment(self, p_type, p_paddr, p_size):
>>>          """Adds a segment to the elf."""
>>>
>>> @@ -505,6 +519,23 @@ shape and this command should mostly work."""
>>>                  cur +=3D chunk_size
>>>                  left -=3D chunk_size
>>>
>>> +    def add_vmcoreinfo(self):
>>> +        qemu_core =3D gdb.inferiors()[0]
>>> +
>>> +        gdb.execute("call vmcoreinfo_gdb_update()")
>>
>> I think it's a bad idea to call a function from a process that's just
>> crashed.
>=20
> Yeah, if qemu crashed you can't use that script. But we are talking
> about dump of guest kernel, so qemu didn't crash :)

I think we have a misunderstanding here. Extracting the guest kernel
core from the core dump of a crashed QEMU process is the *only* purpose
of the GDB extension implemented in "dump-guest-memory.py".

In other words, if you are loading "dump-guest-memory.py" into gdb, then
QEMU crashed *by definition*. Because otherwise you'd dump the guest
kernel core using the live monitor commands (HMP or QMP).

So, "dump-guest-memory.py" is really a last resort utility, for the case
when the guest kernel does something "interesting" that crashes QEMU
with hopefully localized damage, and most of the data structures
hopefully remain usable. It is not guaranteed at all that
"dump-guest-memory.py" will produce anything useful, dependent on how
corrupt the QEMU process memory is at the time of the SIGSEGV or SIGABRT
(or another fatal signal).

Please see the message on original QEMU commit 3e16d14fd93c
("Python-lang gdb script to extract x86_64 guest vmcore from qemu
coredump", 2013-12-17).

See also the original RFE -- I apologize to non-Red Hatters, the RHBZ is
private because it was filed by a customer --:

https://bugzilla.redhat.com/show_bug.cgi?id=3D826266

In my opinion, poking at possibly corrupt data structures with the
python script is OK, while executing code directly from the crashed
image is too much. But, again, that's just my opinion.

>=20
>>
>> If this feature is so important, maybe we can simply set a global
>> pointer variable at the end of vmcoreinfo_realize(); something like:
>>
>> static void vmcoreinfo_realize(DeviceState *dev, Error **errp)
>> {
>>     static VmcoreinfoState * volatile vmcoreinfo_gdb_helper;
>>     [...]
>>     vmcoreinfo_gdb_helper =3D VMCOREINFO(dev);
>> }
>>
>> - vmcoreinfo_gdb_helper has function scope, so no other code can abuse
>>   it
>> - it has static storage duration so gdb can access it at any time
>> - the pointer (not the pointed-to object) is qualified volatile, so gc=
c
>>   cannot optimize out the pointer assignment (which it might be tempte=
d
>>   to do otherwise, due to the pointer never being read within QEMU)
>>
>> Then you can use "vmcoreinfo_gdb_helper->vmcoreinfo_addr_le" to
>> implement all the logic in "dump-guest-memory.py".
>=20
> If necessary, I can try that.

Well, I can't claim it is "objectively necessary"; it's just that this
method would satisfy my preferences above (i.e., poking at process data
from python: OK; running code from the process: not OK).

Thanks,
Laszlo
