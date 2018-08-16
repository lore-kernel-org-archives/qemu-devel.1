Received: from eggs.gnu.org ([2001:4830:134:3::10]:34202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqK3c-00030K-Bc
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:19:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqK3Z-0002mI-0U
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:19:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36732 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fqK3Y-0002lx-RN
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:19:24 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-45-armbru@redhat.com>
	<f779cfde-ce7b-a91f-cb56-f878c6bfcaae@redhat.com>
Date: Thu, 16 Aug 2018 17:19:21 +0200
In-Reply-To: <f779cfde-ce7b-a91f-cb56-f878c6bfcaae@redhat.com> (Eric Blake's
	message of "Thu, 16 Aug 2018 08:10:25 -0500")
Message-ID: <87wosq730m.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 44/56] json: Fix latent parser aborts at
 end of input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

Eric Blake <eblake@redhat.com> writes:

> On 08/08/2018 07:03 AM, Markus Armbruster wrote:
>> json-parser.c carefully reports end of input like this:
>>
>>      token = parser_context_pop_token(ctxt);
>>      if (token == NULL) {
>> 	parse_error(ctxt, NULL, "premature EOI");
>> 	goto out;
>>      }
>
> Are the TABs in the commit message intentional?

No.  Suspect a paste accident.  Fixing...

>> Except parser_context_pop_token() can't return null, it fails its
>> assertion instead.  Same for parser_context_peek_token().  Broken in
>> commit 65c0f1e9558, and faithfully preserved in commit 95385fe9ace.
>> Only a latent bug, because the streamer throws away any input that
>> could trigger it.
>>
>> Drop the assertions, so we can fix the streamer in the next commit.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   qobject/json-parser.c | 2 --
>>   1 file changed, 2 deletions(-)
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
