Received: from eggs.gnu.org ([2001:4830:134:3::10]:55577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dIZNo-00033O-Ie
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 07:44:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dIZNj-0003a0-M8
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 07:44:16 -0400
Date: Wed, 7 Jun 2017 13:44:06 +0200
From: Alberto Garcia <berto@igalia.com>
Message-ID: <20170607114406.GA24076@igalia.com>
References: <cover.1495536228.git.berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1495536228.git.berto@igalia.com>
Subject: Re: [Qemu-devel] [PATCH 0/7] qcow2: Reduce the number of I/O ops
 when doing COW
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Denis V . Lunev" <den@openvz.org>

ping

On Tue, May 23, 2017 at 01:22:55PM +0200, Alberto Garcia wrote:
> Hi all,
> 
> here's a patch series that rewrites the copy-on-write code in the
> qcow2 driver to reduce the number of I/O operations.
> 
> The situation is that when a guest sends a write request and QEMU
> needs to allocate new cluster(s) in a qcow2 file, the unwritten
> regions of the new cluster(s) need to be filled with the existing data
> (e.g. from the backing image) or with zeroes.
> 
> The whole process can require up to 5 I/O operations:
> 
> 1) Write the data from the actual write request.
> 2) Read the existing data located before the guest data.
> 3) Write that data to the new clusters.
> 4) Read the existing data located after the guest data.
> 5) Write that data to the new clusters.
> 
> This series reduces that to only two operations:
> 
> 1) Read the existing data from the original clusters
> 2) Write the updated data (=original + guest request) to the new clusters
> 
> Step (1) implies that there's data that will be read but will be
> immediately discarded (because it's overwritten by the guest
> request). I haven't really detected any big performance problems
> because of that, but I decided to be conservative and my code includes
> a simple heuristic that keeps the old behavior if the amount of data
> to be discarded is higher than 16KB.
> 
> I've been testing this series in several scenarios, with different
> cluster sizes (32K, 64K, 1MB) and request sizes (from 4 up to 512KB),
> and both with an SSD and a rotating HDD. The results vary depending on
> the case, with an average increase of 60% in the number of IOPS in the
> HDD case, and 15% in the SSD case. In some cases there are really no
> big differences and the results are similar before and after this
> patch.
> 
> Further work for the future includes detecting when the data that
> needs to be written consists on zeroes (i.e. allocating a new cluster
> with no backing image) and optimizing that case, but let's start with
> this.
> 
> Regards,
> 
> Berto
> 
> Alberto Garcia (7):
>   qcow2: Remove unused Error in do_perform_cow()
>   qcow2: Use unsigned int for both members of Qcow2COWRegion
>   qcow2: Make perform_cow() call do_perform_cow() twice
>   qcow2: Split do_perform_cow() into _read(), _encrypt() and _write()
>   qcow2: Allow reading both COW regions with only one request
>   qcow2: Pass a QEMUIOVector to do_perform_cow_{read,write}()
>   qcow2: Merge the writing of the COW regions with the guest data
> 
>  block/qcow2-cluster.c | 188 +++++++++++++++++++++++++++++++++++++-------------
>  block/qcow2.c         |  58 +++++++++++++---
>  block/qcow2.h         |  11 ++-
>  3 files changed, 197 insertions(+), 60 deletions(-)
> 
> -- 
> 2.11.0
