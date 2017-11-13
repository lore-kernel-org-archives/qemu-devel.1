Received: from eggs.gnu.org ([2001:4830:134:3::10]:52227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eEIFy-0005cj-Oy
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 12:10:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eEIFx-00046u-RI
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 12:10:46 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20171113152424.25381-1-eblake@redhat.com>
	<be69fe36-58f2-1164-5bcd-823df74ae769@redhat.com>
Date: Mon, 13 Nov 2017 18:10:37 +0100
In-Reply-To: <be69fe36-58f2-1164-5bcd-823df74ae769@redhat.com> (Eric Blake's
	message of "Mon, 13 Nov 2017 09:32:38 -0600")
Message-ID: <87mv3qyuia.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-2.11] nbd/client: Use error_prepend()
 correctly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, vsementsov@virtuozzo.com, qemu-stable@nongnu.org, qemu-block@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> [adding Markus as error maintainer]
>
> On 11/13/2017 09:24 AM, Eric Blake wrote:
>> When using error prepend(), it is necessary to end with a space
>> in the format string; otherwise, messages come out incorrectly,
>> such as when connecting to a socket that hangs up immediately:
>> 
>> can't open device nbd://localhost:10809/: Failed to read dataUnexpected end-of-file before all bytes were read
>> 
>> Originally botched in commit e44ed99d, then several more instances
>> added in the meantime.
>>
>> CC: qemu-stable@nongnu.org
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>  nbd/client.c | 50 ++++++++++++++++++++++++++------------------------
>>  1 file changed, 26 insertions(+), 24 deletions(-)
>> 
>> diff --git a/nbd/client.c b/nbd/client.c
>> index 1880103d2a..4e15fc484d 100644
>> --- a/nbd/client.c
>> +++ b/nbd/client.c
>> @@ -79,12 +79,12 @@ static int nbd_send_option_request(QIOChannel *ioc, uint32_t opt,
>>      stl_be_p(&req.length, len);
>> 
>>      if (nbd_write(ioc, &req, sizeof(req), errp) < 0) {
>> -        error_prepend(errp, "Failed to send option request header");
>> +        error_prepend(errp, "Failed to send option request header: ");
>
> A quick grep of the tree noticed that most (all?) error_prepend()
> callers use trailing ": " in their format string.  Should we refactor
> that to be done automatically by error_prepend() itself, rather than at
> every callsite?

error_prepend() becomes less general, but perhaps a bit harder to
misuse.

When I created it, I considered having it add ": ".  I rejected that,
because adding it in the caller is not much of a burden, and I assumed
that even the most basic testing would catch mistakes.

Turns out we can't be bothered to test new errors even once.

Missing colons in error messages is the least of my worries about
untested error paths.

I'd prefer to leave error_prepend() as it is.
