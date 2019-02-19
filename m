Received: from eggs.gnu.org ([209.51.188.92]:44367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gw68t-0001zK-RH
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 09:13:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gw68t-0006b7-1t
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 09:13:03 -0500
References: <20190218161822.3573-1-kwolf@redhat.com>
	<20190218161822.3573-8-kwolf@redhat.com>
	<9fe39150-f308-8f2e-0c9d-6d0a31d9329d@redhat.com>
	<20190219111116.GH4727@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <563879c5-5c25-052f-c28e-0c647a687c1d@redhat.com>
Date: Tue, 19 Feb 2019 15:12:35 +0100
MIME-Version: 1.0
In-Reply-To: <20190219111116.GH4727@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 07/12] nbd: Increase bs->in_flight during
 AioContext switch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, eblake@redhat.com, stefanha@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org

On 19/02/19 12:11, Kevin Wolf wrote:
>> 2) maybe instead of aio_co_schedul-ing client->connection_co and having
>> the s->aio_ctx_switch flag, you could go through a bottom half that does
>> the bdrv_inc_in_flight and then enters client->connection_co?
> That would be too easy. :-)
> 
> But I agree, that might indeed be the better solution.
> 
> I think I'd keep patch 6 anyway so that we know the exact yield that
> we'll interrupt, even if it's not strictly necessary as long as we know
> that nbd_receive_reply() can only yield in places that are safe to be
> interrupted. While intuitively I think it's true, I don't feel like
> actually auditing the code, and at some point we'd probably fail to
> check that new code won't violate this invariant.

Yes, I agree with keeping patch 6.

Paolo
