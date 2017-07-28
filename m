Received: from eggs.gnu.org ([2001:4830:134:3::10]:34408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1db4qZ-0003S4-Au
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:58:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1db4qW-000793-Gs
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:58:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51594)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1db4qW-000780-7u
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:58:24 -0400
Date: Fri, 28 Jul 2017 14:58:19 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170728145819.2dd0e608@gondolin>
In-Reply-To: <f183e2d8-4f75-2981-e148-02c88014a4b1@linux.vnet.ibm.com>
References: <20170727015418.85407-1-bjsdjshi@linux.vnet.ibm.com>
	<20170727015418.85407-4-bjsdjshi@linux.vnet.ibm.com>
	<20170727135910.27d9e42e@gondolin>
	<316dd24e-cc45-8469-dd23-491c8b15480e@linux.vnet.ibm.com>
	<20170727161457.58b3c7d1@gondolin>
	<abdfb954-d67b-d360-1627-b51bac263880@linux.vnet.ibm.com>
	<20170728121101.2a85216a@gondolin>
	<f183e2d8-4f75-2981-e148-02c88014a4b1@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] s390x/css: generate channel path
 initialized CRW for channel path hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: pmorel@linux.vnet.ibm.com, qemu-devel@nongnu.org, agraf@suse.de, borntraeger@de.ibm.com, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, rth@twiddle.net

On Fri, 28 Jul 2017 14:32:11 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> On 07/28/2017 12:11 PM, Cornelia Huck wrote:
> > On Thu, 27 Jul 2017 18:15:07 +0200
> > Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> >> So my intention was to ask: What benefits do we expect from these 'real'
> >> virtual channel paths?   
> > 
> > Path grouping and friends come to mind. This depends on whether you
> > want to pass-through channel paths to the guest, of course, but you
> > really need management to deal with things like reserve/release on ECKD
> > correctly.  
> 
> Pass-through means dedicated in this case (that is the passed trough paths
> are not used by the host -- correct me if my understanding is wrong).

There's nothing that speaks against path sharing, I think. Especially
as e.g. SetPGID is "first one gets to set it".

> 
> This whole multipath/grouping stuff is currently a gray spot for me. I've
> tired to revisit the corresponding parts of the AR, but there ain't much
> on it in the documents I have.
> 
> Is the protocol for managing multipath equipment (device, maybe also CU)
> dependent? The PoP (and the IO AR) talk about set-multipath-mode type
> of command and similar (disband, resign) but how this type of command
> looks like -- no idea. From the kernel code one can learn more details,
> but that's just an implementation.

Path selection and friends should all be in the base I/O documentation
(maybe something in the common I/O device commands, as well.) Path
grouping is device-specific.

> 
> Can you recommend me a publication where the controls you talk about
> are specified?

For SetPGID etc., I'd recommend the DASD documentation (the one
specifying the channel commands supported). Don't have the publication
number handy, sorry.

> 
> > Also failover etc. Preferred channel paths are not relevant
> > on modern hardware anymore, fortunately (AFAIK).
> >  
> 
> If I understand you correctly it ain't possible to handle these
> in the host (and let the guest a simple 'non-real' virtual
> channel path whose reliability depends on what the host does),
> or?

It is possible. Mapping to a virtual channel path or not is basically a
design decision (IIRC, z/VM supports both).

Mapping everything to a virtual chpid basically concentrates all
path-related handling in the hypervisor. This allows for a dumb guest
OS, but can make errors really hard to debug from the guest side.

Exposing real channel paths to the guest means that the guest OS needs
to be able to deal with path-related things, but OTOH it has more
control. As I don't think we'll ever want to support a guest OS that
does not also run under LPAR, I'd prefer that way.

> 
> Thanks for the explanations!

You're welcome!
