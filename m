Received: from eggs.gnu.org ([2001:4830:134:3::10]:54529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1elZzE-0000mT-At
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:47:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1elZz8-0003mn-KD
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:47:03 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40986 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1elZz8-0003mQ-GT
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:46:58 -0500
Date: Tue, 13 Feb 2018 12:46:49 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180213124649.GD2378@work-vm>
References: <807b2724-7a5f-9d62-55aa-b5b3cf0c9503@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <807b2724-7a5f-9d62-55aa-b5b3cf0c9503@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] monitor.c: Fix infinite loop in monitor's
 auto-complete functionality
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dimitris Karagkasidis <t.pageflt@gmail.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com

* Dimitris Karagkasidis (t.pageflt@gmail.com) wrote:
> The QEMU monitor enters an infinite loop when trying to auto-complete commands
> that accept only optional parameters. The commands currently affected by this
> issue are 'info registers' and 'info mtree'.
> 
> Signed-off-by: Dimitris Karagkasidis <t.pagef.lt@gmail.com>

Hi Dimitris,
  Thanks for that, I guess this has been broken since 48fe86f6.

Your patch does fix it, but I prefer a slightly different fix which I'll
post in a minute, which is a bit more robust to other things going
wrong.

Dave

> ---
>  monitor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/monitor.c b/monitor.c
> index f4992505b1..d8b7270d9b 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -3741,7 +3741,7 @@ static void monitor_find_completion_by_table(Monitor *mon,
>              }
>          }
>          str = args[nb_args - 1];
> -        while (*ptype == '-' && ptype[1] != '\0') {
> +        while (*ptype == '-' && ptype[2] != '\0') {
>              ptype = next_arg_type(ptype);
>          }
>          switch(*ptype) {
> -- 
> 2.14.1
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
