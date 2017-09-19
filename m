Received: from eggs.gnu.org ([2001:4830:134:3::10]:36770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1duOoy-0001zV-Kt
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 16:08:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1duOot-0005Ok-IF
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 16:08:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42204)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1duOot-0005O8-CW
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 16:08:35 -0400
Date: Tue, 19 Sep 2017 17:08:26 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170919200826.GF21016@localhost.localdomain>
References: <20170825195406.19624-1-ehabkost@redhat.com>
	<7dbaeffc-44f2-06a3-0d0c-0470958dd60c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7dbaeffc-44f2-06a3-0d0c-0470958dd60c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] xio3130_downstream: Report error if
 pcie_chassis_add_slot() failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-devel@nongnu.org, Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, "Michael S . Tsirkin" <mst@redhat.com>

On Sun, Aug 27, 2017 at 10:44:26AM +0300, Marcel Apfelbaum wrote:
> Hi Eduardo,
> 
> On 25/08/2017 22:54, Eduardo Habkost wrote:
> > On commit f8cd1b02 ("pci: Convert to realize"), no error_set*()
> > call was added for the pcie_chassis_add_slot() error case.
> > pcie_chassis_add_slot() errors get ignored, making QEMU crash
> > later.  e.g.:
> > 
> >    $ qemu-system-x86_64 -device ioh3420 -device xio3130-downstream
> >    qemu-system-x86_64: memory.c:2166: memory_region_del_subregion: Assertion `subregion->container == mr' failed.
> >    Aborted (core dumped)
> > 
> > Fix it by reporting the error using error_setg().
> > 
> > Fixes: f8cd1b0201c41d88bb97dcafb80348a0e88d8805
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> >   hw/pci-bridge/xio3130_downstream.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
> > index e706f36..5a882b0 100644
> > --- a/hw/pci-bridge/xio3130_downstream.c
> > +++ b/hw/pci-bridge/xio3130_downstream.c
> > @@ -94,6 +94,7 @@ static void xio3130_downstream_realize(PCIDevice *d, Error **errp)
> >       pcie_chassis_create(s->chassis);
> >       rc = pcie_chassis_add_slot(s);
> >       if (rc < 0) {
> > +        error_setg(errp, "Can't add chassis slot, error %d", rc);
> >           goto err_pcie_cap;
> >       }
> > 
> 
> 
> Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>

Thanks!

Michael, do you want to merge this, or should I queue it?

-- 
Eduardo
