Received: from eggs.gnu.org ([2001:4830:134:3::10]:52742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alexander.boettcher@genode-labs.com>)
	id 1clGHl-00010h-Sc
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 09:40:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alexander.boettcher@genode-labs.com>)
	id 1clGHh-0007Pk-Uf
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 09:40:21 -0500
Received: from mail.genode-labs.com ([88.198.56.169]:55281)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alexander.boettcher@genode-labs.com>)
	id 1clGHh-0007PY-Ni
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 09:40:17 -0500
References: <20170307113736.13864-1-pbonzini@redhat.com>
	<87bmtdi28g.fsf@linaro.org>
From: Alexander Boettcher <alexander.boettcher@genode-labs.com>
Message-ID: <5cbb1c3a-9b74-2bb5-3b59-6209a0aaeca5@genode-labs.com>
Date: Tue, 7 Mar 2017 15:40:08 +0100
MIME-Version: 1.0
In-Reply-To: <87bmtdi28g.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] target-i386: defer VMEXIT to do_interrupt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

On 07.03.2017 15:35, Alex Benn=C3=A9e wrote:
>=20
> Paolo Bonzini <pbonzini@redhat.com> writes:
>=20
>> Paths through the softmmu code during code generation now need to be a=
udited
>> to check for double locking of tb_lock.  In particular, VMEXIT can tak=
e tb_lock
>> through cpu_vmexit -> cpu_x86_update_cr4 -> tlb_flush.
>>
>> To avoid this, split VMEXIT delivery in two parts, similar to what is =
done with
>> exceptions.  cpu_vmexit only records the VMEXIT exit code and informat=
ion, and
>> cc->do_interrupt can then deliver it when it is safe to take the lock.
>>
>> Reported-by: Alexander Boettcher <alexander.boettcher@genode-labs.com>
>> Suggested-by: Richard Henderson <rth@twiddle.net>
>> Tested-by: Alexander Boettcher <alexander.boettcher@genode-labs.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>=20
> Looks good to me. When I ran it against Alexander's test case I got:
>=20
>   [init -> log_terminal]
>   [init -> log_terminal] [ 0] CORE:0:0:0 10:2:3:0 [0] AMD Phenom(tm) 95=
50 Quad-Core Processor
>   [init -> log_terminal] [ 0] Killed EC:0xc002c160 SC:0xc002d100 V:0xd =
CS:0x1b EIP:0x14455e CR2:0xe0004004 ERR:0x0 (PT not found) Pd::root
>=20
> But that could be because I'm running remotely in a terminal environmen=
t
> with a null display. I did test against my known good x86 setup and gav=
e
> it some stress and it looks good on that. As long as Alexander is happy
> with his testing I'll snarf this into my series and post today.

That is fine. The GP (0xd) exception will be fixed as soon as the
reorder SVM I/O patch get into qemu master ( I posted it some days ago
with subject "[PATCH=C2=B1 SVM I/O permission bitmap for user-level (ring=
-3)
code ignored" )

Thanks!

--=20
Alexander Boettcher
Genode Labs

http://www.genode-labs.com - http://www.genode.org

Genode Labs GmbH - Amtsgericht Dresden - HRB 28424 - Sitz Dresden
Gesch=C3=A4ftsf=C3=BChrer: Dr.-Ing. Norman Feske, Christian Helmuth
