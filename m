Received: from eggs.gnu.org ([2001:4830:134:3::10]:46984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dSTab-0001ch-Fx
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 15:34:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dSTaY-0004lS-Bm
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 15:34:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35064)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1dSTaY-0004lH-5J
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 15:34:22 -0400
References: <20170628190047.26159-1-dgilbert@redhat.com>
	<20170628190047.26159-25-dgilbert@redhat.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <2f4c1067-14a4-d943-0dff-790d705778f1@redhat.com>
Date: Tue, 4 Jul 2017 21:34:09 +0200
MIME-Version: 1.0
In-Reply-To: <20170628190047.26159-25-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 24/29] vhost+postcopy: Lock around
 set_mem_table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, a.perevalov@samsung.com, marcandre.lureau@redhat.com, mst@redhat.com, quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com, aarcange@redhat.com



On 06/28/2017 09:00 PM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert"<dgilbert@redhat.com>
> 
> **HACK - better solution needed **
> We have the situation where:
> 
>       qemu                      bridge
> 
>       send set_mem_table
>                                map memory
>    a)                          mark area with UFD
>                                send reply with map addresses
>    b)                          start using
>    c) receive reply
> 
>    As soon as (a) happens qemu might start seeing faults
> from memory accesses (but doesn't until b); but it can't
> process those faults until (c) when it's received the
> mmap addresses.
> 
> Make the fault handler spin until it gets the reply in (c).
> 
> At the very least this needs some proper locks, but preferably
> we need to split the message.

Yes, maybe the slave channel could be used to send the ufds with
a dedicated request? The backend would set the reply-ack flag, so that
it starts accessing the guest memory only when Qemu is ready to handle
faults.

Note that the slave channel support has not been implemented in Qemu's
libvhost-user yet, but this is something I can do if we feel the need.

Maxime
