Received: from eggs.gnu.org ([2001:4830:134:3::10]:46177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fnowz-0001MY-La
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 13:42:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fnowu-0004un-Rw
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 13:42:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48652 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fnowu-0004u5-Lt
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 13:42:12 -0400
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-17-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <aa993250-7792-088f-f203-91ce185ea331@redhat.com>
Date: Thu, 9 Aug 2018 12:42:09 -0500
MIME-Version: 1.0
In-Reply-To: <20180808120334.10970-17-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 16/56] json: Fix lexer to include the bad
 character in JSON_ERROR token
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

On 08/08/2018 07:02 AM, Markus Armbruster wrote:
> json_lexer[] maps (lexer state, input character) to the new lexer
> state.  The input character is consumed unless the new state is
> terminal and the input character doesn't belong to this token,
> i.e. the state transition uses look-ahead.  When this is the case,
> input character '\0' would result in the same state transition.
> TERMINAL_NEEDED_LOOKAHEAD() exploits this.
> 
> Except this is wrong for transitions to IN_ERROR.  There, the
> offending input character is in fact consumed: case IN_ERROR returns.
> It isn't added to the JSON_ERROR token, though.
> 
> Fix that by making TERMINAL_NEEDED_LOOKAHEAD() return false for
> transitions to IN_ERROR.
> 
> There's a slight complication.  json_lexer_flush() passes input
> character '\0' to flush an incomplete token.  If this results in
> JSON_ERROR, we'd now add the '\0' to the token.  Suppress that.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   qobject/json-lexer.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Deceptively small change, but worthwhile.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
