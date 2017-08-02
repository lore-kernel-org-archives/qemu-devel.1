Received: from eggs.gnu.org ([2001:4830:134:3::10]:49877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dcstm-0000nk-1k
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 08:37:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dcsti-0000Ti-4C
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 08:37:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55470)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dcsth-0000TN-QL
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 08:37:10 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 69183C047B61
	for <qemu-devel@nongnu.org>; Wed,  2 Aug 2017 12:37:08 +0000 (UTC)
Date: Wed, 2 Aug 2017 13:37:02 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170802123701.GJ4098@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170728121040.631-1-otubo@redhat.com>
	<20170728121040.631-4-otubo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170728121040.631-4-otubo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 3/6] seccomp: add elevateprivileges
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
Cc: qemu-devel@nongnu.org, thuth@redhat.com, pbonzini@redhat.com

On Fri, Jul 28, 2017 at 02:10:37PM +0200, Eduardo Otubo wrote:
> This patch introduces the new argument
> [,elevateprivileges=allow|deny|children] to the `-sandbox on'. It allows
> or denies Qemu process to elevate its privileges by blacklisting all
> set*uid|gid system calls. The 'children' option will let forks and
> execves run unprivileged.
> 
> Signed-off-by: Eduardo Otubo <otubo@redhat.com>
> ---
>  include/sysemu/seccomp.h |  1 +
>  qemu-options.hx          |  9 ++++++---
>  qemu-seccomp.c           | 29 +++++++++++++++++++++++++++++
>  vl.c                     | 22 ++++++++++++++++++++++
>  4 files changed, 58 insertions(+), 3 deletions(-)
> 
> diff --git a/include/sysemu/seccomp.h b/include/sysemu/seccomp.h
> index 7a7bde246b..e6e78d85ce 100644
> --- a/include/sysemu/seccomp.h
> +++ b/include/sysemu/seccomp.h
> @@ -16,6 +16,7 @@
>  #define QEMU_SECCOMP_H
>  
>  #define OBSOLETE    0x0001
> +#define PRIVILEGED  0x0010

Err, this is hex, but you seem to be treating it as a binary
string. It would be better expressed as

  #define OBSOLETE    (1 << 0)
  #define PRIVILEGED  (1 << 1)
  #define ....        (1 << 2)
  #define ....        (1 << 3)
  #define ....        (1 << 4)


>  
> +        value = qemu_opt_get(opts, "elevateprivileges");
> +        if (value) {
> +            if (strcmp(value, "deny") == 0) {
> +                seccomp_opts |= PRIVILEGED;
> +            }
> +            if (strcmp(value, "children") == 0) {
> +                seccomp_opts |= PRIVILEGED;
> +
> +                /* calling prctl directly because we're
> +                 * not sure if host has CAP_SYS_ADMIN set*/
> +                if (prctl(PR_SET_NO_NEW_PRIVS, 1)) {
> +                    error_report("failed to set no_new_privs "
> +                                 "aborting");
> +                }

The prctl() really ought to be done in seccomp_start IMHO.

> +            }

Also it should report an error for invalid 'value' strings.

> +        }
> +
>          if (seccomp_start(seccomp_opts) < 0) {
>              error_report("failed to install seccomp syscall filter "
>                           "in the kernel");
> -- 
> 2.13.3
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
