Received: from eggs.gnu.org ([2001:4830:134:3::10]:42506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUFjL-0000vN-OL
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 13:10:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUFjI-0000EN-HO
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 13:10:47 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:35405)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dUFjI-0000Du-0Y
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 13:10:44 -0400
Received: by mail-wr0-f174.google.com with SMTP id k67so108771549wrc.2
	for <qemu-devel@nongnu.org>; Sun, 09 Jul 2017 10:10:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170613164628.GG4383@noname.redhat.com>
References: <1496857819-12466-1-git-send-email-kwolf@redhat.com>
	<1496857819-12466-6-git-send-email-kwolf@redhat.com>
	<CAFEAcA-zObhNAR7iuQZ0MH7-ng86m2XEik8bie3o4THEbLwcVA@mail.gmail.com>
	<20170613164628.GG4383@noname.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 9 Jul 2017 18:09:22 +0100
Message-ID: <CAFEAcA-GcwUz0UMJE-chqewQ3X6=ZD6NygywF6w-3J7sG7QzbA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 5/8] commit: Fix use after free in completion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 13 June 2017 at 17:46, Kevin Wolf <kwolf@redhat.com> wrote:
> Am 13.06.2017 um 18:12 hat Peter Maydell geschrieben:
>> On 7 June 2017 at 18:50, Kevin Wolf <kwolf@redhat.com> wrote:
>> > diff --git a/block/commit.c b/block/commit.c
>> > index a3028b2..af6fa68 100644
>> > --- a/block/commit.c
>> > +++ b/block/commit.c
>> > @@ -89,6 +89,10 @@ static void commit_complete(BlockJob *job, void *opaque)
>> >      int ret = data->ret;
>> >      bool remove_commit_top_bs = false;
>> >
>> > +    /* Make sure overlay_bs and top stay around until bdrv_set_backing_hd() */
>> > +    bdrv_ref(top);
>> > +    bdrv_ref(overlay_bs);
>> > +
>> >      /* Remove base node parent that still uses BLK_PERM_WRITE/RESIZE before
>> >       * the normal backing chain can be restored. */
>> >      blk_unref(s->base);
>>
>> Hi -- coverity complains about this change, because bdrv_ref()
>> assumes that its argument is not NULL, but later on in commit_complete()
>> we have a check
>>     "if (overlay_bs && ...)"
>> which assumes its argument might be NULL. (CID 1376205)
>>
>> Which is correct?
>
> I saw the Coverity report and am looking into it. It's not completely
> clear to me yet which is correct, but I suspect it can be NULL.

Just a nudge on this one -- I don't think there's been a patch sent
to the list for this check-after-use ?

(It's one of just 7 coverity issues left which haven't had at least
a patch sent to the list now...)

thanks
-- PMM
