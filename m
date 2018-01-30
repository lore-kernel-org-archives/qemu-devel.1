Received: from eggs.gnu.org ([208.118.235.92]:55760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1egew9-00035d-2u
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 18:04:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1egevO-0002pN-7F
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 18:03:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1egevN-0002ma-Ph
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 18:02:45 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
References: <1516434868-24776-1-git-send-email-linzc@zju.edu.cn>
	<3c212a49-6b50-4753-58f5-25837f583a9d@redhat.com>
	<2a533022.52227.1613af9b851.Coremail.linzc@zju.edu.cn>
Message-ID: <abe5bda3-01ad-1058-6039-0f07c6655fee@redhat.com>
Date: Tue, 30 Jan 2018 18:02:38 -0500
MIME-Version: 1.0
In-Reply-To: <2a533022.52227.1613af9b851.Coremail.linzc@zju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] vcpu: create vcpu thread with
 QEMU_THREAD_DETACHED mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: CheneyLin <linzc@zju.edu.cn>
Cc: qemu-devel@nongnu.org, crosthwaite.peter@gmail.com, rth@twiddle.net

On 28/01/2018 05:14, CheneyLin wrote:
>> This is dangerous, it risks introducing use-after-free bugs in the vCPU
>> thread.  Can you instead add a qemu_thread_join call where the vCPU goes
>> away (e.g. unrealize, I'm not sure)?
> 
> 1. If another thread calls qemu_thread_join, it will block until vcpu thread exit.

Sure, but that's not a problem.  If the code is written correctly, it
will only block for a very short time.  In particular, in this case
we'll block anyway in cpu_remove_sync.  The fix is just to change that
function from qemu_cond_wait to qemu_thread_join.

> 2. As vcpu exits, its resources should be freed ,which will not be used any more(e.g. user space stack), how can we get use-after-free bugs?

Use-after-free bugs happen in the vCPU thread if the vCPU resources are
freed just before the vCPU thread exits.

Paolo
