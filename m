Received: from eggs.gnu.org ([2001:4830:134:3::10]:38189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eCiRK-00031S-BW
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 03:43:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eCiRJ-0008RJ-Eo
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 03:43:58 -0500
References: <20171107030912.23930-1-eblake@redhat.com>
	<20171107030912.23930-2-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <f4e76a21-825b-df7c-cfe9-c866099ca476@virtuozzo.com>
Date: Thu, 9 Nov 2017 11:43:42 +0300
MIME-Version: 1.0
In-Reply-To: <20171107030912.23930-2-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 1/2] nbd/server: Implement sparse reads
 atop structured reply
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, pbonzini@redhat.com

07.11.2017 06:09, Eric Blake wrote:
> The reason that NBD added structured reply in the first place was
> to allow for efficient reads of sparse files, by allowing the
> reply to include chunks to quickly communicate holes to the client
> without sending lots of zeroes over the wire.  Time to implement
> this in the server; our client can already read such data.
>
> We can only skip holes insofar as the block layer can query them;
> and only if the client is okay with a fragmented request (if a
> client requests NBD_CMD_FLAG_DF and the entire read is a hole, we
> could technically return a single NBD_REPLY_TYPE_OFFSET_HOLE, but
> that's a fringe case not worth catering to here).  Sadly, the
> control flow is a bit wonkier than I would have preferred, but
> it was minimally invasive to have a split in the action between
> a fragmented read (handled directly where we recognize
> NBD_CMD_READ with the right conditions, and sending multiple
> chunks) vs. a single read (handled at the end of nbd_trip, for
> both simple and structured replies, when we know there is only
> one thing being read).  Likewise, I didn't make any effort to
> optimize the final chunk of a fragmented read to set the
> NBD_REPLY_FLAG_DONE, but unconditionally send that as a separate
> NBD_REPLY_TYPE_NONE.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>


Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>


-- 
Best regards,
Vladimir
