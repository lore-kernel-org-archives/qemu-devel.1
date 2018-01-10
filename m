Received: from eggs.gnu.org ([2001:4830:134:3::10]:43710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1eZ4Du-0004yt-Kl
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 19:26:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1eZ4Dt-0007h6-PG
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 19:26:30 -0500
Message-ID: <1515543979.1993.15.camel@gmail.com>
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Wed, 10 Jan 2018 11:26:19 +1100
In-Reply-To: <ec42a7c1-47f9-ff57-8bdc-bd8d26d9a522@linux.vnet.ibm.com>
References: <20180109092103.18458-1-sjitindarsingh@gmail.com>
	<20180109092103.18458-4-sjitindarsingh@gmail.com>
	<ec42a7c1-47f9-ff57-8bdc-bd8d26d9a522@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
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
To: Murilo Opsfelder =?ISO-8859-1?Q?Ara=FAjo?= <muriloo@linux.vnet.ibm.com>, qemu-ppc@nongnu.org
Cc: paulus@ozlabs.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au

On Tue, 2018-01-09 at 09:19 -0200, Murilo Opsfelder Araújo wrote:
> On 01/09/2018 07:21 AM, Suraj Jitindar Singh wrote:
> > The new H-Call H_GET_CPU_CHARACTERISTICS is used by the guest to
> > query
> > behaviours and available characteristics of the cpu.
> > 
> > Implement the handler for this new H-Call which formulates its
> > response
> > based on the setting of the new capabilities added in the previous
> > patch.
> > 
> > Note: Currently we return H_FUNCTION under TCG which will direct
> > the
> >       guest to fall back to doing a displacement flush
> > 
> > Discussion:
> > Is TCG affected?
> > Is there any point in telling the guest to do these workarounds on
> > TCG
> > given they're unlikely to translate to host instructions which have
> > the
> > desired effect?
> 
> Hi, Suraj.
> 
> What if this is left to the cover letter?

Again, only because this is RFC.

> 
> > ---
> >  hw/ppc/spapr_hcall.c   | 81
> > ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  include/hw/ppc/spapr.h |  1 +
> >  2 files changed, 82 insertions(+)
> > 
> > diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> > index 51eba52e86..b62b47c8d9 100644
> > --- a/hw/ppc/spapr_hcall.c
> > +++ b/hw/ppc/spapr_hcall.c
> > @@ -1654,6 +1654,84 @@ static target_ulong
> > h_client_architecture_support(PowerPCCPU *cpu,
> >      return H_SUCCESS;
> >  }
> > 
> > +#define CPU_CHARACTERISTIC_SPEC_BARRIER         (1ULL << (63 - 0))
> > +#define CPU_CHARACTERISTIC_BCCTR_SERIAL         (1ULL << (63 - 1))
> > +#define CPU_CHARACTERISTIC_ORI_L1_CACHE         (1ULL << (63 - 2))
> > +#define CPU_CHARACTERISTIC_MTTRIG_L1_CACHE      (1ULL << (63 - 3))
> > +#define CPU_CHARACTERISTIC_L1_CACHE_PRIV        (1ULL << (63 - 4))
> > +#define CPU_CHARACTERISTIC_BRANCH_HINTS         (1ULL << (63 - 5))
> > +#define CPU_CHARACTERISTIC_MTTRIG_THR_RECONF    (1ULL << (63 - 6))
> > +#define CPU_BEHAVIOUR_FAVOUR_SECURITY           (1ULL << (63 - 0))
> > +#define CPU_BEHAVIOUR_L1_CACHE_FLUSH            (1ULL << (63 - 1))
> > +#define CPU_BEHAVIOUR_SPEC_BARRIER              (1ULL << (63 - 2))
> 
> Can PPC_BIT be used here?

Yep, will do

> 
> Cheers
> Murilo
> 
