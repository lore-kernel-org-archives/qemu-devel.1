Received: from eggs.gnu.org ([2001:4830:134:3::10]:46473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fv1tT-0000CK-79
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 10:56:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fv1tO-0006zn-Aa
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 10:56:27 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <c147ca8a-da5e-bb8d-86ab-b9c34acddcf3@redhat.com>
References: <cover.1535291602.git.berto@igalia.com>
	<d470d52cfc97265fec584e6b7d4b5a89c37a1739.1535291602.git.berto@igalia.com>
	<c9cb16fe-8e23-50c4-67c0-3c5952163099@redhat.com>
	<w51r2ih2w5m.fsf@maestria.local.igalia.com>
	<c147ca8a-da5e-bb8d-86ab-b9c34acddcf3@redhat.com>
Date: Wed, 29 Aug 2018 16:56:20 +0200
Message-ID: <w51in3t2pd7.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 5/9] block: Allow child references on reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

On Wed 29 Aug 2018 02:59:01 PM CEST, Max Reitz wrote:
>>> Specifically, that means when you don't specify @backing, the default
>>> chain will be opened and may replace the current one.
>> 
>> At the moment "backing" is the only child option that can be omitted,
>> all others must be specified. So if you leave "backing" out on reopen()
>> we have the following possibilities:
>> 
>>   a) We open the default backing file from disk. I don't think we want
>>      to open a new image on reopen(). Plus, what happens if the current
>>      backing image is the default one? Do we need to detect that? And
>>      what if it's the default image but has non-default options? The
>>      whole thing looks like a can of worms.
>
> True.
>
>>   b) We leave the current backing file untouched.
>
> Hm.  That doesn't make sense for blockdev-add, so you could argue that
> this behavior works as a default for reopen (because it cannot be
> "confused" with the blockdev-add default).
>
>>   c) We forbid it, and the user has to pass an explicit child, or NULL.
>
> That sounds good.
>
>> I chose (b) in this series. I suppose (c) could also be an option. But
>> (a) doesn't looke like a good idea.
>
> I agree with the last sentiment, but I'd prefer making it an error
> instead of choosing (b).  Yes, you could argue that choosing (b) as a
> default makes sense in a way, but in another, it just doesn't make
> sense.  (Because while (b) makes no sense for blockdev-add, (a) would
> make sense for both blockdev-add and reopen.  Sure, it's horrible to
> support, but from a user's POV, it makes sense.  So it's just
> confusing not to make that the default for reopen as well).
>
> But the most important point is that it's trivial for the user to keep
> the current backing file.  They just need to give the current
> backing's node-name.

Or NULL if there's no backing file, right?

The problem I see with this is that it would make the options quite
verbose. "backing" is an attribute of all BDSs, also protocol ones. I
suppose we can make "backing" optional in those, or is there any case
where it makes sense?

Berto
