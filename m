Received: from eggs.gnu.org ([209.51.188.92]:47203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gtPnP-0007XB-Ic
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 23:35:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gtPnN-0008Me-Fc
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 23:35:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48438)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gtPnK-0008Gl-UC
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 23:35:43 -0500
Date: Mon, 11 Feb 2019 23:35:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190211233246-mutt-send-email-mst@kernel.org>
References: <e6c30bdd-6cd0-ee9b-9fdf-cc8eaa54f7cc@yandex-team.ru>
	<20190211095049-mutt-send-email-mst@kernel.org>
	<20190212035505.GE28401@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212035505.GE28401@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] Is IOThread for virtio-net a good idea?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Anton Kuchin <antonkuchin@yandex-team.ru>, jasowang@redhat.com, qemu-devel@nongnu.org

On Tue, Feb 12, 2019 at 11:55:05AM +0800, Stefan Hajnoczi wrote:
> On Mon, Feb 11, 2019 at 09:52:01AM -0500, Michael S. Tsirkin wrote:
> > On Mon, Feb 11, 2019 at 04:40:44PM +0300, Anton Kuchin wrote:
> > > As far as I can see currently IOThread offloading is used only for block
> > > devices and all others are emulated by main thread.
> > > 
> > > I expect that network devices can also benefit from processing in separate
> > > thread but I couldn't find any recent work in this direction. I'm going to
> > > implement a PoC but I want to ask if you know any previous attempts and do
> > > you know why it can be a total waste of time. Are there fundamental
> > > obstacles that prevent network emulation handling in IOThread?
> > 
> > No but vhost-net is there. Unlike block where you gain lots of
> > functionality such as snapshots there seems to be little to
> > be gained by doing it in userspace.
> 
> Anthony Liguori tried virtio-net in a dedicated thread a long time ago
> but it was never completed/merged.
> 
> I think the argument for vhost-net in the kernel is that userspace
> doesn't offer the same APIs as the kernel.  For example, is zero copy
> possible from userspace?

Esp with recent spectre/meltdown mitigations, with vhost we are looking
for new ways to batch access checks and avoid overhead.

If you are going to pass the packets back to kernel, you
are better off with them never leaving the kernel.

> Anton: If you want to do virtio-net in userspace, QEMU has
> vhost-user-net support so you can perform emulation in a separate
> process.
> 
> Stefan

And the main point of that is to use a userspace
driver for a hardware nic so packets never end up in kernel.
