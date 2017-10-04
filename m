Received: from eggs.gnu.org ([2001:4830:134:3::10]:34609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dzeJ8-0004i6-7N
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 03:41:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dzeJ7-0006BZ-4K
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 03:41:30 -0400
Date: Wed, 4 Oct 2017 09:41:16 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171004094116.7537e74e.cohuck@redhat.com>
In-Reply-To: <d64ca97ec0058b24002c387264654b4b322ad7a1.1506730372.git.alistair.francis@xilinx.com>
References: <cover.1506730372.git.alistair.francis@xilinx.com>
	<d64ca97ec0058b24002c387264654b4b322ad7a1.1506730372.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 47/47] target: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-devel@nongnu.org, alistair23@gmail.com, armbru@redhat.com, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Michael Walle <michael@walle.cc>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org

On Fri, 29 Sep 2017 17:17:26 -0700
Alistair Francis <alistair.francis@xilinx.com> wrote:

> Replace a large number of the fprintf(stderr, "*\n" calls with
> error_report(). The functions were renamed with these commands and then
> compiler issues where manually fixed.

> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index ebb75cafaa..6f7ebd1c98 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -967,13 +967,13 @@ static void inject_vcpu_irq_legacy(CPUState *cs, struct kvm_s390_irq *irq)
>  
>      r = s390_kvm_irq_to_interrupt(irq, &kvmint);
>      if (r < 0) {
> -        fprintf(stderr, "%s called with bogus interrupt\n", __func__);
> +        error_report("%s called with bogus interrupt", __func__);
>          exit(1);
>      }
>  
>      r = kvm_vcpu_ioctl(cs, KVM_S390_INTERRUPT, &kvmint);
>      if (r < 0) {
> -        fprintf(stderr, "KVM failed to inject interrupt\n");
> +        error_report("KVM failed to inject interrupt");
>          exit(1);
>      }
>  }
> @@ -1002,13 +1002,13 @@ static void __kvm_s390_floating_interrupt(struct kvm_s390_irq *irq)
>  
>      r = s390_kvm_irq_to_interrupt(irq, &kvmint);
>      if (r < 0) {
> -        fprintf(stderr, "%s called with bogus interrupt\n", __func__);
> +        error_report("%s called with bogus interrupt", __func__);
>          exit(1);
>      }
>  
>      r = kvm_vm_ioctl(kvm_state, KVM_S390_INTERRUPT, &kvmint);
>      if (r < 0) {
> -        fprintf(stderr, "KVM failed to inject interrupt\n");
> +        error_report("KVM failed to inject interrupt");
>          exit(1);
>      }
>  }
> @@ -1116,14 +1116,14 @@ static int handle_b2(S390CPU *cpu, struct kvm_run *run, uint8_t ipa1)
>          break;
>      case PRIV_B2_TSCH:
>          /* We should only get tsch via KVM_EXIT_S390_TSCH. */
> -        fprintf(stderr, "Spurious tsch intercept\n");
> +        error_report("Spurious tsch intercept");
>          break;
>      case PRIV_B2_CHSC:
>          ioinst_handle_chsc(cpu, run->s390_sieic.ipb);
>          break;
>      case PRIV_B2_TPI:
>          /* This should have been handled by kvm already. */
> -        fprintf(stderr, "Spurious tpi intercept\n");
> +        error_report("Spurious tpi intercept");
>          break;
>      case PRIV_B2_SCHM:
>          ioinst_handle_schm(cpu, env->regs[1], env->regs[2],
> @@ -2050,15 +2050,15 @@ static int handle_intercept(S390CPU *cpu)
>              }
>              break;
>          case ICPT_SOFT_INTERCEPT:
> -            fprintf(stderr, "KVM unimplemented icpt SOFT\n");
> +            error_report("KVM unimplemented icpt SOFT");
>              exit(1);
>              break;
>          case ICPT_IO:
> -            fprintf(stderr, "KVM unimplemented icpt IO\n");
> +            error_report("KVM unimplemented icpt IO");
>              exit(1);
>              break;
>          default:
> -            fprintf(stderr, "Unknown intercept code: %d\n", icpt_code);
> +            error_report("Unknown intercept code: %d", icpt_code);
>              exit(1);
>              break;
>      }
> @@ -2215,7 +2215,7 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
>              ret = kvm_arch_handle_debug_exit(cpu);
>              break;
>          default:
> -            fprintf(stderr, "Unknown KVM exit: %d\n", run->exit_reason);
> +            error_report("Unknown KVM exit: %d", run->exit_reason);
>              break;
>      }
>      qemu_mutex_unlock_iothread();
> diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
> index 293fc8428a..395872af45 100644
> --- a/target/s390x/misc_helper.c
> +++ b/target/s390x/misc_helper.c
> @@ -354,7 +354,7 @@ uint32_t HELPER(sigp)(CPUS390XState *env, uint64_t order_code, uint32_t r1,
>  #endif
>      default:
>          /* unknown sigp */
> -        fprintf(stderr, "XXX unknown sigp: 0x%" PRIx64 "\n", order_code);
> +        error_report("XXX unknown sigp: 0x%" PRIx64 "", order_code);
>          cc = SIGP_CC_NOT_OPERATIONAL;
>      }
>  

There might be some clashes with David's patches (haven't checked), but
that depends on what goes in first anyway. So, for the s390x parts:

Acked-by: Cornelia Huck <cohuck@redhat.com>
