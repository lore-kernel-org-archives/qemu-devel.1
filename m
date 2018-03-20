Received: from eggs.gnu.org ([2001:4830:134:3::10]:36006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eyLqy-00019D-8P
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 14:19:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eyLqv-0002t8-2O
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 14:19:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55988 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eyLqu-0002sP-TX
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 14:19:16 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1520692378-1835-1-git-send-email-lidongchen@tencent.com> (Lidong
	Chen's message of "Sat, 10 Mar 2018 22:32:58 +0800")
References: <1520692378-1835-1-git-send-email-lidongchen@tencent.com>
Reply-To: quintela@redhat.com
Date: Tue, 20 Mar 2018 19:19:15 +0100
Message-ID: <87sh8uzk2k.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: dgilbert@redhat.com, qemu-devel@nongnu.org, Lidong Chen <lidongchen@tencent.com>

Lidong Chen <jemmy858585@gmail.com> wrote:
> RDMA migration implement save_page function for QEMUFile, but
> ram_control_save_page do not increase bytes_xfer. So when doing
> RDMA migration, it will use whole bandwidth.
>
> Signed-off-by: Lidong Chen <lidongchen@tencent.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

This part of the code is a mess.

To answer David:
- pos: Where we need to write that bit of stuff
- bytex_xfer: how much have we written

WHen we are doing snapshots on qcow2, we store memory in a contiguous
piece of memory, so we can "overwrite" that "page" if a new verion
cames. Nothing else (except the block) uses te "pos" parameter, so we
can't not trust on it.

And that  has been for a fast look at the code, that I got really
confused (again).



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
>          if (ret != RAM_SAVE_CONTROL_DELAYED) {
>              if (bytes_sent && *bytes_sent > 0) {
>                  qemu_update_position(f, *bytes_sent);
