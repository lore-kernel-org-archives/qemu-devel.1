Received: from eggs.gnu.org ([2001:4830:134:3::10]:60222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1evjT8-0000V1-D3
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:55:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1evjT7-0000FE-IU
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:55:54 -0400
Received: from mail-io0-x243.google.com ([2607:f8b0:4001:c06::243]:36401)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jemmy858585@gmail.com>)
	id 1evjT7-0000Ew-CY
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:55:53 -0400
Received: by mail-io0-x243.google.com with SMTP id e30so15629705ioc.3
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 05:55:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1520692378-1835-1-git-send-email-lidongchen@tencent.com>
References: <1520692378-1835-1-git-send-email-lidongchen@tencent.com>
From: 858585 jemmy <jemmy858585@gmail.com>
Date: Tue, 13 Mar 2018 20:55:51 +0800
Message-ID: <CAOGPPbcbnerXf1uJMCcPLiX6DBohVuhy1Ekjtyk+CqkGxbDLog@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Juan Quintela <quintela@redhat.com>, Dave Gilbert <dgilbert@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Lidong Chen <lidongchen@tencent.com>

Ping.

On Sat, Mar 10, 2018 at 10:32 PM, Lidong Chen <jemmy858585@gmail.com> wrote:
> RDMA migration implement save_page function for QEMUFile, but
> ram_control_save_page do not increase bytes_xfer. So when doing
> RDMA migration, it will use whole bandwidth.
>
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
>          if (ret != RAM_SAVE_CONTROL_DELAYED) {
>              if (bytes_sent && *bytes_sent > 0) {
>                  qemu_update_position(f, *bytes_sent);
> --
> 1.8.3.1
>
