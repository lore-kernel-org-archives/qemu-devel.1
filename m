Received: from eggs.gnu.org ([2001:4830:134:3::10]:52851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dWHb9-0000hI-17
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 03:34:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dWHb2-0008GJ-LS
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 03:34:43 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:38181)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dWHb2-0008Fi-98
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 03:34:36 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <150002001195.22386.4679134058536830996.stgit@frigg.lan>
	<150002073981.22386.9870422422367410100.stgit@frigg.lan>
	<01ac89ab-c7b0-3ada-b8bf-9f033cf90f15@twiddle.net>
Date: Sat, 15 Jul 2017 10:34:20 +0300
In-Reply-To: <01ac89ab-c7b0-3ada-b8bf-9f033cf90f15@twiddle.net> (Richard
	Henderson's message of "Fri, 14 Jul 2017 06:48:02 -1000")
Message-ID: <87pod2b1c3.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v13 03/26] target: [tcg] Add generic
 translation framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, "Emilio G. Cota" <cota@braap.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

Richard Henderson writes:

> On 07/13/2017 10:25 PM, Llu=C3=ADs Vilanova wrote:
>> +        /* Pass breakpoint hits to target for further processing */
>> +        if (unlikely(!QTAILQ_EMPTY(&cpu->breakpoints))) {
>> +            CPUBreakpoint *bp;
>> +            QTAILQ_FOREACH(bp, &cpu->breakpoints, entry) {
>> +                if (bp->pc =3D=3D db->pc_next) {
>> +                    if (ops->breakpoint_check(db, cpu, bp)) {
>> +                        break;
>> +                    }
>> +                }
>> +            }
>> +
>> +            if (db->is_jmp =3D=3D DISAS_NORETURN) {
>> +                break;
>> +            }
>> +        }

> You should accept any !=3D DISAS_NEXT value here.
> (1) Because DISAS_NEXT =3D=3D 0 and it's the quickest test, and
> (2) If you *require* NORETURN here, then you've also got to
> convert some of the backends to not use DISAS_TARGET_N, which
> as of [07/26] target/i386: [tcg] Port to breakpoint_check, I
> haven't seen happen.

No, arm has cases with both DISAS_TARGET_N and DISAS_NORETURN, where both e=
nd
the bp check loop, but only DISAS_NORETURN breaks the translation loop (the
previous goto done_generating).

And i386 has no DISAS_NORETURN simply because that's not the behaviour in i=
ts
original code.
