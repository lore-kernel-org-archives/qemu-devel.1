Received: from eggs.gnu.org ([209.51.188.92]:36488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2J3Q-000076-MX
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 12:13:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2J3P-00041m-Az
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 12:13:04 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:36615)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h2J3L-0003i7-Mh
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 12:13:01 -0500
Received: by mail-ot1-x343.google.com with SMTP id v62so17989083otb.3
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 09:12:53 -0800 (PST)
MIME-Version: 1.0
References: <20190306114227.9125-1-dgilbert@redhat.com>
	<20190306114227.9125-8-dgilbert@redhat.com>
In-Reply-To: <20190306114227.9125-8-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Mar 2019 17:12:41 +0000
Message-ID: <CAFEAcA-pxfaooirQMhxasBwZAhKQGeo3BG_hwefLJ-o7EYZJYQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 07/22] migration: Add an ability to ignore
 shared RAM blocks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, wei.w.wang@intel.com, yury-kotov@yandex-team.ru, Zhang Chen <chen.zhang@intel.com>, Markus Armbruster <armbru@redhat.com>

On Wed, 6 Mar 2019 at 11:55, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
>
> From: Yury Kotov <yury-kotov@yandex-team.ru>
>
> If ignore-shared capability is set then skip shared RAMBlocks during the
> RAM migration.
> Also, move qemu_ram_foreach_migratable_block (and rename) to the
> migration code, because it requires access to the migration capabilities.
>

> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -644,7 +644,7 @@ static int qemu_rdma_init_ram_blocks(RDMAContext *rdma)
>
>      assert(rdma->blockmap == NULL);
>      memset(local, 0, sizeof *local);
> -    qemu_ram_foreach_migratable_block(qemu_rdma_init_one_block, rdma);
> +    foreach_not_ignored_block(qemu_rdma_init_one_block, rdma);
>      trace_qemu_rdma_init_ram_blocks(local->nb_blocks);
>      rdma->dest_blocks = g_new0(RDMADestBlock,
>                                 rdma->local_ram_blocks.nb_blocks);

Hi. This change causes Coverity to gripe (CID 1399413) because
the return value from foreach_not_ignored_block() is ignored
here but it is checked on every other use of the function.

This is one of those Coverity errors where it's just using a
sometimes-wrong heuristic, so we could just mark it as a false
positive (AFAICT qemu_rdma_init_one_block() always returns 0),
but OTOH rdma_add_block() and qemu_rdma_init_one_block()
carefully pipe through a return value, so maybe it's worth assert()ing
in case somebody changes rdma_add_block() to maybe fail later?

I don't think there's much in it -- let me know if you just want
me to mark the issue as a false positive.

thanks
-- PMM
