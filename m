Received: from eggs.gnu.org ([2001:4830:134:3::10]:36088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dQXiG-0006yd-Co
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 07:34:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dQXiD-0004aL-6C
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 07:34:20 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <f55056ef-6da8-09d3-a11a-0c97c3fc21ca@redhat.com>
References: <1498661881-9605-1-git-send-email-kchamart@redhat.com>
	<1498661881-9605-2-git-send-email-kchamart@redhat.com>
	<w51fuejq36o.fsf@maestria.local.igalia.com>
	<f55056ef-6da8-09d3-a11a-0c97c3fc21ca@redhat.com>
Date: Thu, 29 Jun 2017 13:34:11 +0200
Message-ID: <w51mv8r58p8.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v4 1/2] live-block-ops.txt:
 Rename, rewrite, and improve it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, stephen@that.guru, armbru@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

On Wed 28 Jun 2017 10:33:49 PM CEST, Eric Blake wrote:
>>> +Disk image backing chain notation
>>> +---------------------------------
>>   [...]
>>> +.. important::
>>> +    The base disk image can be raw format; however, all the overlay
>>> +    files must be of QCOW2 format.
>> 
>> This is not quite like that: overlay files must be in a format that
>> supports backing files. QCOW2 is the most common one, but there are
>> others (qed). Grep for 'supports_backing' in the source code.
>
> At the same time, other image formats are not as frequently tested, or
> may be read-only.  Maybe a compromise of "The overlay files can
> generally be any format that supports a backing file, although qcow2
> is the preferred format and the one used in this document".

That sounds good.

>>> +(2) ``block-commit``: Live merge of data from overlay files into backing
>>> +    files (with the optional goal of removing the overlay file from the
>>> +    chain).  Since QEMU 2.0, this includes "active ``block-commit``"
>>> +    (i.e.  merge the current active layer into the base image).
>> 
>> Same question about the 'optional' here.
>
> Here, optional is a bit more correct. With non-active (intermediate)
> commit, qemu ALWAYS rewrites the backing chain to be shorter; but with
> live commit, you can chose whether to pivot to the now-shorter chain
> (job-complete) or whether to keep the active image intact (starting to
> collect a new delta from the point-in-time of the just-completed
> commit, by job-cancel).

That's correct, I think in this case we can probably leave it as it is
now.

>>> +writing to it.  (The rule of thumb is: live QEMU will always be
>>> pointing +to the right-most image in a disk image chain.)
>> 
>> I think it's 'rightmost', without the hyphen.
>
> Sadly, I think this is one case where both spellings work to a native
> reader, and where I don't know of a specific style-guide preference.
> I probably would have written with the hyphen.

Ah, I didn't know! :-)

>>> +(3) Intermediate streaming (available since QEMU 2.8): Starting
>>> afresh + with the original example disk image chain, with a total of
>>> four + images, it is possible to copy contents from image [B] into
>>> image + [C].  Once the copy is finished, image [B] can now be
>>> (optionally) + discarded; and the backing file pointer of image [C]
>>> will be + adjusted to point to [A].
>> 
>> The 'optional' usage again. [B] will be removed from the chain and
>> can be (optionally) removed from the disk, but that you have to do
>> yourself, QEMU won't do that.
>
> Indeed, we may need to be specifically clear of the cases where qemu
> shortens the chain, but where disk images that are no longer used by
> the chain (whether they are still viable [as in stream], or
> invalidated [as in commit crossing more than one element of the
> chain]) are still left on the disk for the user to discard separately
> from qemu.

Yes, I think that should be clarified. The distinction between valid and
invalid images is also an important one, although it's already mentioned
in the document.

>>> +    (QEMU) block-commit device=node-D base=a.qcow2 top=d.qcow2 job-id=job0
>>> +    {
>>> +        "execute": "block-commit",
>>> +        "arguments": {
>>> +            "device": "node-D",
>>> +            "job-id": "job0",
>>> +            "top": "d.qcow2",
>>> +            "base": "a.qcow2"
>>> +        }
>>> +    }
>> 
>> This is correct, but I don't know if it's worth mentioning that if
>> you omit the 'top' parameter it defaults to the active layer (node-D
>> in this example).
>
> I think it's better to be explicit in the examples (always provide all
> parameters, even if what you provide would also be the default when
> omitted), and then maybe the prose can mention which parameters have
> defaults.

Sounds good to me.

Berto
