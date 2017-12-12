Received: from eggs.gnu.org ([2001:4830:134:3::10]:54821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eOoMI-0004LV-39
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 12:28:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eOoMD-0007AY-E8
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 12:28:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58600)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1eOoMD-00076S-5A
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 12:28:41 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1E01BC00DBB1
	for <qemu-devel@nongnu.org>; Tue, 12 Dec 2017 17:28:38 +0000 (UTC)
References: <20171212163556.2543-1-marcandre.lureau@redhat.com>
	<a4c61f7b-d090-fcc8-8b2f-beb4af12a852@redhat.com>
	<1383318972.54081919.1513099055118.JavaMail.zimbra@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <6ce5e54e-b59a-e72b-016c-7530e3c2dc5f@redhat.com>
Date: Tue, 12 Dec 2017 18:28:30 +0100
MIME-Version: 1.0
In-Reply-To: <1383318972.54081919.1513099055118.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] dump-guest-memory.py: fix "You can't do
 that without a process to debug"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

On 12/12/17 18:17, Marc-Andr=C3=A9 Lureau wrote:
>=20
>=20
> ----- Original Message -----
>> On 12/12/17 17:35, Marc-Andr=C3=A9 Lureau wrote:Hi
>>> If the script is run with a core (no running process), it produces an
>>> error:
>>>
>>> (gdb)  dump-guest-memory /tmp/vmcore X86_64
>>> guest RAM blocks:
>>> target_start     target_end       host_addr        message count
>>> ---------------- ---------------- ---------------- ------- -----
>>> 0000000000000000 00000000000a0000 00007f7935800000 added       1
>>> 00000000000a0000 00000000000b0000 00007f7934200000 added       2
>>> 00000000000c0000 00000000000ca000 00007f79358c0000 added       3
>>> 00000000000ca000 00000000000cd000 00007f79358ca000 joined      3
>>> 00000000000cd000 00000000000e8000 00007f79358cd000 joined      3
>>> 00000000000e8000 00000000000f0000 00007f79358e8000 joined      3
>>> 00000000000f0000 0000000000100000 00007f79358f0000 joined      3
>>> 0000000000100000 0000000080000000 00007f7935900000 joined      3
>>> 00000000fd000000 00000000fe000000 00007f7934200000 added       4
>>> 00000000fffc0000 0000000100000000 00007f7935600000 added       5
>>> Python Exception <class 'gdb.error'> You can't do that without a proc=
ess to
>>> debug.:
>>> Error occurred in Python command: You can't do that without a process
>>> to debug.
>>>
>>> Replace the function call with a variable.
>>
>> Can you state, "replace the object_resolve_path_type() function call
>> with an extern variable"?
>=20
> ok
>=20
>>
>>> I tried to use static
>>> function variables, as suggested by Laszlo in earlier reviews, but th=
e
>>> compiler always took the chance to optimize them away.
>>
>> Did you qualify them "volatile" too?
>>
>> E.g., in the vmcoreinfo_realize() function:
>>
>>   static VMCoreInfoState * volatile vmcoreinfo_state;
>>   ...
>>   vmcoreinfo_state =3D s;
>>
>> (Note: it's the pointer itself that has to be volatile, not the
>> pointed-to object.)
>>
>> If you did try this, but GCC optimized it away, then that's a GCC bug.
>> In that case I guess I can't object to the present approach any longer=
.
>> Can you please confirm?
>>
>=20
> It seems to work, but you get a gcc warning:
>=20
> hw/misc/vmcoreinfo.c:38:39: warning: variable =E2=80=98vmcoreinfo_state=
=E2=80=99 set but not used [-Wunused-but-set-variable]
>=20
> I'll declare it like that and send v2:
> static VMCoreInfoState * volatile vmcoreinfo_state G_GNUC_UNUSED;

Awesome; thank you very much!

(If "G_GNUC_UNUSED" is otherwise accepted practice in the QEMU tree;
that is -- it does seem to be widely used.)

... please don't forget to update the commit message again (the variable
will have block scope, static storage duration, and *no* linkage -- so
it shouldn't be called "extern" like I originally suggested.)

Cheers!
Laszlo

>=20
>>>
>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>> ---
>>>  scripts/dump-guest-memory.py | 3 +--
>>>  hw/misc/vmcoreinfo.c         | 4 ++++
>>>  2 files changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/scripts/dump-guest-memory.py b/scripts/dump-guest-memory=
.py
>>> index 1af26c1a45..9dec796762 100644
>>> --- a/scripts/dump-guest-memory.py
>>> +++ b/scripts/dump-guest-memory.py
>>> @@ -546,8 +546,7 @@ shape and this command should mostly work."""
>>>          return None
>>> =20
>>>      def add_vmcoreinfo(self):
>>> -        vmci =3D '(VMCoreInfoState *)' + \
>>> -               'object_resolve_path_type("", "vmcoreinfo", 0)'
>>> +        vmci =3D 'vmcoreinfo_state'
>>>          if not gdb.parse_and_eval("%s" % vmci) \
>>>             or not gdb.parse_and_eval("(%s)->has_vmcoreinfo" % vmci):
>>>              return
>>> diff --git a/hw/misc/vmcoreinfo.c b/hw/misc/vmcoreinfo.c
>>> index 31db57ab44..d429a4f7d6 100644
>>> --- a/hw/misc/vmcoreinfo.c
>>> +++ b/hw/misc/vmcoreinfo.c
>>> @@ -31,6 +31,9 @@ static void vmcoreinfo_reset(void *dev)
>>>      s->vmcoreinfo.host_format =3D cpu_to_le16(VMCOREINFO_FORMAT_ELF)=
;
>>>  }
>>> =20
>>> +/* this variable is exported for gdb script dump-guest-memory.py */
>>> +VMCoreInfoState *vmcoreinfo_state;
>>> +
>>>  static void vmcoreinfo_realize(DeviceState *dev, Error **errp)
>>>  {
>>>      VMCoreInfoState *s =3D VMCOREINFO(dev);
>>> @@ -56,6 +59,7 @@ static void vmcoreinfo_realize(DeviceState *dev, Er=
ror
>>> **errp)
>>>                               &s->vmcoreinfo, sizeof(s->vmcoreinfo),
>>>                               false);
>>> =20
>>>      qemu_register_reset(vmcoreinfo_reset, dev);
>>> +    vmcoreinfo_state =3D s;
>>>  }
>>> =20
>>>  static const VMStateDescription vmstate_vmcoreinfo =3D {
>>>
>>
>> Thanks!
>> Laszlo
>>
