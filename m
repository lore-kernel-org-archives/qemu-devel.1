Received: from eggs.gnu.org ([2001:4830:134:3::10]:39893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gWLmi-0007Fx-5j
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 08:39:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gWLmc-0007TC-Mg
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 08:39:44 -0500
Date: Mon, 10 Dec 2018 14:39:24 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181210143924.0cba741a.cohuck@redhat.com>
In-Reply-To: <20181210140642.4f2f457c@oc2783563651>
References: <20181210120436.30522-1-peter.maydell@linaro.org>
	<20181210140642.4f2f457c@oc2783563651>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH] hw/s390x/virtio-ccw.c: Don't
 take address of fields in packed structs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, patches@linaro.org, David Hildenbrand <david@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>

On Mon, 10 Dec 2018 14:06:42 +0100
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Mon, 10 Dec 2018 12:04:36 +0000
> Peter Maydell <peter.maydell@linaro.org> wrote:
> 
> > Taking the address of a field in a packed struct is a bad idea, because
> > it might not be actually aligned enough for that pointer type (and
> > thus cause a crash on dereference on some host architectures). Newer
> > versions of clang warn about this. Avoid the bug by not using the
> > "modify in place" byte swapping functions.
> > 
> > Patch produced with scripts/coccinelle/inplace-byteswaps.cocci
> > (with a couple of long lines manually wrapped).
> > 
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>  
> 
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> 
> I wonder if packed was a good idea in the first place. @Connie: Do you
> have an opinion on this?

Some of the structures probably don't need the packed attribute; but
there are two structures that have a trailing 8 bit value. The problem
is that the structures are a a guest<->host interface as defined in the
virtio standard, so we can't e.g. add padding to the structures with
the isc at the end.

If I had to re-define the interface, I'd probably add tail padding; but
I was not aware of the problems the packing might cause when I defined
them, and we can't get rid of them without also getting rid of support
for older virtio versions.

Simply moving away from the modify in place byteswaps is the easiest
solution.
