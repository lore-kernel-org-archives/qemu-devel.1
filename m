Received: from eggs.gnu.org ([209.51.188.92]:54115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1h17JH-0003zZ-Vf
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 05:28:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1h17JH-0007c4-0e
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 05:28:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35526
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1h17JG-0007a1-PA
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 05:28:30 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x25APRBh103242
	for <qemu-devel@nongnu.org>; Tue, 5 Mar 2019 05:28:29 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2r1qbfr4cd-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 05:28:29 -0500
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 5 Mar 2019 10:28:27 -0000
References: <1551775581-27989-1-git-send-email-thuth@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 5 Mar 2019 11:28:23 +0100
MIME-Version: 1.0
In-Reply-To: <1551775581-27989-1-git-send-email-thuth@redhat.com>
Content-Language: en-US
Message-Id: <073132d7-73ed-9d95-d2f3-55a4fcf50b5d@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3] target/s390x: Remove non-architected
 entries from struct LowCore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, "Jason J. Herne" <jjherne@linux.ibm.com>



On 05.03.2019 09:46, Thomas Huth wrote:
> There are some fields in our struct LowCore which apparently have
> been copied from a very old version of the Linux kernel. These
> fields are not architected in the "Principles of Operation", and
> only used on these memory locations in Linux kernels older than
> 2.6.29. Newer Linux kernels moved the entries to different locations
> or are not using them at all anymore. Thus we should never access
> these fields from the QEMU side, so they should be removed.
> 
> While we're at it, also add a QEMU_BUILD_BUG_MSG() statement to
> assert that struct LowCore has the right size.
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Certainly makes sense. The linux values can change all the time.

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

> ---
>  v3: Use QEMU_BUILD_BUG_ON instead of QEMU_BUILD_BUG_MSG
> 
>  target/s390x/internal.h | 41 ++---------------------------------------
>  1 file changed, 2 insertions(+), 39 deletions(-)
> 
> diff --git a/target/s390x/internal.h b/target/s390x/internal.h
> index 7baf0e2..07b69b8 100644
> --- a/target/s390x/internal.h
> +++ b/target/s390x/internal.h
> @@ -63,45 +63,7 @@ typedef struct LowCore {
>      PSW             program_new_psw;          /* 0x1d0 */
>      PSW             mcck_new_psw;             /* 0x1e0 */
>      PSW             io_new_psw;               /* 0x1f0 */
> -    PSW             return_psw;               /* 0x200 */
> -    uint8_t         irb[64];                  /* 0x210 */
> -    uint64_t        sync_enter_timer;         /* 0x250 */
> -    uint64_t        async_enter_timer;        /* 0x258 */
> -    uint64_t        exit_timer;               /* 0x260 */
> -    uint64_t        last_update_timer;        /* 0x268 */
> -    uint64_t        user_timer;               /* 0x270 */
> -    uint64_t        system_timer;             /* 0x278 */
> -    uint64_t        last_update_clock;        /* 0x280 */
> -    uint64_t        steal_clock;              /* 0x288 */
> -    PSW             return_mcck_psw;          /* 0x290 */
> -    uint8_t         pad9[0xc00 - 0x2a0];      /* 0x2a0 */
> -    /* System info area */
> -    uint64_t        save_area[16];            /* 0xc00 */
> -    uint8_t         pad10[0xd40 - 0xc80];     /* 0xc80 */
> -    uint64_t        kernel_stack;             /* 0xd40 */
> -    uint64_t        thread_info;              /* 0xd48 */
> -    uint64_t        async_stack;              /* 0xd50 */
> -    uint64_t        kernel_asce;              /* 0xd58 */
> -    uint64_t        user_asce;                /* 0xd60 */
> -    uint64_t        panic_stack;              /* 0xd68 */
> -    uint64_t        user_exec_asce;           /* 0xd70 */
> -    uint8_t         pad11[0xdc0 - 0xd78];     /* 0xd78 */
> -
> -    /* SMP info area: defined by DJB */
> -    uint64_t        clock_comparator;         /* 0xdc0 */
> -    uint64_t        ext_call_fast;            /* 0xdc8 */
> -    uint64_t        percpu_offset;            /* 0xdd0 */
> -    uint64_t        current_task;             /* 0xdd8 */
> -    uint32_t        softirq_pending;          /* 0xde0 */
> -    uint32_t        pad_0x0de4;               /* 0xde4 */
> -    uint64_t        int_clock;                /* 0xde8 */
> -    uint8_t         pad12[0xe00 - 0xdf0];     /* 0xdf0 */
> -
> -    /* 0xe00 is used as indicator for dump tools */
> -    /* whether the kernel died with panic() or not */
> -    uint32_t        panic_magic;              /* 0xe00 */
> -
> -    uint8_t         pad13[0x11b0 - 0xe04];    /* 0xe04 */
> +    uint8_t         pad13[0x11b0 - 0x200];    /* 0x200 */
>  
>      uint64_t        mcesad;                    /* 0x11B0 */
>  
> @@ -130,6 +92,7 @@ typedef struct LowCore {
>  
>      uint8_t         pad18[0x2000 - 0x1400];    /* 0x1400 */
>  } QEMU_PACKED LowCore;
> +QEMU_BUILD_BUG_ON(sizeof(LowCore) != 8192);
>  #endif /* CONFIG_USER_ONLY */
>  
>  #define MAX_ILEN 6
> 
