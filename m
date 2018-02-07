Received: from eggs.gnu.org ([2001:4830:134:3::10]:53426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1ejQUj-0003b4-NS
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 09:14:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1ejQUe-0004IW-On
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 09:14:41 -0500
Received: from mail-ua0-f181.google.com ([209.85.217.181]:37779)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fzheng@redhat.com>) id 1ejQUe-0004IA-JS
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 09:14:36 -0500
Received: by mail-ua0-f181.google.com with SMTP id q8so619910uae.4
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 06:14:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180207131014.GB3765@localhost.localdomain>
References: <20170418143044.12187-1-famz@redhat.com>
	<20170418143044.12187-3-famz@redhat.com>
	<20180206153237.GA4799@localhost.localdomain>
	<CAK1Eb9=h4435CkK-eSz_YqAbVaz8Mvnx=VuB_BtSRHgZOfCLfA@mail.gmail.com>
	<20180207105110.GA3765@localhost.localdomain>
	<CAK1Eb9=jyFNqrTa9YK4EzS_t6bWGCVxsfzmmt25w49go02BZRA@mail.gmail.com>
	<20180207131014.GB3765@localhost.localdomain>
From: Fam Zheng <famz@redhat.com>
Date: Wed, 7 Feb 2018 22:14:05 +0800
Message-ID: <CAK1Eb9m6Vbq1CLxqj+9v9_tk-U4s6+xhtE3+9okiaEWM+1mGeA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-2.9-rc5 v4 2/2] block: Drain BH in
 bdrv_drained_begin
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Jeffrey Cody <jcody@redhat.com>

On Wed, Feb 7, 2018 at 9:10 PM, Kevin Wolf <kwolf@redhat.com> wrote:
> Am 07.02.2018 um 13:39 hat Fam Zheng geschrieben:
>> On Wed, Feb 7, 2018 at 6:51 PM, Kevin Wolf <kwolf@redhat.com> wrote:
>> > Am 07.02.2018 um 02:48 hat Fam Zheng geschrieben:
>> >> On Tue, Feb 6, 2018 at 11:32 PM, Kevin Wolf <kwolf@redhat.com> wrote:
>> >> > I got a bug assigned where we have a large (200 GB) fragmented qcow2
>> >> > image, and qemu-img convert takes two hours before it even starts to
>> >> > copy data. What it does in this time is iterating through the whole
>> >> > image with bdrv_block_status_above() in order to estimate the work to be
>> >> > done (and of course it will repeat the same calls while actually copying
>> >> > data).
>> >>
>> >> The convert_iteration_sectors loop looks wasteful. Why cannot we
>> >> report progress simply based on (offset/size) * 100% so we don't need
>> >> to do this estimation?
>> >
>> > The assumption is that it's quick and it makes the progress much more
>> > meaningful. You know those progress bars that slowly crawl towards 50%
>> > and then suddenly complete within a second. Or the first 20% are quick,
>> > but then things get really slow. They are not a great example.
>> >
>> > There must have been something wrong with that image file that was
>> > reported, because they reported that it was the only image causing
>> > trouble and if they copied it away, it became quick, too.
>> >
>> > Even for a maximally fragmented 100 GB qcow2 image it only takes about a
>> > second on my laptop. So while I don't feel as certain about the loop as
>> > before, in practice it normally doesn't seem to hurt.
>>
>> No doubt about normal cases. I was unsure about corner cases like
>> slow-ish NFS etc.
>
> Yeah, NFS seems to be a bit slow. Not two-hours-slow, but when I tried
> it with a localhost NFS server, the same operation that took two seconds
> directly from the local file system took about 40s over NFS. They seem
> to go over the network for each lseek() instead of caching the file map.
> Maybe something to fix in the NFS kernel driver.
>
>> A little bit of intelligence would be limiting the time for the loop
>> to a few seconds, for example, "IMG_CVT_EST_SCALE *
>> bdrv_getlength(bs)", or a less linear map.
>
> I don't understand. What would IMG_CVT_EST_SCALE be? Isn't the problem
> that this isn't a constant factor but can be anywhere between 0% and
> 100% depending on the specific image?

This is going to be quite arbitrary, just to make sure we don't waste
a very long time on maximal fragmented images, or on slow lseek()
scenarios. Something like this:

#define IMG_CVT_EST_SCALE ((1 << 40) / 30)

    time_t start = time(NULL);
    while (sector_num < s->total_sectors) {
        if (time(NULL) - start > MAX(30, bdrv_getlength() /
IMG_CVT_EST_SCALE)) {
            /* Too much time spent on counting allocation, just fall
back to bdrv_get_allocated_file_size */
            s->allocated_sectors = bdrv_get_allocated_file_size(bs);
            break;
        }
        n = convert_iteration_sectors(s, sector_num);
        ...
    }

So we loop for at most 30 seconds (for >1TB images).

>
>> >> > One of the things I saw is that between each pair of lseek() calls, we
>> >> > also have unnecessary poll() calls, and these were introduced by this
>> >> > patch. If I modify bdrv_common_block_status_above() so that it doesn't
>> >> > poll if data.done == true already, the time needed to iterate through my
>> >> > test image is cut in half.
>> >> >
>> >> > Now, of course, I'm still only seeing a few seconds for a 100 GB image,
>> >> > so there must be more that is wrong for the reporter, but it suggests to
>> >> > me that BDRV_POLL_WHILE() shouldn't be polling unconditionally when only
>> >> > one of its users actually needs this.
>> >>
>> >> Sounds fine to me. Maybe we could add a boolean parameter to
>> >> BDRV_POLL_WHILE?
>> >
>> > Why not call aio_poll() explicitly in the BDRV_POLL_WHILE() condition in
>> > the one place that needs it?
>>
>> Yes, that is better. Do you have a patch? Or do you want me to work on one?
>
> I don't have a patch yet. If you want to write one, be my guest.
>
> Otherwise I'd just take a to-do note for when I get back to my
> bdrv_drain work. There is still one or two series left to do anyway, and
> I think it would fit in there.

Thought that so I asked, I'll leave it to you then. :)

Fam
