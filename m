Received: from eggs.gnu.org ([209.51.188.92]:51781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1gpKV4-0000qT-3Y
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 17:07:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1gpKL6-00032m-4E
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:57:41 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34248)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farosas@linux.ibm.com>)
	id 1gpKL5-00030N-OK
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:57:40 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0VLnLQk136934
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 16:57:38 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qc67cgrtg-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 16:57:37 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farosas@linux.ibm.com>;
	Thu, 31 Jan 2019 21:57:37 -0000
From: Fabiano Rosas <farosas@linux.ibm.com>
In-Reply-To: <c2c652ad-69af-5288-4861-aaf0e67e9b5b@ozlabs.ru>
References: <20190122170112.8706-1-farosas@linux.ibm.com>
	<20190122170112.8706-3-farosas@linux.ibm.com>
	<30929550-4e18-6c43-1d8f-d4065ec70544@ozlabs.ru>
	<20190126015006.GB22942@umbus> <878sz41rjx.fsf@linux.ibm.com>
	<d06f8763-f994-5913-424a-542f33d6b09a@ozlabs.ru>
	<874l9q152u.fsf@linux.ibm.com>
	<c2c652ad-69af-5288-4861-aaf0e67e9b5b@ozlabs.ru>
Date: Thu, 31 Jan 2019 19:57:28 -0200
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <871s4s1odz.fsf@linux.ibm.com>
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
To: Alexey Kardashevskiy <aik@ozlabs.ru>, David Gibson <david@gibson.dropbear.id.au>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org, groug@kaod.org, qemu-devel@nongnu.org

Alexey Kardashevskiy <aik@ozlabs.ru> writes:

> On 31/01/2019 03:30, Fabiano Rosas wrote:
>> Alexey Kardashevskiy <aik@ozlabs.ru> writes:
>> 
>>>
>>> but this is a register which does not have endianness, the endianness
>>> appears here because the interface between gdb and qemu is
>>> uint8_t*==bytestream but this interface should have fixed endianness
>>> imho (now it is bigendian afaict).
>>>
>>> Something is not right here...
>> 
>> Having a fixed endianness would not work because GDB have no way of
>> knowing how to represent what comes from the remote end.
>
> It definitely would. A register is stored as "unsigned long" in QEMU and
> all gdb has to do is printf("%lx") and that is it. 

OK, but something is not clear to me. Even if GDB just printf("%lx") the
value, we would still have to bswap when the host is LE, right?

QEMU BE:
 (gdb) x/8xb &env->spr[287]
 0x11391760: 0x00    0x00    0x00    0x00    0x00    0x4e    0x12    0x00

QEMU LE:
 (gdb) x/8xb &env->spr[287]
 0x7ffff5bd98c0: 0x01    0x02    0x4b    0x00    0x00    0x00    0x00    0x00

> The problem is that
> we want to pass it as a byte stream from the gdb_read_register() hook
> all the way to gdb and for some reason gdb does not define endianness of
> that stream but rather tries guessing the endianness which is broken.

GDB does define the endianness of the stream (in a way):

 "Each byte of register data is described by two hex digits. The bytes
 with the register are transmitted in target byte order."

https://sourceware.org/gdb/current/onlinedocs/gdb/Packets.html#Packets

> Today I was debugging rtas/clientinterface calls which a little endian
> kernel makes and these calls need to switch to the big endian first. And
> gdb goes nuts when this switch happens (note that I did not give an ELF
> to gdb this time so it picked LE itself). Even if it could fetch the
> endianness from QEMU, it would fail as it is an LE bit in MSR which is a
> register which is parsed according to the gdb's idea of endianness :)

I think it would be possible to define another packet for the remote
protocol that informs the endianness explicitly at each time the guest
stops. If you provide more info on how to reproduce that issue I could
put in my list or go bug GDB folks about it.

>> It will
>> always check the target endianness before printing a value, even if it
>> refers to a register:
>> 
>> https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;a=blob;f=gdb/findvar.c;hb=HEAD#l49
>> 
>> So in our case the contents of mem_buf need to match both the guest
>> endianness *and* what GDB has set for 'show endian' because it will
>> detect it automatically from the ELF. If it guesses incorrectly because
>> there is no ELF, we need to use the 'set endian' command.
>> 
>> By the way, this is already the behavior for the registers that are
>> already implemented (e.g. $msr). Here's the commit that introduced
>> that:
>> 
>> https://git.qemu.org/?p=qemu.git;a=commitdiff;h=8a286ce4502356ce0b97a2424a2cb7
>> 
>> Now, what might be a source of confusion here is the fact that we
>> *always* do a bswap when the host is LE because QEMU thinks that the ppc
>> guest is always BE. That requires the maybe_bswap function to make
>> things right in the end.
>> 
>> What I could do is try to improve this by only swapping when the
>> guest's actual endianness (msr_le) is different from the host's.
>
> The bytestream for registers should have fixed endianness. But looking
> at the gdb code makes me think it is not going to happen :(

Yes, I can't think of a way to fix that without changing the way GDB
exhibits the values or the remote protocol.

May I proceed with this series as it is with the bswaps?

>> That
>> is not entirely within the scope of this patch, though.
>
> True. But since you are touching this, may be you could fix gdb too :)
>
> Does gdb tell QEMU about what endianness it thinks that QEMU is using?
> Or can it read it from QEMU? I cannot easily spot this in QEMU...

GDB currently does not tell and does not ask about endianness. So I
believe there is room for improvement here. I could not find it in the
documentation but I think that GDB supports file transfers and it asks
for the ELF in some scenarios. This approach could be one way of
informing it about the endianness, although it has its own shortcomings.
