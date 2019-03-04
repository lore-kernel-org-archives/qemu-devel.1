Received: from eggs.gnu.org ([209.51.188.92]:42294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h0s3a-0003Tb-1p
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:11:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h0s3Y-0006Gb-1H
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:11:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1h0s3X-0006Bc-Lf
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:11:15 -0500
References: <20190304084238.13481-1-marcel.apfelbaum@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <550bead8-a9a5-d9f4-1204-a6130f8c8e14@redhat.com>
Date: Mon, 4 Mar 2019 12:11:10 -0600
MIME-Version: 1.0
In-Reply-To: <20190304084238.13481-1-marcel.apfelbaum@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] migration/rdma: clang compilation fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, quintela@redhat.com

On 3/4/19 2:42 AM, Marcel Apfelbaum wrote:
> Configuring QEMU with:
>          ../configure --cc=clang --enable-rdma
> 
> Leads to compilation error:
> 
>    CC      migration/rdma.o
>    CC      migration/block.o
>    qemu/migration/rdma.c:3615:58: error: taking address of packed member 'rkey' of class or structure
>        'RDMARegisterResult' may result in an unaligned pointer value [-Werror,-Waddress-of-packed-member]
>                              (uintptr_t)host_addr, NULL, &reg_result->rkey,
>                                                           ^~~~~~~~~~~~~~~~
> 
> This is a false warning; even if RDMARegisterResult is "packed", rkey
> is the first field so is guaranteed to be aligned.

Not so. If you packed struct, gcc is free to abut that struct next to 
some other unaligned field in a larger struct:

https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg06743.html

> 
> Fix it by disabling the warning only for this instance.

Ignoring the bug is not the same as fixing the bug.  You need to rework 
this, as the compiler warning is not a false negative.

> 
> Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> ---
>   migration/rdma.c | 3 +++
>   1 file changed, 3 insertions(+)
-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
