Received: from eggs.gnu.org ([2001:4830:134:3::10]:39645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cSzuM-0004C4-6g
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 00:32:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cSzuJ-0006Wd-2i
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 00:32:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57518)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cSzuI-0006WN-T1
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 00:32:39 -0500
Date: Mon, 16 Jan 2017 13:32:34 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170116053234.GB16076@lemon>
References: <20170115100334.15694-1-lma@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170115100334.15694-1-lma@suse.com>
Subject: Re: [Qemu-devel] [PATCH] Makefile: Fix owner and group for
 qemu-version.h.tmp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lin Ma <lma@suse.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com

On Sun, 01/15 18:03, Lin Ma wrote:
> By commit 67a1de0d, When we perform 'git pull && make && sudo make install',
> In 'make' stage a qemu-version.h.tmp will be generated. If the content of
> qemu-version.h.tmp and qemu-version.h aren't consistent, The qemu-version.h.tmp
> will be renamed to qemu-version.h. Because of the target FORCE, The same action
> will be do again in 'make install' stage.
> 
> In 'make install' stage, If there is no qemu-version.h.tmp exists and we run
> 'make install' with sudo, The owner and group of new qemu-version.h.tmp will be
> privileged user/group. When we run 'make' next time, qemu-version.h.tmp can't
> be overwrited because of permission issue.

s/overwrited/overwritten/

Otherwise, the change looks fine to me.

Reviewed-by: Fam Zheng <famz@redhat.com>

> 
> This patch uses 'cp' instead of 'mv' to keep the qemu-version.h.tmp file, So
> during the 'sudo make install' stage, new qemu-version.h.tmp's owner and group
> wont be set to privileged user/group.
> 
> Signed-off-by: Lin Ma <lma@suse.com>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 1a8bfb2..1ca45b2 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -184,7 +184,7 @@ qemu-version.h: FORCE
>  				printf '""\n'; \
>  			fi; \
>  		fi) > $@.tmp)
> -	$(call quiet-command, cmp -s $@ $@.tmp || mv $@.tmp $@)
> +	$(call quiet-command, cmp -s $@ $@.tmp || cp $@.tmp $@)
>  
>  config-host.h: config-host.h-timestamp
>  config-host.h-timestamp: config-host.mak
> -- 
> 2.9.2
> 
> 
