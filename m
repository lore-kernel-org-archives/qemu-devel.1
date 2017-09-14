Received: from eggs.gnu.org ([2001:4830:134:3::10]:52671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <awolfegordon@digitalocean.com>) id 1dscbm-0002nV-HA
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 18:27:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <awolfegordon@digitalocean.com>) id 1dscbl-0007Tp-G8
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 18:27:42 -0400
Received: from mail-it0-x22c.google.com ([2607:f8b0:4001:c0b::22c]:54764)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <awolfegordon@digitalocean.com>)
	id 1dscbl-0007Sb-Ak
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 18:27:41 -0400
Received: by mail-it0-x22c.google.com with SMTP id e134so1799579ite.3
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 15:27:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <548bda9d-3f65-a58a-94ff-87083c1f1338@redhat.com>
References: <20170913164424.32129-1-awg@digitalocean.com>
	<820405a5-32e9-43e4-f41f-184e3bbb00a7@redhat.com>
	<CAE9i+tAgVv5ebLMuHXK2mDHC0aCcpGKrOib+DzCgsGyFh9EbLg@mail.gmail.com>
	<548bda9d-3f65-a58a-94ff-87083c1f1338@redhat.com>
From: Adam Wolfe Gordon <awg@digitalocean.com>
Date: Thu, 14 Sep 2017 16:27:38 -0600
Message-ID: <CAE9i+tATO-cgatMeG-VOC1EUjZLVP+SXusZdgWhgo1fzYT0kpA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] rbd: Detect rbd image resizes
 and propagate them
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Wed, Sep 13, 2017 at 6:47 PM, John Snow <jsnow@redhat.com> wrote:
> On 09/13/2017 05:36 PM, Adam Wolfe Gordon via Qemu-devel wrote:
>> On Wed, Sep 13, 2017 at 2:53 PM, John Snow <jsnow@redhat.com> wrote:
>> We have a storage orchestration service that manages our ceph block
>> storage clusters and doesn't interact directly with qemu. Volumes get
>> resized through the orchestration service, which (after doing some
>
> resized bigger, one hopes ...

Indeed! That's actually one of the reasons for this change: it's much
easier to guarantee that we're always resizing bigger if all resizes
are issued in the same place.

>> Previously, we would notify the VM of the resize by issuing a
>> blockresize via qmp after doing the resize itself externally. That
>> meant we were actually resizing the rbd image twice (though the second
>> was, hopefully, a no-op). We occasionally had trouble with the resize
>> issued by qemu getting stuck and blocking the qemu main thread.
>> Detecting the out-of-band resize lets us avoid the extra rbd_resize
>> call and means that we never modify an rbd image's metadata from qemu.
>>
>
> Hm, I see... It sounds like you want an operation here that lets us
> detect medium changes without actually attempting to orchestrate one.
>
> It smells like you want the second half of bdrv_truncate without
> actually issuing the call. Perhaps you could split this function into
> its two halves, and in the event of an external resize being detected,
> you could call the latter-half portion of bdrv_truncate.

Yes, I think that agrees with what Jason Dillaman suggested yesterday,
and makes sense to me. Will do that for a v2 of this patch.

> ...if the drive is configured to automatically detect those events, that
> is. Conceivably not all resize events that QEMU *could* detect *should*
> automatically result in guest-visible changes as soon as they occur.

Good point. I can add an option for this to the rbd driver. My gut
feeling is that the default should be off (i.e., the existing
behavior) to avoid any surprises for users who upgrade.

Thanks for the review. I'll get a v2 out as time allows.

-- awg
