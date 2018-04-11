Received: from eggs.gnu.org ([2001:4830:134:3::10]:44427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f6Esd-0006ya-Fx
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 08:29:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f6Esa-00052k-BY
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 08:29:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51464 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1f6Esa-000529-7m
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 08:29:36 -0400
Date: Wed, 11 Apr 2018 13:29:24 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180411122923.GE2667@work-vm>
References: <1523089594-1422-1-git-send-email-lidongchen@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523089594-1422-1-git-send-email-lidongchen@tencent.com>
Subject: Re: [Qemu-devel] [PATCH 0/5] Enable postcopy RDMA live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lidong Chen <jemmy858585@gmail.com>
Cc: quintela@redhat.com, qemu-devel@nongnu.org, adido@mellanox.com, licq@mellanox.com, Lidong Chen <lidongchen@tencent.com>

* Lidong Chen (jemmy858585@gmail.com) wrote:
> Current Qemu RDMA communication does not support send and receive
> data at the same time, so when RDMA live migration with postcopy
> enabled, the source qemu return path thread get qemu file error.
> 
> Those patch add the postcopy support for RDMA live migration.

This description is a little misleading; it doesn't really
do RDMA during the postcopy phase - what it really does is disable
the RDMA page sending during the postcopy phase, relying on the 
RDMA codes stream emulation to send the page.

That's not necessarily a bad fix; you get the nice performance of RDMA
during the precopy phase, but how bad are you finding the performance
during the postcopy phase - the RDMA code we have was only really
designed for sending small commands over the stream?

Dave

> Lidong Chen (5):
>   migration: create a dedicated connection for rdma return path
>   migration: add the interface to set get_return_path
>   migration: implement the get_return_path for RDMA iochannel
>   migration: fix qemu carsh when RDMA live migration
>   migration: disable RDMA WRITR after postcopy started.
> 
>  migration/qemu-file-channel.c |  12 ++--
>  migration/qemu-file.c         |  13 +++-
>  migration/qemu-file.h         |   2 +-
>  migration/rdma.c              | 148 ++++++++++++++++++++++++++++++++++++++++--
>  4 files changed, 163 insertions(+), 12 deletions(-)
> 
> -- 
> 1.8.3.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
