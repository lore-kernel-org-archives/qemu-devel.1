Received: from eggs.gnu.org ([2001:4830:134:3::10]:40066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gZgxO-0001gb-54
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 13:52:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gZgxN-00071z-An
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 13:52:34 -0500
References: <20181219015230.18652-1-jsnow@redhat.com>
	<20181219015230.18652-2-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b92a888e-1223-2966-ae83-b0f014171129@redhat.com>
Date: Wed, 19 Dec 2018 12:52:13 -0600
MIME-Version: 1.0
In-Reply-To: <20181219015230.18652-2-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 1/5] iotests: add qmp recursive sorting
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: vsementsov@virtuozzo.com, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On 12/18/18 7:52 PM, John Snow wrote:
> Python before 3.6 does not sort kwargs by default.
> If we want to print out pretty-printed QMP objects while
> preserving the "exec" > "arguments" ordering, we need a custom sort.

Naive question - why do we need the sorting? Is it so that the output is 
deterministic?  Surely it can't be because the ordering otherwise makes 
a difference to execution.

Here's my review from a non-Python export viewpoint:

> 
> We can accomplish this by sorting **kwargs into an OrderedDict,
> which does preserve addition order.
> ---
>   tests/qemu-iotests/iotests.py | 21 +++++++++++++++++----
>   1 file changed, 17 insertions(+), 4 deletions(-)
> 

> @@ -448,8 +460,9 @@ class VM(qtest.QEMUQtestMachine):
>           return result
>   
>       def qmp_log(self, cmd, filters=[filter_testfiles], **kwargs):
> -        logmsg = '{"execute": "%s", "arguments": %s}' % \
> -            (cmd, json.dumps(kwargs, sort_keys=True))
> +        full_cmd = OrderedDict({"execute": cmd,
> +                                "arguments": ordered_kwargs(kwargs)})
> +        logmsg = json.dumps(full_cmd)

Vladimir knows Python better than me, but once you fix this OrderedDict 
construction up to actually work, the patch looks reasonable to me.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
