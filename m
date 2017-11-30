Received: from eggs.gnu.org ([2001:4830:134:3::10]:43597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eKS3n-0005eB-Ef
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 11:51:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eKS3j-0005my-Dw
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 11:51:39 -0500
Received: from 9.mo177.mail-out.ovh.net ([46.105.72.238]:53668)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eKS3j-0005jl-68
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 11:51:35 -0500
Received: from player779.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id BD84E8FBBC
	for <qemu-devel@nongnu.org>; Thu, 30 Nov 2017 17:51:31 +0100 (CET)
Date: Thu, 30 Nov 2017 17:51:17 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20171130175117.30b6d35a@bahia.lan>
In-Reply-To: <20171130160844.73470c50@redhat.com>
References: <20171129185026.23632-1-dgilbert@redhat.com>
	<20171130122245.7e713d2f@redhat.com>
	<20171130120805.GA3952@work-vm>
	<20171130134057.1d8ecc3e@redhat.com>
	<20171130124720.GB3952@work-vm>
	<20171130135820.69eb5715@redhat.com>
	<20171130130628.GC3952@work-vm>
	<20171130160844.73470c50@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 0/7] Rework vhost memory region updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, maxime.coquelin@redhat.com, qemu-devel@nongnu.org, mst@redhat.com

On Thu, 30 Nov 2017 16:08:44 +0100
Igor Mammedov <imammedo@redhat.com> wrote:
[...]
> > (The logic in vhost_verify_ring_mappings doesn't make sense
> > to me either though; if vhost_verify_ring_part_mapping returns 0
> > on success, why is it doing   if (!r) { break; }  surely it
> > should be  if (r) { break; })  
> it looks like a bug (CCing Greg)
> 

Wow! It's obviously a bug indeed and I'm amazed it didn't get caught
during the review :-\

I'll send a patch ASAP.

> before (f1f9e6c5 vhost: adapt vhost_verify_ring_mappings() to virtio 1 ring layout)
> logic used to be
> 
>    if changed_*_addr doesn't contain ring
>       "IGNORE as we don't care"
>    
>    if changed_*_addr contain ring AND ring can't be mapped at the same place
>       ABORT
> 
> with f1f9e6c5 we have 3 rings so on any of them following could happen
>    if "IGNORE as we don't care"
>      break => false success 
>      since it's possible that the remaining rings in vq do overlap and didn't get checked
> 
