Received: from eggs.gnu.org ([2001:4830:134:3::10]:60998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alexander.boettcher@genode-labs.com>)
	id 1ckuIi-00071g-59
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 10:11:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alexander.boettcher@genode-labs.com>)
	id 1ckuIf-00071b-06
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 10:11:52 -0500
Received: from mail.genode-labs.com ([88.198.56.169]:35884)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alexander.boettcher@genode-labs.com>)
	id 1ckuIe-00071L-PP
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 10:11:48 -0500
References: <49fcb3c4-df9d-ec64-2927-71c02fc2524b@genode-labs.com>
	<87k282im0q.fsf@linaro.org>
	<6515bcf7-e3cd-21b4-746b-c386b1296d88@genode-labs.com>
	<87innmii02.fsf@linaro.org>
From: Alexander Boettcher <alexander.boettcher@genode-labs.com>
Message-ID: <d208c3f0-2e57-0b54-f18f-b5e27d698e28@genode-labs.com>
Date: Mon, 6 Mar 2017 16:11:43 +0100
MIME-Version: 1.0
In-Reply-To: <87innmii02.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Qemu deadlocks in tb_lock when using SVM+SoftMMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, rth@twiddle.net, fred.konrad@greensocs.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com

Hi,

On 06.03.2017 15:42, Alex Benn=C3=A9e wrote:
>=20
> Alexander Boettcher <alexander.boettcher@genode-labs.com> writes:
>=20
>> Hi,
>>
>> On 06.03.2017 14:15, Alex Benn=C3=A9e wrote:
>>> I found the virtualbox.iso on your branch but I can't trigger the
>>> assert. Running:
>>>
>>> #!/bin/sh
>>>
>>> QEMU=3D"$@"
>>>
>>> ${QEMU} -s -no-kvm -display sdl -m 512 -cpu phenom -nographic -cdrom =
virtualbox.iso
>>>
>>> I get:
>>>
>>> NOVA Microhypervisor v7-2436fe2 (x86_32): Feb 25 2017 17:58:48 [gcc 4=
.9.2]
>>> [init -> log_terminal]
>>> [init -> log_terminal] [ 0] CORE:0:0:0 10:2:3:0 [0] AMD Phenom(tm) 95=
50 Quad-Core Processor
>>> qemu: fatal: invalid tss type
>>
>>
>>> Which is a guest error?
>>
>> It's a race which happens in Qemu (not on hardware), so I still
>> investigating it within Qemu. Because of that on [0] the commit before
>> the virtualbox.iso is one commit to avoid this for the moment in order
>> to continue.
>=20
> How can a single-threaded system emulation race with itself?

Good question, I would say interrupts/timing in general. State must be
saved and restored when switching between the modes. Depending on where
you run when an interrupt (e.g. timer) happens (in the hypervisor, or in
user-level VMM respectively in some user-level applications or you run
in the VM in ring-0/ring-3.), different code paths are executed within
Qemu. As said, I'm still investigating, looks like something is not
saved/restored correctly everytime.

Sometimes Qemu just succeeds if the timing is well, will see.

But this is not the point of this issue atm.

Alex.
