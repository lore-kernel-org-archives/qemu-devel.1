Received: from eggs.gnu.org ([2001:4830:134:3::10]:48188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1elgkL-0003Mr-Ii
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 15:00:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1elgkG-0005sN-Lv
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 15:00:09 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46280 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1elgkG-0005s2-HI
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 15:00:04 -0500
References: <1516117900-11382-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1516117900-11382-5-git-send-email-stefanb@linux.vnet.ibm.com>
	<1e1dd3a3-7d87-38b1-cab3-5be375787896@linux.vnet.ibm.com>
	<20180212204609.GB30111@morn.lan>
	<b2725975-6823-8919-e937-56d8cb404372@linux.vnet.ibm.com>
	<e8cf7f36-249f-a3cc-f414-fac4e8b56b51@redhat.com>
	<20180213193758.GA21083@morn.lan>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <17e5dd66-e54d-56a3-7852-daf5bc11b741@redhat.com>
Date: Tue, 13 Feb 2018 20:59:45 +0100
MIME-Version: 1.0
In-Reply-To: <20180213193758.GA21083@morn.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 4/4] acpi: build TPM Physical Presence
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin O'Connor <kevin@koconnor.net>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>, marcandre.lureau@redhat.com, qemu-devel@nongnu.org, mst@redhat.com, Igor Mammedov <imammedo@redhat.com>

On 02/13/18 20:37, Kevin O'Connor wrote:
> On Tue, Feb 13, 2018 at 05:16:49PM +0100, Laszlo Ersek wrote:
>> On 02/12/18 21:49, Stefan Berger wrote:
>>> On 02/12/2018 03:46 PM, Kevin O'Connor wrote:
>>>> I'm not sure I fully understand the goals of the PPI interface.
>>>> Here's what I understand so far:
>>>>
>>>> The TPM specs define some actions that are considered privileged.=C2=
=A0 An
>>>> example of this would be disabling the TPM itself.=C2=A0 In order to
>>>> prevent an attacker from performing these actions without
>>>> authorization, the TPM specs define a mechanism to assert "physical
>>>> presence" before the privileged action can be done.=C2=A0 They do th=
is by
>>>> having the firmware present a menu during early boot that permits
>>>> these privileged operations, and then the firmware locks the TPM chi=
p
>>>> so the actions can no longer be done by any software that runs after
>>>> the firmware.=C2=A0 Thus "physical presence" is asserted by demonstr=
ating
>>>> one has console access to the machine during early boot.
>>>>
>>>> The PPI spec implements a work around for this - presumably some fou=
nd
>>>> the enforcement mechanism too onerous.=C2=A0 It allows the OS to pro=
vide a
>>>> request code to the firmware, and on the next boot the firmware will
>>>> take the requested action before it locks the chip.=C2=A0 Thus allow=
ing the
>>>> OS to indirectly perform the privileged action even after the chip h=
as
>>>> been locked.=C2=A0 Thus, the PPI system seems to be an "elaborate ha=
ck" to
>>>> allow users to circumvent the physical presence mechanism (if they
>>>> choose to).
>>>
>>> Correct.
>>>>
>>>> Here's what I understand the proposed implementation involves:
>>>>
>>>> 1 - in addition to emulating the TPM device itself, QEMU will also
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 introduce a virtual memory device with 0x40=
0 bytes.
>>> Correct.
>>>>
>>>> 2 - on first boot the firmware (seabios and uefi) will populate the
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 memory region created in step 1.=C2=A0 In p=
articular it will fill an
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 array with the list of request codes it sup=
ports.=C2=A0 (Each request
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 is an 8bit value, the array has 256 entries=
.)
>>> Correct. Each firmware would fill out the 256 byte array depending on
>>> what it supports. The 8 bit values are basically flags and so on.
>>>> 3 - QEMU will produce AML code implementing the standard PPI ACPI
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 interface.=C2=A0 This AML code will take th=
e request, find the table
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 produced in step 1, compare it to the list =
of accepted requests
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 produced in step 2, and then place the 8bit=
 request in another
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 qemu virtual memory device (at 0xFFFF0000 o=
r 0xFED45000).
>>>
>>> Correct.
>>>
>>> Now EDK2 wants to store the code in a UEFI variable in NVRAM. We
>>> therefore would need to trigger an SMI. In SeaBIOS we wouldn't have t=
o
>>> do this.
>>>
>>>> 4 - the OS will signal a reboot, qemu will do its normal reboot logi=
c,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 and the firmware will be run again.
>>>>
>>>> 5 - the firmware will extract the code written in stage 3, and if th=
e
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 tpm device has been configured to accept PP=
I codes from the OS, it
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 will invoke the requested action.
>>>
>>> SeaBIOS would look into memory to find the code. EDK2 will read the c=
ode
>>> from a UEFI variable.
>>>
>>>> Did I understand the above correctly?
>>> I think so. With the fine differences between SeaBIOS and EDK2 pointe=
d out.
>>
>> Here's what I suggest:
>>
>> Please everyone continue working on this, according to Kevin's &
>> Stefan's description, but focus on QEMU and SeaBIOS *only*. Ignore edk=
2
>> for now.
>=20
> If this were targetted at SeaBIOS, I'd look for a simpler
> QEMU/firmware interface.  Something like:
>=20
> A - QEMU produces AML code implementing the standard PPI ACPI
>     interface that generates a request code and stores it in the
>     device memory of an existing device (eg, writable fw_cfg or an
>     extension field in the existing emulated TPM device).
>=20
> B - after a reboot the firmware extracts the PPI request code
>     (produced in step A) and performs the requested action (if the TPM
>     is configured to accept OS generated codes).
>=20
> That is, skip steps 1 and 2 from the original proposal.

I think A/B can work fine, as long as
- the firmware can somehow dynamically recognize the device / "register
  block" that the request codes have to be pulled from, and
- QEMU is free to move the device or register block around, from release
  to release, without disturbing migration.

Thanks!
Laszlo
