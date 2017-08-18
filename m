Received: from eggs.gnu.org ([2001:4830:134:3::10]:60244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dik8w-0000so-36
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 12:29:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dik8s-00075B-W6
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 12:29:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41824)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dik8s-00073L-Q9
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 12:29:02 -0400
Date: Fri, 18 Aug 2017 13:28:51 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170818162851.GW3108@localhost.localdomain>
References: <1502846811-32360-1-git-send-email-douly.fnst@cn.fujitsu.com>
	<20170816111807.0275dd5d@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170816111807.0275dd5d@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] hw/acpi: Select an node with memory for
 mapping memory hole to
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>, qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, mst@redhat.com

On Wed, Aug 16, 2017 at 11:18:07AM +0200, Igor Mammedov wrote:
> On Wed, 16 Aug 2017 09:26:51 +0800
> Dou Liyang <douly.fnst@cn.fujitsu.com> wrote:
> 
> > Currently, Using the fisrt node without memory on the machine makes
> > QEMU unhappy. With this example command line:
> >   ... \
> >   -m 1024M,slots=4,maxmem=32G \
> >   -numa node,nodeid=0 \
> >   -numa node,mem=1024M,nodeid=1 \
> >   -numa node,nodeid=2 \
> >   -numa node,nodeid=3 \
> > Guest reports "No NUMA configuration found" and the NUMA topology is
> > wrong.
> > 
> > This is because when QEMU builds ACPI SRAT, it regards node0 as the
> > default node to deal with the memory hole(640K-1M). this means the
> > node0 must have some memory(>1M), but, actually it can have no
> > memory.
> > 
> > Fix this problem by replace the node0 with the first node which has
> > memory on it. Add a new function for each node. Also do some cleanup.
> It seems harmless but one never knows for sure,
> could you test it with different guests including old windows (up to XP)/
> linux (2.6 stable kernel) versions?

This patch is supposed to affect only the cases where there's no
RAM configured on node 0.  I won't be surprised if some guest
OSes don't like it, but in this case the solution is to not
configure the VM that way.

That means I don't think we really need to test ancient OSes if
we ensure there are no ACPI table changes on the existing
known-to-work configurations.

-- 
Eduardo
