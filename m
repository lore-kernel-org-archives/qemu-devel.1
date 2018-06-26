Received: from eggs.gnu.org ([2001:4830:134:3::10]:46690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fXkqE-0004hY-5O
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 06:04:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fXkqA-0004SN-VO
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 06:04:54 -0400
References: <20180625115352.6889-1-david@redhat.com>
	<20180625115352.6889-2-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <081fc645-9f7f-eedf-4f3b-32f2cb89084c@redhat.com>
Date: Tue, 26 Jun 2018 12:04:44 +0200
MIME-Version: 1.0
In-Reply-To: <20180625115352.6889-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/9] s390x/tcg: avoid overflows in
 time2tod/tod2time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On 25.06.2018 13:53, David Hildenbrand wrote:
> Big values for the TOD/ns clock can result in some overflows that can be
> avoided. Not all overflows can be handled however, as the conversion either
> multiplies by 4.096 or divided by 4.096.
> 
> Apply the trick used in the Linux kernel in arch/s390/include/asm/timex.h
> for tod_to_ns() and use the same trick also for the conversion in the
> other direction.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/internal.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/target/s390x/internal.h b/target/s390x/internal.h
> index e392a02d12..6cf63340bf 100644
> --- a/target/s390x/internal.h
> +++ b/target/s390x/internal.h
> @@ -243,13 +243,14 @@ enum cc_op {
>  /* Converts ns to s390's clock format */
>  static inline uint64_t time2tod(uint64_t ns)
>  {
> -    return (ns << 9) / 125;
> +    return (ns << 9) / 125 + (((ns & 0xff10000000000000ull) / 125) << 9);
> +
>  }
>  
>  /* Converts s390's clock format to ns */
>  static inline uint64_t tod2time(uint64_t t)
>  {
> -    return (t * 125) >> 9;
> +    return ((t >> 9) * 125) + (((t & 0x1ff) * 125) >> 9);
>  }
>  
>  static inline hwaddr decode_basedisp_s(CPUS390XState *env, uint32_t ipb,
> 

Looks reasonable.

Reviewed-by: Thomas Huth <thuth@redhat.com>
