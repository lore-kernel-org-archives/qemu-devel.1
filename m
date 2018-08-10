Received: from eggs.gnu.org ([2001:4830:134:3::10]:60013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fo9SR-0004T4-9Q
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 11:36:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fo9SO-00012h-F3
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 11:36:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57202 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fo9SO-00012O-9m
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 11:36:04 -0400
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-24-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0f09fd23-ffbf-6ccb-521d-618834f33321@redhat.com>
Date: Fri, 10 Aug 2018 10:36:02 -0500
MIME-Version: 1.0
In-Reply-To: <20180808120334.10970-24-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 23/56] json: Leave rejecting invalid UTF-8
 to parser
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
> Both the lexer and the parser (attempt to) validate UTF-8 in JSON
> strings.
> 

> 
> The commit before previous made the parser reject invalid UTF-8
> sequences.  Since then, anything the lexer rejects, the parser would
> reject as well.  Thus, the lexer's rejecting is unnecessary for
> correctness, and harmful for error reporting.

Nice analysis.

> 
> However, we want to keep rejecting ASCII control characters in the
> lexer, because that produces the behavior we want for unclosed
> strings.
> 
> We also need to keep rejecting \xFF in the lexer, because we
> documented that as a way to reset the JSON parser
> (docs/interop/qmp-spec.txt section 2.6 QGA Synchronization), which
> means we can't change how we recover from this error now.  I wish we
> hadn't done that.

Or, if we give special meaning to 0xff to cause a lexer reset without 
also emitting an error message, as a design decision. (Doesn't change 
this patch - that would be a change on top).

> 
> I think we should treat \xFE the same as \xFF.

Reasonable, as it would cover byte-order-marks.

> 
> Change the lexer to accept \xC0..\xC1 and \xF5..\xFD.  It now rejects
> only \x00..\x1F and \xFE..\xFF.  Error reporting for invalid UTF-8 in
> strings is much improved, except for \xFE and \xFF.  For the example
> above, the lexer now produces
> 
>      JSON_LCURLY   {
>      JSON_STRING   "abc\xC0\xAFijk"
>      JSON_COLON    :
>      JSON_INTEGER  1
>      JSON_RCURLY
> 
> and the parser reports just
> 
>      JSON parse error, invalid UTF-8 sequence in string
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   qobject/json-lexer.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
