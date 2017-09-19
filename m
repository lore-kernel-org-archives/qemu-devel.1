Received: from eggs.gnu.org ([2001:4830:134:3::10]:45890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duHzB-0004a1-0i
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:50:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duHz9-0003RR-Oc
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:50:44 -0400
References: <20170918135935.255591-1-vsementsov@virtuozzo.com>
	<20170918135935.255591-4-vsementsov@virtuozzo.com>
	<d554b537-54da-2a70-66c7-722f2c27f4da@redhat.com>
	<577e29c4-5187-8c6f-aacc-c77282959fdd@virtuozzo.com>
	<26582eb0-1db3-3aac-3652-44e3fbb1e49c@redhat.com>
	<5fff43cf-717d-2d64-f51d-57f116888921@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <11ccb9c4-aecb-e82f-a520-50710dae8ea1@redhat.com>
Date: Tue, 19 Sep 2017 14:50:30 +0200
MIME-Version: 1.0
In-Reply-To: <5fff43cf-717d-2d64-f51d-57f116888921@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/7] block/nbd-client: refactor reading
 reply
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, eblake@redhat.com, den@openvz.org

On 19/09/2017 13:03, Vladimir Sementsov-Ogievskiy wrote:
>>>
>> I disagree that it is easier to extend it in the future.  If some
>> commands in the future need a different "how do we read it" (e.g. for
>> structured reply), nbd_read_reply_entry may not have all the information
>> it needs anymore.
> 
> how is it possible? all information is in requests[i].

If you are okay with violating information hiding, then it is.

>>
>> In fact, you're pushing knowledge of the commands from nbd_co_request to
>> nbd_read_reply_entry:
>>
>> +        if (s->reply.error == 0 &&
>> +            s->requests[i].request->type == NBD_CMD_READ)
>>
>> and knowledge of NBD_CMD_READ simply doesn't belong there.  So there is
>> an example of that right now, it is not some arbitrary bad thing that
>> could happen in the future.
> 
> I can't agree that my point of view is wrong, it's just different.
> You want commands, reading from socket, each knows what it should read.
> I want the receiver - one sequential reader, that can read all kinds of
> replies and just wake requesting coroutines when all reading is done.
> For me it looks simpler than switching.

It may look simpler, but I think it goes against the principle of
coroutines which is to have related code in the same function.  Here you
have the command function that takes care of sending the request payload
but not receiving the reply payload (except that for commands that
aren't as simple as read or write, it will have to _process_ the reply
payload).  What to do with the reply payload is in another function that
has to peek at the command in order to find out what to do.  It doesn't
seem like a better design, honestly.

Paolo
