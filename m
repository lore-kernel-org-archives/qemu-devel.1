Received: from eggs.gnu.org ([2001:4830:134:3::10]:39590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fL6m0-0000Ny-OU
	for qemu-devel@nongnu.org; Tue, 22 May 2018 08:52:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fL6lw-0000b5-QT
	for qemu-devel@nongnu.org; Tue, 22 May 2018 08:52:16 -0400
Date: Tue, 22 May 2018 14:52:08 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180522145208.310143ea.cohuck@redhat.com>
In-Reply-To: <a5d08fb7-d9c1-b230-fe0c-acebbda2ba65@linux.ibm.com>
References: <20180509154822.23510-1-cohuck@redhat.com>
	<20180509154822.23510-3-cohuck@redhat.com>
	<c18f9b9f-da00-1a0b-8ef0-7ac223c73d1a@linux.ibm.com>
	<20180515181006.0cb1dfc2.cohuck@redhat.com>
	<a5d08fb7-d9c1-b230-fe0c-acebbda2ba65@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 2/2] vfio-ccw: support for halt/clear
 subchannel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On Wed, 16 May 2018 15:32:48 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 15/05/2018 18:10, Cornelia Huck wrote:
> > On Fri, 11 May 2018 11:33:35 +0200
> > Pierre Morel <pmorel@linux.ibm.com> wrote:
> >  
> >> On 09/05/2018 17:48, Cornelia Huck wrote:  

> >>> @@ -126,7 +192,24 @@ static void fsm_io_request(struct vfio_ccw_private *private,
> >>>    
> >>>    	memcpy(scsw, io_region->scsw_area, sizeof(*scsw));
> >>>    
> >>> -	if (scsw->cmd.fctl & SCSW_FCTL_START_FUNC) {
> >>> +	/*
> >>> +	 * Start processing with the clear function, then halt, then start.
> >>> +	 * We may still be start pending when the caller wants to clean
> >>> +	 * up things via halt/clear.
> >>> +	 */  
> >> hum. The scsw here does not reflect the hardware state but the
> >> command passed from the user interface.
> >> Can we and should we authorize multiple commands in one call?
> >>
> >> If not, the comment is not appropriate and a switch on cmd.fctl
> >> would be a clearer.  
> > There may be multiple functions specified, but we need to process them
> > in precedence order (and clear wins over the others, so to speak).
> > Would adding a sentence like "we always process just one function" help?  
> 
> Why should we allow multiple commands in a single call ?
> It brings no added value.
> Is there a use case?
> Currently QEMU does not do this and since we only have the SCSH there
> is no difference having the bit set alone or not alone.

I found this to be a very easy way to implement halt/clear. This still
holds true if we switch to some kind of capabilities for this (did not
have time to look at this further, though).

As we have the fctl field anyway, I'm in favour of processing this all
in one function.
