Received: from eggs.gnu.org ([2001:4830:134:3::10]:36394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ehEAn-00088a-Pr
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 07:41:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ehEAk-00065w-KV
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 07:41:01 -0500
Date: Thu, 1 Feb 2018 13:40:48 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180201134048.3a91f070.cohuck@redhat.com>
In-Reply-To: <20180129125623.21729-13-david@redhat.com>
References: <20180129125623.21729-1-david@redhat.com>
	<20180129125623.21729-13-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 12/18] s390x: fix size + content of STSI
 blocks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>

On Mon, 29 Jan 2018 13:56:17 +0100
David Hildenbrand <david@redhat.com> wrote:

> All blocks are 4k in size, which is only true for two of them right now.
> Also some reserved fields were wrong, fix it and convert all reserved
> fields to u8.
> 
> This also fixes the LPAR part output in /proc/sysinfo under TCG. (for
> now, everything was indicated as 0)
> 
> While at it, introduce typedefs for these structs and use them in TCG/KVM
> code.
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu.h         | 46 ++++++++++++++++++++++++++--------------------
>  target/s390x/kvm.c         |  2 +-
>  target/s390x/misc_helper.c | 12 ++++++------
>  3 files changed, 33 insertions(+), 27 deletions(-)
> 
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index 76c31d970f..1475d705a4 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -437,29 +437,31 @@ static inline void setcc(S390CPU *cpu, uint64_t cc)
>  #define STSI_R1_SEL2_MASK       0x000000000000ffffULL
>  
>  /* Basic Machine Configuration */
> -struct sysib_111 {
> -    uint32_t res1[8];
> +typedef struct SysIB_111 {
> +    uint8_t  res1[32];
>      uint8_t  manuf[16];
>      uint8_t  type[4];
>      uint8_t  res2[12];
>      uint8_t  model[16];
>      uint8_t  sequence[16];
>      uint8_t  plant[4];
> -    uint8_t  res3[156];
> -};
> +    uint8_t  res3[3996];
> +} SysIB_111;
> +QEMU_BUILD_BUG_ON(sizeof(SysIB_111) != 4096);

I would probably have dropped the underscore, but I won't ask you to
respin again for that :)
