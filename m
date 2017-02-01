Received: from eggs.gnu.org ([2001:4830:134:3::10]:32877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cZ3uX-00013V-Hp
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 18:01:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cZ3uU-0006ce-G9
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 18:01:57 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:62614)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cZ3uU-0006bZ-5Y
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 18:01:54 -0500
References: <20170128120307.GA17532@ls3530.fritz.box>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <6cc168bd-98e4-ce2f-a1bc-0a321838523d@vivier.eu>
Date: Thu, 2 Feb 2017 00:01:46 +0100
MIME-Version: 1.0
In-Reply-To: <20170128120307.GA17532@ls3530.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: Add FICLONE and FICLONERANGE
 ioctls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>

Le 28/01/2017 à 13:03, Helge Deller a écrit :
> Add missing FICLONE and FICLONERANGE ioctls.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> 
> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> index 2f6e85b..eb1421d 100644
> --- a/linux-user/ioctls.h
> +++ b/linux-user/ioctls.h
> @@ -112,6 +112,11 @@
>  #ifdef FIBMAP
>       IOCTL(FIBMAP, IOC_W | IOC_R, MK_PTR(TYPE_LONG))
>  #endif
> +#ifdef FICLONE
> +     IOCTL(FICLONE, IOC_W, TYPE_INT)
> +     IOCTL(FICLONERANGE, IOC_W, MK_PTR(MK_ARRAY(TYPE_ULONGLONG, 4)))
> +#endif
> +
>  #ifdef FIGETBSZ
>       IOCTL(FIGETBSZ, IOC_R, MK_PTR(TYPE_LONG))
>  #endif
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index 4442c22..72ca5b1 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -1086,6 +1086,10 @@ struct target_pollfd {
>  
>  #define TARGET_FIBMAP     TARGET_IO(0x00,1)  /* bmap access */
>  #define TARGET_FIGETBSZ   TARGET_IO(0x00,2)  /* get the block size used for bmap */
> +
> +#define TARGET_FICLONE    TARGET_IOW(0x94, 9, int)
> +#define TARGET_FICLONERANGE TARGET_IOW(0x94, 13, struct file_clone_range)
> +
>  /* Note that the ioctl numbers claim type "long" but the actual type
>   * used by the kernel is "int".
>   */
> 

I think it should be cleaner to define STRUCT_file_clone_range in
linux-user/syscall_types.h with STRUCT() macro, and then to use it:

STRUCT(file_clone_range,
       TYPE_LONGLONG, /* src_fd */
       TYPE_ULONGLONG, /* src_offset */
       TYPE_ULONGLONG, /* src_length */
       TYPE_ULONGLONG) /* dest_offset */

IOCTL(FICLONERANGE, IOC_W, MK_PTR(MK_STRUCT(STRUCT_file_clone_range)))

Laurent
