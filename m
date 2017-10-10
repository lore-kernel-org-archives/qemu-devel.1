Received: from eggs.gnu.org ([2001:4830:134:3::10]:35669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e1qbs-0005P3-VO
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 05:13:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e1qbs-0005Vs-27
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 05:13:56 -0400
References: <20171009172723.190282-1-vsementsov@virtuozzo.com>
	<20171009172723.190282-9-vsementsov@virtuozzo.com>
	<5c57b76e-eb34-7825-9c8b-9ee5bd909b02@redhat.com>
	<20171010084035.GB30015@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <aafe2537-9de1-3d5c-75f4-97b09fb979d4@redhat.com>
Date: Tue, 10 Oct 2017 11:13:46 +0200
MIME-Version: 1.0
In-Reply-To: <20171010084035.GB30015@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 04/10] nbd-server: refactor simple reply
 sending
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

On 10/10/2017 10:40, Daniel P. Berrange wrote:
> The I/O channels code does not make guarantees wrt concurrent usage of
> threads or coroutines. It is the callers responsibility to avoid any
> concurrent usage for all APIs. With coroutines you are at least avoiding
> the danger of corrupting memory state, but you still have risk of unexpected
> data ordering.
> 
> IOW, if you have 2 coroutines each doing a series writes on the same QIOChannel
> object, and one does a yield, I/O can certainly be interleaved between the two.
> This is true whether doing multiple qio_channel_writev() calls directly, or
> whether using qio_channel_writev_all().
> 
> Unless I'm misunderstanding though, cork did not offer you protection in
> this scenario either. cork just prevents the data being transmitted onto
> the wire immediately - ie it ensures that if you do 2 writes, they get
> sent in 1 TCP packet instead of many TCP packets.
> 
> If you have multiple coroutines writing to the channel at the same time
> and one yielded in its series of writes, the I/O from multiple coroutines
> will get merged into that 1 single TCP packet when uncorked.
> 
> So if this concurrent usage is a problem NBD was already broken AFAICT.

I don't think there was an issue here.  nbd_co_send_reply is entirely
protected by client->send_lock.

Paolo
