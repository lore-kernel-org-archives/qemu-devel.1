Received: from eggs.gnu.org ([2001:4830:134:3::10]:53230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fQsta-0000fP-QA
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 07:15:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fQstZ-0003rj-BA
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 07:15:58 -0400
Date: Thu, 7 Jun 2018 13:15:52 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180607131552.03d2c508.cohuck@redhat.com>
In-Reply-To: <470c9e37-1e1b-a189-2ae2-9889860dde94@redhat.com>
References: <20180525113708.29856-1-david@redhat.com>
	<20180525113708.29856-6-david@redhat.com>
	<20180604140547.68c95e17.cohuck@redhat.com>
	<470c9e37-1e1b-a189-2ae2-9889860dde94@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1 5/7] s390x/tcg: implement
 SET CLOCK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: "Jason J . Herne" <jjherne@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, "Collin L . Walling" <walling@linux.ibm.com>, Richard Henderson <rth@twiddle.net>

On Thu, 7 Jun 2018 12:48:21 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 04.06.2018 14:05, Cornelia Huck wrote:
> > On Fri, 25 May 2018 13:37:06 +0200
> > David Hildenbrand <david@redhat.com> wrote:
> >   
> >> This allows a guest to change its TOD. We already take care of updating
> >> all CKC timers from within S390TODClass.
> >>
> >> Use MO_ALIGN to load the operand manually - this will properly trigger a
> >> SPECIFICATION exception.
> >>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >> ---
> >>  target/s390x/helper.h      |  1 +
> >>  target/s390x/insn-data.def |  3 +--
> >>  target/s390x/misc_helper.c | 19 +++++++++++++++++++
> >>  target/s390x/translate.c   |  9 +++++++++
> >>  4 files changed, 30 insertions(+), 2 deletions(-)
> >>  
> >   
> >> diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
> >> index 2ef9de1cca..2f5cd6d22a 100644
> >> --- a/target/s390x/misc_helper.c
> >> +++ b/target/s390x/misc_helper.c
> >> @@ -191,6 +191,25 @@ void tcg_s390_tod_updated(CPUState *cs, run_on_cpu_data opaque)
> >>      helper_sckc(env, env->ckc);
> >>  }
> >>  
> >> +/* Set Clock */
> >> +uint32_t HELPER(sck)(CPUS390XState *env, uint64_t tod_low)
> >> +{
> >> +    S390TODState *td = s390_get_tod();
> >> +    S390TODClass *tdc = S390_TOD_GET_CLASS(td);  
> > 
> > Would it make sense to cache the class as well?  
> 
> Probably, but I don't think this is as critical as the flic (as this
> code is TCG only and the class conversion should be fairly fast compared
> to a device lookup).

Yes, it probably does not matter that much. Do as you like :)
