Received: from eggs.gnu.org ([2001:4830:134:3::10]:46033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fnPqZ-0005pl-32
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 10:54:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fnPqY-00051s-0I
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 10:53:59 -0400
References: <20180618164504.24488-1-kwolf@redhat.com>
	<20180618164504.24488-22-kwolf@redhat.com>
	<fd4b2077-448f-2b62-8880-b2a3dcca586a@redhat.com>
	<28f44beb-e19b-3e26-254a-4678eacf30c2@redhat.com>
	<bfd7fd9e-11ad-3aa3-68b8-b9b46df36f1a@virtuozzo.com>
	<20070601-f5e0-6433-e266-823341d09634@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5d5db2ee-e38f-332e-70e4-3d876d67db3b@redhat.com>
Date: Wed, 8 Aug 2018 09:53:43 -0500
MIME-Version: 1.0
In-Reply-To: <20070601-f5e0-6433-e266-823341d09634@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 21/35] block: fix QEMU crash with scsi-hd
 and drive_del
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

On 08/08/2018 09:32 AM, Vladimir Sementsov-Ogievskiy wrote:

>>> What's more, in commit f140e300, we specifically called out in the 
>>> commit message that maybe it was better to trace when we detect 
>>> connection closed rather than log it to stdout, and in all cases in 
>>> that commit, the additional 'Connection closed' messages do not add 
>>> any information to the error message already displayed by the rest of 
>>> the code.
>>>

>> Ok, agree, I'll do it in reconnect series.
>>
> 
> 
> hmm, do what?
> 
> I was going to change these error messages to be traces, but now I'm not 
> sure that it's a good idea.

Traces are fine. They won't show up in iotests, but will show up when 
debugging a failed connection.

> We have generic errp returned from the 
> function, and why to drop it from logs?

Because it is redundant with the very next line already in the log. Any 
error encountered when trying to write to a disconnected server is 
redundant with an already-reported error due to detecting EOF on reading 
from the server.

> Fixing iotest is not a good 
> reason, better is to adjust iotest itself a bit (just commit changed 
> output) and forget about it. Is iotest racy itself, did you see 
> different output running 83 iotest, not testing by hand?

The condition for the output of the 'Connection closed' message is racy 
- it depends entirely on the timing of whether the client was able to 
send() a read request to the server prior to the server disconnecting 
immediately after negotiation ended.  If the client loses the race and 
detects the server hangup prior to writing anything, you get one path; 
if the client wins the race and successfully writes the request and only 
later learns that the server has disconnected when trying to read the 
response to that request, you get the other path. The window for the 
race changed (and the iotests did not seem to ever expose it short of 
this particular change to the block layer to do an extra drain), but I 
could still imagine scenarios where iotests will trigger the opposite 
path of the race from what is expected, depending on load, since I don't 
see any synchronization points between the two processes where the 
server is hanging up after negotiation without reading the client's 
request, but where the client may or may not have had time to get its 
request sent to the server's queue.

So, just because I have not seen the iotest fail directly because of a 
race, I think that this commit causing failures in the iotest is 
evidence that the test is not robust with those extra 'Connection 
closed' messages being output.  Switching the output to be a trace 
instead should be just fine; overall, the client's attempt to read when 
the server hangs up will be an EIO failure whether or not the client was 
able to send() its request and merely fails to get a reply (server 
disconnect was slow), or whether the client was not even able to send() 
its request (server disconnect was fast).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
