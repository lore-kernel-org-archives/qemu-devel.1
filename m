Received: from eggs.gnu.org ([2001:4830:134:3::10]:35186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eYxlR-0006Su-OU
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 12:32:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eYxlO-0005yk-L5
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 12:32:41 -0500
Date: Tue, 9 Jan 2018 18:32:30 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180109183230.5dfae15e.cohuck@redhat.com>
In-Reply-To: <20171211134740.8235-14-david@redhat.com>
References: <20171211134740.8235-1-david@redhat.com>
	<20171211134740.8235-14-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2-12 13/15] s390x/tcg: STSI overhaul
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Thomas Huth <thuth@redhat.com>

On Mon, 11 Dec 2017 14:47:38 +0100
David Hildenbrand <david@redhat.com> wrote:

> Current STSI implementation is a mess, so let's rewrite it.
> 
> Problems fixed by this patch:
> 1) The order of exceptions/when recognized is wrong.
> 2) We have to store to virtual address space, not absolute.
> 3) Alignment check of the block is missing.
> 3) The SMP information is not indicated.
> 
> While at it:
> a) Make the code look nicer
>     - get rid of nesting levels
>     - use struct initialization instead of initializing to zero
>     - rename a misspelled field and rename function code defines
>     - use a union and have only one write statement
>     - use cpu_to_beX()
> b) Indicate the VM name/extended name + UUID just like KVM does
> c) Indicate that all LPAR CPUs we fake are dedicated
> d) Add a comment why we fake being a KVM guest
> e) Give our guest as default the name "TCGguest"
> f) Fake the same CPU information we have in our Guest for all layers
> 
> While at it, get rid of "potential_page_fault()" by forwarding the
> retaddr properly.
> 
> The result is best verified by looking at "/proc/sysinfo" in the guest
> when specifying on the qemu command line
>     -uuid "74738ff5-5367-5958-9aee-98fffdcd1876" \
>     -name "extra long guest name"
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu.h         |  22 +++--
>  target/s390x/misc_helper.c | 213 ++++++++++++++++++++++++---------------------
>  2 files changed, 132 insertions(+), 103 deletions(-)
> 
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index bfe650c46e..aded28d390 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -425,11 +425,11 @@ static inline void setcc(S390CPU *cpu, uint64_t cc)
>  }
>  
>  /* STSI */
> -#define STSI_LEVEL_MASK         0x00000000f0000000ULL
> -#define STSI_LEVEL_CURRENT      0x0000000000000000ULL
> -#define STSI_LEVEL_1            0x0000000010000000ULL
> -#define STSI_LEVEL_2            0x0000000020000000ULL
> -#define STSI_LEVEL_3            0x0000000030000000ULL
> +#define STSI_R0_FC_MASK         0x00000000f0000000ULL
> +#define STSI_R0_FC_CURRENT      0x0000000000000000ULL
> +#define STSI_R0_FC_LEVEL_1      0x0000000010000000ULL
> +#define STSI_R0_FC_LEVEL_2      0x0000000020000000ULL
> +#define STSI_R0_FC_LEVEL_3      0x0000000030000000ULL
>  #define STSI_R0_RESERVED_MASK   0x000000000fffff00ULL
>  #define STSI_R0_SEL1_MASK       0x00000000000000ffULL
>  #define STSI_R1_RESERVED_MASK   0x00000000ffff0000ULL
> @@ -464,7 +464,7 @@ struct sysib_122 {
>      uint8_t res1[32];
>      uint32_t capability;
>      uint16_t total_cpus;
> -    uint16_t active_cpus;
> +    uint16_t conf_cpus;
>      uint16_t standby_cpus;
>      uint16_t reserved_cpus;
>      uint16_t adjustments[2026];
> @@ -524,6 +524,16 @@ struct sysib_322 {
>  };
>  QEMU_BUILD_BUG_ON(sizeof(struct sysib_322) != 4096);
>  
> +union sysib {
> +    struct sysib_111 sysib_111;
> +    struct sysib_121 sysib_121;
> +    struct sysib_122 sysib_122;
> +    struct sysib_221 sysib_221;
> +    struct sysib_222 sysib_222;
> +    struct sysib_322 sysib_322;
> +};

Wondering whether you should add some typedefery to make this more
qemu-y.

> +QEMU_BUILD_BUG_ON(sizeof(union sysib) != 4096);
> +
>  /* MMU defines */
>  #define _ASCE_ORIGIN            ~0xfffULL /* segment table origin             */
>  #define _ASCE_SUBSPACE          0x200     /* subspace group control           */

(...)

> +    /*
> +     * In theory, we could report Level 1 / Level 2 as current. However,
> +     * the Linux kernel will detect then assume that we have a sclp
> +     * linemode console (which is not the default for QEMU), therefore not
> +     * displaying boot messages and making booting a Linux kernel under
> +     * TCG harder

I know what you mean, but this reads a bit confusing. What about:

"However, the Linux kernel will detect this as running under LPAR and
assume that we have a sclp linemode console (which is always present on
LPAR, but not the default for QEMU), therefore not displaying boot
messages and making booting a Linux kernel under TCG harder."

> +     *
> +     * For now we fake the same SMP configuration on all levels.
> +     *
> +     * TODO: We could later make the level configurable via the
> machine
> +     *       and change defaults (linemode console) based on machine
> type
> +     *       and accelerator.
> +     */
