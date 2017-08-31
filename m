Received: from eggs.gnu.org ([2001:4830:134:3::10]:56471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dnLr9-0007ml-Is
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 05:33:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dnLr6-0006qm-Fe
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 05:33:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39664)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dnLr6-0006q1-8c
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 05:33:44 -0400
Date: Thu, 31 Aug 2017 11:33:40 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170831113340.7b437fa7.cohuck@redhat.com>
In-Reply-To: <20170830163609.50260-4-pasic@linux.vnet.ibm.com>
References: <20170830163609.50260-1-pasic@linux.vnet.ibm.com>
	<20170830163609.50260-4-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/9] s390x/css: be more consistent if
 broken beyond repair
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On Wed, 30 Aug 2017 18:36:03 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> If we detect that the internally manged state of the subchannel
> is broken beyond repair while in do_subchannel_work in case of
> virtual we just abort the operation and pretend all went well,
> while in case of pass-through we honor the situation with -ENODEV
> which results in cc 3 for the instruction whose handler triggered
> the call.
> 
> Let's be consistent on this and do the -ENODEV also for virtual
> subchannels.
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Acked-by: Pierre Morel<pmorel@linux.vnet.ibm.com>
> ---
>  hw/s390x/css.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index 0822538cde..bc47bf5b20 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -1078,7 +1078,7 @@ int do_subchannel_work_virtual(SubchDev *sch)
>          sch_handle_start_func_virtual(sch);
>      } else {
>          /* Cannot happen. */
> -        return 0;
> +        return -ENODEV;

No, this _really_ cannot happen. fctl is a three-bit field, which means
that one of the branches above must have executed. fctl cannot be 0, as
any caller of do_subchannel_work() either sets a bit there or, in the
case of rsch, checks for a bit already set. This is an internal error,
so an assert seems more suitable here. [We might need to keep the
return to keep mingw happy.]

>      }
>      css_inject_io_interrupt(sch);
>      return 0;
