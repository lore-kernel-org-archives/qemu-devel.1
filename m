Received: from eggs.gnu.org ([2001:4830:134:3::10]:60030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1d1EXz-0004VB-Jv
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 12:03:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1d1EXw-0003nv-Pz
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 12:03:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55056)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1d1EXw-0003mi-KU
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 12:03:04 -0400
Date: Thu, 20 Apr 2017 10:03:01 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170420100301.51a7f10c@t450s.home>
In-Reply-To: <a8eb495d-7c03-2d6f-c8df-3970f08bc05d@twiddle.net>
References: <1492631083-23965-1-git-send-email-joserz@linux.vnet.ibm.com>
	<a8eb495d-7c03-2d6f-c8df-3970f08bc05d@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] VFIO: Make 8-byte accesses atomic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, qemu-devel@nongnu.org, aik@ozlabs.ru, pbonzini@redhat.com, mdroth@linux.vnet.ibm.com

On Thu, 20 Apr 2017 00:19:23 -0700
Richard Henderson <rth@twiddle.net> wrote:

> On 04/19/2017 12:44 PM, Jose Ricardo Ziviani wrote:
> > This patchset has two patches:
> > [1] 8-byte writes to non-mapped MMIO are broken into pairs of 4-byte writes, this patch makes such pairs atomic.
> >
> > [2] Enable 8-byte accesses in vfio_region_write and vfio_region_read.
> >
> > Patches based on master.
> >
> > Jose Ricardo Ziviani (2):
> >   vfio: Set MemoryRegionOps:max_access_size and min_access_size
> >   vfio: enable 8-byte reads/writes to vfio
> >
> >  hw/vfio/common.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >  
> 
> I think these patches need to be squashed to be bisectable.

No, I think it's fine.  The point of patch 1/2 is to indicate that the
hardware supports 8-byte accesses, which will still be broken into 2
4-byte accesses because we don't yet set the implemented width beyond
the default.  The important part is that the mutex will now group the 4
byte access pair together rather than letting them get re-ordered.
Patch 2/2 then implements native 8-byte access.  I appreciate them
being separate for this subtle nuance, but maybe I'm not seeing the
same issue as you.  Thanks,

Alex
