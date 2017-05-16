Received: from eggs.gnu.org ([2001:4830:134:3::10]:53757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dAXWJ-0001gY-Td
	for qemu-devel@nongnu.org; Tue, 16 May 2017 04:07:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dAXWG-0000oG-Q7
	for qemu-devel@nongnu.org; Tue, 16 May 2017 04:07:51 -0400
Date: Tue, 16 May 2017 16:07:37 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170516080737.GB27669@lemon.lan>
References: <20170516072414.19025-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170516072414.19025-1-famz@redhat.com>
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
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, qemu-stable@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

On Tue, 05/16 15:24, Fam Zheng wrote:
> The root cause of the crash is not obvious here, but the change
> regardlessly makes sense so it's proposed here: the listener was
> registered in .realize(), so do the cleanup in the matching .unrealize()
> rather than the .finalize() callback.

Actually it seem calling memory_listener_unregister in .instance_finalize is not
safe because it can be in the RCU thread.  This race is what caused the
corruption of the listener lists.

So I think this patch is doing the right thing.

Fam
