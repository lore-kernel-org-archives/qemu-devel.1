Received: from eggs.gnu.org ([2001:4830:134:3::10]:57053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dGYbV-000245-Ad
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 18:30:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dGYbU-0006yn-Di
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 18:30:05 -0400
References: <20170503122539.282182-1-vsementsov@virtuozzo.com>
	<20170503122539.282182-10-vsementsov@virtuozzo.com>
	<33ce370d-939f-d02e-0177-1184ae9f4fa7@redhat.com>
	<47488066-bd0f-834d-85d8-63d7289cb0fd@virtuozzo.com>
	<18c4b1ad-bc30-a598-36b8-612c01b00dee@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <f733fb1b-b625-e809-9740-7c093651c2d8@redhat.com>
Date: Thu, 1 Jun 2017 18:29:54 -0400
MIME-Version: 1.0
In-Reply-To: <18c4b1ad-bc30-a598-36b8-612c01b00dee@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 09/25] block/dirty-bitmap: add readonly
 field to BdrvDirtyBitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, armbru@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org



On 05/31/2017 09:43 AM, Max Reitz wrote:
> On 2017-05-30 08:50, Vladimir Sementsov-Ogievskiy wrote:
>> Thank you for this scenario. Hmm.
>>
>> So, as I need guarantee that image and bitmap are unchanged,
>> bdrv_set_dirty should return error and fail the whole write. Ok?
> 
> I don't know. That would mean that you couldn't commit to an image that
> has a persistent auto-loading bitmap, which doesn't seem very nice to me.
> 
> I'm not quite sure what to do myself. So first I'd definitely want the
> commit operation to succeed. That means we'd have to automatically make
> the bitmap non-readonly once we write to it. The "readonly" flag would
> then be an "unchanged" flag, rather, to signify that the bitmap has not
> been changed since it was loaded, which means that it does not need to
> be written back to the image file.
> 
> Now the issue remains that if you modify a persistent bitmap that is
> stored in an image file that is opened RO when it's closed, you won't be
> able to write the modifications back.
> > So in addition, I guess we'd need to "flush" all persistent bitmaps
> (that is, write all modifications back to the file and set the
> "unchanged" flag (you could also call it "dirty" and then mean the
> opposite) for each bitmap) not only when the image is closed or
> invalidated, but also when it is reopened read-only.
>

Makes sense.

> (block-commit reopens the backing BDS R/W, then writes to them, thus
> modifying the dirty bitmaps, and finally reopens the BDS as read-only;
> before that happens, we will have to flush the modified bitmap data.)
> 

OK, so it would perhaps be enough to toggle the RO flag on/off when
nodes get reopened. When they get reopened RO, we'd need to flush at
that point.

(Right?)

Of course, a changed flag makes this a little moot as it is probably
more flexible; but there is something slightly attractive about the more
rigid form.

(Hmm, for the purposes of periodic flushing, we may want a changed flag
anyway...)

> Max
> 
Thanks for the scenario and the explainer.
