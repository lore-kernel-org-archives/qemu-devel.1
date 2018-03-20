Received: from eggs.gnu.org ([2001:4830:134:3::10]:35832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eyEPY-0001y6-Ut
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 06:22:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eyEPU-00020z-WD
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 06:22:32 -0400
References: <1521468046-10400-1-git-send-email-thuth@redhat.com>
	<66c6e02a-a082-b9ef-f13c-3cdd8b0775f7@ilande.co.uk>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <71f8966d-9c5f-a5c5-6a93-9fb11edeed43@redhat.com>
Date: Tue, 20 Mar 2018 11:22:09 +0100
MIME-Version: 1.0
In-Reply-To: <66c6e02a-a082-b9ef-f13c-3cdd8b0775f7@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.12] hw/misc/macio: Fix crash when
 listing device properties of macio device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>

On 20.03.2018 06:05, Mark Cave-Ayland wrote:
> On 19/03/18 14:00, Thomas Huth wrote:
>=20
>> The macio-newworld device can currently be used to abort QEMU
>> unexpectedly:
>>
>> $ ppc-softmmu/qemu-system-ppc -S -M ref405ep,accel=3Dqtest -qmp stdio
>> {"QMP": {"version": {"qemu": {"micro": 50, "minor": 11, "major": 2},
>> =C2=A0 "package": "build-all"}, "capabilities": []}}
>> { 'execute': 'qmp_capabilities' }
>> {"return": {}}
>> { 'execute': 'device-list-properties',
>> =C2=A0=C2=A0 'arguments': {'typename': 'macio-newworld'}}
>> Unexpected error in qemu_chr_fe_init() at chardev/char-fe.c:222:
>> Device 'serial0' is in use
>> Aborted (core dumped)
>>
>> qdev properties should be set during realize(), not during
>> instance_init(),
>> so move the related code there to fix this problem.
>=20
> Ah right, presumably this is because of the reference to serial_hds
> again?

Right.

> The patch looks good, although given that it affects
> macio_instance_init() and macio_common_realize() then I would have
> expected this to have failed on the macio-oldworld device too (or
> perhaps you were just unlucky that this was the first macio-*world
> device enumerated).

Yes, the bug triggers also with the macio-oldworld device. I just hit it
with the newworld device first.

 Thomas
