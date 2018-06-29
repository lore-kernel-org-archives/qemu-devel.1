Received: from eggs.gnu.org ([2001:4830:134:3::10]:37210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fZ14E-0007UM-5m
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 17:36:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fZ14D-0007ye-9n
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 17:36:34 -0400
References: <20180622201122.9358-1-jsnow@redhat.com>
	<20180629170709.GD16547@stefanha-x1.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <4a80026d-b7bf-a656-4216-bab491ca69c1@redhat.com>
Date: Fri, 29 Jun 2018 17:36:25 -0400
MIME-Version: 1.0
In-Reply-To: <20180629170709.GD16547@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] migration: Appease coverity,
 skip empty block trees
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>, peter.maydell@linaro.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Fam Zheng <famz@redhat.com>



On 06/29/2018 01:07 PM, Stefan Hajnoczi wrote:
> On Fri, Jun 22, 2018 at 04:11:22PM -0400, John Snow wrote:
>> If a tree consists exclusively of implicit filter nodes, we might crash
>> QEMU. This configuration should not exist in practice, but if it did,
>> skipping it would be fine.
>>
>> For the purposes of debug builds, throw an assert to remind us that
>> this configuration is truly unexpected, but if it's compiled out we
>> will cope just fine.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>  migration/block-dirty-bitmap.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
>> index 3bafbbdc4c..02725293dd 100644
>> --- a/migration/block-dirty-bitmap.c
>> +++ b/migration/block-dirty-bitmap.c
>> @@ -287,6 +287,10 @@ static int init_dirty_bitmap_migration(void)
>>          while (bs && bs->drv && bs->implicit) {
>>              bs = backing_bs(bs);
>>          }
>> +        if (!bs) {
>> +            g_assert_not_reached();
>> +            continue;
>> +        }
> 
> If bs can never be NULL, why test that it is non-NULL in the while loop
> condition?
> 
> Try:
> 
>   /* Precondition: bs != NULL thanks to the for loop */
>   while (bs->drv && bs->implicit) {
>       bs = backing_bs(bs);
>   }
>   /* Postcondition: bs != NULL due to implicit node layout assumption */
> 
> Does this silence Coverity?  ISTR it looks for cues like the bs check in
> the while loop condition to decide whether it's likely that a variable
> could be NULL.
> 

I'll give this a go, but mechanically it looks suspect without an
assert(bs) in the loop body, but that would definitely silence Coverity.

--js
