Received: from eggs.gnu.org ([2001:4830:134:3::10]:48349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fGPzg-0005yC-VN
	for qemu-devel@nongnu.org; Wed, 09 May 2018 10:23:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fGPzc-0007Zb-Vy
	for qemu-devel@nongnu.org; Wed, 09 May 2018 10:23:00 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180503122241.GA6140@localhost.localdomain>
References: <w517ep7gpsz.fsf@maestria.local.igalia.com>
	<ee24e79d-b37e-ac8f-c349-b0fa637ba2a6@redhat.com>
	<w51bmegjzp4.fsf@maestria.local.igalia.com>
	<216e7398-0bc3-4822-d4b0-e0267c714abb@redhat.com>
	<w5136zjsar5.fsf@maestria.local.igalia.com>
	<bc26c382-458f-5a86-de59-3945397fbcac@redhat.com>
	<w51wowvqu65.fsf@maestria.local.igalia.com>
	<b3ec832d-202b-db93-a163-3d63a4d36326@redhat.com>
	<w51h8nqcijb.fsf@maestria.local.igalia.com>
	<aab201a7-ef3f-8152-cc37-85ae7e106a5e@redhat.com>
	<20180503122241.GA6140@localhost.localdomain>
Date: Wed, 09 May 2018 16:22:54 +0200
Message-ID: <w51r2mkq56p.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC] Intermediate block mirroring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Thu 03 May 2018 02:22:41 PM CEST, Kevin Wolf wrote:

> A clean QMP command would probably apply the same defaults as
> blockdev-add, so you just get to specify the full options again.
>
>> reopen: You call it like blockdev-add, that is:
>>     { "node-name": "overlay",
>>       "backing": "new-backing" }
>> In theory every option you do not specify is unchanged, so I suppose
>> you can leave out e.g. the "driver" option here.
>
> That already doesn't work because "driver" is the discriminator for
> the QAPI union, so it must be mandatory. I'd go further and reuse
> BlockdevOptions, which makes everything mandatory that is mandatory
> when creating the image.
>
> blockdev-reopen would basically mean "replace the whole set of options
> of this node".

There's at least one case which would need special consideration. Let's
say we want to reopen an image ("top") that has a backing file ("base").

When specifying the options there are at least these alternatives for
the backing image:

1) "backing" is a dict with the options of the backing image.

   { ..., "backing": { "driver": "qcow2", "node-name": "base", ... }

   In this case I suppose the backing image would be reopened with the
   new options. Any attempt to change the node name or the file name
   should fail. The graph itself doesn't change, only the options of
   each node.

2) "backing" is reference to another node.

   { ..., "backing": "base2" }

   In this case this should replace "base" with "base2" (which must have
   been opened already).

3) "backing" is null

   { ..., "backing": null }

   This is similar to (2). "base" would be removed from the backing
   chain and "top" would no longer have a backing image. 

4) "backing" is omitted altogether

   In the case of 'blockdev-add' this means that the default backing
   image (specified in the header) is opened with the default
   options. What would it mean for 'blockdev-reopen' ? We keep the
   backing image with the current options (e.g we remove it from the
   BlockReopenQueue)?

There are similar considerations with other children. In the case of
"file" the child is mandatory and non-null, so options (3) and (4) are
not possible.

In the case of Quorum (where there are no default children) we should
keep the children that are specified and remove all others.

Berto
