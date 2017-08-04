Received: from eggs.gnu.org ([2001:4830:134:3::10]:46803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ddTWv-0004ze-VT
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 23:44:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ddTWr-0001kd-09
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 23:44:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57660)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ddTWq-0001gd-NI
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 23:44:00 -0400
Date: Fri, 4 Aug 2017 11:43:50 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170804034350.GD5561@pxdev.xzpeter.org>
References: <1501229198-30588-1-git-send-email-peterx@redhat.com>
	<1501229198-30588-13-git-send-email-peterx@redhat.com>
	<20170801094715.GE2079@work-vm>
	<20170802050610.GD15080@pxdev.xzpeter.org>
	<20170803140356.GC3673@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170803140356.GC3673@work-vm>
Subject: Re: [Qemu-devel] [RFC 12/29] migration: allow dst vm pause on
 postcopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

On Thu, Aug 03, 2017 at 03:03:57PM +0100, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > On Tue, Aug 01, 2017 at 10:47:16AM +0100, Dr. David Alan Gilbert wrote:
> > > * Peter Xu (peterx@redhat.com) wrote:
> > 
> > [...]
> > 
> > > > +/* Return true if we should continue the migration, or false. */
> > > > +static bool postcopy_pause_incoming(MigrationIncomingState *mis)
> > > > +{
> > > > +    trace_postcopy_pause_incoming();
> > > > +
> > > > +    migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
> > > > +                      MIGRATION_STATUS_POSTCOPY_PAUSED);
> > > > +
> > > > +    assert(mis->from_src_file);
> > > > +    qemu_file_shutdown(mis->from_src_file);
> > > > +    qemu_fclose(mis->from_src_file);
> > > > +    mis->from_src_file = NULL;
> > > > +
> > > > +    assert(mis->to_src_file);
> > > > +    qemu_mutex_lock(&mis->rp_mutex);
> > > > +    qemu_file_shutdown(mis->to_src_file);
> > > > +    qemu_fclose(mis->to_src_file);
> > > > +    mis->to_src_file = NULL;
> > > > +    qemu_mutex_unlock(&mis->rp_mutex);
> > > 
> > > Hmm is that safe?  If we look at migrate_send_rp_message we have:
> > > 
> > >     static void migrate_send_rp_message(MigrationIncomingState *mis,
> > >                                         enum mig_rp_message_type message_type,
> > >                                         uint16_t len, void *data)
> > >     {
> > >         trace_migrate_send_rp_message((int)message_type, len);
> > >         qemu_mutex_lock(&mis->rp_mutex);
> > >         qemu_put_be16(mis->to_src_file, (unsigned int)message_type);
> > >         qemu_put_be16(mis->to_src_file, len);
> > >         qemu_put_buffer(mis->to_src_file, data, len);
> > >         qemu_fflush(mis->to_src_file);
> > >         qemu_mutex_unlock(&mis->rp_mutex);
> > >     }
> > > 
> > > If we came into postcopy_pause_incoming at about the same time
> > > migrate_send_rp_message was being called and pause_incoming took the
> > > lock first, then once it release the lock, send_rp_message carries on
> > > and uses mis->to_src_file that's now NULL.
> > > 
> > > One solution here is to just call qemu_file_shutdown() but leave the
> > > files open at this point, but clean the files up sometime later.
> > 
> > I see the commnent on patch 14 as well - yeah, we need patch 14 to
> > co-op here, and as long as we are with patch 14, we should be ok.
> > 
> > > 
> > > > +
> > > > +    while (mis->state == MIGRATION_STATUS_POSTCOPY_PAUSED) {
> > > > +        qemu_sem_wait(&mis->postcopy_pause_sem_dst);
> > > > +    }
> > > > +
> > > > +    trace_postcopy_pause_incoming_continued();
> > > > +
> > > > +    return true;
> > > > +}
> > > > +
> > > >  static int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis)
> > > >  {
> > > >      uint8_t section_type;
> > > >      int ret = 0;
> > > >  
> > > > +retry:
> > > >      while (true) {
> > > >          section_type = qemu_get_byte(f);
> > > >  
> > > > @@ -2004,6 +2034,21 @@ static int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis)
> > > >  out:
> > > >      if (ret < 0) {
> > > >          qemu_file_set_error(f, ret);
> > > > +
> > > > +        /*
> > > > +         * Detect whether it is:
> > > > +         *
> > > > +         * 1. postcopy running
> > > > +         * 2. network failure (-EIO)
> > > > +         *
> > > > +         * If so, we try to wait for a recovery.
> > > > +         */
> > > > +        if (mis->state == MIGRATION_STATUS_POSTCOPY_ACTIVE &&
> > > > +            ret == -EIO && postcopy_pause_incoming(mis)) {
> > > > +            /* Reset f to point to the newly created channel */
> > > > +            f = mis->from_src_file;
> > > > +            goto retry;
> > > > +        }
> > > 
> > > I wonder if:
> > > 
> > >            if (mis->state == MIGRATION_STATUS_POSTCOPY_ACTIVE &&
> > >                ret == -EIO && postcopy_pause_incoming(mis)) {
> > >                /* Try again after postcopy recovery */
> > >                return qemu_loadvm_state_main(mis->from_src_file, mis);
> > >            }
> > > would be nicer; it avoids the goto loop.
> > 
> > I agree we should avoid using goto loops. However I do see vast usages
> > of goto like this one when we want to redo part of the procedures of a
> > function (or, of course, when handling errors in "C-style").
> 
> We mostly use them to jump forward to an error exit; only rarely do
> we do loops with them;  so if we can sensibly avoid them it's best.
> 
> > Calling qemu_loadvm_state_main() inside itself is ok as well, but it
> > also has defect: stack usage would be out of control, or even, it can
> > be controled by malicious users. E.g., if someone used program to
> > periodically stop/start any network endpoint along the migration
> > network, QEMU may go into a paused -> recovery -> active -> paused ...
> > loop, and stack usage will just grow with time. I'd say it's an
> > extreme example though...
> 
> I think it's safe because it's a tail-call so a new stack frame isn't
> needed.

I tried it and dumped the assembly, looks like even with tail-call, we
didn't really avoid the "callq":

(gdb) disassemble qemu_loadvm_state_main
Dump of assembler code for function qemu_loadvm_state_main:
   0x00000000005d9ff8 <+0>:     push   %rbp
   0x00000000005d9ff9 <+1>:     mov    %rsp,%rbp
   0x00000000005d9ffc <+4>:     sub    $0x20,%rsp
   0x00000000005da000 <+8>:     mov    %rdi,-0x18(%rbp)
   0x00000000005da004 <+12>:    mov    %rsi,-0x20(%rbp)
   0x00000000005da008 <+16>:    movl   $0x0,-0x4(%rbp)
   0x00000000005da00f <+23>:    mov    -0x18(%rbp),%rax
   0x00000000005da013 <+27>:    mov    %rax,%rdi
   0x00000000005da016 <+30>:    callq  0x5e185e <qemu_get_byte>

[...]

   0x00000000005da135 <+317>:   jne    0x5da165 <qemu_loadvm_state_main+365>
   0x00000000005da137 <+319>:   cmpl   $0xfffffffb,-0x4(%rbp)
   0x00000000005da13b <+323>:   jne    0x5da165 <qemu_loadvm_state_main+365>
   0x00000000005da13d <+325>:   mov    -0x20(%rbp),%rax
   0x00000000005da141 <+329>:   mov    %rax,%rdi
   0x00000000005da144 <+332>:   callq  0x5d9eb4 <postcopy_pause_incoming>
   0x00000000005da149 <+337>:   test   %al,%al
   0x00000000005da14b <+339>:   je     0x5da165 <qemu_loadvm_state_main+365>
   0x00000000005da14d <+341>:   mov    -0x20(%rbp),%rax
   0x00000000005da151 <+345>:   mov    (%rax),%rax
   0x00000000005da154 <+348>:   mov    -0x20(%rbp),%rdx
   0x00000000005da158 <+352>:   mov    %rdx,%rsi
   0x00000000005da15b <+355>:   mov    %rax,%rdi
   0x00000000005da15e <+358>:   callq  0x5d9ff8 <qemu_loadvm_state_main>
                                ^^^^^^^^^^^^^^^ (this one)
   0x00000000005da163 <+363>:   jmp    0x5da168 <qemu_loadvm_state_main+368>
   0x00000000005da165 <+365>:   mov    -0x4(%rbp),%eax
   0x00000000005da168 <+368>:   leaveq
   0x00000000005da169 <+369>:   retq

Do we need extra compilation parameters to achieve the tail-call
optimization for gcc? My gcc version is: v6.1.1 20160621.

(even with extra flags, I am still a bit worried on whether it'll work
 on the other compilers though)

And, the "label-way" to retry is indeed used widely at least in both
QEMU and Linux kernel. I tried to directly grep "^retry:" (so we are
ignoring the same usage using different label names), there are ~30
usage in QEMU and hundreds of cases in Linux kernel. So not sure
whether this can be seen as another "legal" way to use C labels...

Thanks,

-- 
Peter Xu
