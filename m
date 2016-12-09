Received: from eggs.gnu.org ([2001:4830:134:3::10]:41348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cFRRa-0007Ad-Jt
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 15:06:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cFRRX-0007u3-Fh
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 15:06:58 -0500
Date: Fri, 9 Dec 2016 18:06:50 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20161209200650.GB29563@thinpad.lan.raisama.net>
References: <148104617887.7699.984921868108236415.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<20161206191952.GD4027@thinpad.lan.raisama.net>
	<20161206193159.GE4027@thinpad.lan.raisama.net>
	<20161207143925.7b3a54f2@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161207143925.7b3a54f2@bahia>
Subject: Re: [Qemu-devel] [RFC for-2.8] machine: Convert abstract typename
 on compat_props to subclass names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-stable@nongnu.org, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>

On Wed, Dec 07, 2016 at 02:39:25PM +0100, Greg Kurz wrote:
> On Tue, 6 Dec 2016 17:31:59 -0200
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> > On Tue, Dec 06, 2016 at 05:19:52PM -0200, Eduardo Habkost wrote:
> > > On Tue, Dec 06, 2016 at 06:50:47PM +0100, Greg Kurz wrote:  
> > > > Since commit "9a4c0e220d8a hw/virtio-pci: fix virtio behaviour", passing
> > > > -device virtio-blk-pci.disable-modern=off has no effect on 2.6 machine
> > > > types because the internal virtio-pci.disable-modern=on compat property
> > > > always prevail.
> > > > 
> > > > This should ideally be fixed in the qdev properties core code, but it is
> > > > too late in the QEMU 2.8 schedule. So this patch fixes the issue by setting
> > > > the compat properties for every virtio-*-pci subtypes instead of the base
> > > > virtio-pci type.
> > > > 
> > > > Signed-off-by: Greg Kurz <groug@kaod.org>  
> > > 
> > > So, it looks like the bug is present in many other cases...
> > > 
> > > I have hacked QEMU to print a warning in case the driver name in
> > > compat_props refer to an abstract class or a class that have any
> > > subclasses. The results are below:
> > > 
[...]
> > > 
> > > I believe the cases where we are likely to cause real-world bugs
> > > are virtio-pci and the *-cpu classes (because -cpu is translated
> > > to -global).
> > > 
> > > I'm not sure what should be the right fix in 2.8. I am
> > > considering a temporary hack to translate abstract class names in
> > > compat_props to global properties for all subclasses, in case
> > > they refer to an abstract class. This way we fix the bug where
> > > -global doesn't override compat_props properly, but keep the
> > > rules for -global untouched.  
> > 
> > What about this?
> > 
> 
> Indeed that would have been a clever workaround but it is too late anyway. :)

Now my question is: what should we do in 2.8.1?

1) Change the rules and apply "[PATCH] qdev: fix the order compat
   and global properties are applied"
2) Fix only virtio-pci (apply a new version of "[PATCH] virtio:
   fix HW_COMPAT_2_6 macro for virtio-*-pci drivers")
3) Apply this hack so we fix all compat_props cases without
   changing ordering rules. (And then change the ordering rules
   in 2.9)

-- 
Eduardo
