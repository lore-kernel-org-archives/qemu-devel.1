Received: from eggs.gnu.org ([2001:4830:134:3::10]:35646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g03FI-00006H-KH
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 07:23:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g033T-0007NF-1P
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 07:11:31 -0400
References: <20180910145616.8598-1-famz@redhat.com>
	<20180910145616.8598-3-famz@redhat.com>
	<9f4907a3-e96e-131c-a032-1669d0c09bc8@redhat.com>
	<20180911141245.GQ19292@lemon.usersys.redhat.com>
	<271b24b6-c8eb-1425-3e73-e0ec734bafc6@redhat.com>
	<20180912013134.GA2526@lemon.usersys.redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3266e1a2-d4af-e8b3-1239-21778396718e@redhat.com>
Date: Wed, 12 Sep 2018 13:11:17 +0200
MIME-Version: 1.0
In-Reply-To: <20180912013134.GA2526@lemon.usersys.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] virtio-scsi/virtio-blk: Disable poll
 handlers when stopping vq handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, peterx@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>

On 12/09/2018 03:31, Fam Zheng wrote:
>>>
>>> ctx is qemu_aio_context here, so there's no interaction with IOThread.
>> In this case, it should be okay to have the reentrancy, what is the bug
>> that this patch is fixing?
> The same symptom as in the previous patch: virtio_scsi_handle_cmd_vq hangs. The
> reason it hangs is fixed by the previous patch, but I don't think it should be
> invoked as we're in the middle of virtio_scsi_dataplane_stop(). Applying either
> one of the two patches avoids the problem, but this one is more superficial.
> What do you think?

I think it's okay if it is invoked.  The sequence is first you stop the
vq, then you drain the BlockBackends, then you switch AioContext.  All
that matters is the outcome when virtio_scsi_dataplane_stop returns.

Paolo
