Received: from eggs.gnu.org ([2001:4830:134:3::10]:59205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d3Pdb-0004I3-1R
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 12:17:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d3PdX-00025M-RA
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 12:17:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1d3PdX-00024L-KH
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 12:17:51 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E333B6198F
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 16:17:49 +0000 (UTC)
Date: Wed, 26 Apr 2017 18:17:43 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170426181743.33a547fa@nial.brq.redhat.com>
In-Reply-To: <20170426143404.GX3482@thinpad.lan.raisama.net>
References: <20170425153750.43322-1-imammedo@redhat.com>
	<20170426143404.GX3482@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] pc/fwcfg: unbreak migration from
 qemu-2.5 and qemu-2.6 during firmware boot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mst@redhat.com, dgilbert@redhat.com, lersek@redhat.com, Marcel Apfelbaum <marcel@redhat.com>

On Wed, 26 Apr 2017 11:34:04 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Tue, Apr 25, 2017 at 05:37:50PM +0200, Igor Mammedov wrote:
> > Since 2.7 commit (b2a575a Add optionrom compatible with fw_cfg DMA version)
> > regressed migration during firmware exection time by
> > abusing fwcfg.dma_enabled property to decide loading
> > dma version of option rom AND by mistake disabling DMA
> > for 2.6 and earlier globally instead of only for option rom.
> > 
> > so 2.6 machine type guest is broken when it already runs
> > firmware in DMA mode but migrated to qemu-2.7(pc-2.6)
> > at that time;
> > 
> > a) qemu-2.6:pc2.6 (fwcfg.dma=on,firmware=dma,oprom=ioport)
> > b) qemu-2.7:pc2.6 (fwcfg.dma=off,firmware=ioport,oprom=ioport)
> > 
> >   to:   a     b
> > from
> > a       OK   FAIL
> > b       OK   OK
> > 
> > So we currently have broken forward migration from
> > qemu-2.6 to qemu-2.[789] that however could be fixed
> > for 2.10 by re-enabling DMA for 2.[56] machine types
> > and allowing dma capable option rom only since 2.7.
> > As result qemu should end up with:
> > 
> > c) qemu-2.10:pc2.6 (fwcfg.dma=on,firmware=dma,oprom=ioport)
> > 
> >    to:  a     b    c
> > from
> > a      OK   FAIL  OK
> > b      OK   OK    OK
> > c      OK   FAIL  OK
> > 
> > where forward migration from qemu-2.6 to qemu-2.10 should
> > work again leaving only qemu-2.[789]:pc-2.6 broken.
> > 
> > Reported-by: Eduardo Habkost <ehabkost@redhat.com>
> > Analyzed-by: Laszlo Ersek <lersek@redhat.com>
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > Reviewed-by: Laszlo Ersek <lersek@redhat.com>  
> 
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

Marcel or Michael,

could you pick up and merge the patch through your tree?
