Received: from eggs.gnu.org ([2001:4830:134:3::10]:45451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.ibm.com>) id 1fLxoX-0006BQ-4N
	for qemu-devel@nongnu.org; Thu, 24 May 2018 17:30:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.ibm.com>) id 1fLxoS-00084P-8x
	for qemu-devel@nongnu.org; Thu, 24 May 2018 17:30:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36638)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.ibm.com>)
	id 1fLxoS-00083X-1Q
	for qemu-devel@nongnu.org; Thu, 24 May 2018 17:30:20 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4OLSkhu079494
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 17:30:18 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2j641qb6pr-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 17:30:17 -0400
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.ibm.com>;
	Thu, 24 May 2018 17:30:16 -0400
References: <42ec7519-653d-09e2-abc6-78f04733ca47@linux.ibm.com>
	<20180524140453.GB28984@stefanha-x1.localdomain>
From: Daniel Henrique Barboza <danielhb@linux.ibm.com>
Date: Thu, 24 May 2018 18:30:10 -0300
MIME-Version: 1.0
In-Reply-To: <20180524140453.GB28984@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Message-Id: <a30a4e06-4028-4cad-ebae-e7bd3be7359a@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] Problem with data miscompare using
 scsi-hd, cache=none and io=threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>



On 05/24/2018 11:04 AM, Stefan Hajnoczi wrote:
> On Tue, May 15, 2018 at 06:25:46PM -0300, Daniel Henrique Barboza wrote=
:
>> This means that the test executed a write at=A0 LBA 0x94fa and, after
>> confirming that the write was completed, issue 2 reads in the same LBA=
 to
>> assert the written contents and found out a mismatch.
> Have you confirmed this pattern at various levels in the stack:
> 1. Application inside the guest (strace)
> 2. Guest kernel block layer (blktrace)
> 3. QEMU (strace)
> 4. Host kernel block layer (blktrace)

Tested (3). In this case the bug stop reproducing. Not sure if there is
anything related with strace adding a delay back and forth the
preadv/pwritev calls, but the act of attaching strace to the QEMU
process changed the behavior.

Haven't tried the other 3 scenarios. (2) and (4) are definitely worth=20
trying it
out, specially (4).

> The key thing is that the write completes before the 2 reads are
> submitted.
>
> Have you tried running the test on bare metal?

Yes. The stress test does not reproduce the miscompare issue when
running on bare metal.


Thanks,

Daniel

>
> Stefan
