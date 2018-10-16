Received: from eggs.gnu.org ([2001:4830:134:3::10]:53356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gCRce-0006b0-Iy
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:51:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gCRcb-0001tf-E4
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:51:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50702)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1gCRcb-0001rg-6Y
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:51:01 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 395585F72C
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 15:51:00 +0000 (UTC)
Date: Tue, 16 Oct 2018 09:50:53 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20181016095053.1ee0727a@w520.home>
In-Reply-To: <20181016094924.GA2427@work-vm>
References: <20181015141841.09b945e5@w520.home> <20181016094924.GA2427@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] QEMU PCIe link "negotiation"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

On Tue, 16 Oct 2018 10:49:25 +0100
"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:

> * Alex Williamson (alex.williamson@redhat.com) wrote:
> > This email is already too long, but I also wonder whether we should
> > consider additional vfio-pci interfaces to trigger a link retraining or
> > allow virtualized access to the physical upstream port config space.
> > Clearly we need to consider multi-function devices and whether there
> > are useful configurations that could benefit from such access.  Thanks
> > for reading, please discuss,  
> 
> I'm not sure about the consequences of the actual link speeds, but I
> worry we'll hit things looking for PCIe v3 features; in particular
> AMD's ROCm code needs PCIe atomics:
> 
> https://github.com/RadeonOpenCompute/ROCm_Documentation/blob/master/Installation_Guide/More-about-how-ROCm-uses-PCIe-Atomics.rst
> 
> so it feels like getting that to work with passthrough would
> need some negotiation of features.

Taking a quick read through the AtomicOps ECN, I think this is
somewhat orthogonal to the link speeds and widths.  Support for acting
as a completer or router of atomic ops is indicated through the DEVCAP2
register in the PCIe capability, it's optional and should not be
assumed by other newer PCIe features.  So I think we can tackle it
separately, but indeed it does appear to be a difficult feature to
implement correctly for a VM, at least if we attempt to do it
automatically.  We might need to burden the user with this sort of
configuration unless AtomicOps support is so ubiquitous that we can
correctly assume that it's available between arbitrary endpoints which
might be assigned to the same VM.  Probably a device option on the
pcie-root-port device to expose atomic op support is possible in the
short term, though more thorough reading of the spec is required.
Thanks,

Alex
