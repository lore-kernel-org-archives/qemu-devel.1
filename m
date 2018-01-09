Received: from eggs.gnu.org ([2001:4830:134:3::10]:59841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <muriloo@linux.vnet.ibm.com>) id 1eYrws-0000px-LA
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 06:20:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <muriloo@linux.vnet.ibm.com>) id 1eYrwn-0002vk-Mk
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 06:20:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35562
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <muriloo@linux.vnet.ibm.com>)
	id 1eYrwn-0002vH-IG
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 06:20:01 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w09BJNvS069437
	for <qemu-devel@nongnu.org>; Tue, 9 Jan 2018 06:20:01 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fcvq4g81g-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 06:20:00 -0500
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <muriloo@linux.vnet.ibm.com>;
	Tue, 9 Jan 2018 06:20:00 -0500
References: <20180109092103.18458-1-sjitindarsingh@gmail.com>
	<20180109092103.18458-4-sjitindarsingh@gmail.com>
From: =?UTF-8?Q?Murilo_Opsfelder_Ara=c3=bajo?= <muriloo@linux.vnet.ibm.com>
Date: Tue, 9 Jan 2018 09:19:56 -0200
MIME-Version: 1.0
In-Reply-To: <20180109092103.18458-4-sjitindarsingh@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <ec42a7c1-47f9-ff57-8bdc-bd8d26d9a522@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [QEMU-PPC] [RFC 3/3] target/ppc: Add
 H-Call H_GET_CPU_CHARACTERISTICS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, qemu-ppc@nongnu.org
Cc: paulus@ozlabs.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au

On 01/09/2018 07:21 AM, Suraj Jitindar Singh wrote:
> The new H-Call H_GET_CPU_CHARACTERISTICS is used by the guest to query
> behaviours and available characteristics of the cpu.
> 
> Implement the handler for this new H-Call which formulates its response
> based on the setting of the new capabilities added in the previous
> patch.
> 
> Note: Currently we return H_FUNCTION under TCG which will direct the
>       guest to fall back to doing a displacement flush
> 
> Discussion:
> Is TCG affected?
> Is there any point in telling the guest to do these workarounds on TCG
> given they're unlikely to translate to host instructions which have the
> desired effect?

Hi, Suraj.

What if this is left to the cover letter?

> ---
>  hw/ppc/spapr_hcall.c   | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/hw/ppc/spapr.h |  1 +
>  2 files changed, 82 insertions(+)
> 
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 51eba52e86..b62b47c8d9 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1654,6 +1654,84 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
>      return H_SUCCESS;
>  }
> 
> +#define CPU_CHARACTERISTIC_SPEC_BARRIER         (1ULL << (63 - 0))
> +#define CPU_CHARACTERISTIC_BCCTR_SERIAL         (1ULL << (63 - 1))
> +#define CPU_CHARACTERISTIC_ORI_L1_CACHE         (1ULL << (63 - 2))
> +#define CPU_CHARACTERISTIC_MTTRIG_L1_CACHE      (1ULL << (63 - 3))
> +#define CPU_CHARACTERISTIC_L1_CACHE_PRIV        (1ULL << (63 - 4))
> +#define CPU_CHARACTERISTIC_BRANCH_HINTS         (1ULL << (63 - 5))
> +#define CPU_CHARACTERISTIC_MTTRIG_THR_RECONF    (1ULL << (63 - 6))
> +#define CPU_BEHAVIOUR_FAVOUR_SECURITY           (1ULL << (63 - 0))
> +#define CPU_BEHAVIOUR_L1_CACHE_FLUSH            (1ULL << (63 - 1))
> +#define CPU_BEHAVIOUR_SPEC_BARRIER              (1ULL << (63 - 2))

Can PPC_BIT be used here?

Cheers
Murilo
