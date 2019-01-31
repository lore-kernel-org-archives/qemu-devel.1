Received: from eggs.gnu.org ([209.51.188.92]:40967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gp7Dw-0007oz-Ce
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:57:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gp7Dt-000386-5l
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:57:24 -0500
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:38490)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1gp7Ds-00037d-Q8
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:57:21 -0500
Received: by mail-io1-xd43.google.com with SMTP id l14so1867794ioj.5
	for <qemu-devel@nongnu.org>; Wed, 30 Jan 2019 23:57:20 -0800 (PST)
References: <20190122170112.8706-1-farosas@linux.ibm.com>
	<20190122170112.8706-3-farosas@linux.ibm.com>
	<30929550-4e18-6c43-1d8f-d4065ec70544@ozlabs.ru>
	<20190126015006.GB22942@umbus> <878sz41rjx.fsf@linux.ibm.com>
	<d06f8763-f994-5913-424a-542f33d6b09a@ozlabs.ru>
	<874l9q152u.fsf@linux.ibm.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <c2c652ad-69af-5288-4861-aaf0e67e9b5b@ozlabs.ru>
Date: Thu, 31 Jan 2019 18:57:13 +1100
MIME-Version: 1.0
In-Reply-To: <874l9q152u.fsf@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v4 2/3] target/ppc: Add GDB
 callbacks for SPRs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fabiano Rosas <farosas@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, groug@kaod.org, qemu-devel@nongnu.org



On 31/01/2019 03:30, Fabiano Rosas wrote:
> Alexey Kardashevskiy <aik@ozlabs.ru> writes:
> 
>>
>> but this is a register which does not have endianness, the endianness
>> appears here because the interface between gdb and qemu is
>> uint8_t*==bytestream but this interface should have fixed endianness
>> imho (now it is bigendian afaict).
>>
>> Something is not right here...
> 
> Having a fixed endianness would not work because GDB have no way of
> knowing how to represent what comes from the remote end.

It definitely would. A register is stored as "unsigned long" in QEMU and
all gdb has to do is printf("%lx") and that is it. The problem is that
we want to pass it as a byte stream from the gdb_read_register() hook
all the way to gdb and for some reason gdb does not define endianness of
that stream but rather tries guessing the endianness which is broken.

Today I was debugging rtas/clientinterface calls which a little endian
kernel makes and these calls need to switch to the big endian first. And
gdb goes nuts when this switch happens (note that I did not give an ELF
to gdb this time so it picked LE itself). Even if it could fetch the
endianness from QEMU, it would fail as it is an LE bit in MSR which is a
register which is parsed according to the gdb's idea of endianness :)


> It will
> always check the target endianness before printing a value, even if it
> refers to a register:
> 
> https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;a=blob;f=gdb/findvar.c;hb=HEAD#l49
> 
> So in our case the contents of mem_buf need to match both the guest
> endianness *and* what GDB has set for 'show endian' because it will
> detect it automatically from the ELF. If it guesses incorrectly because
> there is no ELF, we need to use the 'set endian' command.
> 
> By the way, this is already the behavior for the registers that are
> already implemented (e.g. $msr). Here's the commit that introduced
> that:
> 
> https://git.qemu.org/?p=qemu.git;a=commitdiff;h=8a286ce4502356ce0b97a2424a2cb7
> 
> Now, what might be a source of confusion here is the fact that we
> *always* do a bswap when the host is LE because QEMU thinks that the ppc
> guest is always BE. That requires the maybe_bswap function to make
> things right in the end.
> 
> What I could do is try to improve this by only swapping when the
> guest's actual endianness (msr_le) is different from the host's.

The bytestream for registers should have fixed endianness. But looking
at the gdb code makes me think it is not going to happen :(


> That
> is not entirely within the scope of this patch, though.

True. But since you are touching this, may be you could fix gdb too :)

Does gdb tell QEMU about what endianness it thinks that QEMU is using?
Or can it read it from QEMU? I cannot easily spot this in QEMU...


-- 
Alexey
