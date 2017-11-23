Received: from eggs.gnu.org ([2001:4830:134:3::10]:46513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eHusX-0002us-SE
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 12:01:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eHusT-0004J7-IH
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 12:01:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1eHusT-0004Im-99
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 12:01:29 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A6B41C05679B
	for <qemu-devel@nongnu.org>; Thu, 23 Nov 2017 17:01:27 +0000 (UTC)
Date: Thu, 23 Nov 2017 18:01:22 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171123170122.GB4375@localhost.localdomain>
References: <20171123135906.12852-1-famz@redhat.com>
	<20171123135906.12852-2-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171123135906.12852-2-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] docs: Add image locking subsection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, mreitz@redhat.com

Am 23.11.2017 um 14:59 hat Fam Zheng geschrieben:
> This documents the image locking feature and explains when and how
> related options can be used.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  docs/qemu-block-drivers.texi | 36 ++++++++++++++++++++++++++++++++++++
>  qemu-doc.texi                |  1 +
>  2 files changed, 37 insertions(+)
> 
> diff --git a/docs/qemu-block-drivers.texi b/docs/qemu-block-drivers.texi
> index 1cb1e55686..fa2e90d15f 100644
> --- a/docs/qemu-block-drivers.texi
> +++ b/docs/qemu-block-drivers.texi
> @@ -785,6 +785,42 @@ warning: ssh server @code{ssh.example.com:22} does not support fsync
>  With sufficiently new versions of libssh2 and OpenSSH, @code{fsync} is
>  supported.
>  
> +@node disk_image_locking
> +@subsection Disk image file locking
> +
> +By default, QEMU tries to protect image files from unexpected concurrent
> +access, as long as it's supported by the block protocol driver and host
> +operating system. If multiple QEMU processes (including QEMU emulators and
> +utilities) try to open the same image with conflicting accessing modes, all but
> +the first one will get an error.
> +
> +This feature is currently supported by the file protocol on Linux with Open

s/with/with the/

> +File Descriptor (OFD) locking API, and can be configured to fall back to POSIX
> +locking if the POSIX host doesn't support Linux OFD locking.
> +
> +To explicitly enable image locking, specify "locking=on" in the file protocol
> +driver options. If OFD locking is not possible, a warning will be printed and
> +the POSIX locking API will be used. In this case there is risk that the lock

s/risk/a risk/ (native speakers, is this the right correction?)

> +will get silently lost when doing hot plugging and block jobs, due to the
> +shortcomings of the POSIX locking API.
> +
> +QEMU transparently handles lock handover during shared storage migration.  For
> +shared virtual disk images between multiple VMs, the "share-rw" device option
> +should be used.
> +
> +Alternatively, locking can be fully disabled by "locking=off" block device

s/by/with the/

> +option. In the command line the option is usually in the form of

Comma after "command line"?

> +"file.locking=off" as the protocol driver is normally placed as a "file" child
> +under a format driver. For example:
> +
> +@code{-blockdev driver=qcow2,file.filename=/path/to/image,file.locking=off,file.driver=file}
> +
> +To check if image locking is active, check the output of "lslocks" command on

_the_ "lslocks" command

> +host and see if there are locks held by QEMU process on the image file. More

"by a" or "by the", depending on what exactly you want to say

> +than one bytes could be locked by a QEMU instance, each byte of which reflects

s/bytes/byte/

> +a perticular permission that are acquired or protected by the running block

s/are/is/

> +driver.
> +
>  @c man end

Kevin
