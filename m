Received: from eggs.gnu.org ([2001:4830:134:3::10]:59163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dxveH-0000mb-7i
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 09:48:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dxveE-0000H9-6A
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 09:48:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34554
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dxveE-0000Gm-0D
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 09:48:10 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8TDkGtj046756
	for <qemu-devel@nongnu.org>; Fri, 29 Sep 2017 09:48:05 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2d9kh5pkya-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 29 Sep 2017 09:48:05 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 29 Sep 2017 14:48:04 +0100
References: <20170926122427.GC4115@localhost.localdomain>
	<20170926130028.12471-1-ehabkost@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 29 Sep 2017 15:47:59 +0200
MIME-Version: 1.0
In-Reply-To: <20170926130028.12471-1-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <890a01d9-d7a0-6afd-ffac-5c8f2425570f@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] iothread: Make iothread_stop() idempotent
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>
List-ID: <qemu-devel.nongnu.org>

Is anybody going to pick this up? upstream qemu is still happily filling
up my disk with coredumps on exit.

On 09/26/2017 03:00 PM, Eduardo Habkost wrote:
> Currently, iothread_stop_all() makes all iothread objects unsafe
> to be destroyed, because qemu_thread_join() ends up being called
> twice.
> 
> To fix this, make iothread_stop() idempotent by checking
> thread->stopped.
> 
> Fixes the following crash:
> 
>   qemu-system-x86_64 -object iothread,id=iothread0 -monitor stdio -display none
>   QEMU 2.10.50 monitor - type 'help' for more information
>   (qemu) quit
>   qemu: qemu_thread_join: No such process
>   Aborted (core dumped)
> 
> Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  iothread.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/iothread.c b/iothread.c
> index 44c8944dc4..59d0850988 100644
> --- a/iothread.c
> +++ b/iothread.c
> @@ -85,7 +85,7 @@ static int iothread_stop(Object *object, void *opaque)
>      IOThread *iothread;
> 
>      iothread = (IOThread *)object_dynamic_cast(object, TYPE_IOTHREAD);
> -    if (!iothread || !iothread->ctx) {
> +    if (!iothread || !iothread->ctx || iothread->stopping) {
>          return 0;
>      }
>      iothread->stopping = true;
> 
