Received: from eggs.gnu.org ([208.118.235.92]:40105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eocde-0001ji-Go
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 17:14:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eocd0-0001T2-2b
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 17:13:22 -0500
References: <20180221140849.16068-1-berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <903a9e3e-85f7-485f-44b6-31a97a42ca35@redhat.com>
Date: Wed, 21 Feb 2018 16:10:07 -0600
MIME-Version: 1.0
In-Reply-To: <20180221140849.16068-1-berto@igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] specs/qcow2: Fix documentation of the
 compressed cluster descriptor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On 02/21/2018 08:08 AM, Alberto Garcia wrote:
> This patch fixes several mistakes in the documentation of the
> compressed cluster descriptor:
> 

More things to consider, as followup patches:

Note that both the L1 table, and the standard L2 descriptors, have a cap 
on bit 55 as the maximum host offset (< 64PB).  But for compressed 
clusters, our maximum depends on cluster_bits, as follows:

512 byte cluster: bit 61 forms 'number clusters', leaving bits 60-0 for 
computing the host offset.  But even though this looks on the surface 
like you could allocate 2EB of compressed clusters, it does not play 
well with the rest of the L1/L2 system, so we should probably explicitly 
document that bits 60-56 MUST be 0, if they are assigned to the 'host 
offset field', making the maximum compressed cluster offset at 64PB.

2M cluster: bits 61-50 form 'number clusters', leaving bit 49 as the 
maximum bit in the host offset (< 512 TB).  But we never validate that 
we don't overflow this value!  I'm working on a patch.

Meanwhile, the refcount table currently allows all the way up to bit 63 
to form an offset to a refcount block, although capping that at 55 the 
way L1/L2 are capped would be reasonable (it gets weird to state that 
your metadata must live below 64PB but that your data pointed to by the 
metadata can live beyond that point).  So it may also be worth 
considering a spec patch that points out the 64PB maximum useful size, 
and maybe even a comment that the maximum size may be further 
constrained by the protocol layer (for example, ext4 has a 16TB cap on 
individual file size).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
