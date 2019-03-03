Received: from eggs.gnu.org ([209.51.188.92]:41671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1h0XJ9-0006J6-T1
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 15:02:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1h0X9a-0002CB-6F
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 14:52:06 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:38145)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1h0X9Z-000262-FP
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 14:52:06 -0500
Date: Sun, 3 Mar 2019 14:52:02 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20190303195202.GA12447@flamenco>
References: <20190130004811.27372-1-cota@braap.org>
	<20190130004811.27372-63-cota@braap.org>
	<877eeams4z.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877eeams4z.fsf@zen.linaroharston>
Subject: Re: [Qemu-devel] [PATCH v6 62/73] cpu: introduce
 cpu_has_work_with_iothread_lock
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

On Fri, Feb 08, 2019 at 11:33:32 +0000, Alex Bennée wrote:
> 
> Emilio G. Cota <cota@braap.org> writes:
> 
> > It will gain some users soon.
> >
> > Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> > Signed-off-by: Emilio G. Cota <cota@braap.org>
> > ---
> >  include/qom/cpu.h | 36 +++++++++++++++++++++++++++++++++---
(snip)
> >  static inline bool cpu_has_work(CPUState *cpu)
> >  {
> >      CPUClass *cc = CPU_GET_CLASS(cpu);
> > +    bool has_cpu_lock = cpu_mutex_locked(cpu);
> > +    bool (*func)(CPUState *cpu);
> >      bool ret;
> >
> > +    if (cc->has_work_with_iothread_lock) {
> > +        if (qemu_mutex_iothread_locked()) {
> > +            func = cc->has_work_with_iothread_lock;
> > +            goto call_func;
> > +        }
> > +
> > +        if (has_cpu_lock) {
> > +            /* avoid deadlock by acquiring the locks in order */
> 
> This is fine here but can we expand the comment above:
> 
>  * cpu_has_work:
>  * @cpu: The vCPU to check.
>  *
>  * Checks whether the CPU has work to do. If the vCPU helper needs to
>  * check it's work status with the BQL held ensure we hold the BQL
>  * before taking the CPU lock.

I added a comment to the body of the function:

+    /* some targets require us to hold the BQL when checking for work */
     if (cc->has_work_with_iothread_lock) {

> Where is our canonical description of the locking interaction between
> BQL and CPU locks?

It's in a few places, for instance cpu_mutex_lock's documentation
in include/qom/cpu.h.

I've added a comment about the locking order to @lock's documentation,
also in cpu.h:

- * @lock: Lock to prevent multiple access to per-CPU fields.
+ * @lock: Lock to prevent multiple access to per-CPU fields. Must be acqrd
+ *        after the BQL.

> Otherwise:
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

Thanks!

		Emilio
