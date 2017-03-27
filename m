Received: from eggs.gnu.org ([2001:4830:134:3::10]:46920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1csZqe-0002OB-9V
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 14:58:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1csZqa-00047Z-7l
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 14:58:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38710)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1csZqa-00047B-1W
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 14:58:32 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C6AA37AEA5
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 18:58:30 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1490621195-2228-1-git-send-email-armbru@redhat.com>
	<1490621195-2228-3-git-send-email-armbru@redhat.com>
	<ba4b08e7-7e8d-5210-be2c-545be4cdeb99@redhat.com>
	<abc2a347-5f42-59c0-5f51-0f03bb2b3c6d@redhat.com>
	<87wpbaefzo.fsf@dusky.pond.sub.org>
Date: Mon, 27 Mar 2017 20:58:28 +0200
In-Reply-To: <87wpbaefzo.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Mon, 27 Mar 2017 20:23:07 +0200")
Message-ID: <8737dybl7v.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC v3 for-2.9 02/11] rbd: Fix to cleanly
 reject -drive without pool or image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, jdurgin@redhat.com, jcody@redhat.com

Markus Armbruster <armbru@redhat.com> writes:

> Max Reitz <mreitz@redhat.com> writes:
>
>> On 27.03.2017 18:10, Max Reitz wrote:
>>> On 27.03.2017 15:26, Markus Armbruster wrote:
>>>> qemu_rbd_open() neglects to check pool and image are present.
>>>> Reproducer:
>>>>
>>>>     $ qemu-system-x86_64 -nodefaults -drive if=none,driver=rbd,pool=p
>>>>     Segmentation fault (core dumped)
>>>>     $ qemu-system-x86_64 -nodefaults -drive if=none,driver=rbd,image=i
>>>>     qemu-system-x86_64: -drive if=none,driver=rbd,image=i: error opening pool (null)
>>>>
>>>> Doesn't affect -drive with file=..., because qemu_rbd_parse_filename()
>>>> always sets both pool and image.
>>>>
>>>> Doesn't affect -blockdev, because pool and image are mandatory in the
>>>> QAPI schema.
>>>>
>>>> Fix by adding the missing checks.
>>>>
>>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>>> ---
>>>>  block/rbd.c | 10 +++++++---
>>>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>> 
>>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>>
>> That said, don't we have a similar issue with qemu_rbd_create()? It too
>> doesn't check whether those options are given but I guess they're just
>> as mandatory.
>
> Looks like it.  I'll try to stick a fix into v4.

Hmm, ignorant question: how can I reach qemu_rbd_create() without going
through qemu_rbd_parse_filename()?
