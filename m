Received: from eggs.gnu.org ([2001:4830:134:3::10]:42015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fpFmP-0001YZ-1w
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 12:33:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fpFmO-00081a-CX
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 12:33:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42492 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fpFmO-00081C-5n
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 12:33:16 -0400
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-42-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <eb69bba3-9226-87b7-ddf7-45c2d51b8446@redhat.com>
Date: Mon, 13 Aug 2018 11:33:14 -0500
MIME-Version: 1.0
In-Reply-To: <20180808120334.10970-42-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 41/56] json: Nicer recovery from invalid
 leading zero
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
> For input 0123, the lexer produces the tokens
> 
>      JSON_ERROR    01
>      JSON_INTEGER  23
> 
> Reporting an error is correct; 0123 is invalid according to RFC 7159.
> But the error recovery isn't nice.
> 
> Make the finite state machine eat digits before going into the error
> state.  The lexer now produces
> 
>      JSON_ERROR    0123
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   qobject/json-lexer.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 

> @@ -158,10 +159,14 @@ static const uint8_t json_lexer[][256] =  {
>       /* Zero */
>       [IN_ZERO] = {
>           TERMINAL(JSON_INTEGER),
> -        ['0' ... '9'] = IN_ERROR,
> +        ['0' ... '9'] = IN_BAD_ZERO,
>           ['.'] = IN_MANTISSA,
>       },
>   
> +    [IN_BAD_ZERO] = {
> +        ['0' ... '9'] = IN_BAD_ZERO,
> +    },
> +

Should IN_BAD_ZERO also consume '.' and/or 'e' (after all, '01e2 is a 
valid C constant, but not a valid JSON literal)?  But I think your 
choice here is fine (again, add too much, and then the lexer has to 
track a lot of state; whereas this minimal addition catches the most 
obvious things with little effort).

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
