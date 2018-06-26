Received: from eggs.gnu.org ([2001:4830:134:3::10]:53270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fXpen-0005mL-F8
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 11:13:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fXpek-0000n9-1f
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 11:13:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44178 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fXpej-0000mX-SJ
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 11:13:21 -0400
Date: Tue, 26 Jun 2018 17:13:18 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180626171318.03045b07@redhat.com>
In-Reply-To: <20180626170212-mutt-send-email-mst@kernel.org>
References: <20180622192148.178309-1-mst@redhat.com>
	<20180622192148.178309-2-mst@redhat.com>
	<20180625114012.138c0416@redhat.com>
	<20180626170212-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 1/2] kvm: support -overcommit
 cpu-pm=on|off
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org

On Tue, 26 Jun 2018 17:06:12 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Jun 25, 2018 at 11:40:12AM +0200, Igor Mammedov wrote:
> > On Fri, 22 Jun 2018 22:22:05 +0300
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >   
> > > With this flag, kvm allows guest to control host CPU power state.  This
> > > increases latency for other processes using same host CPU in an
> > > unpredictable way, but if decreases idle entry/exit times for the
> > > running VCPU, so to use it QEMU needs a hint about whether host CPU is
> > > overcommitted, hence the flag name.
> > > 
> > > Follow-up patches will expose this capability to guest
> > > (using mwait leaf).
> > > 
> > > Based on a patch by Wanpeng Li <kernellwp@gmail.com> .
> > > 
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > ---
> > >  include/sysemu/sysemu.h |  1 +
> > >  target/i386/kvm.c       | 23 +++++++++++++++++++++++
> > >  vl.c                    | 32 +++++++++++++++++++++++++++++++-
> > >  qemu-options.hx         | 27 +++++++++++++++++++++++++--
> > >  4 files changed, 80 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> > > index e893f72f3b..b921c6f3b7 100644
> > > --- a/include/sysemu/sysemu.h
> > > +++ b/include/sysemu/sysemu.h
> > > @@ -128,6 +128,7 @@ extern bool boot_strict;
> > >  extern uint8_t *boot_splash_filedata;
> > >  extern size_t boot_splash_filedata_size;
> > >  extern bool enable_mlock;
> > > +extern bool enable_cpu_pm;
> > >  extern uint8_t qemu_extra_params_fw[2];
> > >  extern QEMUClockType rtc_clock;
> > >  extern const char *mem_path;
> > > diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> > > index 44f70733e7..cf9107be4b 100644
> > > --- a/target/i386/kvm.c
> > > +++ b/target/i386/kvm.c
> > > @@ -1357,6 +1357,29 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
> > >          smram_machine_done.notify = register_smram_listener;
> > >          qemu_add_machine_init_done_notifier(&smram_machine_done);
> > >      }
> > > +
> > > +    if (enable_cpu_pm) {
> > > +        int disable_exits = kvm_check_extension(s, KVM_CAP_X86_DISABLE_EXITS);
> > > +        int ret;
> > > +
> > > +/* Work around for kernel header with a typo. TODO: fix header and drop. */
> > > +#if defined(KVM_X86_DISABLE_EXITS_HTL) && !defined(KVM_X86_DISABLE_EXITS_HLT)
> > > +#define KVM_X86_DISABLE_EXITS_HLT KVM_X86_DISABLE_EXITS_HTL
> > > +#endif
> > > +        if (disable_exits) {
> > > +            disable_exits &= (KVM_X86_DISABLE_EXITS_MWAIT |
> > > +                              KVM_X86_DISABLE_EXITS_HLT |
> > > +                              KVM_X86_DISABLE_EXITS_PAUSE);
> > > +        }
> > > +
> > > +        ret = kvm_vm_enable_cap(s, KVM_CAP_X86_DISABLE_EXITS, 0,
> > > +                                disable_exits);
> > > +        if (ret < 0) {
> > > +            error_report("kvm: guest stopping CPU not supported: %s",
> > > +                         strerror(-ret));
> > > +        }
> > > +    }
> > > +
> > >      return 0;
> > >  }
> > >  
> > > diff --git a/vl.c b/vl.c
> > > index 06031715ac..c9530efed5 100644
> > > --- a/vl.c
> > > +++ b/vl.c
> > > @@ -142,6 +142,7 @@ ram_addr_t ram_size;
> > >  const char *mem_path = NULL;
> > >  int mem_prealloc = 0; /* force preallocation of physical target memory */
> > >  bool enable_mlock = false;
> > > +bool enable_cpu_pm = false;
> > >  int nb_nics;
> > >  NICInfo nd_table[MAX_NICS];
> > >  int autostart;
> > > @@ -390,6 +391,22 @@ static QemuOptsList qemu_realtime_opts = {
> > >      },
> > >  };
> > >  
> > > +static QemuOptsList qemu_overcommit_opts = {
> > > +    .name = "overcommit",
> > > +    .head = QTAILQ_HEAD_INITIALIZER(qemu_overcommit_opts.head),
> > > +    .desc = {
> > > +        {
> > > +            .name = "mem-lock",
> > > +            .type = QEMU_OPT_BOOL,
> > > +        },
> > > +        {
> > > +            .name = "cpu-pm",
> > > +            .type = QEMU_OPT_BOOL,
> > > +        },
> > > +        { /* end of list */ }
> > > +    },
> > > +};
> > > +
> > >  static QemuOptsList qemu_msg_opts = {
> > >      .name = "msg",
> > >      .head = QTAILQ_HEAD_INITIALIZER(qemu_msg_opts.head),
> > > @@ -3903,7 +3920,20 @@ int main(int argc, char **argv, char **envp)
> > >                  if (!opts) {
> > >                      exit(1);
> > >                  }
> > > -                enable_mlock = qemu_opt_get_bool(opts, "mlock", true);
> > > +                /* Don't override the -overcommit option if set */
> > > +                enable_mlock = enable_mlock ||
> > > +                    qemu_opt_get_bool(opts, "mlock", true);
> > > +                break;
> > > +            case QEMU_OPTION_overcommit:
> > > +                opts = qemu_opts_parse_noisily(qemu_find_opts("overcommit"),
> > > +                                               optarg, false);
> > > +                if (!opts) {
> > > +                    exit(1);
> > > +                }
> > > +                /* Don't override the -realtime option if set */
> > > +                enable_mlock = enable_mlock ||
> > > +                    qemu_opt_get_bool(opts, "mem-lock", false);
> > > +                enable_cpu_pm = qemu_opt_get_bool(opts, "cpu-pm", false);  
> > should we error out or complain if the option can't be used
> > /i.e. in case of non kvm accelerator/
> > instead of silently ignoring it
> > and making user wonder why it doesn't work?  
> 
> 
> Well it also only applies with -cpu host right now.
> And guest works fine, even if it's somewhat slower.
> 
> As there's no interface to discover which configurations
> work, I *suspect* it's easier for management if we keep guest
> running rather than fail and make it guess.

not perfect but better than nothing
if not kvm, we can bail out from:

+    if (xcc->host_cpuid_required && enable_cpu_pm) {
+        host_cpuid(5, 0, &cpu->mwait.eax, &cpu->mwait.ebx,
+                   &cpu->mwait.ecx, &cpu->mwait.edx);
+        env->features[FEAT_1_ECX] |= CPUID_EXT_MONITOR;
+    }

> 
> > >                  break;
> > >              case QEMU_OPTION_msg:
> > >                  opts = qemu_opts_parse_noisily(qemu_find_opts("msg"), optarg,
> > > diff --git a/qemu-options.hx b/qemu-options.hx
> > > index c0d3951e9f..1bba3d258b 100644
> > > --- a/qemu-options.hx
> > > +++ b/qemu-options.hx
> > > @@ -3328,8 +3328,7 @@ DEF("realtime", HAS_ARG, QEMU_OPTION_realtime,
> > >      "-realtime [mlock=on|off]\n"
> > >      "                run qemu with realtime features\n"
> > >      "                mlock=on|off controls mlock support (default: on)\n",
> > > -    QEMU_ARCH_ALL)
> > > -STEXI
> > > +    QEMU_ARCH_ALL) STEXI
> > >  @item -realtime mlock=on|off
> > >  @findex -realtime
> > >  Run qemu with realtime features.
> > > @@ -3337,6 +3336,30 @@ mlocking qemu and guest memory can be enabled via @option{mlock=on}
> > >  (enabled by default).
> > >  ETEXI
> > >  
> > > +DEF("overcommit", HAS_ARG, QEMU_OPTION_overcommit,
> > > +    "--overcommit [mem-lock=on|off][cpu-pm=on|off]\n"
> > > +    "                run qemu with overcommit hints\n"
> > > +    "                mem-lock=on|off controls memory lock support (default: off)\n"
> > > +    "                cpu-pm=on|off controls cpu power management (default: off)\n",
> > > +    QEMU_ARCH_ALL)
> > > +STEXI
> > > +@item -overcommit mem-lock=on|off
> > > +@item -overcommit cpu-pm=on|off
> > > +@findex -overcommit
> > > +Run qemu with hints about host resource overcommit. The default is
> > > +to assume that host overcommits all resources.
> > > +
> > > +Locking qemu and guest memory can be enabled via @option{mem-lock=on} (disabled
> > > +by default).  This works when host memory is not overcommitted and reduces the
> > > +worst-case latency for guest.  This is equivalent to @option{realtime}.
> > > +
> > > +Guest ability to manage power state of host cpus (increasing latency for other
> > > +processes on the same host cpu, but decreasing latency for guest) can be
> > > +enabled via @option{cpu-pm=on} (disabled by default).  This works best when
> > > +host CPU is not overcommitted. When used, host estimates of CPU cycle and power
> > > +utilization will be incorrect, not taking into account guest idle time.
> > > +ETEXI
> > > +
> > >  DEF("gdb", HAS_ARG, QEMU_OPTION_gdb, \
> > >      "-gdb dev        wait for gdb connection on 'dev'\n", QEMU_ARCH_ALL)
> > >  STEXI  
