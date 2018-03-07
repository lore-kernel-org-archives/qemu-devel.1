Received: from eggs.gnu.org ([2001:4830:134:3::10]:34054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1etZ3A-0007DM-S7
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 08:24:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1etZ35-0003zy-SN
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 08:24:08 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38360 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1etZ35-0003zp-NY
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 08:24:03 -0500
Date: Wed, 7 Mar 2018 14:23:52 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180307142352.586c49e1.cohuck@redhat.com>
In-Reply-To: <20180307130238.19358-1-pbonzini@redhat.com>
References: <20180307130238.19358-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] memory: fix flatview_access_valid RCU read
 lock/unlock imbalance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, intermediadc@hotmail.com

On Wed,  7 Mar 2018 14:02:38 +0100
Paolo Bonzini <pbonzini@redhat.com> wrote:

> Fixes: 11e732a5ed46903f997985bed4c3767ca28a7eb6
> Reported-by: Cornelia Huck <cohuck@redhat.com>
> Reported-by: luigi burdo <intermediadc@hotmail.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  exec.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/exec.c b/exec.c
> index 604f03c535..a9181e6417 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -3393,7 +3393,6 @@ static bool flatview_access_valid(FlatView *fv, hwaddr addr, int len,
>          if (!memory_access_is_direct(mr, is_write)) {
>              l = memory_access_size(mr, l, addr);
>              if (!memory_region_access_valid(mr, xlat, l, is_write)) {
> -                rcu_read_unlock();
>                  return false;
>              }
>          }

Thanks, that fixes master for me.

Tested-by: Cornelia Huck <cohuck@redhat.com>
