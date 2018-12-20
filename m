Received: from eggs.gnu.org ([2001:4830:134:3::10]:51294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gZoGa-0003TJ-8u
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 21:40:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gZoGU-0001OV-Qk
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 21:40:49 -0500
References: <20181220022952.20493-1-jsnow@redhat.com>
	<20181220022952.20493-8-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fc598fa9-31ba-ce75-2add-0ff56bcbe2a7@redhat.com>
Date: Wed, 19 Dec 2018 20:40:26 -0600
MIME-Version: 1.0
In-Reply-To: <20181220022952.20493-8-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 07/11] iotests: add qmp recursive
 sorting function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: vsementsov@virtuozzo.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <fam@euphon.net>, Markus Armbruster <armbru@redhat.com>

On 12/19/18 8:29 PM, John Snow wrote:
> Python before 3.6 does not sort dictionaries (including kwargs).
> Therefore, printing QMP objects involves sorting the keys to have
> a predictable ordering in the iotests output.

It may be worth also mentioning that sometimes this sorting results in 
the log showing things in a different order than the source command 
(with no ill effect, as long as the output order is deterministic).

> 
> However, if we want to pretty-print QMP objects being sent to the
> QEMU process, we need to build the entire command before logging it.
> Ordinarily, this would then involve "arguments" being sorted above
> "execute", which would necessitate a rather ugly and harder-to-read
> change to many iotests outputs.
> 
> To facilitate pretty-printing AND maintaining predictable output AND
> having "arguments" sort before "execute", add a custom sort function

s/before/after/

> that takes a dictionary and recursively builds an OrderedDict that
> maintains the specific key order we wish to see in iotests output.

namely, keys within subdicts are sorted by key name (even if that is not 
the order they were input), but the top-level struct with "execute" and 
"arguments" stays the way we want it.

> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   tests/qemu-iotests/iotests.py | 24 ++++++++++++++++++++----
>   1 file changed, 20 insertions(+), 4 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
