Received: from eggs.gnu.org ([2001:4830:134:3::10]:39868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pahome.chen@mirlab.org>) id 1g0dhZ-0006pY-NO
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 22:19:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pahome.chen@mirlab.org>) id 1g0dhU-0003zq-NO
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 22:19:18 -0400
Received: from mail-vs1-xe42.google.com ([2607:f8b0:4864:20::e42]:43506)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pahome.chen@mirlab.org>)
	id 1g0dhP-0003be-86
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 22:19:11 -0400
Received: by mail-vs1-xe42.google.com with SMTP id v14-v6so2610vsv.10
	for <qemu-devel@nongnu.org>; Thu, 13 Sep 2018 19:19:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <9af35c5f-1d84-c336-a565-c2e1acb8704e@redhat.com>
References: <CAB3eZfsvnyyo0C4nU=Mucg51krnN9Q9ExKA0t4AEEA3DiOd2aA@mail.gmail.com>
	<ce6e31f1-0190-89ea-3aae-90ccdf81c585@redhat.com>
	<f7c8ab1d-c752-29ce-bcd1-64a5598a41b4@redhat.com>
	<56133002-7a79-bf6a-8835-fba043638224@redhat.com>
	<31456c31-7a74-7df2-40d3-2a5841f39996@redhat.com>
	<9af35c5f-1d84-c336-a565-c2e1acb8704e@redhat.com>
From: lampahome <pahome.chen@mirlab.org>
Date: Fri, 14 Sep 2018 10:19:01 +0800
Message-ID: <CAB3eZfu6gM-ikoW7C=Ce82kMVO1OFdU_RXaUxpKm0bqYAL=o-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Can I only commit from active image to
 corresponding range of its backing file by qemu cmd?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>, Markus Armbruster <armbru@redhat.com>

Sorry, I need to explain what case I want to do

Todo: I want to *backup a block device into qcow2 format image.*
I met a problem which is the *file size limit of filesystem* ex: Max is
16TB for any file in ext4, but the block device maybe 32TB or more.

I figure out one way is to *divide data of device into 1TB chunk* and save
every chunk into qcow2 image cuz I don't change filesystem, and  connect
with backing chain.
*(That's what I said range is different)*
Ex: 1st chunk of device will save into image.000
2nd chunk of device will save into image.001
Nth chunk of device will save into image.(N-1)
...etc

I can see all block device data when I mount image.(N-1) by qemu-nbd cuz
the chunk doesn't overlap and all chunks connect by backing chain.

Now I want to do next thing: *Incremental backup*
When I modify data of 1st chunk, what I thought is to write new 1st chunk
to new image *image.N* and let *imgae.(N-1)* be the backing file of
*image.N* .
That's cuz I want to store the data before modified to roll back anytime.

So now I have two *version of block device(like concept of snapshot)*:
One is image.000 to image.(N-1). I can access the data before modify by
mount image.(N-1) through qemu-nbd
The other one is image.000 to image.N.  I can access the data after modify
by mount image.N through qemu-nbd(cuz the visible 1st chunk are in the
image.N)

Consider about the situation:
000   A - - - - - - - -  <<<<<---  store the 1st chunk of block device
001   - B - - - - - - -
002   - - C - - - - - - (1st state of block device)
003   A' - - - - - - - - <<<<<--- store the 1st chunk of block device, but
data is different
004   - - - D - - - - - (2nd state of block device)
005   - - - - E - - - -  (3rd state of block device)

The original problem is If I want to remove the 2nd state(003 and 004) but
I need to keep the data of 003 and 004.
If I just commit 003, the A' of 003 must be committed into 002 cuz 002 is
the backing file of 003.
I try to figure out some way to let it only commit from 003 into 000.
