Received: from eggs.gnu.org ([2001:4830:134:3::10]:39437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eS7jn-00020V-Kg
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 15:46:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eS7jj-0001WC-O9
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 15:46:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45262)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eS7jj-0001VM-Id
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 15:46:39 -0500
Date: Thu, 21 Dec 2017 22:46:35 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171221224323-mutt-send-email-mst@kernel.org>
References: <20171217125457.3429-1-marcel@redhat.com>
	<20171219194951-mutt-send-email-mst@kernel.org>
	<77710384-30d0-cb76-9dbc-6195b831f050@redhat.com>
	<20171220200550-mutt-send-email-mst@kernel.org>
	<20171221072750.GC2931@yuvallap>
	<20171221162200-mutt-send-email-mst@kernel.org>
	<69d67108-448d-51af-c6d7-46d2054b00a5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69d67108-448d-51af-c6d7-46d2054b00a5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V2 0/5] hw/pvrdma: PVRDMA device
 implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: Yuval Shaia <yuval.shaia@oracle.com>, qemu-devel@nongnu.org, ehabkost@redhat.com, imammedo@redhat.com, pbonzini@redhat.com

On Thu, Dec 21, 2017 at 05:59:38PM +0200, Marcel Apfelbaum wrote:
> On 21/12/2017 16:22, Michael S. Tsirkin wrote:
> > On Thu, Dec 21, 2017 at 09:27:51AM +0200, Yuval Shaia wrote:
> > > > > 
> > > > > > What happens if guest attempts to register all its memory?
> > > > > > 
> > > > > 
> > > > > Then we loose, is not different from bare metal, reg_mr will pin all the RAM.
> > > > 
> > > > We need to find a way to communicate to guests about amount
> > > > of memory they can pin.
> > > 
> > > dev_caps.max_mr_size is the way device limits guest driver.
> > > This value is controlled by the command line argument dev-caps-max-mr-size
> > > so we should be fine (btw, default value is 1<<32).
> > 
> > Isn't that still leaving the option for guest to register all memory,
> > just in chunks?
> > 
> 
> We also have a parameter limiting the number of mrs (dev-caps-max-mr),
> together with dev-caps-max-mr-size we can limit the memory the guests can pin.
> 
> Thanks,
> Marcel

You might want to limit the default values then.

Right now:

+#define MAX_MR_SIZE           (1UL << 32)
+#define MAX_MR                2048

Which is IIUC 8TB.

That's pretty close to unlimited, and so far overcommit seems to be the
main feature for users.


> > > > 
> > > > > However this is only one scenario, and hopefully not much used
> > > > > for RoCE. (I know IPoIB does that, but it doesn't make sense to use it with RoCE).
> > > > 
> > > > SRP does it too AFAIK.
> > > > 
