Received: from eggs.gnu.org ([2001:4830:134:3::10]:56602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dNw0e-0004Ln-Fn
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 02:54:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dNw0a-0000LS-HP
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 02:54:32 -0400
Received: from mga07.intel.com ([134.134.136.100]:54407)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1dNw0a-0000LD-70
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 02:54:28 -0400
Date: Thu, 22 Jun 2017 14:54:16 +0800
From: Zhong Yang <yang.zhong@intel.com>
Message-ID: <20170622065416.GA28944@yangzhon-Virtual>
References: <1498040401-16361-1-git-send-email-yang.zhong@intel.com>
	<1498040401-16361-3-git-send-email-yang.zhong@intel.com>
	<40825889-8af3-c757-81eb-60c7226f8ec7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40825889-8af3-c757-81eb-60c7226f8ec7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 02/15] vl: add CONFIG_TCG for tcg related
 code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, a.rigo@virtualopensystems.com, anthony.xu@intel.com, yang.zhong@intel.com

On Wed, Jun 21, 2017 at 03:10:36PM +0200, Paolo Bonzini wrote:
> 
> 
> On 21/06/2017 12:19, Yang Zhong wrote:
> > @@ -3738,8 +3738,13 @@ int main(int argc, char **argv, char **envp)
> >                  }
> >                  break;
> >               case QEMU_OPTION_no_kvm:
> > +#ifdef CONFIG_TCG
> >                  olist = qemu_find_opts("machine");
> >                  qemu_opts_parse_noisily(olist, "accel=tcg", false);
> > +#else
> > +                error_report("TCG is disabled");
> 
> This should not be necessary, it would work anyway.
> 
  Hello Paolo,

  You are right, i justly did the test to verify your comment, i will remove this CONFIG_TCG. thanks!

  Yang

> > +                exit(1);
> > +#endif
> >                  break;
> >              case QEMU_OPTION_no_kvm_pit: {
> >                  error_report("warning: ignoring deprecated option");
> > @@ -3915,10 +3920,15 @@ int main(int argc, char **argv, char **envp)
> >                  configure_rtc(opts);
> >                  break;
> >              case QEMU_OPTION_tb_size:
> > +#ifdef CONFIG_TCG
> >                  tcg_tb_size = strtol(optarg, NULL, 0);
> >                  if (tcg_tb_size < 0) {
> >                      tcg_tb_size = 0;
> >                  }
> > +#else
> > +                error_report("TCG is disabled");
> > +                exit(1);
> > +#endif
> 
> This would regress the case where people are using -tb-size with KVM.
> Just leave it aside.
> 
  Hello Paolo,

  The tb_size is only useful in TCG mode, only tcg_init() will call this variable.
  If TCG is disabled in compile, the KVM will not need this variable. Of course, if
  we keep this variable in pure KVM mode, there is not any side effect. What's your 
  opinion? thanks!

  Yang 

> >                  break;
> >              case QEMU_OPTION_icount:
> >                  icount_opts = qemu_opts_parse_noisily(qemu_find_opts("icount"),
> > @@ -4457,7 +4467,9 @@ int main(int argc, char **argv, char **envp)
> >          qemu_opts_del(icount_opts);
> >      }
> >  
> > +#ifdef CONFIG_TCG
> >      qemu_tcg_configure(accel_opts, &error_fatal);
> 
> Why is this appearing in this patch?
> 
  Hello Paolo,

  If the TCG is disabled, the qemu_tcg_configure() is not useful, this function only set
  the single or mutiple thread for TCG. thanks!

  Yang

> > +#endif
