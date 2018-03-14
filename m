Received: from eggs.gnu.org ([2001:4830:134:3::10]:44743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ewCsE-0007Ih-PR
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 16:19:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ewCsA-0001xw-5v
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 16:19:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42708 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ewCsA-0001xT-0m
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 16:19:42 -0400
Date: Wed, 14 Mar 2018 20:19:30 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180314201929.GK3006@work-vm>
References: <1520692378-1835-1-git-send-email-lidongchen@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520692378-1835-1-git-send-email-lidongchen@tencent.com>
Subject: Re: [Qemu-devel] [PATCH] migration: Fix rate limiting issue on RDMA
 migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lidong Chen <jemmy858585@gmail.com>
Cc: quintela@redhat.com, qemu-devel@nongnu.org, Lidong Chen <lidongchen@tencent.com>

* Lidong Chen (jemmy858585@gmail.com) wrote:
> RDMA migration implement save_page function for QEMUFile, but
> ram_control_save_page do not increase bytes_xfer. So when doing
> RDMA migration, it will use whole bandwidth.

Hi,
  Thanks for this,

> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
> ---
>  migration/qemu-file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> index 2ab2bf3..217609d 100644
> --- a/migration/qemu-file.c
> +++ b/migration/qemu-file.c
> @@ -253,7 +253,7 @@ size_t ram_control_save_page(QEMUFile *f, ram_addr_t block_offset,
>      if (f->hooks && f->hooks->save_page) {
>          int ret = f->hooks->save_page(f, f->opaque, block_offset,
>                                        offset, size, bytes_sent);
> -
> +        f->bytes_xfer += size;

I'm a bit confused, because I know rdma.c calls acct_update_position()
and I'd always thought that was enough.
That calls qemu_update_position(...) which increases f->pos but not
f->bytes_xfer.

f_pos is used to calculate the 'transferred' value in
migration_update_counters and thus the current bandwidth and downtime -
but as you say, not the rate_limit.

So really, should this f->bytes_xfer += size   go in
qemu_update_position ?

Juan: I'm not sure I know why we have both bytes_xfer and pos.

Dave

>          if (ret != RAM_SAVE_CONTROL_DELAYED) {
>              if (bytes_sent && *bytes_sent > 0) {
>                  qemu_update_position(f, *bytes_sent);
> -- 
> 1.8.3.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
