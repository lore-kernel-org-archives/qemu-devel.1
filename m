Received: from eggs.gnu.org ([2001:4830:134:3::10]:58355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ccxRM-0003Rb-6s
	for qemu-devel@nongnu.org; Sun, 12 Feb 2017 11:55:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ccxRJ-0001sW-3a
	for qemu-devel@nongnu.org; Sun, 12 Feb 2017 11:55:56 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:62077)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ccxRI-0001rw-Oe
	for qemu-devel@nongnu.org; Sun, 12 Feb 2017 11:55:53 -0500
References: <20170211222602.GA6399@ls3530.fritz.box>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <a40d2e9f-1995-f32f-217a-abd6283b9646@vivier.eu>
Date: Sun, 12 Feb 2017 17:55:28 +0100
MIME-Version: 1.0
In-Reply-To: <20170211222602.GA6399@ls3530.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] linux-user: Add FICLONE and
 FICLONERANGE ioctls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>
Cc: Richard Henderson <rth@twiddle.net>

Le 11/02/2017 à 23:26, Helge Deller a écrit :
> Add missing FICLONE and FICLONERANGE ioctls.
> 
> Changes to v1:
> - Added STRUCT_file_clone_range as suggested by Laurent Vivier
> 
> Signed-off-by: Helge Deller <deller@gmx.de>

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

> 
> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> index 2f6e85b..e6997ff 100644
> --- a/linux-user/ioctls.h
> +++ b/linux-user/ioctls.h
> @@ -112,6 +112,11 @@
>  #ifdef FIBMAP
>       IOCTL(FIBMAP, IOC_W | IOC_R, MK_PTR(TYPE_LONG))
>  #endif
> +#ifdef FICLONE
> +     IOCTL(FICLONE, IOC_W, TYPE_INT)
> +     IOCTL(FICLONERANGE, IOC_W, MK_PTR(MK_STRUCT(STRUCT_file_clone_range)))
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
> diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
> index 2b8c0c6..24631b0 100644
> --- a/linux-user/syscall_types.h
> +++ b/linux-user/syscall_types.h
> @@ -232,6 +232,12 @@ STRUCT(dm_target_versions,
>  STRUCT(dm_target_msg,
>         TYPE_ULONGLONG) /* sector */
>  
> +STRUCT(file_clone_range,
> +       TYPE_LONGLONG, /* src_fd */
> +       TYPE_ULONGLONG, /* src_offset */
> +       TYPE_ULONGLONG, /* src_length */
> +       TYPE_ULONGLONG) /* dest_offset */
> +
>  STRUCT(fiemap_extent,
>         TYPE_ULONGLONG, /* fe_logical */
>         TYPE_ULONGLONG, /* fe_physical */
> 
