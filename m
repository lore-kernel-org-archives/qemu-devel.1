Received: from eggs.gnu.org ([2001:4830:134:3::10]:57545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cejvc-0005Xc-M9
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 09:54:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cejvb-0006tV-LT
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 09:54:32 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:5531 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cejvb-0006se-9p
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 09:54:31 -0500
References: <1487153430-17260-9-git-send-email-vsementsov@virtuozzo.com>
	<20170216112506.GB4869@noname.redhat.com>
	<20170216114944.GD4869@noname.redhat.com>
	<8d7a5d17-7b1b-578a-67fc-c79beb196a4c@virtuozzo.com>
	<20170217120935.GC5338@noname.redhat.com>
	<fd790939-7ad7-1d74-c810-eceece98bbb7@virtuozzo.com>
	<20170217124842.GE5338@noname.redhat.com>
	<3a827d65-1028-d0fd-c3aa-cabe61dafbd9@openvz.org>
	<20170217133430.GI5338@noname.redhat.com>
	<635d98d9-0f65-4fa6-2208-02ff7d23a2e9@openvz.org>
	<20170217142403.GJ5338@noname.redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <89b7456e-e689-fdee-7ab0-89bb664f1cb6@virtuozzo.com>
Date: Fri, 17 Feb 2017 17:54:16 +0300
MIME-Version: 1.0
In-Reply-To: <20170217142403.GJ5338@noname.redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v15 08/25] block: introduce auto-loading
 bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, "Denis V. Lunev" <den@openvz.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com

17.02.2017 17:24, Kevin Wolf wrote:
> Am 17.02.2017 um 14:48 hat Denis V. Lunev geschrieben:
>> On 02/17/2017 04:34 PM, Kevin Wolf wrote:
>>> Am 17.02.2017 um 14:22 hat Denis V. Lunev geschrieben:
>>>> But for sure this is bad from the downtime point of view.
>>>> On migrate you will have to write to the image and re-read
>>>> it again on the target. This would be very slow. This will
>>>> not help for the migration with non-shared disk too.
>>>>
>>>> That is why we have specifically worked in a migration,
>>>> which for a good does not influence downtime at all now.
>>>>
>>>> With a write we are issuing several write requests + sync.
>>>> Our measurements shows that bdrv_drain could take around
>>>> a second on an averagely loaded conventional system, which
>>>> seems unacceptable addition to me.
>>> I'm not arguing against optimising migration, I fully agree with you. I
>>> just think that we should start with a correct if slow base version and
>>> then add optimisation to that, instead of starting with a broken base
>>> version and adding to that.
>>>
>>> Look, whether you do the expensive I/O on open/close and make that a
>>> slow operation or whether you do it on invalidate_cache/inactivate
>>> doesn't really make a difference in term of slowness because in general
>>> both operations are called exactly once. But it does make a difference
>>> in terms of correctness.
>>>
>>> Once you do the optimisation, of course, you'll skip writing those
>>> bitmaps that you transfer using a different channel, no matter whether
>>> you skip it in bdrv_close() or in bdrv_inactivate().
>>>
>>> Kevin
>> I do not understand this point as in order to optimize this
>> we will have to create specific code path or option from
>> the migration code and keep this as an ugly kludge forever.
> The point that I don't understand is why it makes any difference for the
> follow-up migration series whether the writeout is in bdrv_close() or
> bdrv_inactivate(). I don't really see the difference between the two
> from a migration POV; both need to be skipped if we transfer the bitmap
> using a different channel.
>
> Maybe I would see the reason if I could find the time to look at the
> migration patches first, but unfortunately I don't have this time at the
> moment.
>
> My point is just that generally we want to have a correctly working qemu
> after every single patch, and even more importantly after every series.
> As the migration series is separate from this, I don't think it's a good
> excuse for doing worse than we could easily do here.
>
> Kevin

With open/close all is already ok - bitmaps will not be saved because of 
BDRV_O_INACTIVE  and will not be loaded because of IN_USE.


-- 
Best regards,
Vladimir
