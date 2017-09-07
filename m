Received: from eggs.gnu.org ([2001:4830:134:3::10]:43487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dptaP-0002fa-Qc
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 05:59:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dptaL-0007gl-41
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 05:59:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41004)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dptaK-0007gC-Ri
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 05:58:57 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DE069C047B67
	for <qemu-devel@nongnu.org>; Thu,  7 Sep 2017 09:58:55 +0000 (UTC)
Date: Thu, 7 Sep 2017 10:58:51 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170907095851.GG30609@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170901105818.31956-1-otubo@redhat.com>
	<20170901105818.31956-4-otubo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170901105818.31956-4-otubo@redhat.com>
Subject: Re: [Qemu-devel] [PATCHv4 3/6] seccomp: add elevateprivileges
 argument to command line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Otubo <otubo@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com

On Fri, Sep 01, 2017 at 12:58:15PM +0200, Eduardo Otubo wrote:
> This patch introduces the new argument
> [,elevateprivileges=allow|deny|children] to the `-sandbox on'. It allows
> or denies Qemu process to elevate its privileges by blacklisting all
> set*uid|gid system calls. The 'children' option will let forks and
> execves run unprivileged.
> 
> Signed-off-by: Eduardo Otubo <otubo@redhat.com>
> ---
>  include/sysemu/seccomp.h |  1 +
>  qemu-options.hx          | 12 +++++++++---
>  qemu-seccomp.c           | 29 ++++++++++++++++++-----------
>  vl.c                     | 27 +++++++++++++++++++++++++++
>  4 files changed, 55 insertions(+), 14 deletions(-)


> diff --git a/vl.c b/vl.c
> index ca267f9918..1d44b05772 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -29,6 +29,7 @@
>  
>  #ifdef CONFIG_SECCOMP
>  #include "sysemu/seccomp.h"
> +#include "sys/prctl.h"
>  #endif
>  
>  #if defined(CONFIG_VDE)
> @@ -275,6 +276,10 @@ static QemuOptsList qemu_sandbox_opts = {
>              .name = "obsolete",
>              .type = QEMU_OPT_STRING,
>          },
> +        {
> +            .name = "elevateprivileges",
> +            .type = QEMU_OPT_STRING,
> +        },
>          { /* end of list */ }
>      },
>  };
> @@ -1052,6 +1057,28 @@ static int parse_sandbox(void *opaque, QemuOpts *opts, Error **errp)
>  	    }
>          }
>  
> +        value = qemu_opt_get(opts, "elevateprivileges");
> +        if (value) {
> +            if (strcmp(value, "deny") == 0) {
> +                seccomp_opts |= QEMU_SECCOMP_SET_PRIVILEGED;
> +            } else if (strcmp(value, "children") == 0) {
> +                seccomp_opts |= QEMU_SECCOMP_SET_PRIVILEGED;
> +
> +                /* calling prctl directly because we're
> +                 * not sure if host has CAP_SYS_ADMIN set*/
> +                if (prctl(PR_SET_NO_NEW_PRIVS, 1)) {
> +                    error_report("failed to set no_new_privs "
> +                                 "aborting");
> +                    return -1;
> +                }
> +            } else if (strcmp(value, "allow") == 0) {
> +                /* default value */

Again slight preference for g_str_equal() in all these checks.


> +            } else {
> +                error_report("invalid argument for elevateprivileges");
> +                return -1;
> +            }
> +        }
> +
>          if (seccomp_start(seccomp_opts) < 0) {
>              error_report("failed to install seccomp syscall filter "
>                           "in the kernel");

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
