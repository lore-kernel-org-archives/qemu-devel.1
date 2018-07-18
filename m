Received: from eggs.gnu.org ([2001:4830:134:3::10]:43458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ffg8O-0000tx-Qq
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 02:40:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ffg8L-00063e-P3
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 02:40:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47128 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ffg8L-000619-Jw
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 02:40:21 -0400
Date: Wed, 18 Jul 2018 14:40:15 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180718064015.GI20520@xz-mi>
References: <20180717222721.14019.27548.stgit@gimli.home>
	<20180717224737.14019.3324.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180717224737.14019.3324.stgit@gimli.home>
Subject: Re: [Qemu-devel] [RFC PATCH 1/3] balloon: Allow nested inhibits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org

On Tue, Jul 17, 2018 at 04:47:37PM -0600, Alex Williamson wrote:
> A simple true/false internal state does not allow multiple users.  Fix
> this within the existing interface by converting to a counter, so long
> as the counter is elevated, ballooning is inhibited.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  balloon.c |    7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/balloon.c b/balloon.c
> index 6bf0a9681377..2a6a7e1a22a0 100644
> --- a/balloon.c
> +++ b/balloon.c
> @@ -37,16 +37,17 @@
>  static QEMUBalloonEvent *balloon_event_fn;
>  static QEMUBalloonStatus *balloon_stat_fn;
>  static void *balloon_opaque;
> -static bool balloon_inhibited;
> +static int balloon_inhibited;
>  
>  bool qemu_balloon_is_inhibited(void)
>  {
> -    return balloon_inhibited;
> +    return balloon_inhibited > 0;
>  }
>  
>  void qemu_balloon_inhibit(bool state)
>  {
> -    balloon_inhibited = state;
> +    balloon_inhibited += (state ? 1 : -1);
> +    assert(balloon_inhibited >= 0);

Better do it atomically?

>  }
>  
>  static bool have_balloon(Error **errp)
> 
> 

Regards,

-- 
Peter Xu
