Received: from eggs.gnu.org ([2001:4830:134:3::10]:33725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f6BeD-0002Gq-TU
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 05:02:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f6Be9-0000hI-0r
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 05:02:33 -0400
References: <20180330161040.350271-1-vsementsov@virtuozzo.com>
	<b6a499bc-b5c6-7c35-e916-d63861f0c0c5@redhat.com>
	<3d0d9016-276f-c1c6-eb7e-ef78c0744f01@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <47c416af-4b8e-db9a-4b4b-9b0eb060b4ff@virtuozzo.com>
Date: Wed, 11 Apr 2018 12:02:10 +0300
MIME-Version: 1.0
In-Reply-To: <3d0d9016-276f-c1c6-eb7e-ef78c0744f01@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] iotests: fix 169
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org

03.04.2018 23:13, John Snow wrote:
>
> On 04/03/2018 12:23 PM, Max Reitz wrote:
>> On 2018-03-30 18:10, Vladimir Sementsov-Ogievskiy wrote:
>>> Use MIGRATION events instead of RESUME. Also, make a TODO: enable
>>> dirty-bitmaps capability for offline case.
>>>
>>> This (likely) fixes racy faults at least of the following types:
>>>
>>>      - timeout on waiting for RESUME event
>>>      - sha256 mismatch on 136 (138 after this patch)
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> ---
>>>
>>> This patch is a true change for the test anyway. But I don't understand=
,
>>> why (and do really) it fixes the things. And I'm not sure about do we
>>> really have a bug in bitmap migration or persistence. So, it's up to yo=
u,
>>> take it into 2.12...
>>>
>>> It was already discussed, that "STOP" event is bad for tests. What abou=
t
>>> "RESUME"? How can we miss it? And sha256 mismatch is really something
>>> strange.
>>>
>>> Max, please check, do it fix 169 for you.
>>>
>>>   tests/qemu-iotests/169 | 44 +++++++++++++++++++++++------------------=
---
>>>   1 file changed, 23 insertions(+), 21 deletions(-)
>> This makes the test pass (thanks!), but it still leaves behind five cats=
...
>>
>> Max
>>
>>
> Hmm:
>
> jhuston  14772  0.0  0.0   4296   784 pts/3    S    16:12   0:00 cat
> /home/bos/jhuston/src/qemu/bin/git/tests/qemu-iotests/scratch/mig_file
> jhuston  14796  0.0  0.0   4296   764 pts/3    S    16:12   0:00 cat
> /home/bos/jhuston/src/qemu/bin/git/tests/qemu-iotests/scratch/mig_file
> jhuston  14940  0.0  0.0   4296   788 pts/3    S    16:12   0:00 cat
> /home/bos/jhuston/src/qemu/bin/git/tests/qemu-iotests/scratch/mig_file
> jhuston  14964  0.0  0.0   4296   720 pts/3    S    16:12   0:00 cat
> /home/bos/jhuston/src/qemu/bin/git/tests/qemu-iotests/scratch/mig_file
> jhuston  15052  0.0  0.0   4296   768 pts/3    S    16:12   0:00 cat
> /home/bos/jhuston/src/qemu/bin/git/tests/qemu-iotests/scratch/mig_file
>
> Why do these get left behind? Nothing to consume the data...?

aha, understand. it is due to last vm_b.shutdown() and vm_b.launch in=20
case of should_migrate. So, at the end of the test I restart vm_b with=20
-incoming parameter. But it looks like=C2=A0 a bug anyway, If we start qemu=
=20
with -incoming "exec", should not we kill cat process, if there were no=20
migration?

--=20
Best regards,
Vladimir
