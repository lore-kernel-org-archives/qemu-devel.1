Received: from eggs.gnu.org ([2001:4830:134:3::10]:53532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fY8Pp-0007ly-Ai
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:15:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fY8Pm-0008CI-4z
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:15:13 -0400
References: <20180625115352.6889-1-david@redhat.com>
	<20180625115352.6889-7-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <60957ff4-f1cb-1bde-2243-87d00e23b929@redhat.com>
Date: Wed, 27 Jun 2018 13:15:04 +0200
MIME-Version: 1.0
In-Reply-To: <20180625115352.6889-7-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v3 6/9] s390x/tcg: SET CLOCK
 COMPARATOR can clear CKC interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>

On 25.06.2018 13:53, David Hildenbrand wrote:
> Let's stop the timer and delete any pending CKC IRQ before doing
> anything else.
> 
> While at it, add a comment while the check for ckc == -1ULL is needed.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/misc_helper.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
> index be341b5295..4872bdd774 100644
> --- a/target/s390x/misc_helper.c
> +++ b/target/s390x/misc_helper.c
> @@ -156,6 +156,13 @@ void HELPER(sckc)(CPUS390XState *env, uint64_t time)
>      S390TODClass *tdc = S390_TOD_GET_CLASS(td);
>      S390TOD tod_base;
>  
> +    /* stop the timer and remove pending CKC IRQs */
> +    timer_del(env->tod_timer);
> +    qemu_mutex_lock_iothread();
> +    env->pending_int &= ~INTERRUPT_EXT_CLOCK_COMPARATOR;
> +    qemu_mutex_unlock_iothread();
> +
> +    /* the tod has to exceed the ckc, this can never happen if ckc is all 1's */
>      if (time == -1ULL) {
>          return;
>      }
> 

With the commit message ("while" -> "why") fixed:

Reviewed-by: Thomas Huth <thuth@redhat.com>
