Received: from eggs.gnu.org ([2001:4830:134:3::10]:56730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g0pZ2-0004tw-SH
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 10:59:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g0pZ0-0003CM-5E
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 10:59:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60718)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1g0pYz-0003Bc-Ux
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 10:59:18 -0400
References: <CAB3eZftpYi6Am7RSRKz-JW-tA0Wrre+XdKkxP0AiBB90wq6fag@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2b7f0cc1-1cac-0ed3-b90a-bc719b3073b3@redhat.com>
Date: Fri, 14 Sep 2018 09:59:15 -0500
MIME-Version: 1.0
In-Reply-To: <CAB3eZftpYi6Am7RSRKz-JW-tA0Wrre+XdKkxP0AiBB90wq6fag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Different type of qcow2_get_cluster_type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: lampahome <pahome.chen@mirlab.org>, QEMU Developers <qemu-devel@nongnu.org>

On 9/14/18 3:35 AM, lampahome wrote:
> The function qcow2_get_cluster_type() is in /block/qcow2.h
> It will return the flage based on the entry.
> 
> There're some flags confused me.
> What's difference between QCOW2_CLUSTER_ZERO_ALLOC &
> QCOW2_CLUSTER_ZERO_PLAIN
> in there?

Look at docs/interop/qcow2.txt at the L2 entry format:

Bit 0: If set to 1, the cluster reads as all zeros
Bits 9-55: Bits 9-55 of host cluster offset; if 0 the cluster is unallocated

Both values correspond to L2 entries with bit 0 set.  However, 
QCOW2_CLUSTER_ZERO_ALLOC is an entry that has a non-zero value in bits 
9-55 (the cluster has an allocated host location, we guarantee that 
things read as zero regardless of whether the host data actually 
contains zeroes at that offset, and writes go directly to that offset 
with no further allocation required); while QCOW2_CLUSTER_ZERO_PLAIN is 
an entry with all zeros in bits 9-55 (we guarantee things read as zero, 
but writes have to allocate a new cluster because we have not reserved 
any space in the host yet).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
