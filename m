Received: from eggs.gnu.org ([2001:4830:134:3::10]:35547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <huaicheng@cs.uchicago.edu>) id 1fNova-00089f-1o
	for qemu-devel@nongnu.org; Tue, 29 May 2018 20:25:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <huaicheng@cs.uchicago.edu>) id 1fNovW-0004AB-Ml
	for qemu-devel@nongnu.org; Tue, 29 May 2018 20:25:22 -0400
Received: from mx.cs.uchicago.edu ([128.135.164.214]:37164)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <huaicheng@cs.uchicago.edu>)
	id 1fNovW-00049Y-GA
	for qemu-devel@nongnu.org; Tue, 29 May 2018 20:25:18 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx.cs.uchicago.edu (Postfix) with ESMTP id 7268068368
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 19:25:17 -0500 (CDT)
Received: from mx.cs.uchicago.edu ([127.0.0.1])
	by localhost (mx.cs.uchicago.edu [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ofZN6m_RYqzw for <qemu-devel@nongnu.org>;
	Tue, 29 May 2018 19:25:16 -0500 (CDT)
Received: from mail-ua0-f181.google.com (mail-ua0-f181.google.com
	[209.85.217.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mx.cs.uchicago.edu (Postfix) with ESMTPSA id 9A230682CF
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 19:25:16 -0500 (CDT)
Received: by mail-ua0-f181.google.com with SMTP id e8-v6so11257906uam.13
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 17:25:16 -0700 (PDT)
MIME-Version: 1.0
From: Huaicheng Li <huaicheng@cs.uchicago.edu>
Date: Tue, 29 May 2018 17:24:40 -0700
Message-ID: <CANr0WEeKL03vFNYh1Nfj8rNWv_F3hrjwXZJUk+pjySfePAKo9w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] About cpu_physical_memory_map()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org

Dear QEMU/KVM developers,

I was trying to map a buffer in host QEMU process to a guest user space
application. I tried to achieve this
by allocating a buffer in the guest application first, then map this buffer
to QEMU process address space via
GVA -> GPA --> HVA (GPA to HVA is done via cpu_physical_memory_map). Last,
I wrote a host kernel driver to
walk QEMU process's page table and change corresponding page table entries
of HVA to the HPA of the target
buffer.

Basically, the idea is to keep

GVA --> GPA --> HVA mapping (this step is to map guest buffer into QEMU's
address space)

and change

HVA --> HPA1 (HPA1 is the physical base addr of the buffer malloc'ed by the
guest application)
to
HVA --> HPA2 (HPA2 is the physical base addr of the target buffer we want
to remap into guest application's address space)

The above change is done by my kernel module to change the page table
entries in QEMU's page table in the host system.
Under this case, I expect to see GVA will point to HPA2, instead of HPA1.

With the above change, when I access HVA in QEMU process, I find it indeed
points to HPA2.
However, inside guest OS, the application's GVA still points to HPA1

I have cleaned TLBs of QEMU process's page table as well as the guest
application's page table (in guest OS) accordingly
but the guest application's GVA is still mapped to HPA1, instead of HPA2.

Does QEMU maintain a fixed GPA to HVA mapping? After goingthrough the code
of "cpu_physical_memory_map()", I think
HVA is calculated as ramblock->host + GPA since guest RAM space is a
mmap'ed area in QEMU's address space and GPA
is an offset within that area. Thus, GPA -> HVA mapping is fixed during
runtime. Is QEMU/KVM doing
another layer of TLB caching so as to the guest application picks up the
old mapping to HPA1, instead of HPA2?

Any comments are appreciated.

Thank you!

Best,
Huaicheng
