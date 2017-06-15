Received: from eggs.gnu.org ([2001:4830:134:3::10]:39102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1dLKb0-0001rz-JI
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 22:33:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1dLKax-0002lC-AH
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 22:33:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41301)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1dLKax-0002iw-0o
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 22:33:15 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v5F2SrHD089736
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 22:33:13 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2b3ftyun6t-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 22:33:13 -0400
Received: from localhost
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Thu, 15 Jun 2017 12:33:10 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <87wp8ght4g.fsf@linaro.org>
References: <1497351329-12936-1-git-send-email-thuth@redhat.com>
	<87wp8ght4g.fsf@linaro.org>
Date: Thu, 15 Jun 2017 08:02:11 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <877f0et1zo.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] target/ppc/excp_helper: Take
 BQL before calling cpu_interrupt()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <bherren@au1.ibm.com>

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Thomas Huth <thuth@redhat.com> writes:
>
>> Since the introduction of MTTCG, using the msgsnd instruction
>> abort()s if being called without holding the BQL. So let's protect
>> that part of the code now with qemu_mutex_lock_iothread().
>>
>> Buglink: https://bugs.launchpad.net/qemu/+bug/1694998
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> p.s. I was checking the ppc code for other CPU_FOREACH patterns and I
> noticed the tlb_flush calls could probably use the tlb_flush_all_cpus
> API instead of manually looping themselves.

Will that be synchronous call? In PPC, we do lazy tlb flush, the tlb
flushes are batched until a synchronization point (for optimization).
The batching is achieved using a tlb_need_flush (global/local) and when
there is isync/ptesync or an exception, the actual flush is done. At
this point we need to make sure that the flush is synchronous.

> You should also double check the semantics to make sure none of them
> need to use the _synced variant and a cpu_exit if the flush needs to
> complete w.r.t the originating CPU.

Regards,
Nikunj
