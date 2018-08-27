Received: from eggs.gnu.org ([2001:4830:134:3::10]:55037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fuKwr-0003dS-Rm
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 13:05:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fuKwo-0001sf-J9
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 13:05:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41176 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fuKwo-0001s8-Bw
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 13:05:02 -0400
References: <20180827070021.11931-1-armbru@redhat.com>
	<20180827070021.11931-4-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c7f6a3aa-c4d3-494f-b8a7-b92cb6f2478d@redhat.com>
Date: Mon, 27 Aug 2018 12:04:58 -0500
MIME-Version: 1.0
In-Reply-To: <20180827070021.11931-4-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/6] json: Make lexer's "character
 consumed" logic less confusing
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
> The lexer uses macro TERMINAL_NEEDED_LOOKAHEAD() to decide whether a
> state transition consumes the input character.  It returns true when
> the state transition is defined with the TERMINAL() macro.  To detect
> that, it checks whether input '\0' would have resulted in the same
> state transition, and the new state is not IN_ERROR.
> 
> Why does that even work?  For all states, the new state on input '\0'
> is either IN_ERROR or defined with TERMINAL().  If the state
> transition equals the one we'd get for input '\0', it goes to IN_ERROR
> or to the argument of TERMINAL().  We never use TERMINAL(IN_ERROR),
> because it makes no sense.  Thus, if it doesn't go to IN_ERROR, it
> must be defined with TERMINAL().
> 
> Since this isn't quite confusing enough, we negate the result to get
> @char_consumed, and ignore it when @flush is true.
> 
> Instead of deriving the lookahead bit from the state transition, make
> it explicit.  This is easier to understand, and a bit more flexible,
> too.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   qobject/json-lexer.c      | 27 ++++++++++++++++-----------
>   qobject/json-parser-int.h |  1 +
>   2 files changed, 17 insertions(+), 11 deletions(-)
> 

Good description of the convoluted logic. And yes, I find the new 
version more legible, even if more lines of code.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
