Received: from eggs.gnu.org ([2001:4830:134:3::10]:51853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fyFtP-0005Al-38
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 08:29:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fyFtO-0002SY-7P
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 08:29:43 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <3ed9672d-12ba-1a89-e960-617e779bcba9@redhat.com>
References: <20180809213528.14738-1-mreitz@redhat.com>
	<20180809213528.14738-5-mreitz@redhat.com>
	<w5136uot46b.fsf@maestria.local.igalia.com>
	<3ed9672d-12ba-1a89-e960-617e779bcba9@redhat.com>
Date: Fri, 07 Sep 2018 14:28:57 +0200
Message-ID: <w51o9d9ij92.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-3.1 v10 04/31] block: Add
 BDS.auto_backing_file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

On Fri 07 Sep 2018 01:32:58 PM CEST, Max Reitz wrote:
> On 2018-09-05 16:22, Alberto Garcia wrote:
>> On Thu 09 Aug 2018 11:35:01 PM CEST, Max Reitz wrote:
>>> If the backing file is overridden, this most probably does change the
>>> guest-visible data of a BDS.  Therefore, we will need to consider this
>>> in bdrv_refresh_filename().
>>>
>>> To see whether it has been overridden, we might want to compare
>>> bs->backing_file and bs->backing->bs->filename.  However,
>>> bs->backing_file is changed by bdrv_set_backing_hd() (which is just used
>>> to change the backing child at runtime, without modifying the image
>>> header), so bs->backing_file most of the time simply contains a copy of
>>> bs->backing->bs->filename anyway, so it is useless for such a
>>> comparison.
>> 
>> What's the point of bs->backing_file then? In what cases is it different
>> from backing->bs->filename?
>
> Good question!  Yes, why?
>
> One thing is when you have detached the backing file, bs->backing_file
> will stay the same, even though backing is now NULL.  But that is
> pretty much useless, I couldn't find any part in the block layer which
> relies on this.
  [...]
> But when the backing BDS is attached, bdrv_set_backing_hd() (through
> bdrv_backing_attach()) will update backing_file to "foo/base.qcow2"
> (or probably the absolute equivalent, I can't remember).

But then why do you need bs->backing_file at all? What are the cases
where you need bs->backing_file but you can't use directly the value in
bs->backing->bs->filename because it's wrong or missing?

> So consequentially, there is a "block: Leave BDS.backing_file
> constant" patch in my "block: Deal with filters" series.  It makes
> backing_file always report what the image header says.

Ok, so after tha patch bs->backing_file is guaranteed to be exactly as
it's written on the image header.

And bs->auto_backing_file is the backing filename after having called
bdrv_refresh_filename(). And that's supposed to be exactly the same as
bs->backing->bs->filename. So I have the same question again, why do you
need bs->auto_backing_filename and in what cases is it different from
bs->auto_backing_file different from bs->backing->bs->filename?

Berto
