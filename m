Received: from eggs.gnu.org ([2001:4830:134:3::10]:40638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dNfPB-0000yg-E1
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 09:10:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dNfP7-0006Oq-Cf
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 09:10:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52448)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dNfP7-0006Nv-6g
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 09:10:41 -0400
References: <1498040401-16361-1-git-send-email-yang.zhong@intel.com>
	<1498040401-16361-3-git-send-email-yang.zhong@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <40825889-8af3-c757-81eb-60c7226f8ec7@redhat.com>
Date: Wed, 21 Jun 2017 15:10:36 +0200
MIME-Version: 1.0
In-Reply-To: <1498040401-16361-3-git-send-email-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Yang Zhong <yang.zhong@intel.com>
Cc: qemu-devel@nongnu.org, a.rigo@virtualopensystems.com, anthony.xu@intel.com



On 21/06/2017 12:19, Yang Zhong wrote:
> @@ -3738,8 +3738,13 @@ int main(int argc, char **argv, char **envp)
>                  }
>                  break;
>               case QEMU_OPTION_no_kvm:
> +#ifdef CONFIG_TCG
>                  olist = qemu_find_opts("machine");
>                  qemu_opts_parse_noisily(olist, "accel=tcg", false);
> +#else
> +                error_report("TCG is disabled");

This should not be necessary, it would work anyway.

> +                exit(1);
> +#endif
>                  break;
>              case QEMU_OPTION_no_kvm_pit: {
>                  error_report("warning: ignoring deprecated option");
> @@ -3915,10 +3920,15 @@ int main(int argc, char **argv, char **envp)
>                  configure_rtc(opts);
>                  break;
>              case QEMU_OPTION_tb_size:
> +#ifdef CONFIG_TCG
>                  tcg_tb_size = strtol(optarg, NULL, 0);
>                  if (tcg_tb_size < 0) {
>                      tcg_tb_size = 0;
>                  }
> +#else
> +                error_report("TCG is disabled");
> +                exit(1);
> +#endif

This would regress the case where people are using -tb-size with KVM.
Just leave it aside.

>                  break;
>              case QEMU_OPTION_icount:
>                  icount_opts = qemu_opts_parse_noisily(qemu_find_opts("icount"),
> @@ -4457,7 +4467,9 @@ int main(int argc, char **argv, char **envp)
>          qemu_opts_del(icount_opts);
>      }
>  
> +#ifdef CONFIG_TCG
>      qemu_tcg_configure(accel_opts, &error_fatal);

Why is this appearing in this patch?

> +#endif
