Received: from eggs.gnu.org ([2001:4830:134:3::10]:54199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gNUoY-0004uk-Ve
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 22:29:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gNUoX-00016o-U5
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 22:29:02 -0500
References: <20181016132018.5054-1-vsementsov@virtuozzo.com>
	<20181017095128.GK22755@stefanha-x1.localdomain>
	<CAFEAcA_h8pWjNokWQqUXqLDS=WrtKz-zKQ4QjhjV5UR2Yb8MbQ@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <97c6b0f3-da95-7c99-c478-303544c2990b@redhat.com>
Date: Thu, 15 Nov 2018 22:28:48 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_h8pWjNokWQqUXqLDS=WrtKz-zKQ4QjhjV5UR2Yb8MbQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] migration/block-dirty-bitmap:
 fix Coverity CID1390625
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>



On 11/15/18 6:48 AM, Peter Maydell wrote:
> On 17 October 2018 at 10:51, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>> On Tue, Oct 16, 2018 at 04:20:18PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>> Theoretically possible that we finish the skipping loop with bs = NULL
>>> and the following code will crash trying to dereference it. Fix that.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> ---
>>>  migration/block-dirty-bitmap.c | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
>>> index 477826330c..6de808f95f 100644
>>> --- a/migration/block-dirty-bitmap.c
>>> +++ b/migration/block-dirty-bitmap.c
>>> @@ -288,6 +288,10 @@ static int init_dirty_bitmap_migration(void)
>>>              bs = backing_bs(bs);
>>>          }
>>>
>>> +        if (!bs || bs->implicit) {
>>> +            continue;
>>> +        }
>>> +
>>>          for (bitmap = bdrv_dirty_bitmap_next(bs, NULL); bitmap;
>>>               bitmap = bdrv_dirty_bitmap_next(bs, bitmap))
>>>          {
>>
>> Previous discussion:
>> http://qemu.11.n7.nabble.com/PATCH-migration-Appease-coverity-skip-empty-block-trees-td582504.html
>>
>> I've CCed John so he can take a look.
> 
> So have you block-layer folks figured out how you want to address
> this Coverity issue yet?
> 
> thanks
> -- PMM
> 

I looked again. I think Vladimir's patch will shut up Coverity for sure,
feel free to apply it if you want this out of your hair.

Stefan suggests the following, however;


diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 5e90f44c2f..00c068fda3 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -284,7 +284,7 @@ static int init_dirty_bitmap_migration(void)
         const char *drive_name = bdrv_get_device_or_node_name(bs);

         /* skip automatically inserted nodes */
-        while (bs && bs->drv && bs->implicit) {
+        while (bs->drv && bs->implicit) {
             bs = backing_bs(bs);
         }


that by removing the assumption that bs could ever be null here (it
shouldn't), that we'll coax coverity into not warning anymore. I don't
know if that will work, because backing_bs can theoretically return NULL
and might convince coverity there's a problem. In practice it won't be.

I don't know how to check this to see if Stefan's suggestion is appropriate.

For such a small, trivial issue though, just merge this and be done with
it, in my opinion. If you want to take this fix directly as a "build
fix" I wouldn't object.

I'm sorry for the fuss.
