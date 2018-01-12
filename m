Received: from eggs.gnu.org ([2001:4830:134:3::10]:42485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <steven.seeger@flightsystems.net>) id 1ea4BG-0000yk-04
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 13:35:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <steven.seeger@flightsystems.net>) id 1ea4BC-0005vq-TC
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 13:35:54 -0500
Received: from p3plsmtpa06-05.prod.phx3.secureserver.net
	([173.201.192.106]:51963)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <steven.seeger@flightsystems.net>)
	id 1ea4BC-0005ti-Nr
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 13:35:50 -0500
From: Steven Seeger <steven.seeger@flightsystems.net>
Reply-To: steven.seeger@flightsystems.net
Date: Fri, 12 Jan 2018 13:35:47 -0500
Message-ID: <2270319.IXj8bBQWhi@wirbelwind>
In-Reply-To: <c2e77a8e-077d-1d7e-b19c-e6f9c683d6aa@redhat.com>
References: <2465248.BadtJazF69@wirbelwind> <13538328.oP85yjFLDs@wirbelwind>
	<c2e77a8e-077d-1d7e-b19c-e6f9c683d6aa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Subject: Re: [Qemu-devel] ppc icount questions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

> I think this is the issue:
> 
>      I/O thread                    vCPU thread
>  -----------------------------------------------------------------------
>                                    executes 1,000,000,000-th instruction
>                                    wakes up I/O thread
>      finds 1st timer
>      runs 1st timer
>                                    executes 1,000 instructions
> ----------- QEMU_CLOCK_VIRTUAL now is 1,000,001,000 --------------------
>      1st timer finishes
>                                    executes 10,000 instructions
> ----------- QEMU_CLOCK_VIRTUAL now is 1,000,011,000 --------------------
>      runs 2nd timer

I would agree this is the issue. I was thinking that the timer ran in the same 
thread as the CPU (thus preventing the two from running at the same time) but 
I guess this is not true. There must be some sync point, because taking too 
long to finish the timer makes things stall (or that may just be due to 
causing a delay in delivery of the next interrupt.)

So I guess what I am looking for is a way to ensure the two run mutually 
exclusive of each other. I know from other systems that we can run all this in 
a single thread (hardware models and guest CPU) so it should be possible to do 
in QEMU as well.

Steven
