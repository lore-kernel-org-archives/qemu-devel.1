Received: from eggs.gnu.org ([2001:4830:134:3::10]:41603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dsVwB-0002ci-0Z
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:20:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dsVw8-0005Gm-Cn
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:20:18 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:53467)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dsVw8-0005Ct-2Q
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:20:16 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <150505986682.19604.11937392314067517230.stgit@frigg.lan>
	<150506083546.19604.543091497330269756.stgit@frigg.lan>
	<169db8d7-fe49-05c4-aca7-ad818b12c9c5@linaro.org>
Date: Thu, 14 Sep 2017 18:20:04 +0300
In-Reply-To: <169db8d7-fe49-05c4-aca7-ad818b12c9c5@linaro.org> (Richard
	Henderson's message of "Wed, 13 Sep 2017 10:09:09 -0700")
Message-ID: <87a81xpasb.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/7] tcg: Add support for "inlining"
 regions of code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Richard Henderson <rth@twiddle.net>

Richard Henderson writes:

> On 09/10/2017 09:27 AM, Llu=C3=ADs Vilanova wrote:
>> TCG BBLs and instructions have multiple exit points from where to raise
>> tracing events, but some of the necessary information in the generic
>> disassembly infrastructure is not available until after generating these
>> exit points.
>>=20
>> This patch adds support for "inline points" (where the tracing code will
>> be placed), and "inline regions" (which identify the TCG code that must
>> be inlined). The TCG compiler will basically copy each inline region to
>> any inline points that reference it.

> I am not keen on this.

> Is there a reason you can't just emit the tracing code at the appropriate=
 place
> to begin with?  Perhaps I have to wait to see how this is used...

As I tried to briefly explain on next patch, the main problem without inlin=
ing
is that we will see guest_tb_after_trans twice on the trace for each TB in
conditional instructions on the guest, since they have two exit points (whi=
ch we
capture when emitting goto_tb in TCG).

We cannot instead emit it only once by overloading the brcond opcode in TCG,
since that can be used internally in the guest instruction emulation without
necessarily ending a TB (or we could have more than one brcond for a single
instruction).

I hope it's clearer now.


Thanks,
  Lluis
