Received: from eggs.gnu.org ([2001:4830:134:3::10]:45948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dAYhL-0005GN-4K
	for qemu-devel@nongnu.org; Tue, 16 May 2017 05:23:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dAYhI-0002XN-03
	for qemu-devel@nongnu.org; Tue, 16 May 2017 05:23:19 -0400
References: <20170516072414.19025-1-famz@redhat.com>
	<20170516080737.GB27669@lemon.lan>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e780d3d8-43f1-f46d-2858-7554a334246b@redhat.com>
Date: Tue, 16 May 2017 11:23:06 +0200
MIME-Version: 1.0
In-Reply-To: <20170516080737.GB27669@lemon.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] virtio: Move memory_listener_unregister
 to .unrealize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, qemu-stable@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>



On 16/05/2017 10:07, Fam Zheng wrote:
> On Tue, 05/16 15:24, Fam Zheng wrote:
>> The root cause of the crash is not obvious here, but the change
>> regardlessly makes sense so it's proposed here: the listener was
>> registered in .realize(), so do the cleanup in the matching .unrealize()
>> rather than the .finalize() callback.

This is not entirely true.

Unrealize is the point where the device doesn't get any more requests.
Instance finalize is the point where there are no references anymore.
If a pending request has a reference to X, instance finalize is the
right place to free X.

However, in this case using .unrealize() should be fine.

> Actually it seem calling memory_listener_unregister in .instance_finalize is not
> safe because it can be in the RCU thread.  This race is what caused the
> corruption of the listener lists.

RCU callbacks are called with BQL held, so that shouldn't be it.  But
the patch should be okay anyway.

Paolo
