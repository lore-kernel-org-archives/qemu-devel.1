Received: from eggs.gnu.org ([2001:4830:134:3::10]:38333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashmit602@gmail.com>) id 1cv9Cy-00027G-8a
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 17:08:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashmit602@gmail.com>) id 1cv9Cw-0000Bh-TP
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 17:08:16 -0400
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:36621)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashmit602@gmail.com>) id 1cv9Cw-0000B3-Ky
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 17:08:14 -0400
Received: by mail-io0-x242.google.com with SMTP id 68so13350279ioh.3
	for <qemu-devel@nongnu.org>; Mon, 03 Apr 2017 14:08:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170403151154.GD3539@stefanha-x1.localdomain>
References: <1490583036-3683-1-git-send-email-Ashish.Mittal@veritas.com>
	<20170327172738.GG28620@stefanha-x1.localdomain>
	<CAAo6VWPPjX2UfU55rnR375jzmpMojUOHfmMafwBiZqBa80aBeQ@mail.gmail.com>
	<CAAo6VWNShCJDYkRSC-qCZ_X002ud5QLpHgP7V-51XaPqaRcggA@mail.gmail.com>
	<20170403151154.GD3539@stefanha-x1.localdomain>
From: ashish mittal <ashmit602@gmail.com>
Date: Mon, 3 Apr 2017 14:08:13 -0700
Message-ID: <CAAo6VWP505CgV_CyGwSbMj_oidkhjeQWO3XtHhSyThVwLh-d7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v10 1/2] block/vxhs.c: Add support for a
 new block device type called "vxhs"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Jeff Cody <jcody@redhat.com>, Fam Zheng <famz@redhat.com>, Ashish Mittal <ashish.mittal@veritas.com>, Ketan Nilangekar <Ketan.Nilangekar@veritas.com>, John Ferlan <jferlan@redhat.com>, Buddhi Madhav <Buddhi.Madhav@veritas.com>, Suraj Singh <Suraj.Singh@veritas.com>, Nitin Jerath <Nitin.Jerath@veritas.com>, Peter Maydell <peter.maydell@linaro.org>, "Venkatesha M.G." <venkatesha.mg@veritas.com>, Abhijit Dey <Abhijit.Dey@veritas.com>, Rakesh Ranjan <Rakesh.Ranjan@veritas.com>

On Mon, Apr 3, 2017 at 8:11 AM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Fri, Mar 31, 2017 at 11:25:02AM -0700, ashish mittal wrote:
>> On Mon, Mar 27, 2017 at 6:04 PM, ashish mittal <ashmit602@gmail.com> wrote:
>> > On Mon, Mar 27, 2017 at 10:27 AM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>> >> On Sun, Mar 26, 2017 at 07:50:35PM -0700, Ashish Mittal wrote:
>> >>
>> >> Have you tested live migration?
>> >>
>> >> If live migration is not supported then a migration blocker should be
>> >> added using migrate_add_blocker().
>> >>
>> >
>> > We do support live migration. We have been testing a fork of this code
>> > (slightly different version) with live migration.
>
> The reason I ask is because this patch doesn't implement the
> BlockDriver bdrv_invalidate_cache()/bdrv_inactivate() callbacks.  These
> functions are invoked during live migration so that the block driver can
> ensure data consistency.
>
> Since the destination QEMU process is launched while the source QEMU is
> still running and making changes to the disk, some block drivers need to
> discard metadata at migration handover time that was read upon opening
> the image on the destination.  The guarantees that they see the latest
> metadata.
>

Thanks! During live migration, we point the vdisks to the same host as
the migration source (specified on the vxhs command line), thereby
insuring consistent view of data.

> Not sure if libvxhs caches anything that might get stale during live
> migration, but I wanted to raise this question?
>
> Regarding a fork of this code that you haven't posted to the mailing
> list, it doesn't exist as far as anyone here is concerned :).  Therefore
> either the code on the mailing list needs to support migration or it
> must register a migration blocker to prevent migration.
>

The code on the mailing list does support live migration. Live
migration requires the support of proprietary vxhs bits and also our
orchestration code within OpenStack. We have been testing live
migration and it works without any data consistency issues.

>> >>> +static BlockDriver bdrv_vxhs = {
>> >>> +    .format_name                  = "vxhs",
>> >>> +    .protocol_name                = "vxhs",
>> >>> +    .instance_size                = sizeof(BDRVVXHSState),
>> >>> +    .bdrv_file_open               = vxhs_open,
>> >>> +    .bdrv_parse_filename          = vxhs_parse_filename,
>> >>> +    .bdrv_close                   = vxhs_close,
>> >>> +    .bdrv_getlength               = vxhs_getlength,
>> >>> +    .bdrv_aio_readv               = vxhs_aio_readv,
>> >>> +    .bdrv_aio_writev              = vxhs_aio_writev,
>> >>
>> >> Missing .bdrv_aio_flush().  Does VxHS promise that every completed write
>> >> request is persistent?
>> >>
>> >
>> > Yes, every acknowledged write request is persistent.
>> >
>> >> In that case it may be better to disable the emulated disk write cache
>> >> so the guest operating system and application know not to send flush
>> >> commands.
>> >
>> > We do pass "cache=none" on the qemu command line for every block
>> > device. Are there any other code changes necessary? Any pointers will
>> > help.
>> >
>>
>> Upon further reading, I now understand that cache=none will not
>> disable the emulated disk write cache. I am trying to understand if -
>> (1) It should still not be a problem since flush will just be a no-op for us.
>
> The guest operating system and applications may take different code
> paths depending on the state of the disk write cache.
>
> Useless vmexits can be eliminated if the guest doesn't need to send
> flush commands.  Hence the file system and applications may perform
> better.
>
>> (2) Is there a way, or reason, to disable the emulated disk write
>> cache in the code for vxhs? I think passing WCE=0 to the guest has
>> something to do with this, although I have yet to figure out what that
>> means.
>
> Right, WCE == "Write Cache Enable".  If you disable the write cache then
> the guest's SCSI disk or virtio-blk drivers will notice that the disk
> does not require flush commands.
>
> Try launching a guest with -drive if=none,id=drive0,cache=directsync,...
> and you should see that the write cache is disabled:
>
>   # cat /sys/block/vda/queue/write_cache
>

Thanks! Will try this. As you mentioned, this might give us a slightly
better performance as it will avoid unnecessary flush from the guest
OS/app. I was wondering if there was a separate command line option
(other than cache=directsync) for passing WCE=0? Reading some of the
articles out there almost suggested as if there was! Maybe I was just
confused.

>> (3) Is this a must for merge?
>
> This doesn't affect the block driver code so no change is necessary.
