Received: from eggs.gnu.org ([2001:4830:134:3::10]:43449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eDClI-0002Rd-I1
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 12:06:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eDClD-00014f-KL
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 12:06:36 -0500
References: <20171103144113.7188-1-berrange@redhat.com>
	<9b0c5170-c97a-51d5-b1e4-003f1628d7be@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <3c66a730-7909-1f7b-4ee7-1a1bdcdbd39c@virtuozzo.com>
Date: Fri, 10 Nov 2017 20:06:13 +0300
MIME-Version: 1.0
In-Reply-To: <9b0c5170-c97a-51d5-b1e4-003f1628d7be@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] qcow2: fix image corruption after
 committing qcow2 image into base
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

10.11.2017 19:34, Eric Blake wrote:
> On 11/03/2017 09:41 AM, Daniel P. Berrange wrote:
>> After committing the qcow2 image contents into the base image, qemu-img
>> will call bdrv_make_empty to drop the payload in the layered image.
>>
>> When this is done for qcow2 images, it blows away the LUKS encryption
>> header, making the resulting image unusable. There are two codepaths
>> for emptying a qcow2 image, and the second (slower) codepaths leaves
>> the LUKS header intact, so force use of that codepath.
>>
>> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
>> ---
>>
>> NB, ideally we would fix the faster codepath in make_completely_empty, but
>> having looked at the code, I've really no idea how to even start on fixing that
>> to not kill the LUKS header clusters.
> Hmm - I wonder if persistent bitmaps are also corrupted in the fast path.
>

Oops.
If I understand correct fast path results in absolutely empty image, so 
bitmaps will be dropped of course.
So, s->nb_bitmaps == 0 should be checked too. You can squash it or I can 
send separate patch. Don't think
that special test is needed for bitmaps in this case.

-- 
Best regards,
Vladimir
