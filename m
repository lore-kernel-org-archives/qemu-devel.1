Received: from eggs.gnu.org ([2001:4830:134:3::10]:53224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <awolfegordon@digitalocean.com>) id 1dsFeE-0002vV-3f
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 17:56:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <awolfegordon@digitalocean.com>) id 1dsFeD-0006yn-6M
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 17:56:42 -0400
Received: from mail-it0-x22f.google.com ([2607:f8b0:4001:c0b::22f]:47284)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <awolfegordon@digitalocean.com>)
	id 1dsFeD-0006yJ-15
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 17:56:41 -0400
Received: by mail-it0-x22f.google.com with SMTP id o200so688636itg.0
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 14:56:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1505337665.15211.3.camel@redhat.com>
References: <20170913164424.32129-1-awg@digitalocean.com>
	<1505337665.15211.3.camel@redhat.com>
From: Adam Wolfe Gordon <awg@digitalocean.com>
Date: Wed, 13 Sep 2017 15:56:39 -0600
Message-ID: <CAE9i+tDpajGDhT5R3p+vAk_-YQ6hvVFUjJ=vPiYUKXSfuYR+9A@mail.gmail.com>
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
To: dillaman@redhat.com
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>

On Wed, Sep 13, 2017 at 3:21 PM, Jason Dillaman <jdillama@redhat.com> wrote:
> On Wed, 2017-09-13 at 10:44 -0600, Adam Wolfe Gordon wrote:
>> +    parent = bs->inherits_from;
>> +    if (parent == NULL) {
>> +        error_report("bs %s does not have parent", bdrv_get_device_or_node_name(bs));
>> +        return;
>> +    }
>> +
>> +    /* Force parents to re-read our size. */
>
> Can you just invoke blk_truncate instead?

blk_truncate will end up calling qemu_rbd_truncate, which does an
rbd_resize. The goal of this patch is to avoid calling rbd_resize from
qemu, since we do resizes from an external orchestration service.

That said, this patch also introduces a cache of the size (in
BDRVRBDState.size_bytes), so it would be possible for
qemu_rbd_truncate to avoid calling rbd_resize when the image is
already the right size. If I did that, we could use blk_truncate when
we detect a resize as well. Would that be a desirable change?
