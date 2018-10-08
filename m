Received: from eggs.gnu.org ([2001:4830:134:3::10]:38452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1g9TWF-0002xX-0M
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 07:16:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1g9TSz-0005lY-M3
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 07:12:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39434)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1g9TSz-0005l6-Cy
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 07:12:49 -0400
Date: Mon, 8 Oct 2018 12:12:44 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181008111244.GC2355@work-vm>
References: <20181006091816.7659-1-liq3ea@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181006091816.7659-1-liq3ea@163.com>
Subject: Re: [Qemu-devel] [PATCH] target/i386: kvm: just return after
 migrate_add_blocker failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@163.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org

* Li Qiang (liq3ea@163.com) wrote:
> When migrate_add_blocker failed, the invtsc_mig_blocker is not
> appended so no need to remove. This can save several instructions.
> 
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>  target/i386/kvm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 0b2a07d3a4..6ba84a39f3 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -1153,7 +1153,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
>              if (local_err) {
>                  error_report_err(local_err);
>                  error_free(invtsc_mig_blocker);
> -                goto fail;
> +                return r;

So I think that's OK, however, I wonder if fail: should be
doing some more cleanup?
For example, I notice we've added cpu_update_state to the change state
handler's before that point, should that be removed?

Dave

>              }
>              /* for savevm */
>              vmstate_x86_cpu.unmigratable = 1;
> -- 
> 2.17.1
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
