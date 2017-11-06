Received: from eggs.gnu.org ([2001:4830:134:3::10]:44124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eBhYW-0008Uv-97
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 08:35:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eBhYT-0008Oz-6c
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 08:35:12 -0500
Received: from 6.mo179.mail-out.ovh.net ([46.105.56.76]:46063)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eBhYT-0008OB-0a
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 08:35:09 -0500
Received: from player690.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 028126195E
	for <qemu-devel@nongnu.org>; Mon,  6 Nov 2017 14:35:03 +0100 (CET)
Date: Mon, 6 Nov 2017 14:34:57 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20171106143457.63bf47f2@bahia>
In-Reply-To: <20170929111323.6308-2-michael@fritscher.net>
References: <20170929111323.6308-1-michael@fritscher.net>
	<20170929111323.6308-2-michael@fritscher.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/18] Add definitions needed by
 file-op-9p.h for Windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Fritscher <michael@fritscher.net>
Cc: sw@weilnetz.de, aneesh.kumar@linux.vnet.ibm.com, mst@redhat.com, qemu-devel@nongnu.org, Greg Kurz <gkurz@linux.vnet.ibm.com>

On Fri, 29 Sep 2017 13:13:06 +0200
Michael Fritscher <michael@fritscher.net> wrote:

> Signed-off-by: Michael Fritscher <michael@fritscher.net>
> ---
>  include/sysemu/os-win32.h | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/include/sysemu/os-win32.h b/include/sysemu/os-win32.h
> index ff18b23db1..15cc94513b 100644
> --- a/include/sysemu/os-win32.h
> +++ b/include/sysemu/os-win32.h
> @@ -196,4 +196,30 @@ ssize_t qemu_recv_wrap(int sockfd, void *buf, size_t len, int flags);
>  ssize_t qemu_recvfrom_wrap(int sockfd, void *buf, size_t len, int flags,
>                             struct sockaddr *addr, socklen_t *addrlen);
> 
> +typedef uint32_t uid_t;
> +typedef uint32_t gid_t;
> +
> +/* from http://man7.org/linux/man-pages/man2/statfs.2.html */
> +typedef uint32_t __fsword_t;
> +typedef uint32_t fsblkcnt_t;
> +typedef uint32_t fsfilcnt_t;
> +
> +/* from linux/include/uapi/asm-generic/posix_types.h */
> +typedef struct {
> +    long __val[2];
> +} fsid_t;
> +
> +struct statfs {
> +    __fsword_t f_type;
> +    __fsword_t f_bsize;
> +    fsblkcnt_t f_blocks;
> +    fsblkcnt_t f_bfree;
> +    fsblkcnt_t f_bavail;
> +    fsfilcnt_t f_files;
> +    fsfilcnt_t f_ffree;
> +    fsid_t f_fsid;
> +    __fsword_t f_namelen;
> +    __fsword_t f_frsize;
> +    __fsword_t f_flags;
> +};
>  #endif

Since this statfs definition is likely to be only ever used by fsdev, I'm
wondering if all the related typedefs would better sit in fsdev/file-op-9p.h
directly (ie, move the lines to a #else block in the next patch).
