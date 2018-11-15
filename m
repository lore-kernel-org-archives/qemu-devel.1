Received: from eggs.gnu.org ([2001:4830:134:3::10]:46434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNG8t-00029m-DA
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 06:49:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNG8s-0006fx-K0
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 06:49:03 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:35355)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gNG8r-0006dJ-NG
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 06:49:01 -0500
Received: by mail-oi1-x243.google.com with SMTP id v6so4171646oif.2
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 03:48:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181017095128.GK22755@stefanha-x1.localdomain>
References: <20181016132018.5054-1-vsementsov@virtuozzo.com>
	<20181017095128.GK22755@stefanha-x1.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Nov 2018 11:48:37 +0000
Message-ID: <CAFEAcA_h8pWjNokWQqUXqLDS=WrtKz-zKQ4QjhjV5UR2Yb8MbQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>, John Snow <jsnow@redhat.com>

On 17 October 2018 at 10:51, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Tue, Oct 16, 2018 at 04:20:18PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> Theoretically possible that we finish the skipping loop with bs = NULL
>> and the following code will crash trying to dereference it. Fix that.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>  migration/block-dirty-bitmap.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
>> index 477826330c..6de808f95f 100644
>> --- a/migration/block-dirty-bitmap.c
>> +++ b/migration/block-dirty-bitmap.c
>> @@ -288,6 +288,10 @@ static int init_dirty_bitmap_migration(void)
>>              bs = backing_bs(bs);
>>          }
>>
>> +        if (!bs || bs->implicit) {
>> +            continue;
>> +        }
>> +
>>          for (bitmap = bdrv_dirty_bitmap_next(bs, NULL); bitmap;
>>               bitmap = bdrv_dirty_bitmap_next(bs, bitmap))
>>          {
>
> Previous discussion:
> http://qemu.11.n7.nabble.com/PATCH-migration-Appease-coverity-skip-empty-block-trees-td582504.html
>
> I've CCed John so he can take a look.

So have you block-layer folks figured out how you want to address
this Coverity issue yet?

thanks
-- PMM
