Received: from eggs.gnu.org ([2001:4830:134:3::10]:53874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gRQkJ-0004SC-Jx
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 18:56:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gRQkG-0003kA-FC
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 18:56:55 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:48107)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gRQkG-0003k4-8d
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 18:56:52 -0500
Date: Mon, 26 Nov 2018 18:56:49 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181126235649.GB22108@flamenco>
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-11-cota@braap.org>
	<874lc9hwe5.fsf@linaro.org> <20181123231948.GB13782@flamenco>
	<87tvk43xfq.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tvk43xfq.fsf@linaro.org>
Subject: Re: [Qemu-devel] [RFC 10/48] exec: export do_tb_flush
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>

On Mon, Nov 26, 2018 at 11:11:53 +0000, Alex Bennée wrote:
> 
> Emilio G. Cota <cota@braap.org> writes:
> 
> > On Thu, Nov 22, 2018 at 17:09:22 +0000, Alex Bennée wrote:
> >>
> >> Emilio G. Cota <cota@braap.org> writes:
> >>
> >> > This will be used by plugin code to flush the code cache as well
> >> > as doing other bookkeeping in a safe work environment.
> >>
> >> This seems a little excessive given the plugin code could just call
> >> tb_flush() directly. Wouldn't calling tb_flush after scheduling the
> >> plugin_destroy be enough?
> >>
> >> If there is a race condition here maybe we could build some sort of
> >> awareness into tb_flush as to the current run state. But having two
> >> entry points to this rather fundamental action seems likely to either be
> >> misused or misunderstood.
> >
> > We have to make sure that no callback left in the generated code is
> > called once a plugin has been uninstalled. To me, using the same safe
> > work window to both flush the TB and uninstall the plugin seems the
> > simplest way to do this.
> 
> I still think making tb_flush() aware that it can run in an exclusive
> period would be a better solution than exposing two functions for the
> operation. So tb_flush could be something like:
> 
>   void tb_flush(CPUState *cpu)
>   {
>       if (tcg_enabled()) {
>           unsigned tb_flush_count = atomic_mb_read(&tb_ctx.tb_flush_count);
>           if (cpu_current_and_exclusive(cpu)) {
>               do_tb_flush(RUN_ON_CPU_HOST_INT(tb_flush_count))
>           } else {
>               async_safe_run_on_cpu(cpu, do_tb_flush,
>                                     RUN_ON_CPU_HOST_INT(tb_flush_count));
>           }
>       }
>   }
> 
> Or possibly push that logic down into async_safe_run_on_cpu()?

The latter option would be much harder, because in async_safe_run_on_cpu
we always queue the work and kick the CPU (which could be ourselves).
IOW the job is always asynchronous, as the name implies.

I've thus implemented the former in v2, as follows (I'm using a hole
in struct CPUState to add the bool):

@@ -1277,8 +1277,13 @@ void tb_flush(CPUState *cpu)
 {
     if (tcg_enabled()) {
         unsigned tb_flush_count = atomic_mb_read(&tb_ctx.tb_flush_count);
-        async_safe_run_on_cpu(cpu, do_tb_flush,
-                              RUN_ON_CPU_HOST_INT(tb_flush_count));
+
+        if (cpu_in_exclusive_work_context(cpu)) {
+            do_tb_flush(cpu, RUN_ON_CPU_HOST_INT(tb_flush_count));
+        } else {
+            async_safe_run_on_cpu(cpu, do_tb_flush,
+                                  RUN_ON_CPU_HOST_INT(tb_flush_count));
+        }
     }
 }

+++ b/cpus-common.c
@@ -386,7 +386,9 @@ static void process_queued_cpu_work_locked(CPUState *cpu)
                 qemu_mutex_unlock_iothread();
             }
             start_exclusive();
+            cpu->in_exclusive_work_context = true;
             wi->func(cpu, wi->data);
+            cpu->in_exclusive_work_context = false;
             end_exclusive();

I've also fixed a couple of unrelated bugs when uninstalling a plugin
with memory callbacks enabled.

Thanks,

		Emilio
