Received: from eggs.gnu.org ([209.51.188.92]:57627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gvlB5-0006bv-Ef
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 10:49:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gvlB0-0005Bt-J5
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 10:49:52 -0500
Date: Mon, 18 Feb 2019 16:49:41 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190218164941.33e62369.cohuck@redhat.com>
In-Reply-To: <30de3db1-c1df-1aed-8dac-5d0e446b7ca4@linux.ibm.com>
References: <1548768562-20007-1-git-send-email-jjherne@linux.ibm.com>
	<1548768562-20007-9-git-send-email-jjherne@linux.ibm.com>
	<a9633e15-13c7-70a5-17c2-2204dd174335@redhat.com>
	<30de3db1-c1df-1aed-8dac-5d0e446b7ca4@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 08/15] s390-bios: Map low core
 memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

On Mon, 18 Feb 2019 10:40:45 -0500
"Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> On 2/12/19 7:47 AM, Thomas Huth wrote:
> > On 2019-01-29 14:29, Jason J. Herne wrote:  
> >> Create a new header for basic architecture specific definitions and add a
> >> mapping of low core memory. This mapping will be used by the real dasd boot
> >> process.
> >>
> >> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> >> ---
> >>   pc-bios/s390-ccw/main.c      |   2 +
> >>   pc-bios/s390-ccw/s390-arch.h | 100 +++++++++++++++++++++++++++++++++++++++++++
> >>   2 files changed, 102 insertions(+)
> >>   create mode 100644 pc-bios/s390-ccw/s390-arch.h
> >>

> >> +typedef struct PSW {
> >> +    uint64_t mask;
> >> +    uint64_t addr;
> >> +} __attribute__ ((packed, aligned(8))) PSW;  
> > 
> > We've seen quite some trouble with "packed" in the past... See
> > 3b8afb41bc8e or 55281a2c53b884d0 for example ... This is only the
> > s390-ccw bios code here, so it is likely ok, but still, since this
> > structure is "naturally" packed, I'd rather go without that attribute
> > here (even if it's only to allow the compiler to generate better code in
> > some cases). You could still _Static_assert(sizeof(struct PSW) == 16)
> > afterwards, just to be sure.
> >   
> 
> So the problem is that this struct, if baked into another struct, will not be aligned 
> properly? Given that this struct is only two 64-bit fields I guess we could get away 
> without packed.

I would advise to try to build with clang, but there are other issues
in the ccw bios that prevent that :(

In general, the build assert way seems to be more portable, though.
