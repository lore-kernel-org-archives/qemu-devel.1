Received: from eggs.gnu.org ([2001:4830:134:3::10]:36477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1egBgK-0005hX-5A
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 10:49:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1egBgE-0002CY-MM
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 10:49:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56396)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1egBgE-0002CE-Gu
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 10:49:10 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B587FC052450
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 15:49:09 +0000 (UTC)
Date: Mon, 29 Jan 2018 16:49:02 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180129154902.GJ6141@localhost.localdomain>
References: <20180124044216.12461-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180124044216.12461-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] iotests: Fix CID for VMDK afl image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mreitz@redhat.com

Am 24.01.2018 um 05:42 hat Fam Zheng geschrieben:
> The descriptor block in the image, which includes the CID to verify, has been
> invalid since the reference image was added. Since commit 9877860e7bd we report
> this error earlier than the "file too large", so 059.out mismatches.
> 
> Instead of fixing the output, we fix the image descriptor, because the code
> path we want to exercise is actually the invalid image size.
> 
> The binary change is generated along the operations of:
> 
>   $ bunzip2 afl9.vmdk.bz2
>   $ qemu-img create -f qcow2 fix.vmdk 1G

Sure about -f qcow2? :-)

>   $ dd if=afl9.vmdk.bz2 of=fix.vmdk bs=512 count=1 conv=notrunc
>   $ mv fix.vmdk afl9.vmdk
>   $ bzip2 afl9.vmdk
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  tests/qemu-iotests/sample_images/afl9.vmdk.bz2 | Bin 178 -> 618 bytes
>  1 file changed, 0 insertions(+), 0 deletions(-)

I think you also want to revert 76bf133c in this patch, otherwise 059
fails after applying it.

Kevin
