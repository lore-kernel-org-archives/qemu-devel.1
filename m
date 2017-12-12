Received: from eggs.gnu.org ([2001:4830:134:3::10]:48936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eOlZY-0006LT-M1
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 09:30:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eOlZS-0006fE-QR
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 09:30:16 -0500
Date: Tue, 12 Dec 2017 15:29:59 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171212152959.1ff2b7d5.cohuck@redhat.com>
In-Reply-To: <0aa794ee-c781-0cc4-3c0a-5f49ae495c63@de.ibm.com>
References: <20171211134740.8235-1-david@redhat.com>
	<20171211134740.8235-7-david@redhat.com>
	<20171212144944.09860296.cohuck@redhat.com>
	<0aa794ee-c781-0cc4-3c0a-5f49ae495c63@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2-12 06/15] s390x/flic: factor out
 injection of floating interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Thomas Huth <thuth@redhat.com>

On Tue, 12 Dec 2017 15:13:46 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 12/12/2017 02:49 PM, Cornelia Huck wrote:

> > One thing I noticed: You removed the caching of the flic (in the old
> > kvm inject routine), and you generally do more qom invocations (first,
> > to find the common flic; then, to translate to the qemu or kvm flic).
> > Not sure if this might be a problem (probably not).  
> 
> Is any of these calls on a potential fast path (e.g. guest without adapter
> interrupts)? If yes, then QOM is a no-go since it is really slow.

At least the new airq interface was using QOM without caching before.

It's basically about any interrupt; but otoh we are (for kvm) in
userspace already. Caching the flic and just keeping the casting to the
specialized flic might be ok (I'd guess that the lookup is the slowest
path.)
