Received: from eggs.gnu.org ([2001:4830:134:3::10]:46765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fPoFG-0005qH-Gk
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 08:05:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fPoFE-00034J-6O
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 08:05:54 -0400
Date: Mon, 4 Jun 2018 14:05:47 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180604140547.68c95e17.cohuck@redhat.com>
In-Reply-To: <20180525113708.29856-6-david@redhat.com>
References: <20180525113708.29856-1-david@redhat.com>
	<20180525113708.29856-6-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 5/7] s390x/tcg: implement SET CLOCK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>, "Jason J . Herne" <jjherne@linux.ibm.com>, "Collin L . Walling" <walling@linux.ibm.com>

On Fri, 25 May 2018 13:37:06 +0200
David Hildenbrand <david@redhat.com> wrote:

> This allows a guest to change its TOD. We already take care of updating
> all CKC timers from within S390TODClass.
> 
> Use MO_ALIGN to load the operand manually - this will properly trigger a
> SPECIFICATION exception.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.h      |  1 +
>  target/s390x/insn-data.def |  3 +--
>  target/s390x/misc_helper.c | 19 +++++++++++++++++++
>  target/s390x/translate.c   |  9 +++++++++
>  4 files changed, 30 insertions(+), 2 deletions(-)
> 

> diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
> index 2ef9de1cca..2f5cd6d22a 100644
> --- a/target/s390x/misc_helper.c
> +++ b/target/s390x/misc_helper.c
> @@ -191,6 +191,25 @@ void tcg_s390_tod_updated(CPUState *cs, run_on_cpu_data opaque)
>      helper_sckc(env, env->ckc);
>  }
>  
> +/* Set Clock */
> +uint32_t HELPER(sck)(CPUS390XState *env, uint64_t tod_low)
> +{
> +    S390TODState *td = s390_get_tod();
> +    S390TODClass *tdc = S390_TOD_GET_CLASS(td);

Would it make sense to cache the class as well?

> +    S390TOD tod = {
> +        .high = 0,
> +        .low = tod_low,
> +    };
> +    Error *err = NULL;
> +
> +    qemu_mutex_lock_iothread();
> +    tdc->set(td, &tod, &err);
> +    qemu_mutex_unlock_iothread();
> +    g_assert(!err);
> +
> +    return 0;
> +}
> +
