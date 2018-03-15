Received: from eggs.gnu.org ([2001:4830:134:3::10]:51409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ewYBO-0002EZ-HU
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 15:05:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ewYBL-0004Zl-9H
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 15:04:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47808)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ewYBK-0004ZP-Uk
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 15:04:55 -0400
Date: Thu, 15 Mar 2018 16:04:50 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180315190450.GF28578@localhost.localdomain>
References: <1520888449-4352-1-git-send-email-babu.moger@amd.com>
	<1520888449-4352-3-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520888449-4352-3-git-send-email-babu.moger@amd.com>
Subject: Re: [Qemu-devel] [PATCH v4 2/5] target/i386: Populate AMD Processor
 Cache Information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Babu Moger <babu.moger@amd.com>
Cc: pbonzini@redhat.com, rth@twiddle.net, rkrcmar@redhat.com, Thomas.Lendacky@amd.com, brijesh.singh@amd.com, kvm@vger.kernel.org, kash@tripleback.net, mtosatti@redhat.com, Gary.Hook@amd.com, qemu-devel@nongnu.org

Hi,

Sorry for not reviewing the previous versions of this series (and
making it miss soft freeze).


On Mon, Mar 12, 2018 at 05:00:46PM -0400, Babu Moger wrote:
> From: Stanislav Lanci <pixo@polepetko.eu>
> 
> Add information for cpuid 0x8000001D leaf. Populate cache topology information
> for different cache types(Data Cache, Instruction Cache, L2 and L3) supported
> by 0x8000001D leaf. Please refer Processor Programming Reference (PPR) for AMD
> Family 17h Model for more details.
> 
> Signed-off-by: Stanislav Lanci <pixo@polepetko.eu>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  target/i386/cpu.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  target/i386/kvm.c | 29 ++++++++++++++++++++++---
>  2 files changed, 91 insertions(+), 3 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 42dd381..5fdbedd 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -118,6 +118,7 @@
>  #define L1I_LINE_SIZE         64
>  #define L1I_ASSOCIATIVITY      8
>  #define L1I_SETS              64
> +#define L1I_SETS_AMD         256
>  #define L1I_PARTITIONS         1
>  /* Size = LINE_SIZE*ASSOCIATIVITY*SETS*PARTITIONS = 32KiB */
>  #define L1I_DESCRIPTOR CPUID_2_L1I_32KB_8WAY_64B
> @@ -129,7 +130,9 @@
>  /* Level 2 unified cache: */
>  #define L2_LINE_SIZE          64
>  #define L2_ASSOCIATIVITY      16
> +#define L2_ASSOCIATIVITY_AMD   8
>  #define L2_SETS             4096
> +#define L2_SETS_AMD         1024
>  #define L2_PARTITIONS          1
>  /* Size = LINE_SIZE*ASSOCIATIVITY*SETS*PARTITIONS = 4MiB */
>  /*FIXME: CPUID leaf 2 descriptor is inconsistent with CPUID leaf 4 */
> @@ -146,6 +149,7 @@
>  #define L3_N_LINE_SIZE         64
>  #define L3_N_ASSOCIATIVITY     16
>  #define L3_N_SETS           16384
> +#define L3_N_SETS_AMD        8192
>  #define L3_N_PARTITIONS         1
>  #define L3_N_DESCRIPTOR CPUID_2_L3_16MB_16WAY_64B
>  #define L3_N_LINES_PER_TAG      1

I wouldn't like to add even more inconsistencies between
different CPUID leaves.

If you really wish to have different defaults on AMD and Intel,
let's either hide Intel-specific CPUID leaves when using AMD
values, or make all of them agree (and choose the defaults based
on CPU model or vendor id).

-- 
Eduardo
