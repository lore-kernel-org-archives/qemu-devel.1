Received: from eggs.gnu.org ([2001:4830:134:3::10]:52536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fIbLY-0000ei-FN
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:54:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fIbLV-0000pN-UZ
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:54:36 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36995)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fIbLV-0000oE-NX
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:54:33 -0400
Received: by mail-wm0-f67.google.com with SMTP id l1-v6so1704271wmb.2
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 07:54:33 -0700 (PDT)
References: <1525530936-21835-1-git-send-email-lidongchen@tencent.com>
	<1525530936-21835-6-git-send-email-lidongchen@tencent.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <379b3f13-f53f-966b-ccbf-66517d45aa9d@redhat.com>
Date: Tue, 15 May 2018 16:54:30 +0200
MIME-Version: 1.0
In-Reply-To: <1525530936-21835-6-git-send-email-lidongchen@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 5/6] migration: implement bi-directional
 RDMA QIOChannel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lidong Chen <jemmy858585@gmail.com>, quintela@redhat.com, dgilbert@redhat.com, berrange@redhat.com
Cc: adido@mellanox.com, galsha@mellanox.com, aviadye@mellanox.com, qemu-devel@nongnu.org, Lidong Chen <lidongchen@tencent.com>

On 05/05/2018 16:35, Lidong Chen wrote:
> @@ -2635,12 +2637,20 @@ static ssize_t qio_channel_rdma_writev(QIOChannel *ioc,
>  {
>      QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(ioc);
>      QEMUFile *f = rioc->file;
> -    RDMAContext *rdma = rioc->rdma;
> +    RDMAContext *rdma;
>      int ret;
>      ssize_t done = 0;
>      size_t i;
>      size_t len = 0;
>  
> +    rcu_read_lock();
> +    rdma = atomic_rcu_read(&rioc->rdmaout);
> +
> +    if (!rdma) {
> +        rcu_read_unlock();
> +        return -EIO;
> +    }
> +
>      CHECK_ERROR_STATE();
>  
>      /*

I am not sure I understand this.  It would probably be wrong to use the
output side from two threads at the same time, so why not use two mutexes?

Also, who is calling qio_channel_rdma_close in such a way that another
thread is still using it?  Would it be possible to synchronize with the
other thread *before*, for example with qemu_thread_join?

Thanks,

Paolo
