Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC31C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 09:26:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4674B2068E
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 09:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GG15hS4L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4674B2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJCfN-0002sZ-6S
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 05:26:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46602)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kJCcL-0008Ds-NP
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 05:23:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26038)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kJCcJ-0004Lb-RS
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 05:23:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600421022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DHGWJXU6i5pp1p7TuHJthcB7MUd2QKUp8KmLLnakRws=;
 b=GG15hS4LlYfGD8g03V5Km/AqvHJlmv/eHmtXzuANlKn3+dYuFDtBBoln5Ef/fuG0WWh6be
 dYaJt2EAwN0ZmQynA8j6Mo2IpCaE54QZ5jwm3WNBre60kMS2cTWYw2fUBGohQ3232UL6cL
 ChQWZdI1gWrj43NCWcvvMBozEEJShEA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-QUh5J1KoOo6c2H2xIbjvjA-1; Fri, 18 Sep 2020 05:23:39 -0400
X-MC-Unique: QUh5J1KoOo6c2H2xIbjvjA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A620E81F004;
 Fri, 18 Sep 2020 09:23:37 +0000 (UTC)
Received: from work-vm (ovpn-114-196.ams2.redhat.com [10.36.114.196])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6AB5319D7C;
 Fri, 18 Sep 2020 09:23:31 +0000 (UTC)
Date: Fri, 18 Sep 2020 10:23:29 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v3 4/5] sev/i386: Don't allow a system reset under an
 SEV-ES guest
Message-ID: <20200918092329.GE2816@work-vm>
References: <cover.1600205384.git.thomas.lendacky@amd.com>
 <058dcb33a9cc223e3180133d29e7a92bfdc40938.1600205384.git.thomas.lendacky@amd.com>
 <20200917170119.GR2793@work-vm>
 <c54ec30c-21f6-db4f-72c4-b0825482a960@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c54ec30c-21f6-db4f-72c4-b0825482a960@amd.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Received-SPF: pass client-ip=216.205.24.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 01:32:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Brijesh Singh <brijesh.singh@amd.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Connor Kuehl <ckuehl@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Jiri Slaby <jslaby@suse.cz>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Tom Lendacky (thomas.lendacky@amd.com) wrote:
