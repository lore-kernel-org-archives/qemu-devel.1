Received: from eggs.gnu.org ([2001:4830:134:3::10]:46416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fXn7c-0000d8-B2
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 08:31:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fXn7b-0002uo-EU
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 08:31:00 -0400
Date: Tue, 26 Jun 2018 14:30:53 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180626143053.2438548c.cohuck@redhat.com>
In-Reply-To: <20180625115352.6889-7-david@redhat.com>
References: <20180625115352.6889-1-david@redhat.com>
	<20180625115352.6889-7-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 6/9] s390x/tcg: SET CLOCK COMPARATOR can
 clear CKC interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>

On Mon, 25 Jun 2018 13:53:49 +0200
David Hildenbrand <david@redhat.com> wrote:

> Let's stop the timer and delete any pending CKC IRQ before doing
> anything else.
> 
> While at it, add a comment while the check for ckc == -1ULL is needed.

s/while/why/

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
