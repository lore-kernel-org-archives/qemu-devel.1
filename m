Received: from eggs.gnu.org ([209.51.188.92]:37651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2J9K-00037i-Ku
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 12:19:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2J9K-0001fm-19
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 12:19:10 -0500
Date: Fri, 8 Mar 2019 18:18:58 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190308171858.GF31583@localhost.localdomain>
References: <20190308062455.29755-1-armbru@redhat.com>
	<481d398a-e26c-6c0a-20b7-7466ae1ebf1f@redhat.com>
	<875zsteeih.fsf@dusky.pond.sub.org>
	<20190308133510.GC31583@localhost.localdomain>
	<87sgvxbft2.fsf@dusky.pond.sub.org>
	<20190308154043.GE31583@localhost.localdomain>
	<87bm2l8fiu.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bm2l8fiu.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v7] pflash: Require backend size to match
 device, improve errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org, philmd@redhat.com, mreitz@redhat.com, alex.bennee@linaro.org

Am 08.03.2019 um 18:03 hat Markus Armbruster geschrieben:
> >> bool blk_check_size_and_read_all(BlockBackend *blk, void *buf, hwaddr size,
> >>                                  Error **errp)
> >> {
> >>     int64_t blk_len;
> >>     int ret;
> >> 
> >>     blk_len = blk_getlength(blk);
> >>     if (blk_len < 0) {
> >>         error_setg_errno(errp, -blk_len,
> >>                          "can't get size of block backend '%s'",
> >>                          blk_name(blk));
> >>         return false;
> >>     }
> >>     if (blk_len != size) {
> >>         error_setg(errp, "device requires %" PRIu64 " bytes, "
> >>                    "block backend '%s' provides %" PRIu64 " bytes",
> >>                    size, blk_name(blk), blk_len);
> >
> > Should size use HWADDR_PRIu?
> 
> Yes.
> 
> > I'm not sure if printing the BlockBackend name is a good idea because
> > hopefully one day the BlockBackend will be anonymous even for the flash
> > devices.
> 
> Hmm.  Tell me what else I can use to identify the troublemaker to the
> user.

My hope was that a caller of this would prefix the right context. For
example, if the device were created by -device, the error message would
be prefixed with the whole "-device driver=pflash...:" string, which
gives enough context to the user.

Machine code that instantiates the device based on -drive should
probably do something similar.

Kevin
