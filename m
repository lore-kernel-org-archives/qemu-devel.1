Received: from eggs.gnu.org ([2001:4830:134:3::10]:42994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dptZ3-00023e-Bf
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 05:57:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dptYz-00077c-G0
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 05:57:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dptYz-00077K-9x
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 05:57:33 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 093BD61470
	for <qemu-devel@nongnu.org>; Thu,  7 Sep 2017 09:57:32 +0000 (UTC)
Date: Thu, 7 Sep 2017 10:57:25 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170907095725.GF30609@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170901105818.31956-1-otubo@redhat.com>
	<20170901105818.31956-3-otubo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170901105818.31956-3-otubo@redhat.com>
Subject: Re: [Qemu-devel] [PATCHv4 2/6] seccomp: add obsolete argument to
 command line
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

On Fri, Sep 01, 2017 at 12:58:14PM +0200, Eduardo Otubo wrote:
> This patch introduces the argument [,obsolete=allow] to the `-sandbox on'
> option. It allows Qemu to run safely on old system that still relies on
> old system calls.
> 
> Signed-off-by: Eduardo Otubo <otubo@redhat.com>
> ---
>  include/sysemu/seccomp.h |  3 ++-
>  qemu-options.hx          | 12 ++++++++++--
>  qemu-seccomp.c           | 23 ++++++++++++++++++++++-
>  vl.c                     | 22 +++++++++++++++++++++-
>  4 files changed, 55 insertions(+), 5 deletions(-)
> 

> @@ -1032,7 +1036,23 @@ static int parse_sandbox(void *opaque, QemuOpts *opts, Error **errp)
>  {
>      if (qemu_opt_get_bool(opts, "enable", false)) {
>  #ifdef CONFIG_SECCOMP
> -        if (seccomp_start() < 0) {
> +        uint32_t seccomp_opts = 0x00000;
> +        const char *value = NULL;
> +
> +        value = qemu_opt_get(opts, "obsolete");
> +        if (value) {
> +            if (strcmp(value, "allow") == 0) {

I would have a slight preference for g_str_equal(value, "allow")

> +                seccomp_opts |= QEMU_SECCOMP_SET_OBSOLETE;
> +            } else if (strcmp(value, "deny")) {

and  !g_str_equal(value, "deny")

> +                /* this is the default option, this if is here
> +		 * to provide a little bit of consistency for
> +		 * the command line */
> +	    } else {
> +		error_report("invalid argument for obsolete");
> +	    }

There seem to be tabs for indent here too

> +        }
> +
> +        if (seccomp_start(seccomp_opts) < 0) {
>              error_report("failed to install seccomp syscall filter "
>                           "in the kernel");
>              return -1;
> -- 
> 2.13.5
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
