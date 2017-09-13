Received: from eggs.gnu.org ([2001:4830:134:3::10]:44600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <awolfegordon@digitalocean.com>) id 1dsFKu-0004BT-Uc
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 17:36:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <awolfegordon@digitalocean.com>) id 1dsFKt-0006gt-TR
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 17:36:44 -0400
Received: from mail-io0-x233.google.com ([2607:f8b0:4001:c06::233]:43234)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <awolfegordon@digitalocean.com>)
	id 1dsFKt-0006gS-OK
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 17:36:43 -0400
Received: by mail-io0-x233.google.com with SMTP id k101so9052490iod.0
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 14:36:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <820405a5-32e9-43e4-f41f-184e3bbb00a7@redhat.com>
References: <20170913164424.32129-1-awg@digitalocean.com>
	<820405a5-32e9-43e4-f41f-184e3bbb00a7@redhat.com>
From: Adam Wolfe Gordon <awg@digitalocean.com>
Date: Wed, 13 Sep 2017 15:36:42 -0600
Message-ID: <CAE9i+tAgVv5ebLMuHXK2mDHC0aCcpGKrOib+DzCgsGyFh9EbLg@mail.gmail.com>
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
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>

On Wed, Sep 13, 2017 at 2:53 PM, John Snow <jsnow@redhat.com> wrote:
> On 09/13/2017 12:44 PM, Adam Wolfe Gordon wrote:
>> Register a watcher with rbd so that we get notified when an image is
>> resized. Propagate resizes to parent block devices so that guest devices
>> get resized without user intervention.
>>
>> Signed-off-by: Adam Wolfe Gordon <awg@digitalocean.com>
>> ---
>> Hello!
>>
>> We are using this patch in production at DigitalOcean and have tested it fairly
>> extensively. However, we use the same block device configuration everywhere, so
>> I'd be interested to get an answer to the question I've left in the code:>
>>> /* NOTE: This assumes there's only one layer between us and the
>>>    block-backend. Is this always true? */
>>
>
> Even if it were always true presently, the fact that the block layer
> storage graph can be configured in arbitrary ways suggests that it might
> not always be true in the future.
>
> Probably in practice MOST drives are configured like
> [BB]<--[Format]<--[Protocol], but the block layer is adding a lot of fun
> stuff like filter nodes for throttling or debugging, so it's probably
> too much to assert that the length of the chain will ALWAYS be exactly two.

OK, thanks - that's exactly what I was wondering. I can add some code
to traverse the parents until we get to the BB.

> Can I play dumb and ask what you are trying to accomplish? The concept
> of a drive deciding to resize itself is not something I have a model for
> understanding, presently...

Good question; I probably should have explained the use-case in the
commit message.

We have a storage orchestration service that manages our ceph block
storage clusters and doesn't interact directly with qemu. Volumes get
resized through the orchestration service, which (after doing some
checks, updating external metadata, etc.) issues the resize via
librbd. The drive doesn't exactly resize itself, but the trigger is
out-of-band from any VM the drive may be attached to.

Previously, we would notify the VM of the resize by issuing a
blockresize via qmp after doing the resize itself externally. That
meant we were actually resizing the rbd image twice (though the second
was, hopefully, a no-op). We occasionally had trouble with the resize
issued by qemu getting stuck and blocking the qemu main thread.
Detecting the out-of-band resize lets us avoid the extra rbd_resize
call and means that we never modify an rbd image's metadata from qemu.
