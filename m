Received: from eggs.gnu.org ([2001:4830:134:3::10]:52666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <venu.busireddy@oracle.com>) id 1fVKpd-0007G8-D1
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 13:54:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <venu.busireddy@oracle.com>) id 1fVKpa-0005AI-7e
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 13:54:17 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:46048)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <venu.busireddy@oracle.com>)
	id 1fVKpZ-0005A0-VL
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 13:54:14 -0400
Date: Tue, 19 Jun 2018 12:54:06 -0500
From: Venu Busireddy <venu.busireddy@oracle.com>
Message-ID: <20180619175406.GA14192@lt>
References: <20180619163228.13790-1-venu.busireddy@oracle.com>
	<20180619163228.13790-5-venu.busireddy@oracle.com>
	<20180619202529-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619202529-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH virtio 1/1] Add "Group
 Identifier" support to virtio PCI capabilities.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org

On 2018-06-19 20:30:06 +0300, Michael S. Tsirkin wrote:
> On Tue, Jun 19, 2018 at 11:32:28AM -0500, Venu Busireddy wrote:
> > Add VIRTIO_PCI_CAP_GROUP_ID_CFG (Group Identifier) capability to the
> > virtio PCI capabilities to allow for the grouping of devices.
> > 
> > Signed-off-by: Venu Busireddy <venu.busireddy@oracle.com>
> > ---
> >  content.tex | 43 +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 43 insertions(+)
> > 
> > diff --git a/content.tex b/content.tex
> > index 7a92cb1..7ea6267 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -599,6 +599,8 @@ The fields are interpreted as follows:
> >  #define VIRTIO_PCI_CAP_DEVICE_CFG        4
> >  /* PCI configuration access */
> >  #define VIRTIO_PCI_CAP_PCI_CFG           5
> > +/* Group Identifier */
> > +#define VIRTIO_PCI_CAP_GROUP_ID_CFG      6
> >  \end{lstlisting}
> >  
> >          Any other value is reserved for future use.
> > @@ -997,6 +999,47 @@ address \field{cap.length} bytes within a BAR range
> >  specified by some other Virtio Structure PCI Capability
> >  of type other than \field{VIRTIO_PCI_CAP_PCI_CFG}.
> >  
> > +\subsubsection{Group Identifier capability}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Group Identifier capability}
> > +
> > +The VIRTIO_PCI_CAP_GROUP_ID_CFG capability provides means for grouping devices together.
> > +
> > +The capability is immediately followed by an identifier of arbitrary size as below:
> > +
> > +\begin{lstlisting}
> > +struct virtio_pci_group_id_cap {
> > +        struct virtio_pci_cap cap;
> > +        u8 group_id[]; /* Group Identifier */
> > +};
> > +\end{lstlisting}
> > +
> > +The fields \field{cap.bar}, \field{cap.length}, \field{cap.offset}
> > +and \field{group_id} are read-only for the driver.
> > +
> > +The specification does not impose any restrictions on the size or
> > +structure of group_id[].
> 
> I think it must be a multiple of 4 in size, as is
> standard for all capabilities.

Sure. Would rephrasing it as below suffice?

The specification does not impose any restrictions on the size or
structure of group_id[], except that the size must be a multiple of 4.

> 
> 
> > Vendors are free to declare this array as
> > +large as needed, as long as the combined size of all capabilities can
> > +be accommodated within the PCI configuration space.
> > +
> > +If there is enough room in the PCI configuration space to accommodate
> > +the group identifier, the fields \field{cap.bar}, \field{cap.offset}
> > +and \field{cap.length} should be set to 0.
> > +
> > +If there isn't enough room, some or all of the group identifier can be
> > +presented in the BAR region, in which case the fields \field{cap.bar},
> > +\field{cap.offset} and \field{cap.length} should be set appropriately.
> 
> And then how do you glue the two pieces?

How the user glues them up is up to the user. The specification should
not impose rules on that, right?

> 
> > +
> > +In either case, the field \field{cap.cap_len} indicates the length of
> > +the group identifier information present in the configuration space
> > +itself.
> 
> It seems like an overkill to me. Isn't it enough to have it in config
> space? This would make comparisons easier.

I was trying to make the proposal permissive for expansion, in case
the user needs the size to be larger than what can be accommodated in
the config space. Would you like me to restrict that the capability be
entirely present in the config space? I am fine with it. Please confirm,
and I will change it so.

> 
> > +
> > +\devicenormative{\paragraph}{Group Identifier capability}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Group Identifier capability}
> > +
> > +The device MAY present the VIRTIO_PCI_CAP_GROUP_ID_CFG capability.
> > +
> > +\drivernormative{\paragraph}{Group Identifier capability}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Group Identifier capability}
> > +
> > +The driver MUST NOT write to group_id[] area or the BAR region.
> > +
> >  \subsubsection{Legacy Interfaces: A Note on PCI Device Layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Legacy Interfaces: A Note on PCI Device Layout}
> >  
> >  Transitional devices MUST present part of configuration
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> 
