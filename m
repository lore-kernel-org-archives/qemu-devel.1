Received: from eggs.gnu.org ([2001:4830:134:3::10]:42797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1d5V6Z-0001QD-0i
	for qemu-devel@nongnu.org; Tue, 02 May 2017 06:32:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1d5V6U-0007vh-52
	for qemu-devel@nongnu.org; Tue, 02 May 2017 06:32:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55423)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1d5V6T-0007u1-TH
	for qemu-devel@nongnu.org; Tue, 02 May 2017 06:32:22 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v42ASl0h123195
	for <qemu-devel@nongnu.org>; Tue, 2 May 2017 06:32:20 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a68vwj4v7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 06:32:19 -0400
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 2 May 2017 04:32:19 -0600
References: <1493719600-30853-1-git-send-email-thuth@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 2 May 2017 12:32:15 +0200
MIME-Version: 1.0
In-Reply-To: <1493719600-30853-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Message-Id: <52fc3efd-55a7-af2d-ce8c-9b4565dfe6dc@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] Deprecate '-enable-kvm' and '-enable-hax'
 in favour of '-accel'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vincent Palatin <vpalatin@chromium.org>

On 05/02/2017 12:06 PM, Thomas Huth wrote:
> The '-enable-...' option do not make too much sense: They do not
> allow additional parameters, using '-accel xxx' is shorter than
> '-enable-xxx' and we're also inconsistent here, since there is
> no '-enable-xen' option available. So let's try to convince the
> users to use '-accel xxx' instead.



google has 36000 hits for "--enable-kvm" and 18000 hits for "--accel kvm"
So I assume this will affect a lot of setups for only a very small benefit.


> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  qemu-options.hx | 5 +++--
>  vl.c            | 4 ++++
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/qemu-options.hx b/qemu-options.hx
> index c7b1d2d..eb33286 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -3367,7 +3367,8 @@ STEXI
>  @item -enable-kvm
>  @findex -enable-kvm
>  Enable KVM full virtualization support. This option is only available
> -if KVM support is enabled when compiling.
> +if KVM support is enabled when compiling. Note: This option is deprecated,
> +please use @code{-accel kvm} instead.
>  ETEXI
> 
>  DEF("enable-hax", 0, QEMU_OPTION_enable_hax, \
> @@ -3378,7 +3379,7 @@ STEXI
>  Enable HAX (Hardware-based Acceleration eXecution) support. This option
>  is only available if HAX support is enabled when compiling. HAX is only
>  applicable to MAC and Windows platform, and thus does not conflict with
> -KVM.
> +KVM. Note: This option is deprecated, please use @code{-accel hax} instead.
>  ETEXI
> 
>  DEF("xen-domid", HAS_ARG, QEMU_OPTION_xen_domid,
> diff --git a/vl.c b/vl.c
> index d5e88fb..d5ec87e 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -3690,10 +3690,14 @@ int main(int argc, char **argv, char **envp)
>                  }
>                  break;
>              case QEMU_OPTION_enable_kvm:
> +                error_report("'-enable-kvm' is depreacted, please use "
> +                             "'-accel kvm' instead");
>                  olist = qemu_find_opts("machine");
>                  qemu_opts_parse_noisily(olist, "accel=kvm", false);
>                  break;
>              case QEMU_OPTION_enable_hax:
> +                error_report("'-enable-hax' is depreacted, please use "
> +                             "'-accel hax' instead");
>                  olist = qemu_find_opts("machine");
>                  qemu_opts_parse_noisily(olist, "accel=hax", false);
>                  break;
> 
