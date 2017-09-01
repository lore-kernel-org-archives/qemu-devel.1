Received: from eggs.gnu.org ([2001:4830:134:3::10]:53428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dnjkb-0005P3-I2
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:04:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dnjkV-0003X2-Kv
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:04:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35834)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dnjkV-0003Wo-FA
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:04:31 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8E538267DF
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 11:04:30 +0000 (UTC)
Date: Fri, 1 Sep 2017 12:04:22 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170901110422.GJ31680@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170901105818.31956-1-otubo@redhat.com>
	<20170901105818.31956-2-otubo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170901105818.31956-2-otubo@redhat.com>
Subject: Re: [Qemu-devel] [PATCHv4 1/6] seccomp: changing from whitelist to
 blacklist
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

On Fri, Sep 01, 2017 at 12:58:13PM +0200, Eduardo Otubo wrote:
> This patch changes the default behavior of the seccomp filter from
> whitelist to blacklist. By default now all system calls are allowed and
> a small black list of definitely forbidden ones was created.
> 
> Signed-off-by: Eduardo Otubo <otubo@redhat.com>
> ---
>  include/sysemu/seccomp.h |   2 +
>  qemu-seccomp.c           | 264 ++++++-----------------------------------------
>  vl.c                     |   1 -
>  3 files changed, 35 insertions(+), 232 deletions(-)
> 
> diff --git a/include/sysemu/seccomp.h b/include/sysemu/seccomp.h
> index cfc06008cb..23b9c3c789 100644
> --- a/include/sysemu/seccomp.h
> +++ b/include/sysemu/seccomp.h

> +    for (i = 0; i < ARRAY_SIZE(blacklist); i++) {
> +        switch (blacklist[i].set) {
> +        default:
> +            goto add_syscall;

This goto rule is pointless - just use 'break'

>          }
> -        rc = seccomp_syscall_priority(ctx, seccomp_whitelist[i].num,
> -                                      seccomp_whitelist[i].priority);
> +add_syscall:
> +        rc = seccomp_rule_add(ctx, SCMP_ACT_KILL, blacklist[i].num, 0);
>          if (rc < 0) {
>              goto seccomp_return;
>          }

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
