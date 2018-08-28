Received: from eggs.gnu.org ([2001:4830:134:3::10]:54077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fuVu1-0001Bq-QA
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 00:46:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fuVnS-0007UZ-T7
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 00:40:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44460 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fuVnS-0007Tj-Mo
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 00:40:06 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180827070021.11931-1-armbru@redhat.com>
	<20180827070021.11931-6-armbru@redhat.com>
	<2f5517a3-bb02-c7e7-cebc-315fbf8bd89b@redhat.com>
Date: Tue, 28 Aug 2018 06:40:03 +0200
In-Reply-To: <2f5517a3-bb02-c7e7-cebc-315fbf8bd89b@redhat.com> (Eric Blake's
	message of "Mon, 27 Aug 2018 12:29:31 -0500")
Message-ID: <87d0u3qf30.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 5/6] json: Eliminate lexer state IN_ERROR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

Eric Blake <eblake@redhat.com> writes:

> On 08/27/2018 02:00 AM, Markus Armbruster wrote:
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   qobject/json-lexer.c      | 9 +++++----
>>   qobject/json-parser-int.h | 8 ++++----
>>   2 files changed, 9 insertions(+), 8 deletions(-)
>
>> -
>>   typedef enum json_token_type {
>> -    JSON_MIN = 100,
>> -    JSON_LCURLY = JSON_MIN,
>> +    JSON_ERROR = 0,             /* must be zero, see json_lexer[] */
>> +    /* Gap for lexer states */
>> +    JSON_LCURLY = 100,
>> +    JSON_MIN = JSON_LCURLY,
>
> In an earlier version of this type of cleanup, you swapped the IN_ and
> JSON_ values and eliminated the gap, to make the overall table more
> compact (no storage wasted on any of the states in the gap between the
> two).
>
> https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg01178.html
>
> Is it still worth trying to minimize the gap between the two
> sequences, even if you now no longer swap them in order?

You caught me :)

Eliminating the gap actually enlarges the table.  I first got confused,
then measured the size change backwards to confirm my confused ideas.
When I looked at the patch again, I realized my mistake, and silently
dropped this part of the change.
