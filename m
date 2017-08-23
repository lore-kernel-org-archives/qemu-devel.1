Received: from eggs.gnu.org ([2001:4830:134:3::10]:35804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dkSVI-0000S7-Nf
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 06:03:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dkSVH-0006Ja-Ob
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 06:03:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54496)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dkSVH-0006If-JY
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 06:03:15 -0400
Date: Wed, 23 Aug 2017 12:03:05 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170823120305.722d2de6.cohuck@redhat.com>
In-Reply-To: <f24dde77-5fd0-8827-7b93-d0e390f392da@linux.vnet.ibm.com>
References: <20170821091614.28251-1-cohuck@redhat.com>
	<20170821091614.28251-10-cohuck@redhat.com>
	<feebff17-e4b8-2e00-9775-126055172564@linux.vnet.ibm.com>
	<20170821141353.32a1242c.cohuck@redhat.com>
	<aa499e7a-2692-d3b8-d3f5-c8bc1d5783d2@linux.vnet.ibm.com>
	<91e5cbdf-9d91-fc7f-3fb5-3727d73b1419@redhat.com>
	<f24dde77-5fd0-8827-7b93-d0e390f392da@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 09/10] s390x/kvm: msi route fixup for
 non-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, zyimin@linux.vnet.ibm.com, david@redhat.com, pmorel@linux.vnet.ibm.com, agraf@suse.de, qemu-devel@nongnu.org, borntraeger@de.ibm.com

On Mon, 21 Aug 2017 17:30:58 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> On 08/21/2017 05:17 PM, Thomas Huth wrote:
> > On 21.08.2017 17:10, Halil Pasic wrote:
> > [...]  
> >> The situation is just complicated by the fact that there is code which
> >> relies on assert(true) asserting for correctness (e.g. virtio goes so far
> >> to make builds with normal asserts disabled fail). Thus for me it's hard
> >> to assume that the assertion is guaranteed to be disabled in production.  
> > 
> > FYI: https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg03608.html
> > 
> >  Thomas
> >   
> 
> Thanks, I've missed that. With that assumed it becomes either
> assert(false) or return -ENODEV but not both.
> 
> Regards,
> Halil 
> 

Thinking about this some more, this seems to be completely covered
within the next statement:

- For builds with pci completely disabled, we'll end up with NULL in
  both s390_get_phb() and s390_pci_find_dev_by_idx() and return -ENODEV.
- If only the zpci facility bit is not set, we'll hit the assert in
  s390_get_phb().

Without an error message, there does not really seem to be additional
value (other than failing explicitly), so I'll drop this patch.

(Yeah, deja vu...)
