Received: from eggs.gnu.org ([2001:4830:134:3::10]:37194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1g8RBP-0001vz-Hc
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 10:34:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1g8R7c-0001uo-Ou
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 10:30:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37280)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1g8R7c-0001ea-Hp
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 10:30:28 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 47E9180F8F
	for <qemu-devel@nongnu.org>; Fri,  5 Oct 2018 14:30:20 +0000 (UTC)
Date: Fri, 5 Oct 2018 16:30:12 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181005163012.01bb7e73.cohuck@redhat.com>
In-Reply-To: <1538748792-19444-1-git-send-email-thuth@redhat.com>
References: <1538748792-19444-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] accel: Improve selection of the default
 accelerator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On Fri,  5 Oct 2018 16:13:12 +0200
Thomas Huth <thuth@redhat.com> wrote:

> When compiling with "--disable-tcg", we currently still use "tcg"
> as default accelerator. "kvm" should be used in this case instead.
> Also, some downstream distros provide QEMU binaries which have "kvm"
> in their names (e.g. "qemu-kvm" on RHEL or "kvm" on Ubuntu) that use
> KVM by default - and some users might want to do something similar
> with upstream binaries, too. Accomodate them by using "kvm:tcg" as
> default when we detect such a binary name.

Heh, we haven't had that discussion for some time ;)

> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  accel/accel.c          | 18 +++++++++++++++---
>  include/sysemu/accel.h |  2 +-
>  vl.c                   |  2 +-
>  3 files changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/accel/accel.c b/accel/accel.c
> index 966b2d8..9be195c 100644
> --- a/accel/accel.c
> +++ b/accel/accel.c
> @@ -68,7 +68,7 @@ static int accel_init_machine(AccelClass *acc, MachineState *ms)
>      return ret;
>  }
>  
> -void configure_accelerator(MachineState *ms)
> +void configure_accelerator(MachineState *ms, const char *progname)
>  {
>      const char *accel;
>      char **accel_list, **tmp;
> @@ -79,8 +79,20 @@ void configure_accelerator(MachineState *ms)
>  
>      accel = qemu_opt_get(qemu_get_machine_opts(), "accel");
>      if (accel == NULL) {
> -        /* Use the default "accelerator", tcg */
> -        accel = "tcg";
> +        /* Select the default accelerator */
> +        int pnlen = strlen(progname);
> +        if (pnlen >= 3 && g_str_equal(&progname[pnlen - 3], "kvm")) {
> +            /* If the program name ends with "kvm", we prefer KVM */
> +            accel = "kvm:tcg";

Ends, or also starts?

(In general, that approach probably makes more sense than the current
default.)

> +        } else {
> +#if defined(CONFIG_TCG)
> +            accel = "tcg";
> +#elif defined(CONFIG_KVM)
> +            accel = "kvm";
> +#else
> +#error "No default accelerator available"

So, we can't configure a qemu with neither tcg nor kvm, but for example
with hax or xen? (Is that possible today?)

> +#endif
> +        }
>      }
>  
>      accel_list = g_strsplit(accel, ":", 0);

ISTR that we had a suggestion last time that we should provide
qemu-kvm, qemu-tcg, etc. binaries...
