Received: from eggs.gnu.org ([2001:4830:134:3::10]:56901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dXAji-00019l-R7
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:27:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dXAjh-0000rj-VX
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:27:14 -0400
References: <20170714183224.7209-1-eblake@redhat.com>
	<20170714183224.7209-3-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <20d98b63-0520-9062-0b76-b5dde45c7acf@redhat.com>
Date: Mon, 17 Jul 2017 14:27:07 -0400
MIME-Version: 1.0
In-Reply-To: <20170714183224.7209-3-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 2/2] nbd: Fix server reply to
 NBD_OPT_EXPORT_NAME of older clients
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org



On 07/14/2017 02:32 PM, Eric Blake wrote:
> A typo in commit 23e099c set the size of buf[] used in response
> to NBD_OPT_EXPORT_NAME according to the length needed for old-style
> negotiation (4 bytes of flag information) instead of the intended
> 2 bytes used in new style.  If the client doesn't enable
> NBD_FLAG_C_NO_ZEROES, then the server sends two bytes too many,
> and is then out of sync in response to the client's next command
> (the bug is masked when modern qemu is the client, since we enable
> the no zeroes flag).
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  nbd/server.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/nbd/server.c b/nbd/server.c
> index 49ed574..bcb241c 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -283,7 +283,7 @@ static int nbd_negotiate_handle_export_name(NBDClient *client, uint32_t length,
>                                              Error **errp)
>  {
>      char name[NBD_MAX_NAME_SIZE + 1];
> -    char buf[8 + 4 + 124] = "";
> +    char buf[8 + 2 + 124] = "";

Is it worth naming these values with some kind of constant to help
describe what the components are? Or at least documenting nearby what
these pieces are? It's clearly written to help illustrate the length of
segments of the reply, but I'm not sure what the segments are.

Also, do we have a policy on how much stuff we're allowed to put on the
stack? I know we've been moving some larger allocations off, but I don't
know what the rule of thumb is.

>      size_t len;
>      int ret;
> 
> @@ -800,7 +800,7 @@ static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,
>   */
>  static coroutine_fn int nbd_negotiate(NBDClient *client, Error **errp)
>  {
> -    char buf[8 + 8 + 8 + 128];
> +    char buf[8 + 8 + 8 + 2 + 2 + 124];

I assume this is a semantic fix instead of a logical one, but I don't
know exactly what or why.

>      int ret;
>      const uint16_t myflags = (NBD_FLAG_HAS_FLAGS | NBD_FLAG_SEND_TRIM |
>                                NBD_FLAG_SEND_FLUSH | NBD_FLAG_SEND_FUA |
> 

Sincerely, someone who has never read our NBD code before.
