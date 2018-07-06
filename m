Received: from eggs.gnu.org ([2001:4830:134:3::10]:58228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fbOR6-000819-Dw
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:58:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fbOR5-0006ri-AB
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:58:00 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:37558)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fbOR4-0006ng-TR
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:57:59 -0400
Received: by mail-oi0-x242.google.com with SMTP id k81-v6so22684462oib.4
	for <qemu-devel@nongnu.org>; Fri, 06 Jul 2018 03:57:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180627125604.15275-11-quintela@redhat.com>
References: <20180627125604.15275-1-quintela@redhat.com>
	<20180627125604.15275-11-quintela@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Jul 2018 11:57:37 +0100
Message-ID: <CAFEAcA9biQpYu6Ry-b_W2iw0zpW8JfA_u-kgczBDMB8sc=X07g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 10/16] migration: Create
 ram_save_multifd_page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>

On 27 June 2018 at 13:55, Juan Quintela <quintela@redhat.com> wrote:
> The function still don't use multifd, but we have simplified
> ram_save_page, xbzrle and RDMA stuff is gone.  We have added a new
> counter.
>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>
> --
> Add last_page parameter
> Add commets for done and address
> Remove multifd field, it is the same than normal pages
> Merge next patch, now we send multiple pages at a time
> Remove counter for multifd pages, it is identical to normal pages
> Use iovec's instead of creating the equivalent.
> Clear memory used by pages (dave)
> Use g_new0(danp)
> define MULTIFD_CONTINUE
> now pages member is a pointer
> Fix off-by-one in number of pages in one packet
> Remove RAM_SAVE_FLAG_MULTIFD_PAGE
> s/multifd_pages_t/MultiFDPages_t/
> add comment explaining what it means
> ---

Coverity has flagged an issue with this code...

> +static void multifd_send_pages(void)
> +{
> +    int i;
> +    static int next_channel;
> +    MultiFDSendParams *p = NULL; /* make happy gcc */
> +    MultiFDPages_t *pages = multifd_send_state->pages;
> +    uint64_t transferred;

[...]

> +    transferred = pages->used * TARGET_PAGE_SIZE + p->packet_len;

This is the usual "32-bit multiply that we then put into a
64-bit result" -- needs a cast to force the multiply to
give you a 64-bit result. (CID 1393783)

> +    ram_counters.multifd_bytes += transferred;
> +    ram_counters.transferred += transferred;;

Stray double semicolon, I just noticed while writing this email.

Coverity is also unconvinced by the locking strategies this
code is using -- eg CID 1393775 (which I'm pretty sure is a
false positive), and CID 1393778 (which is less clear), plus
a lot of others we've silenced as false-positives. Somebody
who understands the locking should probably go through the
coverity issues for the 'migration' component.

thanks
-- PMM
