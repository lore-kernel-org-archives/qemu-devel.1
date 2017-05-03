Received: from eggs.gnu.org ([2001:4830:134:3::10]:38163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d5ovx-0004S2-Gd
	for qemu-devel@nongnu.org; Wed, 03 May 2017 03:42:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d5ovu-0003A6-Dy
	for qemu-devel@nongnu.org; Wed, 03 May 2017 03:42:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35192)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1d5ovu-00039w-7q
	for qemu-devel@nongnu.org; Wed, 03 May 2017 03:42:46 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E5E347AE81
	for <qemu-devel@nongnu.org>; Wed,  3 May 2017 07:42:44 +0000 (UTC)
Date: Wed, 3 May 2017 15:42:40 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170503074240.GC9318@lemon.lan>
References: <20170503072819.14462-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170503072819.14462-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] dump: Acquire BQL around vm_start() in
 dump thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com, peterx@redhat.com

On Wed, 05/03 15:28, Fam Zheng wrote:
> This fixes an assertion failure in the following backtrace:
> 
>     __GI___assert_fail
>     memory_region_transaction_commit
>     memory_region_add_eventfd
>     virtio_pci_ioeventfd_assign
>     virtio_bus_set_host_notifier
>     virtio_blk_data_plane_start
>     virtio_bus_start_ioeventfd
>     virtio_vmstate_change
>     vm_state_notify
>     vm_prepare_start
>     vm_start
>     dump_cleanup
>     dump_process
>     dump_thread
>     start_thread
>     clone
> 
> vm_start need BQL, acquire it if doing cleaning up from main thread.

Oops, s/need/needs and s/main thread/detached thread/.

Fam
