Received: from eggs.gnu.org ([2001:4830:134:3::10]:48346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1evLLX-0000Ny-Mi
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 07:10:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1evLLS-0004VY-0J
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 07:10:27 -0400
Received: from mail-wr0-f175.google.com ([209.85.128.175]:35582)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1evLLR-0004Rm-Kz
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 07:10:21 -0400
Received: by mail-wr0-f175.google.com with SMTP id n12so4089506wra.2
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 04:10:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
References: <20180207163622.29935-1-pbonzini@redhat.com>
	<20180207163622.29935-3-pbonzini@redhat.com>
	<20180208013517.GB24289@lemon.usersys.redhat.com>
	<5ac0b76e-213a-60c3-c010-87512d3a564a@redhat.com>
	<20180212135206.GG5103@localhost.localdomain>
	<81af35f9-4934-0c21-e3b1-b27c2fa7fdd9@redhat.com>
	<20180212143040.GH5103@localhost.localdomain>
	<3d6031b0-7d75-c3ab-e466-ce3d87d630df@redhat.com>
	<20180212144824.GI5103@localhost.localdomain>
	<31e295bd-3012-c34c-a96d-54122557b20c@redhat.com>
Message-ID: <2d47ca9e-6f68-ab4e-0ec0-9f932128a93f@redhat.com>
Date: Mon, 12 Mar 2018 12:10:18 +0100
MIME-Version: 1.0
In-Reply-To: <31e295bd-3012-c34c-a96d-54122557b20c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 2/2] scsi: add block job
 opblockers for scsi-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

On 12/02/2018 15:50, Paolo Bonzini wrote:
> On 12/02/2018 15:48, Kevin Wolf wrote:
>> Am 12.02.2018 um 15:32 hat Paolo Bonzini geschrieben:
>>> Okay, we are in agreement about this and you expressed very well why I
>>> (at the gut feeling level) didn't like the old op blockers.  But you
>>> bypassed the real question, which is: should I send a pull request for
>>> these two patches or not? :)
>> I didn't spell it out that explicitly, but this is essentially a NACK.
>> I'd very much prefer if you could replace it with the proper solution.
>> Of course, we can always make exceptions when there is a good reason,
>> but with 2.12 still two months away, I doubt we have one.
> Ok, I don't mind explicitness.  I'll keep these two patches in the queue
> for now.

It's now one month away.  Regarding the solution below:

> I propose a new BLK_PERM_BYPASS that allows its users to bypass the
> block layer I/O functions. In other words, bdrv_aio_ioctl() would
> require that you got this permission. A dirty bitmap would keep a
> BdrvChild with perm=0, shared=BLK_PERM_ALL & ~BLK_PERM_BYPASS, so you
> can never have a dirty bitmap and a device using ioctls attached to the
> BDS at the same time.

I suppose it would be like:

- scsi-block/scsi-generic call blk_set_perm with perm == shared ==
BLK_PERM_BYPASS

- users of dirty bitmaps would call use perm/shared_perm as in your
message above

- dirty bitmaps creation calls bdrv_get_cumulative_perm (which should
now become public) and checks that it doesn't have BLK_PERM_BYPASS in
shared_perm

Anything I'm missing?

Paolo
