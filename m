Received: from eggs.gnu.org ([2001:4830:134:3::10]:38537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dddUh-0003Nx-G1
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 10:23:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dddTd-0007BV-57
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 10:22:27 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <8760e3mst2.fsf@dusky.pond.sub.org>
	<5f5a45ed-26c8-e96d-f39f-39e7a289ec91@openvz.org>
Date: Fri, 04 Aug 2017 16:20:10 +0200
In-Reply-To: <5f5a45ed-26c8-e96d-f39f-39e7a289ec91@openvz.org> (Denis
	V. Lunev's message of "Fri, 4 Aug 2017 16:08:09 +0300")
Message-ID: <87y3qzbejp.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] Is the use of bdrv_getlength() in
 handle_aiocb_write_zeroes() kosher?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

"Denis V. Lunev" <den@openvz.org> writes:

> On 08/04/2017 03:16 PM, Markus Armbruster wrote:
>> Denis, you added this in commit d50d822:
>>
>> #ifdef CONFIG_FALLOCATE
>>     if (s->has_fallocate && aiocb->aio_offset >= bdrv_getlength(aiocb->bs)) {
>>         int ret = do_fallocate(s->fd, 0, aiocb->aio_offset, aiocb->aio_nbytes);
>>         if (ret == 0 || ret != -ENOTSUP) {
>>             return ret;
>>         }
>>         s->has_fallocate = false;
>>     }
>> #endif
>>
>> bdrv_getlength() can fail.  Does it do the right thing then?  For what
>> it's worth, the comparison of its value is signed.
> fallocate() with 0 flags can work only beyond end of file
> or on top of the hole. Thus the check is made to validate
> that we are beyond EOF.
>
> Technically fallocate should fail if that condition will be
> violated. But you right, we can add sanity check here.
> This would not harm.
>
> Should I send it?

I figure an explicit check for bdrv_getlength() failure would make the
code easier to understand.  In short: yes, please!
