Received: from eggs.gnu.org ([2001:4830:134:3::10]:39402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cX93T-0003W3-WE
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 11:07:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cX93Q-0000bM-09
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 11:07:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37924)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cX93P-0000bC-Pj
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 11:07:11 -0500
References: <20170126170119.27876-1-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5f274867-7189-5bcd-d64b-f5ff31b0d54c@redhat.com>
Date: Fri, 27 Jan 2017 17:07:08 +0100
MIME-Version: 1.0
In-Reply-To: <20170126170119.27876-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] iothread: enable AioContext polling by
 default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Karl Rister <krister@redhat.com>



On 26/01/2017 18:01, Stefan Hajnoczi wrote:
> IOThread AioContexts are likely to consist only of event sources like
> virtqueue ioeventfds and LinuxAIO completion eventfds that are pollable
> from userspace (without system calls).
> 
> We recently merged the AioContext polling feature but didn't enable it
> by default yet.  I have gone back over the performance data on the
> mailing list and picked a default polling value that gave good results.
> 
> Let's enable AioContext polling by default so users don't have another
> switch they need to set manually.  If performance regressions are found
> we can still disable this for the QEMU 2.9 release.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Karl Rister <krister@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  iothread.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/iothread.c b/iothread.c
> index 7bedde8..257b01d 100644
> --- a/iothread.c
> +++ b/iothread.c
> @@ -30,6 +30,12 @@ typedef ObjectClass IOThreadClass;
>  #define IOTHREAD_CLASS(klass) \
>     OBJECT_CLASS_CHECK(IOThreadClass, klass, TYPE_IOTHREAD)
>  
> +/* Benchmark results from 2016 on NVMe SSD drives show max polling times around
> + * 16-32 microseconds yield IOPS improvements for both iodepth=1 and iodepth=32
> + * workloads.
> + */
> +#define IOTHREAD_POLL_MAX_NS_DEFAULT 32768ULL
> +
>  static __thread IOThread *my_iothread;
>  
>  AioContext *qemu_get_current_aio_context(void)
> @@ -71,6 +77,13 @@ static int iothread_stop(Object *object, void *opaque)
>      return 0;
>  }
>  
> +static void iothread_instance_init(Object *obj)
> +{
> +    IOThread *iothread = IOTHREAD(obj);
> +
> +    iothread->poll_max_ns = IOTHREAD_POLL_MAX_NS_DEFAULT;
> +}
> +
>  static void iothread_instance_finalize(Object *obj)
>  {
>      IOThread *iothread = IOTHREAD(obj);
> @@ -215,6 +228,7 @@ static const TypeInfo iothread_info = {
>      .parent = TYPE_OBJECT,
>      .class_init = iothread_class_init,
>      .instance_size = sizeof(IOThread),
> +    .instance_init = iothread_instance_init,
>      .instance_finalize = iothread_instance_finalize,
>      .interfaces = (InterfaceInfo[]) {
>          {TYPE_USER_CREATABLE},
> 

ACK

Paolo
