Received: from eggs.gnu.org ([2001:4830:134:3::10]:53867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dnjlp-0006Yr-7y
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:05:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dnjlk-00045f-In
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:05:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57104)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dnjlk-00045E-2w
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:05:48 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 27044C047B74
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 11:05:47 +0000 (UTC)
Date: Fri, 1 Sep 2017 12:05:41 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170901110541.GK31680@redhat.com>
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

> @@ -72,6 +85,14 @@ int seccomp_start(void)
>  
>      for (i = 0; i < ARRAY_SIZE(blacklist); i++) {
>          switch (blacklist[i].set) {
> +        case QEMU_SECCOMP_SET_OBSOLETE:
> +            if (!(seccomp_opts & QEMU_SECCOMP_SET_OBSOLETE)) {
> +                goto add_syscall;
> +            } else {
> +                continue;
> +            }
> +
> +            break;

THis can be simplified:

            if ((seccomp_opts & QEMU_SECCOMP_SET_OBSOLETE)) {
                continue;
            }

            break;

thus avoiding need to 'goto'

Likewise for all following patches

>          default:
>              goto add_syscall;
>          }

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
