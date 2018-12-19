Received: from eggs.gnu.org ([2001:4830:134:3::10]:41836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gZh6O-0004xR-0Z
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 14:01:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gZh6N-0005kt-7z
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 14:01:51 -0500
References: <20181219015230.18652-1-jsnow@redhat.com>
	<20181219015230.18652-4-jsnow@redhat.com>
	<0de4bd2b-c78f-f293-4d43-20c8bcd168c6@virtuozzo.com>
	<71a31ed2-b371-3b8f-d527-bf37b09e5443@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b3e9768f-cb40-5112-9174-1f352b2d97ed@redhat.com>
Date: Wed, 19 Dec 2018 13:01:41 -0600
MIME-Version: 1.0
In-Reply-To: <71a31ed2-b371-3b8f-d527-bf37b09e5443@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 3/5] iotests: change qmp_log filters to
 expect QMP objects only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On 12/19/18 5:27 AM, Vladimir Sementsov-Ogievskiy wrote:

> But still not sure that it worth it. Isn't it better to just remove fields from dict,
> which are unpredictable, instead of substituting them..

For getting the test to pass when we have a key:unpredictable value in 
the dict, you are right that both changing it to key:SUBST or removing 
key work at producing reproducible output. But when it comes to 
debugging test failure, having key:SUBST in the logs gives you a hint at 
what else to look at, whereas omitting key altogether may make the 
reason for the failure completely disappear from the logs.

Thus, I would argue that even though it is more complex to write a 
filter that can recursively substitute, the resulting output is easier 
to debug if a test starts failing - and that if the work in doing the 
more complex filtering has already been submitted and is not too much of 
a burden to maintain, then we might as well use it rather than going 
with the simpler case of just eliding the problematic keys or using just 
textual filtering.

However, I'm not in a good position to argue whether there is a 
reasonable maintenance burden with the patches in this series, vs. what 
it would take to rewrite 206 to do just textual filtering instead of QMP 
dict substitution filtering.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
