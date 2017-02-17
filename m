Received: from eggs.gnu.org ([2001:4830:134:3::10]:46255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cel0O-0003ym-Jy
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 11:03:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cel0L-0000tM-Gk
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 11:03:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cel0L-0000tH-8S
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 11:03:29 -0500
References: <cover.1487286467.git.ben@skyportsystems.com>
	<88232638f9ff3b17b54987624468678ea14a3037.1487286467.git.ben@skyportsystems.com>
	<20170217114321.6c8577e1@nial.brq.redhat.com>
	<4F60B53E-1A5D-4D4C-954F-F1C3ED5B487C@skyportsystems.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <de706a53-137c-a49d-5765-4afecc5ce3d8@redhat.com>
Date: Fri, 17 Feb 2017 17:03:25 +0100
MIME-Version: 1.0
In-Reply-To: <4F60B53E-1A5D-4D4C-954F-F1C3ED5B487C@skyportsystems.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 4/8] ACPI: Add Virtual Machine
 Generation ID support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ben Warren <ben@skyportsystems.com>, Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com

On 02/17/17 16:33, Ben Warren wrote:
>=20
>> On Feb 17, 2017, at 2:43 AM, Igor Mammedov <imammedo@redhat.com
>> <mailto:imammedo@redhat.com>> wrote:
>>
>> On Thu, 16 Feb 2017 15:15:36 -0800
>> ben@skyportsystems.com <mailto:ben@skyportsystems.com> wrote:
>>
>>> From: Ben Warren <ben@skyportsystems.com <mailto:ben@skyportsystems.c=
om>>
>>>
>>> This implements the VM Generation ID feature by passing a 128-bit
>>> GUID to the guest via a fw_cfg blob.
>>> Any time the GUID changes, an ACPI notify event is sent to the guest
>>>
>>> The user interface is a simple device with one parameter:
>>> - guid (string, must be "auto" or in UUID format
>>>   xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx)
>> I've given it some testing with WS2012R2 and v4 patches for Seabios,
>>
>> Windows is able to read initial GUID allocation and writeback
>> seems to work somehow:
>>
>> (qemu) info vm-generation-id
>> c109c09b-0e8b-42d5-9b33-8409c9dcd16c
>>
>> vmgenid client in Windows reads it as 2 following 64bit integers:
>> 42d50e8bc109c09b:6cd1dcc90984339b
>>
>> However update path/restore from snapshot doesn't
>> here is as I've tested it:
>>
>> qemu-system-x86_64 -device vmgenid,id=3Dtestvgid,guid=3Dauto -monitor =
stdio
>> (qemu) info vm-generation-id
>> c109c09b-0e8b-42d5-9b33-8409c9dcd16c
>> (qemu) stop
>> (qemu) migrate "exec:gzip -c > STATEFILE.gz"
>> (qemu) quit
>>
>> qemu-system-x86_64 -device vmgenid,id=3Dtestvgid,guid=3Dauto -monitor =
stdio
>> -incoming "exec: gzip -c -d STATEFILE.gz"
>> (qemu) info vm-generation-id
>> 28b587fa-991b-4267-80d7-9cf28b746fe9
>>
>> guest
>> 1. doesn't get GPE notification that it must receive
>> 2. vmgenid client in Windows reads the same value
>>      42d50e8bc109c09b:6cd1dcc90984339b
>>
> Strange, this was working for me, but with a slightly different test me=
thod:
>=20
>   * I use virsh save/restore

Awesome, this actually what I should try. All my guests are managed by
libvirt (with the occasional <qemu:arg>, for development), and direct
QEMU monitor commands such as

  virsh qemu-monitor-command ovmf.rhel7 --hmp 'info vm-generation-id'

only work for me if they are reasonably non-intrusive.

>   * While I do later testing with Windows, during development I use a
>     Linux kernel module I wrote that keeps track of GUID and
>     notifications.  I=E2=80=99m happy to share this with you if interes=
ted.

Please do. If you have a public git repo somewhere, that would be
awesome. (Bonus points if the module builds out-of-tree, if the
kernel-devel package is installed.)

NB: while the set-id monitor command was part of the series, I did test
it to the extent that I checked the SCI ("ACPI interrupt") count in the
guest, in /proc/interrupts. I did see it increase, so minimally the SCI
injection was fine.

Thanks!
Laszlo

> I=E2=80=99ll dig into this morning.
>=20
> =E2=80=94Ben
> <snip>
