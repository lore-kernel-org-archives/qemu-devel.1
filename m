Received: from eggs.gnu.org ([209.51.188.92]:51241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jack@suse.cz>) id 1ghXPY-0005uU-CE
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 05:18:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jack@suse.cz>) id 1ghXPX-0005hI-3N
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 05:18:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:33736 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jack@suse.cz>) id 1ghXPV-0005ga-O0
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 05:18:03 -0500
Date: Thu, 10 Jan 2019 11:17:57 +0100
From: Jan Kara <jack@suse.cz>
Message-ID: <20190110101757.GC15790@quack2.suse.cz>
References: <20190109144736.17452-1-pagupta@redhat.com>
	<20190110012617.GA4205@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110012617.GA4205@dastard>
Subject: Re: [Qemu-devel] [PATCH v3 0/5] kvm "virtio pmem" device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dave Chinner <david@fromorbit.com>
Cc: Pankaj Gupta <pagupta@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, linux-nvdimm@ml01.01.org, linux-fsdevel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-acpi@vger.kernel.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, jack@suse.cz, stefanha@redhat.com, dan.j.williams@intel.com, riel@surriel.com, nilal@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, zwisler@kernel.org, vishal.l.verma@intel.com, dave.jiang@intel.com, david@redhat.com, jmoyer@redhat.com, xiaoguangrong.eric@gmail.com, hch@infradead.org, mst@redhat.com, jasowang@redhat.com, lcapitulino@redhat.com, imammedo@redhat.com, eblake@redhat.com, willy@infradead.org, tytso@mit.edu, adilger.kernel@dilger.ca, darrick.wong@oracle.com, rjw@rjwysocki.net

On Thu 10-01-19 12:26:17, Dave Chinner wrote:
> On Wed, Jan 09, 2019 at 08:17:31PM +0530, Pankaj Gupta wrote:
> >  This patch series has implementation for "virtio pmem". 
> >  "virtio pmem" is fake persistent memory(nvdimm) in guest 
> >  which allows to bypass the guest page cache. This also
> >  implements a VIRTIO based asynchronous flush mechanism.  
> 
> Hmmmm. Sharing the host page cache direct into the guest VM. Sounds
> like a good idea, but.....
> 
> This means the guest VM can now run timing attacks to observe host
> side page cache residency, and depending on the implementation I'm
> guessing that the guest will be able to control host side page
> cache eviction, too (e.g. via discard or hole punch operations).
> 
> Which means this functionality looks to me like a new vector for
> information leakage into and out of the guest VM via guest
> controlled host page cache manipulation.
> 
> https://arxiv.org/pdf/1901.01161
> 
> I might be wrong, but if I'm not we're going to have to be very
> careful about how guest VMs can access and manipulate host side
> resources like the page cache.....

Right. Thinking about this I would be more concerned about the fact that
guest can effectively pin amount of host's page cache upto size of the
device/file passed to guest as PMEM, can't it Pankaj? Or is there some QEMU
magic that avoids this?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
