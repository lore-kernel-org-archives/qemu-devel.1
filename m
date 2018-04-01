Received: from eggs.gnu.org ([2001:4830:134:3::10]:33792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f2j6b-0002cP-FU
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 15:57:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f2j6W-0003qm-L5
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 15:57:33 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:47685)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1f2j6W-0003pK-AW
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 15:57:28 -0400
References: <20180401192421.29712-1-jcmvbkbc@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <a2eb3458-6f61-e9e7-20df-d9b9325ef2ed@vivier.eu>
Date: Sun, 1 Apr 2018 21:57:15 +0200
MIME-Version: 1.0
In-Reply-To: <20180401192421.29712-1-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] target/xtensa: linux-user: fix sysv IPC
 structures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>

Le 01/04/2018 à 21:24, Max Filippov a écrit :
> - make target_ipc_perm fields match kernel definitions for xtensa;
> - add target_semid64_ds with proper order of times and reserved fields
>   for little/big endian specific for xtensa;
> - fix order of times and reserved fields of target_shmid_ds for
>   little/big endian;
> - fix types of shm_cpid, shm_lpid and shm_nattch fields of
>   target_shmid_ds to match kernel definitions for xtensa.
> 
> These changes fix guest ipcs output and fix glibc testsuite tests
> sysvipc/test-sysvsem and sysvipc/test-sysvshm.
> 
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  linux-user/xtensa/target_structs.h | 44 ++++++++++++++++++++++++++++++++------
>  1 file changed, 38 insertions(+), 6 deletions(-)
> 
> diff --git a/linux-user/xtensa/target_structs.h b/linux-user/xtensa/target_structs.h
> index 020e20e242fc..a3c854b53731 100644
> --- a/linux-user/xtensa/target_structs.h
> +++ b/linux-user/xtensa/target_structs.h
> @@ -8,21 +8,53 @@ struct target_ipc_perm {
>      abi_uint cuid;                      /* Creator's user ID.  */
>      abi_uint cgid;                      /* Creator's group ID.  */
>      abi_uint mode;                      /* Read/write permission.  */
> -    abi_ushort __seq;                   /* Sequence number.  */
> +    abi_ulong __seq;                    /* Sequence number.  */
> +    abi_ulong __unused1;
> +    abi_ulong __unused2;
>  };

ok, looks like ipc64_perm in arch/xtensa/include/uapi/asm/ipcbuf.h

> +struct target_semid64_ds {
> +  struct target_ipc_perm sem_perm;
> +#ifdef TARGET_WORDS_BIGENDIAN
> +  abi_ulong __unused1;
> +  abi_ulong sem_otime;
> +  abi_ulong __unused2;
> +  abi_ulong sem_ctime;
> +#else
> +  abi_ulong sem_otime;
> +  abi_ulong __unused1;
> +  abi_ulong sem_ctime;
> +  abi_ulong __unused2;
> +#endif
> +  abi_ulong sem_nsems;
> +  abi_ulong __unused3;
> +  abi_ulong __unused4;
> +};
> +#define TARGET_SEMID64_DS
> +

ok, looks like semid64_ds in arch/xtensa/include/uapi/asm/sembuf.h

>  struct target_shmid_ds {
>      struct target_ipc_perm shm_perm;    /* operation permission struct */
> -    abi_int shm_segsz;                  /* size of segment in bytes */
> +    abi_long shm_segsz;                 /* size of segment in bytes */
> +#ifdef TARGET_WORDS_BIGENDIAN
> +    abi_ulong __unused1;
>      abi_long shm_atime;                 /* time of last shmat() */
> +    abi_ulong __unused2;
>      abi_long shm_dtime;                 /* time of last shmdt() */
> +    abi_ulong __unused3;
>      abi_long shm_ctime;                 /* time of last change by shmctl() */
> -    abi_ushort shm_cpid;                /* pid of creator */
> -    abi_ushort shm_lpid;                /* pid of last shmop */
> -    abi_ushort shm_nattch;              /* number of current attaches */
> -    abi_ushort shm_unused;              /* compatibility */
> +#else
> +    abi_long shm_atime;                 /* time of last shmat() */
> +    abi_ulong __unused1;
> +    abi_long shm_dtime;                 /* time of last shmdt() */
>      abi_ulong __unused2;
> +    abi_long shm_ctime;                 /* time of last change by shmctl() */
>      abi_ulong __unused3;
> +#endif
> +    abi_uint shm_cpid;                  /* pid of creator */
> +    abi_uint shm_lpid;                  /* pid of last shmop */
> +    abi_ulong shm_nattch;               /* number of current attaches */
> +    abi_ulong __unused4;
> +    abi_ulong __unused5;
>  };

This is weird: shmid64_ds in arch/xtensa/include/uapi/asm/shmbuf.h has
two part like yours, but both parts have exactly the same fields order.

Could you explain?

Thanks,
Laurent
