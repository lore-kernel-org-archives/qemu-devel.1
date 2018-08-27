Received: from eggs.gnu.org ([2001:4830:134:3::10]:44471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fuKin-0003XH-RW
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 12:50:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fuKiY-0006hu-Gd
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 12:50:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43264 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fuKiV-0006bL-0p
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 12:50:17 -0400
References: <20180827070021.11931-1-armbru@redhat.com>
	<20180827070021.11931-2-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0a033e63-a980-b8e6-2f60-cd743cc6c94c@redhat.com>
Date: Mon, 27 Aug 2018 11:50:08 -0500
MIME-Version: 1.0
In-Reply-To: <20180827070021.11931-2-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/6] json: Fix lexer for lookahead
 character beyond '\x7F'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

On 08/27/2018 02:00 AM, Markus Armbruster wrote:
> The lexer fails to end a valid token when the lookahead character is
> beyond '\x7F'.  For instance, input
> 
>      true\xC2\xA2
> 
> produces the tokens
> 
>      JSON_ERROR     true\xC2
>      JSON_ERROR     \xA2
> 
> The first token should be
> 
>      JSON_KEYWORD   true
> 
> instead.

As long as we still get a JSON_ERROR in the end.

> 
> The culprit is
> 
>      #define TERMINAL(state) [0 ... 0x7F] = (state)
> 
> It leaves [0x80..0xFF] zero, i.e. IN_ERROR.  Has always been broken.

I wonder if that was done because it was assuming that valid input is 
only ASCII, and that any byte larger than 0x7f is invalid except within 
the context of a string.  But whatever the reason for the original bug, 
your fix makes sense.

> Fix it to initialize the complete array.

Worth testsuite coverage?

> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   qobject/json-lexer.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

> diff --git a/qobject/json-lexer.c b/qobject/json-lexer.c
> index e1745a3d95..4867839f66 100644
> --- a/qobject/json-lexer.c
> +++ b/qobject/json-lexer.c
> @@ -123,7 +123,7 @@ enum json_lexer_state {
>   QEMU_BUILD_BUG_ON((int)JSON_MIN <= (int)IN_START_INTERP);
>   QEMU_BUILD_BUG_ON(IN_START_INTERP != IN_START + 1);
>   
> -#define TERMINAL(state) [0 ... 0x7F] = (state)
> +#define TERMINAL(state) [0 ... 0xFF] = (state)
>   
>   /* Return whether TERMINAL is a terminal state and the transition to it
>      from OLD_STATE required lookahead.  This happens whenever the table
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