> On 9/17/20 12:01 PM, Dr. David Alan Gilbert wrote:
> > * Tom Lendacky (thomas.lendacky@amd.com) wrote:
> > > From: Tom Lendacky <thomas.lendacky@amd.com>
> > > 
> > > An SEV-ES guest does not allow register state to be altered once it has
> > > been measured. When a SEV-ES guest issues a reboot command, Qemu will
> > > reset the vCPU state and resume the guest. This will cause failures under
> > > SEV-ES, so prevent that from occurring.
> > > 
> > > Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> > > ---
> > >   accel/kvm/kvm-all.c       | 9 +++++++++
> > >   include/sysemu/cpus.h     | 2 ++
> > >   include/sysemu/hw_accel.h | 5 +++++
> > >   include/sysemu/kvm.h      | 2 ++
> > >   softmmu/cpus.c            | 5 +++++
> > >   softmmu/vl.c              | 5 ++++-
> > >   6 files changed, 27 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> > > index 20725b0368..63153b6e53 100644
> > > --- a/accel/kvm/kvm-all.c
> > > +++ b/accel/kvm/kvm-all.c
> > > @@ -2388,6 +2388,15 @@ void kvm_flush_coalesced_mmio_buffer(void)
> > >       s->coalesced_flush_in_progress = false;
> > >   }
> > > +bool kvm_cpu_check_resettable(void)
> > > +{
> > > +    /*
> > > +     * If we have a valid reset vector override, then SEV-ES is active
> > > +     * and the CPU can't be reset.
> > > +     */
> > > +    return !kvm_state->reset_valid;
> > 
> > This seems a bit weird since it's in generic rather than x86 specific
> > code.
> 
> I could push it down to arch specific code.

It seems best to me.

> Is there a way to do that
> without defining the function for all the other arches?

I don't know this interface too well.

Dave

> 
> Thanks,
> Tom
> 
> > 
> > Dave
> > 
> > > +}
> > > +
> > >   static void do_kvm_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
> > >   {
> > >       if (!cpu->vcpu_dirty) {
> > > diff --git a/include/sysemu/cpus.h b/include/sysemu/cpus.h
> > > index 3c1da6a018..6d688c757f 100644
> > > --- a/include/sysemu/cpus.h
> > > +++ b/include/sysemu/cpus.h
> > > @@ -24,6 +24,8 @@ void dump_drift_info(void);
> > >   void qemu_cpu_kick_self(void);
> > >   void qemu_timer_notify_cb(void *opaque, QEMUClockType type);
> > > +bool cpu_is_resettable(void);
> > > +
> > >   void cpu_synchronize_all_states(void);
> > >   void cpu_synchronize_all_post_reset(void);
> > >   void cpu_synchronize_all_post_init(void);
> > > diff --git a/include/sysemu/hw_accel.h b/include/sysemu/hw_accel.h
> > > index e128f8b06b..8b4536e7ae 100644
> > > --- a/include/sysemu/hw_accel.h
> > > +++ b/include/sysemu/hw_accel.h
> > > @@ -17,6 +17,11 @@
> > >   #include "sysemu/hvf.h"
> > >   #include "sysemu/whpx.h"
> > > +static inline bool cpu_check_resettable(void)
> > > +{
> > > +    return kvm_enabled() ? kvm_cpu_check_resettable() : true;
> > > +}
> > > +
> > >   static inline void cpu_synchronize_state(CPUState *cpu)
> > >   {
> > >       if (kvm_enabled()) {
> > > diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> > > index f74cfa85ab..eb94bbbff9 100644
> > > --- a/include/sysemu/kvm.h
> > > +++ b/include/sysemu/kvm.h
> > > @@ -494,6 +494,8 @@ int kvm_physical_memory_addr_from_host(KVMState *s, void *ram_addr,
> > >   #endif /* NEED_CPU_H */
> > > +bool kvm_cpu_check_resettable(void);
> > > +
> > >   void kvm_cpu_synchronize_state(CPUState *cpu);
> > >   void kvm_cpu_synchronize_post_reset(CPUState *cpu);
> > >   void kvm_cpu_synchronize_post_init(CPUState *cpu);
> > > diff --git a/softmmu/cpus.c b/softmmu/cpus.c
> > > index a802e899ab..32f286643f 100644
> > > --- a/softmmu/cpus.c
> > > +++ b/softmmu/cpus.c
> > > @@ -927,6 +927,11 @@ void hw_error(const char *fmt, ...)
> > >       abort();
> > >   }
> > > +bool cpu_is_resettable(void)
> > > +{
> > > +    return cpu_check_resettable();
> > > +}
> > > +
> > >   void cpu_synchronize_all_states(void)
> > >   {
> > >       CPUState *cpu;
> > > diff --git a/softmmu/vl.c b/softmmu/vl.c
> > > index 4eb9d1f7fd..422fbb1650 100644
> > > --- a/softmmu/vl.c
> > > +++ b/softmmu/vl.c
> > > @@ -1475,7 +1475,10 @@ void qemu_system_guest_crashloaded(GuestPanicInformation *info)
> > >   void qemu_system_reset_request(ShutdownCause reason)
> > >   {
> > > -    if (no_reboot && reason != SHUTDOWN_CAUSE_SUBSYSTEM_RESET) {
> > > +    if (!cpu_is_resettable()) {
> > > +        error_report("cpus are not resettable, terminating");
> > > +        shutdown_requested = reason;
> > > +    } else if (no_reboot && reason != SHUTDOWN_CAUSE_SUBSYSTEM_RESET) {
> > >           shutdown_requested = reason;
> > >       } else {
> > >           reset_requested = reason;
> > > -- 
> > > 2.28.0
> > > 
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


