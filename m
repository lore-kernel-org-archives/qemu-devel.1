Received: from eggs.gnu.org ([2001:4830:134:3::10]:60708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqIWQ-0002px-Ct
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:41:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqIWM-0005ii-Da
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:41:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38876 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fqIWM-0005iO-7s
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:41:02 -0400
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-50-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <00ae28b2-a3a3-428a-abfe-4948a5b70bc8@redhat.com>
Date: Thu, 16 Aug 2018 08:40:58 -0500
MIME-Version: 1.0
In-Reply-To: <20180808120334.10970-50-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 49/56] json: Streamline
 json_message_process_token()
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

On 08/08/2018 07:03 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   qobject/json-streamer.c | 13 +++++--------
>   1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/qobject/json-streamer.c b/qobject/json-streamer.c
> index 810aae521f..954bf9d468 100644
> --- a/qobject/json-streamer.c
> +++ b/qobject/json-streamer.c
> @@ -99,16 +99,13 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
>   
>       g_queue_push_tail(parser->tokens, token);
>   
> -    if (parser->brace_count < 0 ||
> -        parser->bracket_count < 0 ||

Old: if we are unbalanced (more right tokens read than left)...

> -        (parser->brace_count == 0 &&
> -         parser->bracket_count == 0)) {

...or if we uniformly ended nesting,...

> -        json = json_parser_parse(parser->tokens, parser->ap, &err);

...then parse (to either diagnose the unbalance, or to see if the 
balanced construct is valid), with weird flow control that skips over an 
early return.

Or put another way, if we invert the condition, we find the cases where 
we want an early return instead of parsing (and can thus use that to get 
rid of an unsightly goto over a single early return).

Applying deMorgan's rules:

!(brace < 0 || bracket < 0 || (brace == 0 && bracket == 0))
!(brace < 0) && !(bracket < 0) && !(brace == 0 && bracket == 0)
brace >= 0 && bracket >= 0 && (!(brace == 0) || !(bracket == 0))
brace >= 0 && bracket >= 0 && (brace != 0 || bracket != 0)

But based on what we learned in the first two conjunctions, we can 
rewrite the third:

brace >= 0 && bracket >= 0 && (brace > 0 || bracket > 0)

and then commute the logic:

(brace > 0 || bracket > 0) && brace >= 0 && bracket >= 0

> -        parser->tokens = NULL;
> -        goto out_emit;
> +    if ((parser->brace_count > 0 || parser->bracket_count > 0)
> +        && parser->bracket_count >= 0 && parser->bracket_count >= 0) {

So the new condition is correct, and reads as:

If either struct is still awaiting closure, and both structs have not 
gone unbalanced, then early exit.

It was not intuitive, but stepping through the logic shows it is identical.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
