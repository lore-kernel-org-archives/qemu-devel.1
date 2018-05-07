Received: from eggs.gnu.org ([2001:4830:134:3::10]:40386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fFlRi-00072e-5F
	for qemu-devel@nongnu.org; Mon, 07 May 2018 15:05:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fFlRd-0004qE-IL
	for qemu-devel@nongnu.org; Mon, 07 May 2018 15:05:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54366)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fFlRd-0004pS-Cd
	for qemu-devel@nongnu.org; Mon, 07 May 2018 15:05:09 -0400
Date: Mon, 7 May 2018 16:05:01 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180507190501.GA13350@localhost.localdomain>
References: <1524760009-24710-1-git-send-email-babu.moger@amd.com>
	<1524760009-24710-2-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524760009-24710-2-git-send-email-babu.moger@amd.com>
Subject: Re: [Qemu-devel] [PATCH v7 1/9] i386: Helpers to encode cache
 information consistently
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Babu Moger <babu.moger@amd.com>
Cc: mst@redhat.com, marcel@redhat.com, pbonzini@redhat.com, rth@twiddle.net, mtosatti@redhat.com, geoff@hostfission.com, kash@tripleback.net, qemu-devel@nongnu.org, kvm@vger.kernel.org

Hi,

I was about to apply this because I assumed it was the same patch
I sent in March, but then I found this:

On Thu, Apr 26, 2018 at 11:26:41AM -0500, Babu Moger wrote:
> From: Eduardo Habkost <ehabkost@redhat.com>
> 
> Instead of having a collection of macros that need to be used in
> complex expressions to build CPUID data, define a CPUCacheInfo
> struct that can hold information about a given cache.  Helper
> functions will take a CPUCacheInfo struct as input to encode
> CPUID leaves for a cache.
> 
> This will help us ensure consistency between cache information
> CPUID leaves, and make the existing inconsistencies in CPUID info
> more visible.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Tested-by: Geoffrey McRae <geoff@hostfission.com>
[...]
> -#define L2_ASSOCIATIVITY      16
[...]
>  /*FIXME: CPUID leaf 0x80000006 is inconsistent with leaves 2 & 4 */
> +static CPUCacheInfo l2_cache_amd = {
[...]
> +    .associativity = 8,
[...]
> +};
[...]
>      case 0x80000006:
[...]
> -        *ecx = (L2_SIZE_KB_AMD << 16) | \
> -               (AMD_ENC_ASSOC(L2_ASSOCIATIVITY) << 12) | \
> -               (L2_LINES_PER_TAG << 8) | (L2_LINE_SIZE);
[...]
> +        encode_cache_cpuid80000006(&l2_cache_amd,
> +                                   cpu->enable_l3_cache ? &l3_cache : NULL,
> +                                   ecx, edx);
[...]

The structs added by this patch are supposed to represent the
legacy cache sizes, and must match the old code.  My original
patch set l2_cache_amd.associativity=16 because of that.

This patch changes 0x80000006 from associativity=16 to
associativity=8.  Why?

-- 
Eduardo
