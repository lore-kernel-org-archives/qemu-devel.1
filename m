Received: from eggs.gnu.org ([2001:4830:134:3::10]:37068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dxuAd-0006j2-J0
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 08:13:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dxuAa-0006Jq-DN
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 08:13:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43788)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dxuAa-0006JR-6j
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 08:13:28 -0400
Date: Fri, 29 Sep 2017 14:13:20 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170929141320.1becfd34.cohuck@redhat.com>
In-Reply-To: <d40ebe4f-5306-4810-db72-b148c1b2adcf@redhat.com>
References: <20170927170027.8539-1-david@redhat.com>
	<20170929134938.18fae231.cohuck@redhat.com>
	<d40ebe4f-5306-4810-db72-b148c1b2adcf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 0/3] s390x/tcg: LAP support using
 immediate TLB invalidation
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <richard.henderson@linaro.org>
List-ID: <qemu-devel.nongnu.org>

On Fri, 29 Sep 2017 14:09:04 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 29.09.2017 13:49, Cornelia Huck wrote:
> > On Wed, 27 Sep 2017 19:00:24 +0200
> > David Hildenbrand <david@redhat.com> wrote:
> >   
> >> Details about Low-Address Protection can be found in description of
> >> patch 1 and 2. It is basically a subpage protection of the first two
> >> pages of every address space (for which it is enabled).
> >>
> >> We can achieve this by simply directly invalidating the TLB entry and
> >> therefore forcing every write accesses onto these two pages into the slow
> >> path.
> >>
> >> With this patch, I can boot Linux just fine (which uses LAP). This also
> >> makes all related kvm-unit-tests that we have pass.
> >>
> >> The checks are working that good, that I discovered a STFL bug. STFL
> >> stores into the low addresses but low-address protection does explicitly
> >> not apply. The Linux kernel calls STFL while LAP is active. So without
> >> patch nr 3, booting Linux will fail. (this change is also part of a patch
> >> of my SMP series).  
> > 
> > I fear I have lost track a bit with all those patches floating around.
> > IIUC, patch 3 fixes a real bug that is only exposed by your LAP
> > changes. It used to be part of the stfl changes in v1 of your smp
> > series but is no longer in v2. So, is this a patch that can be applied
> > to current s390-next?
> >   
> 
> The SMP series is based on both, this series and the CPU cleanup series
> you already picked up.
> 
> You can apply Patch 3 with the following modified description (requested
> by Thomas):
> 
> 
> s390x/tcg: make STFL store into the lowcore
> 
> Using virtual memory access is wrong and will soon include low-address
> protection checks, which is to be bypassed for STFL.
> 
> STFL is a privileged instruction and using LowCore requires
> !CONFIG_USER_ONLY, so add the ifdef and move the declaration to the
> right place.
> 
> This was originally part of a bigger STFL(E) refactoring.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> 
> The other two patches, I will resend once we know how to handle the TLB
> invalidation.

OK, thanks for the clarification!
