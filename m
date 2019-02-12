Received: from eggs.gnu.org ([209.51.188.92]:38445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gtfnt-0000Jc-I8
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 16:41:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gtfjt-0002fr-0P
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 16:37:13 -0500
References: <20190212200750.27521-1-jsnow@redhat.com>
	<44d4452d-8b94-205a-dc28-c617be80c29c@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <87241634-5a14-f943-8446-07bd34f12aff@redhat.com>
Date: Tue, 12 Feb 2019 16:37:06 -0500
MIME-Version: 1.0
In-Reply-To: <44d4452d-8b94-205a-dc28-c617be80c29c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] blockdev: acquire aio_context for
 bitmap add/remove
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, pbonzini@redhat.com, vsementsov@virtuozzo.com, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>



On 2/12/19 3:16 PM, Eric Blake wrote:
> On 2/12/19 2:07 PM, John Snow wrote:
>> When bitmaps are persistent, they may incur a disk read or write when bitmaps
>> are added or removed. For configurations like virtio-dataplane, failing to
>> acquire this lock will abort QEMU when disk IO occurs.
>>
>> We used to acquire aio_context as part of the bitmap lookup, so re-introduce
>> the lock for just the cases that have an IO penalty.
> 
> It would be nice to call out which commit id dropped the aio_context
> acquisition during bitmap lookup (making it easier to analyze how long
> this has broken, and which downstream builds need the backport.
> 

OK, I will amend this.

Looks like:

commit 2119882c7eb7e2c612b24fc0c8d86f5887d6f1c3
Author: Paolo Bonzini <pbonzini@redhat.com>
Date:   Mon Jun 5 14:39:03 2017 +0200

since 2.10.

>>
>> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1672010
>> Reported-By: Aihua Liang <aliang@redhat.com>
>> ---
>>  blockdev.c | 26 ++++++++++++++++++++------
>>  1 file changed, 20 insertions(+), 6 deletions(-)
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
