Received: from eggs.gnu.org ([2001:4830:134:3::10]:34118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gNgni-0002hO-FD
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:16:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gNgnh-0006Ib-KP
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:16:58 -0500
References: <20181016132018.5054-1-vsementsov@virtuozzo.com>
	<20181017095128.GK22755@stefanha-x1.localdomain>
	<CAFEAcA_h8pWjNokWQqUXqLDS=WrtKz-zKQ4QjhjV5UR2Yb8MbQ@mail.gmail.com>
	<97c6b0f3-da95-7c99-c478-303544c2990b@redhat.com>
	<CAFEAcA8B5Ki=qmVGrLvWH4oO6Zaf43_NUAsgwwmCqGqcgj3RAQ@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <eeb95dc4-f1ee-4224-4efe-c4a33ffbae25@redhat.com>
Date: Fri, 16 Nov 2018 11:16:22 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8B5Ki=qmVGrLvWH4oO6Zaf43_NUAsgwwmCqGqcgj3RAQ@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>



On 11/16/18 5:04 AM, Peter Maydell wrote:
> On 16 November 2018 at 03:28, John Snow <jsnow@redhat.com> wrote:
>> I looked again. I think Vladimir's patch will shut up Coverity for sure,
>> feel free to apply it if you want this out of your hair.
>>
>> Stefan suggests the following, however;
>>
>>
>> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
>> index 5e90f44c2f..00c068fda3 100644
>> --- a/migration/block-dirty-bitmap.c
>> +++ b/migration/block-dirty-bitmap.c
>> @@ -284,7 +284,7 @@ static int init_dirty_bitmap_migration(void)
>>          const char *drive_name = bdrv_get_device_or_node_name(bs);
>>
>>          /* skip automatically inserted nodes */
>> -        while (bs && bs->drv && bs->implicit) {
>> +        while (bs->drv && bs->implicit) {
>>              bs = backing_bs(bs);
>>          }
>>
>>
>> that by removing the assumption that bs could ever be null here (it
>> shouldn't), that we'll coax coverity into not warning anymore. I don't
>> know if that will work, because backing_bs can theoretically return NULL
>> and might convince coverity there's a problem. In practice it won't be.
>>
>> I don't know how to check this to see if Stefan's suggestion is appropriate.
>>
>> For such a small, trivial issue though, just merge this and be done with
>> it, in my opinion. If you want to take this fix directly as a "build
>> fix" I wouldn't object.
> 
> Personally I think the main benefit of this sort of Coverity
> warning is that it nudges you to work through and figure out
> whether something really can be NULL or not. Stefan's fix
> will satisfy Coverity, because what it's complaining about
> is that the code in one place assumes a pointer can't be NULL
> but in another place does have handling for NULL: it is the
> inconsistency that triggers the warning. If backing_bs()
> can't return NULL (ie if you would be happy in theory to put
> an assert() in after the call) then I think Stefan's fix is
> better. If it can return NULL ever then Vladimir's fix is
> what you want.
> 
> thanks
> -- PMM
> 

I understand the point of Coverity.

I really don't think it can, but I don't actually know how to verify it
or to convince Coverity of the same. Stefan's suggestion seems most
appropriate if it actually does calm Coverity down.

The loop above, there, just iterates down a chain in a graph, looking
for the first node that satisfies a certain criteria -- that it's not an
implicit node. These are reserved for intermediary filter nodes that
should ALWAYS have a child. That is their intended design.

(Is it mechanically possible to violate this? That's very hard to audit
and promise for you. There are always bugs lurking somewhere else.)

I think the only two places where we create such nodes are in:

block/commit.c:        commit_top_bs->implicit = true;
block/mirror.c:        mirror_top_bs->implicit = true;


in commit, it's inserted explicitly above `top`.
in mirror, we use bdrv_append(mirror_top_bs, bs, ...) to put the
implicit node above the target.

In both cases, the loop *cannot* end at a node without a backing file.

Now, this is not to say there might not be a bug somewhere else when we
do graph manipulation that we might accidentally end up with such an
errant configuration ...

Stefan's suggestion is probably most appropriate, *if* it actually
shushes Coverity. I'll send you a small patch and you can find out? I
don't want to task offload but I also genuinely don't know if that will
hint to coverity strongly enough that this is a false positive.

--js
