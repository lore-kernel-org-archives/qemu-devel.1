Received: from eggs.gnu.org ([209.51.188.92]:38813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jimw@sifive.com>) id 1goJqh-0000SY-L3
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 22:14:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jimw@sifive.com>) id 1goJoo-00065D-1I
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 22:12:10 -0500
Received: from mail-vs1-xe42.google.com ([2607:f8b0:4864:20::e42]:46561)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jimw@sifive.com>) id 1goJon-000646-U6
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 22:12:09 -0500
Received: by mail-vs1-xe42.google.com with SMTP id n10so11096954vso.13
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 19:12:09 -0800 (PST)
MIME-Version: 1.0
References: <CAFyWVaai=5K7j8w+Abpk9jxGyKuo4v9w2BgmDbY=_29+Q++Jyw@mail.gmail.com>
	<20181228221102.5080-1-jimw@sifive.com>
	<CAKmqyKMT7F_ziNjbdTU08ph33DnSkKyt+dSMSVXLVZffSvBu-w@mail.gmail.com>
In-Reply-To: <CAKmqyKMT7F_ziNjbdTU08ph33DnSkKyt+dSMSVXLVZffSvBu-w@mail.gmail.com>
From: Jim Wilson <jimw@sifive.com>
Date: Mon, 28 Jan 2019 19:11:58 -0800
Message-ID: <CAFyWVaYACGYvUe2ehYiT0hjJR4bUc44ZG5niEdT7mJOMXxGVpg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 5/5 v2] RISC-V: Add hooks to use the gdb
 xml files.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-riscv@nongnu.org

On Tue, Jan 22, 2019 at 1:52 PM Alistair Francis <alistair23@gmail.com> wrote:
> You can get env and then check for floating point support:
>
> CPURISCVState *env = &cs->env;
> if (env->misa_mask & RVF) {
> ...

I needed this which wasn't hard to figure out.
    RISCVCPU *cpu = RISCV_CPU(cs);
    CPURISCVState *env = &cpu->env;
    if (env->misa & RVF) {

The tricky bit was figuring out how to test it, because I wasn't sure
if making registers conditional would actually work.  I figured out
that using -machine sifive_e gives me a target with no fpu, and
playing with that a bit I get the expected result, which is that the
FP regs don't print anymore.  The FP related CSRs still do, but that
would require gdb fixes I think, because gdb knows that they are both
FP regs and CSR, and tries to print them both ways.  That leads to a
more general problem of figuring out exactly which CSRs a particular
target implements, which is a bigger problem than I have time to fix
at the moment, and should be handled as a separate problem.

Since my patch set is now a month old, I'll rebase onto current master
and post a version 3 patch set.

Jim
