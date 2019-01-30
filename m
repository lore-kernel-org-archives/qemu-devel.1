Received: from eggs.gnu.org ([209.51.188.92]:54063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1goskh-0005vG-CN
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 11:30:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1goskf-0005vv-D4
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 11:30:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35104
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farosas@linux.ibm.com>)
	id 1goskf-0005qj-64
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 11:30:13 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0UGTYaV087613
	for <qemu-devel@nongnu.org>; Wed, 30 Jan 2019 11:30:10 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qbd140unn-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 30 Jan 2019 11:30:09 -0500
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farosas@linux.ibm.com>;
	Wed, 30 Jan 2019 16:30:07 -0000
From: Fabiano Rosas <farosas@linux.ibm.com>
In-Reply-To: <d06f8763-f994-5913-424a-542f33d6b09a@ozlabs.ru>
References: <20190122170112.8706-1-farosas@linux.ibm.com>
	<20190122170112.8706-3-farosas@linux.ibm.com>
	<30929550-4e18-6c43-1d8f-d4065ec70544@ozlabs.ru>
	<20190126015006.GB22942@umbus> <878sz41rjx.fsf@linux.ibm.com>
	<d06f8763-f994-5913-424a-542f33d6b09a@ozlabs.ru>
Date: Wed, 30 Jan 2019 14:30:01 -0200
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <874l9q152u.fsf@linux.ibm.com>
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
Cc: qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, groug@kaod.org, qemu-devel@nongnu.org

Alexey Kardashevskiy <aik@ozlabs.ru> writes:

>
> but this is a register which does not have endianness, the endianness
> appears here because the interface between gdb and qemu is
> uint8_t*==bytestream but this interface should have fixed endianness
> imho (now it is bigendian afaict).
>
> Something is not right here...

Having a fixed endianness would not work because GDB have no way of
knowing how to represent what comes from the remote end. It will
always check the target endianness before printing a value, even if it
refers to a register:

https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;a=blob;f=gdb/findvar.c;hb=HEAD#l49

So in our case the contents of mem_buf need to match both the guest
endianness *and* what GDB has set for 'show endian' because it will
detect it automatically from the ELF. If it guesses incorrectly because
there is no ELF, we need to use the 'set endian' command.

By the way, this is already the behavior for the registers that are
already implemented (e.g. $msr). Here's the commit that introduced
that:

https://git.qemu.org/?p=qemu.git;a=commitdiff;h=8a286ce4502356ce0b97a2424a2cb7

Now, what might be a source of confusion here is the fact that we
*always* do a bswap when the host is LE because QEMU thinks that the ppc
guest is always BE. That requires the maybe_bswap function to make
things right in the end.

What I could do is try to improve this by only swapping when the
guest's actual endianness (msr_le) is different from the host's. That
is not entirely within the scope of this patch, though.

Cheers
