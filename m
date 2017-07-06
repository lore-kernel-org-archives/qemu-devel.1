Received: from eggs.gnu.org ([2001:4830:134:3::10]:39140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dT42O-0003Zy-89
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 06:29:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dT42J-0005r6-6D
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 06:29:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34154)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dT42I-0005qo-Te
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 06:29:27 -0400
References: <20170629132310.18865-1-marcandre.lureau@redhat.com>
	<20170629132310.18865-5-marcandre.lureau@redhat.com>
	<d002d6bb-19ad-f8ba-bfa9-fda9915009ee@redhat.com>
	<CAJ+F1CLgvHO3cm6+KM6RVG5AghronCq0KTG6GbEkLRa5Lo9m1A@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <f2f82e05-f9af-ed63-b5cc-37307f48cd95@redhat.com>
Date: Thu, 6 Jul 2017 12:29:22 +0200
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CLgvHO3cm6+KM6RVG5AghronCq0KTG6GbEkLRa5Lo9m1A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/7] dump: add vmcoreinfo ELF note
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Dave Anderson <anderson@redhat.com>, QEMU <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>

On 07/05/17 23:52, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Wed, Jul 5, 2017 at 1:48 AM, Laszlo Ersek <lersek@redhat.com> wrote:
>> On 06/29/17 15:23, Marc-Andr=C3=A9 Lureau wrote:

>>> @@ -258,6 +280,8 @@ static void write_elf64_notes(WriteCoreDumpFuncti=
on f, DumpState *s,
>>>              return;
>>>          }
>>>      }
>>> +
>>> +    write_vmcoreinfo_note(f, s, errp);
>>>  }
>>>
>>>  static void write_elf32_note(DumpState *s, Error **errp)
>>> @@ -303,6 +327,8 @@ static void write_elf32_notes(WriteCoreDumpFuncti=
on f, DumpState *s,
>>>              return;
>>>          }
>>>      }
>>> +
>>> +    write_vmcoreinfo_note(f, s, errp);
>>>  }
>>>
>>
>> Wait, I'm confused again. You explained why it was OK to hook this log=
ic
>> into the kdump handling too, but I don't think I understand your
>> explanation, so let me repeat my confusion below :)
>>
>> In the ELF case, this code works fine, I think. As long as the guest
>> provided us with a well-formed note, a well-formed note will be append=
ed
>> to the ELF dump.
>>
>> But, this code is also invoked in the kdump case, and I don't understa=
nd
>> why that's a good thing. If I understand the next patch correctly, the
>> kdump format already provides crash with a (trimmed) copy of the guest
>> kernels vmcoreinfo note. So in the kdump case, why do we have to creat=
e
>> yet another copy of the guest kernel's vmcoreinfo note?
>>
>> Thus, my confusion persists, and I can only think (again) that
>> write_vmcoreinfo_note() should be called from dump_begin() only (at th=
e
>> end). (And the s->note_size adjustment should take that into account.)
>>
>> Alternatively, we should keep this logic, and drop patch #5.
>=20
> You are right, sorry for my misunderstanding, although crash is seems
> fine as long as size/offsets are ok.
>=20
> So, instead of duplicating the info, let's keep the complete ELF note
> (with the header) in the dump, and simply adjust kdump header to point
> to the adjusted offset/size. This has the advantage of not making the
> code unnecessarily more complicated wrt s->note_size handling etc, and
> is consistent with the rest of the elf notes.

I guess that's OK, although I don't really see why even that is
necessary. The vmcoreinfo note should be possible to find in the kdump
output with the rest of the ELF notes, even without pointing some kdump
header fields into that specific note.

Snipping the rest because I'm going to see updates on those things in v2
anyway (which you've just posted).

Thanks
Laszlo
