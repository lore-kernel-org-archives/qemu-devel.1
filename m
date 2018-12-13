Received: from eggs.gnu.org ([2001:4830:134:3::10]:57796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gXGc9-0005EC-HC
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 21:20:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gXGc8-0000pV-9R
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 21:20:37 -0500
References: <20181213015013.15350-1-jsnow@redhat.com>
	<20181213015013.15350-7-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dda19b8f-1320-7bd5-cc29-c113b0a590e8@redhat.com>
Date: Wed, 12 Dec 2018 20:20:26 -0600
MIME-Version: 1.0
In-Reply-To: <20181213015013.15350-7-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 6/7] iotests: allow pretty-print for
 qmp_log
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On 12/12/18 7:50 PM, John Snow wrote:
> If iotests have lines exceeding >998 characters long, git doesn't
> want to send it plaintext to the list. We can solve this by allowing
> the iotests to use pretty printed QMP output that we can match against
> instead.
> 
> As a bonus, it's much nicer for human eyes, too.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   tests/qemu-iotests/iotests.py | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
> index 9595429fea..dbbef4bad3 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -447,12 +447,12 @@ class VM(qtest.QEMUQtestMachine):
>               result.append(filter_qmp_event(ev))
>           return result
>   
> -    def qmp_log(self, cmd, filters=[filter_testfiles], **kwargs):
> +    def qmp_log(self, cmd, indent=None, filters=[filter_testfiles], **kwargs):

Why None instead of False?

>           logmsg = '{"execute": "%s", "arguments": %s}' % \
>               (cmd, json.dumps(kwargs, sort_keys=True))
>           log(logmsg, filters)
>           result = self.qmp(cmd, **kwargs)
> -        log(json.dumps(result, sort_keys=True), filters)
> +        log(json.dumps(result, indent=indent, sort_keys=True), filters)

But I'd actually have to read the contract to json.dumps() to learn what 
is expected.

/me goes and does that...
https://docs.python.org/2/library/json.html

If indent is a non-negative integer, then JSON array elements and object 
members will be pretty-printed with that indent level. An indent level 
of 0, or negative, will only insert newlines. None (the default) selects 
the most compact representation.

Okay, makes sense.
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
