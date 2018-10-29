Received: from eggs.gnu.org ([2001:4830:134:3::10]:47669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gH9tN-0002mh-CJ
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:55:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gH9tI-000206-H0
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:55:49 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:59423)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gH9tG-0001wI-HO
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:55:43 -0400
Date: Mon, 29 Oct 2018 11:55:36 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181029155536.GB17805@flamenco>
References: <20181025144644.15464-1-cota@braap.org> <874ld4ahji.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874ld4ahji.fsf@linaro.org>
Subject: Re: [Qemu-devel] [RFC v4 01/71] cpu: convert queued work to a
 QSIMPLEQ
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>

On Mon, Oct 29, 2018 at 15:39:29 +0000, Alex Bennée wrote:
> 
> Emilio G. Cota <cota@braap.org> writes:
(snip)
> > @@ -357,7 +357,7 @@ struct CPUState {
> >      sigjmp_buf jmp_env;
> >
> >      QemuMutex work_mutex;
> > -    struct qemu_work_item *queued_work_first, *queued_work_last;
> > +    QSIMPLEQ_HEAD(, qemu_work_item) work_list;
> 
> Would:
> 
>   QSIMPLEQ_HEAD(work_list, qemu_work_item);
> 
> be neater?

That would expand to

struct CPUState {
	...
	struct work_list {
		struct qemu_work_item *sqh_first;
		struct qemu_work_item **sqh_last;
	}; // <-- missing field name
	...
};

, which doesn't declare an actual field in the struct.

> > +static inline bool cpu_work_list_empty(CPUState *cpu)
> > +{
> > +    bool ret;
> > +
> > +    qemu_mutex_lock(&cpu->work_mutex);
> > +    ret = QSIMPLEQ_EMPTY(&cpu->work_list);
> > +    qemu_mutex_unlock(&cpu->work_mutex);
> > +    return ret;
> 
> This could just be:
> 
>   return QSIMPLEQ_EMPTY_ATOMIC(&cpu->work_list)

Not quite; (1) the non-RCU version of the list does not set
pointers with atomic_set, so an atomic_read here would not be enough,
and (2) using the lock ensures that the read is up-to-date. These
two points are not a big deal though, since later in the
series ("cpu: protect most CPU state with cpu->lock") we hold the
CPU lock when calling this.

> Otherwise:
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

Thanks!

		Emilio
