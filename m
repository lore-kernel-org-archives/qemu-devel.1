Received: from eggs.gnu.org ([2001:4830:134:3::10]:56529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dSh4u-0003eL-Oz
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 05:58:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dSh4t-0003Tz-PJ
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 05:58:36 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:35308)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dSh4t-0003Td-DS
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 05:58:35 -0400
Received: by mail-lf0-x242.google.com with SMTP id z78so7956081lff.2
	for <qemu-devel@nongnu.org>; Wed, 05 Jul 2017 02:58:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <bbc74cf4-4d61-8ad3-7a33-0e6c49490892@redhat.com>
References: <20170629132310.18865-1-marcandre.lureau@redhat.com>
	<20170629132310.18865-7-marcandre.lureau@redhat.com>
	<bbc74cf4-4d61-8ad3-7a33-0e6c49490892@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 5 Jul 2017 11:58:33 +0200
Message-ID: <CAJ+F1CJvcwE0ed9ui8Z09ia5h29BXVEjQ7vbiJhSjkR09Kn7DA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Laszlo Ersek <lersek@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Dave Anderson <anderson@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

Hi

On Wed, Jul 5, 2017 at 2:22 AM, Laszlo Ersek <lersek@redhat.com> wrote:
> On 06/29/17 15:23, Marc-Andr=C3=A9 Lureau wrote:
>> Add vmcoreinfo ELF note if vmcoreinfo device is ready.
>>
>> To help the python script, add a little global vmcoreinfo_gdb
>> structure, that is populated with vmcoreinfo_gdb_update().
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  scripts/dump-guest-memory.py | 32 ++++++++++++++++++++++++++++++++
>>  include/hw/acpi/vmcoreinfo.h |  1 +
>>  hw/acpi/vmcoreinfo.c         | 16 ++++++++++++++++
>>  3 files changed, 49 insertions(+)
>>
>> diff --git a/scripts/dump-guest-memory.py b/scripts/dump-guest-memory.py
>> index f7c6635f15..16c3d7cb10 100644
>> --- a/scripts/dump-guest-memory.py
>> +++ b/scripts/dump-guest-memory.py
>> @@ -120,6 +120,20 @@ class ELF(object):
>>          self.segments[0].p_filesz +=3D ctypes.sizeof(note)
>>          self.segments[0].p_memsz +=3D ctypes.sizeof(note)
>>
>> +
>> +    def add_vmcoreinfo_note(self, vmcoreinfo):
>> +        """Adds a vmcoreinfo note to the ELF dump."""
>> +        chead =3D type(get_arch_note(self.endianness, 0, 0))
>> +        header =3D chead.from_buffer_copy(vmcoreinfo[0:ctypes.sizeof(ch=
ead)])
>> +        note =3D get_arch_note(self.endianness,
>> +                             header.n_namesz - 1, header.n_descsz)
>> +        ctypes.memmove(ctypes.pointer(note), vmcoreinfo, ctypes.sizeof(=
note))
>> +        header_size =3D ctypes.sizeof(note) - header.n_descsz
>> +
>> +        self.notes.append(note)
>> +        self.segments[0].p_filesz +=3D ctypes.sizeof(note)
>> +        self.segments[0].p_memsz +=3D ctypes.sizeof(note)
>> +
>>      def add_segment(self, p_type, p_paddr, p_size):
>>          """Adds a segment to the elf."""
>>
>> @@ -505,6 +519,23 @@ shape and this command should mostly work."""
>>                  cur +=3D chunk_size
>>                  left -=3D chunk_size
>>
>> +    def add_vmcoreinfo(self):
>> +        qemu_core =3D gdb.inferiors()[0]
>> +
>> +        gdb.execute("call vmcoreinfo_gdb_update()")
>
> I think it's a bad idea to call a function from a process that's just
> crashed.

Yeah, if qemu crashed you can't use that script. But we are talking
about dump of guest kernel, so qemu didn't crash :)

>
> If this feature is so important, maybe we can simply set a global
> pointer variable at the end of vmcoreinfo_realize(); something like:
>
> static void vmcoreinfo_realize(DeviceState *dev, Error **errp)
> {
>     static VmcoreinfoState * volatile vmcoreinfo_gdb_helper;
>     [...]
>     vmcoreinfo_gdb_helper =3D VMCOREINFO(dev);
> }
>
> - vmcoreinfo_gdb_helper has function scope, so no other code can abuse
>   it
> - it has static storage duration so gdb can access it at any time
> - the pointer (not the pointed-to object) is qualified volatile, so gcc
>   cannot optimize out the pointer assignment (which it might be tempted
>   to do otherwise, due to the pointer never being read within QEMU)
>
> Then you can use "vmcoreinfo_gdb_helper->vmcoreinfo_addr_le" to
> implement all the logic in "dump-guest-memory.py".

If necessary, I can try that.

>
> Just my two cents, of course.
>
> Thanks
> Laszlo
>
>> +        avail =3D gdb.parse_and_eval("vmcoreinfo_gdb.available")
>> +        if not avail:
>> +            return;
>> +
>> +        addr =3D gdb.parse_and_eval("vmcoreinfo_gdb.paddr")
>> +        size =3D gdb.parse_and_eval("vmcoreinfo_gdb.size")
>> +        for block in self.guest_phys_blocks:
>> +            if block["target_start"] <=3D addr < block["target_end"]:
>> +                haddr =3D block["host_addr"] + (addr - block["target_st=
art"])
>> +                vmcoreinfo =3D qemu_core.read_memory(haddr, size)
>> +                self.elf.add_vmcoreinfo_note(vmcoreinfo.tobytes())
>> +                return
>> +
>>      def invoke(self, args, from_tty):
>>          """Handles command invocation from gdb."""
>>
>> @@ -518,6 +549,7 @@ shape and this command should mostly work."""
>>
>>          self.elf =3D ELF(argv[1])
>>          self.guest_phys_blocks =3D get_guest_phys_blocks()
>> +        self.add_vmcoreinfo()
>>
>>          with open(argv[0], "wb") as vmcore:
>>              self.dump_init(vmcore)
>> diff --git a/include/hw/acpi/vmcoreinfo.h b/include/hw/acpi/vmcoreinfo.h
>> index 40fe99c3ed..4efa678237 100644
>> --- a/include/hw/acpi/vmcoreinfo.h
>> +++ b/include/hw/acpi/vmcoreinfo.h
>> @@ -32,5 +32,6 @@ void vmcoreinfo_build_acpi(VmcoreinfoState *vis, GArra=
y *table_data,
>>  void vmcoreinfo_add_fw_cfg(VmcoreinfoState *vis, FWCfgState *s, GArray =
*vmci);
>>  bool vmcoreinfo_get(VmcoreinfoState *vis, uint64_t *paddr, uint64_t *si=
ze,
>>                      Error **errp);
>> +void vmcoreinfo_gdb_update(void);
>>
>>  #endif
>> diff --git a/hw/acpi/vmcoreinfo.c b/hw/acpi/vmcoreinfo.c
>> index 216e0bb83a..75e3330813 100644
>> --- a/hw/acpi/vmcoreinfo.c
>> +++ b/hw/acpi/vmcoreinfo.c
>> @@ -145,6 +145,22 @@ bool vmcoreinfo_get(VmcoreinfoState *vis,
>>      return true;
>>  }
>>
>> +struct vmcoreinfo_gdb {
>> +    bool available;
>> +    uint64_t paddr;
>> +    uint64_t size;
>> +} vmcoreinfo_gdb;
>> +
>> +void vmcoreinfo_gdb_update(void)
>> +{
>> +    Object *vmci =3D find_vmcoreinfo_dev();
>> +
>> +    vmcoreinfo_gdb.available =3D vmci ?
>> +        vmcoreinfo_get(VMCOREINFO(vmci),
>> +                       &vmcoreinfo_gdb.paddr, &vmcoreinfo_gdb.size, NUL=
L)
>> +        : false;
>> +}
>> +
>>  static const VMStateDescription vmstate_vmcoreinfo =3D {
>>      .name =3D "vmcoreinfo",
>>      .version_id =3D 1,
>>
>
>



--=20
Marc-Andr=C3=A9 Lureau
