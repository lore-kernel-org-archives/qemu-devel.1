Received: from eggs.gnu.org ([208.118.235.92]:39880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jimw@sifive.com>) id 1gdhCd-0007i8-MU
	for qemu-devel@nongnu.org; Sun, 30 Dec 2018 14:56:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jimw@sifive.com>) id 1gdhCc-0007VN-TN
	for qemu-devel@nongnu.org; Sun, 30 Dec 2018 14:56:51 -0500
Received: from mail-ua1-x941.google.com ([2607:f8b0:4864:20::941]:34140)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jimw@sifive.com>) id 1gdhCc-0007Up-OG
	for qemu-devel@nongnu.org; Sun, 30 Dec 2018 14:56:50 -0500
Received: by mail-ua1-x941.google.com with SMTP id c24so8232949uak.1
	for <qemu-devel@nongnu.org>; Sun, 30 Dec 2018 11:56:50 -0800 (PST)
MIME-Version: 1.0
References: <CAFyWVaai=5K7j8w+Abpk9jxGyKuo4v9w2BgmDbY=_29+Q++Jyw@mail.gmail.com>
	<20181228220731.4753-1-jimw@sifive.com>
	<bcf78767-a96e-8ba4-52da-97b34b3cb3ba@linaro.org>
In-Reply-To: <bcf78767-a96e-8ba4-52da-97b34b3cb3ba@linaro.org>
From: Jim Wilson <jimw@sifive.com>
Date: Sun, 30 Dec 2018 11:56:39 -0800
Message-ID: <CAFyWVaaTk_0cimE1z3p6vyT9hCvC4bF46KkooedFkz-QKP6g=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/5 v2] RISC-V: Add 32-bit gdb xml files.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org

On Sat, Dec 29, 2018 at 2:20 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 12/29/18 9:07 AM, Jim Wilson wrote:
> Don't the csr's vary between priv-1.9.1 and priv-1.10?

There are a few csr's that disappear in 1.10, but there is no known
hardware that implements them.  There are a few csr's new in 1.10, but
I don't know of any 1.9.1 systems that can run the software that
requires the new registers.  There are a few that change name; the
toolchain supports both the old and new names.  On the toolchain side,
currently, none of the tools care about the privilege spec version.
And the linux kernel doesn't care about the priv spec version either.
This will eventually have to change, maybe with 1.11, but so far it
hasn't been an issue with any software I've seen.

qemu has an option to specify the priv spec version.  But looking at
the csr's, this affects two of the registers that disappeared, which
were never implemented in hardware, and aren't supported by gdb.  This
also affects a few registers that have new fields in 1.10, but gdb
doesn't know about those internal register fields, so this doesn't
affect gdb either.

> I wonder if it would be better to auto-generate these, via the
> gdb_get_dynamic_xml hook.  That way you don't need near identical copies for
> 32-bit vs 64-bit.

I haven't tried looking at this, but I don't see a convenient list of
implemented csr's.  This list would be every csr that the
csr_read_helper function in target/riscv/op_helper.c supports  That
function requires some machine state that includes the register
values, so it doesn't look convenient to use, unless we add more
hackery to it.

Long term, it would be useful to have target specific csr register
lists.  Most csr's are optional, and most hardware only implements a
subset of them.  This is somewhat orthogonal to what I'm trying to do
here, but this would require a list of supported csr's in the target
hardware file, then this would have to be fed back into
csr_read_helper somehow, and then we could also use this to generate
an appropriate xml csr register file for that target for use with gdb.
Openocd already does something like this for a few supported targets.

Jim
