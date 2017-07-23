Received: from eggs.gnu.org ([2001:4830:134:3::10]:35211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <riel@redhat.com>) id 1dZHV8-0000q0-16
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 10:04:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <riel@redhat.com>) id 1dZHV4-00035H-T9
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 10:04:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <riel@redhat.com>) id 1dZHV4-00032e-Mo
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 10:04:50 -0400
Message-ID: <1500818683.4073.31.camel@redhat.com>
From: Rik van Riel <riel@redhat.com>
Date: Sun, 23 Jul 2017 10:04:43 -0400
In-Reply-To: <CAPcyv4gtWYpzbmggsbdLocPiMzU2rVt-ee+kL24gbrPxKd5Eyw@mail.gmail.com>
References: <1455443283.33337333.1500618150787.JavaMail.zimbra@redhat.com>
	<945864462.33340808.1500620194836.JavaMail.zimbra@redhat.com>
	<20170721121241.GA18014@stefanha-x1.localdomain>
	<46101617.33460557.1500643755247.JavaMail.zimbra@redhat.com>
	<20170721155848.GO18014@stefanha-x1.localdomain>
	<CAPcyv4gtWYpzbmggsbdLocPiMzU2rVt-ee+kL24gbrPxKd5Eyw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] KVM "fake DAX" flushing interface - discussion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dan Williams <dan.j.williams@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: Pankaj Gupta <pagupta@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, kvm-devel <kvm@vger.kernel.org>, Qemu Developers <qemu-devel@nongnu.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@ml01.01.org>, ross zwisler <ross.zwisler@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, Haozhong Zhang <haozhong.zhang@intel.com>

On Sat, 2017-07-22 at 12:34 -0700, Dan Williams wrote:
> On Fri, Jul 21, 2017 at 8:58 AM, Stefan Hajnoczi <stefanha@redhat.com
> > wrote:
> >
> > Maybe the NVDIMM folks can comment on this idea.
> 
> I think it's unworkable to use the flush hints as a guest-to-host
> fsync mechanism. That mechanism was designed to flush small memory
> controller buffers, not large swaths of dirty memory. What about
> running the guests in a writethrough cache mode to avoid needing
> dirty
> cache management altogether? Either way I think you need to use
> device-dax on the host, or one of the two work-in-progress filesystem
> mechanisms (synchronous-faults or S_IOMAP_FROZEN) to avoid need any
> metadata coordination between guests and the host.

The thing Pankaj is looking at is to use the DAX mechanisms
inside the guest (disk image as memory mapped nvdimm area),
with that disk image backed by a regular storage device on
the host.

The goal is to increase density of guests, by moving page
cache into the host (where it can be easily reclaimed).

If we assume the guests will be backed by relatively fast
SSDs, a "whole device flush" from filesystem journaling
code (issued where the filesystem issues a barrier or
disk cache flush today) may be just what we need to make
that work.
