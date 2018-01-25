Received: from eggs.gnu.org ([2001:4830:134:3::10]:36759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eehvq-0000sO-Nq
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:51:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eehvn-0008Hj-Lj
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:51:10 -0500
Date: Thu, 25 Jan 2018 14:51:00 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180125145100.5029d8c2.cohuck@redhat.com>
In-Reply-To: <438493f5-d66f-0bb6-4db2-59dd4d5b556e@redhat.com>
References: <20180117174047.6382-1-david@redhat.com>
	<20180117174047.6382-13-david@redhat.com>
	<20180125112659.3c08063d.cohuck@redhat.com>
	<438493f5-d66f-0bb6-4db2-59dd4d5b556e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 12/18] s390x: fix size + content of STSI
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

On Thu, 25 Jan 2018 14:15:45 +0100
David Hildenbrand <david@redhat.com> wrote:

> On 25.01.2018 11:26, Cornelia Huck wrote:
> > On Wed, 17 Jan 2018 18:40:41 +0100
> > David Hildenbrand <david@redhat.com> wrote:
> >   
> >> All blocks are 4k in size, which is only true for two of them right now.
> >> Also some reserved fields were wrong, fix it and convert all reserved
> >> fields to u8.
> >>
> >> This also fixes the LPAR part output in /proc/sysinfo under TCG. (for
> >> now, everything was indicated as 0)
> >>
> >> While at it, introduce typedefs for these structs and use it in KVM
> >> code. Not changing misc_helper.c as that will be overhauled soon.
> >>
> >> Reviewed-by: Thomas Huth <thuth@redhat.com>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >> ---
> >>  target/s390x/cpu.h | 46 ++++++++++++++++++++++++++--------------------
> >>  target/s390x/kvm.c |  2 +-
> >>  2 files changed, 27 insertions(+), 21 deletions(-)
> >>
> >> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> >> index b4a88830de..31593a5381 100644
> >> --- a/target/s390x/cpu.h
> >> +++ b/target/s390x/cpu.h
> >> @@ -436,29 +436,31 @@ static inline void setcc(S390CPU *cpu, uint64_t cc)
> >>  #define STSI_R1_SEL2_MASK       0x000000000000ffffULL
> >>  
> >>  /* Basic Machine Configuration */
> >> -struct sysib_111 {
> >> -    uint32_t res1[8];
> >> +typedef struct sysib_111 {
> >> +    uint8_t  res1[32];
> >>      uint8_t  manuf[16];
> >>      uint8_t  type[4];
> >>      uint8_t  res2[12];
> >>      uint8_t  model[16];
> >>      uint8_t  sequence[16];
> >>      uint8_t  plant[4];
> >> -    uint8_t  res3[156];
> >> -};
> >> +    uint8_t  res3[3996];
> >> +} sysib_111;  
> > 
> > Do you want to CamelCase this?  
> 
> "System-information block" "SysIB" ?

Looks good to me.

> 
> >   
> >> +QEMU_BUILD_BUG_ON(sizeof(sysib_111) != 4096);  
> 
> 
