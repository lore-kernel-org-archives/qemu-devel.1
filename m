Received: from eggs.gnu.org ([2001:4830:134:3::10]:33478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.vnet.ibm.com>) id 1dGTYC-0006Ec-Ea
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:06:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.vnet.ibm.com>) id 1dGTY9-00046K-83
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:06:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32842)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.vnet.ibm.com>)
	id 1dGTY8-00044u-UT
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:06:17 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v51H3nB1118395
	for <qemu-devel@nongnu.org>; Thu, 1 Jun 2017 13:06:14 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2atnkbc27e-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 01 Jun 2017 13:06:14 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.vnet.ibm.com>;
	Thu, 1 Jun 2017 13:06:13 -0400
Reply-To: jjherne@linux.vnet.ibm.com
References: <20170531193434.6918-1-david@redhat.com>
	<20170531193434.6918-3-david@redhat.com>
From: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
Date: Thu, 1 Jun 2017 13:06:07 -0400
MIME-Version: 1.0
In-Reply-To: <20170531193434.6918-3-david@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <e70d08bd-bf75-4997-df7b-e64710046fc3@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1 2/2] s390x/cpumodel: improve defintion
 search without an IBC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Aurelien Jarno <aurelien@aurel32.net>, rth@twiddle.net

On 05/31/2017 03:34 PM, David Hildenbrand wrote:
> Currently, under z/VM on a 0x2827, QEMU will detect a 0x2828 if no
> IBC value is provided. QEMU will simply take the last model of that HW
> generation, which happens to be the BC version.
>
> Let's improve our search for that case by selecting the latest CPU
> definition that matches the CPU type. This might still detect e.g. a
> GA2 version on a GA1 system, but as we don't have further information at
> hand, there isn't too much we can do about it.
>

Isn't it better to choose the earliest machine possible in this case? 
Systems
are backwards compatible far more often than they are forwards compatible.

Said in a more verbose way, I'd rather pretend to be a GA1 on a GA2 
(ignoring
some new features) than pretend to be a GA2 on a GA1 and attempt to use
something that does not exist.

I'm sure you've thought of all of this though, so what am I missing?


> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu_models.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index 9e23535..b6220c8 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -184,6 +184,7 @@ const S390CPUDef *s390_find_cpu_def(uint16_t type, uint8_t gen, uint8_t ec_ga,
>                                      S390FeatBitmap features)
>  {
>      const S390CPUDef *last_compatible = NULL;
> +    const S390CPUDef *matching_cpu_type = NULL;
>      int i;
>
>      if (!gen) {
> @@ -218,8 +219,16 @@ const S390CPUDef *s390_find_cpu_def(uint16_t type, uint8_t gen, uint8_t ec_ga,
>          if (def->type == type && def->ec_ga == ec_ga) {
>              return def;
>          }
> +        /* remember if we've at least seen one with the same cpu type */
> +        if (def->type == type) {
> +            matching_cpu_type = def;
> +        }
>          last_compatible = def;
>      }
> +    /* prefer the model with the same cpu type, esp. don't take the BC for EC */
> +    if (matching_cpu_type) {
> +        return matching_cpu_type;
> +    }
>      return last_compatible;
>  }
>

-- 
-- Jason J. Herne (jjherne@linux.vnet.ibm.com)
