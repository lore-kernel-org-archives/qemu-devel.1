Received: from eggs.gnu.org ([2001:4830:134:3::10]:60941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eZh4r-0004iM-T5
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 12:55:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eZh4r-0003Lg-6x
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 12:55:45 -0500
References: <20180110230825.18321-1-eblake@redhat.com>
	<20180110230825.18321-3-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <b95cd0c3-0581-b763-07f2-8f90ef5e2e25@virtuozzo.com>
Date: Thu, 11 Jan 2018 20:55:31 +0300
MIME-Version: 1.0
In-Reply-To: <20180110230825.18321-3-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 2/6] nbd/server: refactor negotiation
 functions parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

11.01.2018 02:08, Eric Blake wrote:
> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>
> Instead of passing currently negotiating option and its length to
> many of negotiation functions let's just store them on NBDClient
> struct to be state-variables of negotiation phase.
>
> This unifies semantics of negotiation functions and allows
> tracking changes of remaining option length in future patches.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Message-Id: <20171122101958.17065-2-vsementsov@virtuozzo.com>
> [eblake: rebase, commit message tweak, assert !optlen after
> negotiation completes]
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>   nbd/server.c | 168 +++++++++++++++++++++++++++++------------------------------
>   1 file changed, 84 insertions(+), 84 deletions(-)

[..]

> @@ -818,7 +817,7 @@ static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,
>                */
>               switch (option) {
>               case NBD_OPT_EXPORT_NAME:
> -                return nbd_negotiate_handle_export_name(client, length,
> +                return nbd_negotiate_handle_export_name(client,
>                                                           myflags, no_zeroes,
>                                                           errp);
>
> @@ -1707,6 +1706,7 @@ static coroutine_fn void nbd_co_client_start(void *opaque)
>           return;
>       }
>
> +    assert(!client->optlen);


hmm, should not it be at the end of nbd_negotiate() ? Looks OK anyway.

>       nbd_client_receive_next_request(client);
>   }
>


-- 
Best regards,
Vladimir
