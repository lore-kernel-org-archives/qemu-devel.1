Received: from eggs.gnu.org ([2001:4830:134:3::10]:55592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fpEno-0006O7-Vw
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 11:30:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fpEnl-0005Xv-Qm
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 11:30:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54014 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fpEnl-0005XP-Kt
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 11:30:37 -0400
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-34-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <750d65b3-afc8-d837-c943-23df639c8d21@redhat.com>
Date: Mon, 13 Aug 2018 10:30:35 -0500
MIME-Version: 1.0
In-Reply-To: <20180808120334.10970-34-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 33/56] json: Redesign the callback to
 consume JSON values
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

> 
> Observations:
> 
> 1. This is not the only way to use recursive descent.  If we replaced
>     "get next token" by a coroutine yield, we could do without a
>     streamer.
> 
> 2. The lexer reports errors by passing a JSON_ERROR token to the
>     streamer.  This communicates the offending input characters and
>     their location, but no more.

In fact, the offending input wasn't completely available until earlier 
in the series :)

> 
> 3. The streamer reports errors by passing a null token sequence to the
>     callback.  The (already poor) lexical error information is thrown
>     away.
> 
> 4. Having the callback receive a token sequence duplicates the code to
>     convert token sequence to abstract syntax tree in every callback.
> 
> 5. Known bug: the streamer silently drops incomplete token sequences.
> 
> This commit rectifies 4. by lifting the call of the parser from the
> callbacks into the streamer.  Later commits will address 3. and 5.
> 
> The lifting removes a bug from qjson.c's parse_json(): it passed a
> pointer to a non-null Error * in certain cases, as demonstrated by
> check-qjson.c.
> 
> json_parser_parse() is now unused.  It's a stupid wrapper around
> json_parser_parse_err().  Drop it, and rename json_parser_parse_err()
> to json_parser_parse().
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
