Received: from eggs.gnu.org ([2001:4830:134:3::10]:58461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1fj1e4-0001B7-JV
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 08:14:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1fj1e1-0006M9-Dz
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 08:14:56 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:37147)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fzheng@redhat.com>) id 1fj1e1-0006LP-9N
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 08:14:53 -0400
Received: by mail-ua0-f195.google.com with SMTP id y10-v6so3185147uao.4
	for <qemu-devel@nongnu.org>; Fri, 27 Jul 2018 05:14:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180727033402.13513-1-famz@redhat.com>
	<20180727102938.GD4355@localhost.localdomain>
In-Reply-To: <20180727102938.GD4355@localhost.localdomain>
From: Fam Zheng <famz@redhat.com>
Date: Fri, 27 Jul 2018 20:14:15 +0800
Message-ID: <CAK1Eb9m2Fzs8_1Swm5Z8qbPdK=qUShX5zhZQ0Wtqx=LOBT8HnQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH RFC for-3.0-rc3 0/3] qemu-img: Disable copy
 offloading by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu block <qemu-block@nongnu.org>

On Fri, Jul 27, 2018 at 6:29 PM Kevin Wolf <kwolf@redhat.com> wrote:
>
> Am 27.07.2018 um 05:33 hat Fam Zheng geschrieben:
> > Kevin pointed out that both glibc and kernel provides a slow fallback of
> > copy_file_range which hurts thin provisioning. This is particularly true for
> > thin LVs, because host_device driver cannot get allocation info from the
> > volume, and copy_file_range is called on every sectors, making the dst fully
> > allocated.
> >
> > NFS mount points also doesn't support SEEK_DATA well, so the allocation
> > information is unknown to QEMU.
> >
> > That leaves only iscsi:// which seems to do what we want so far, but it is a
> > smaller use case.
> >
> > Add an option to qemu-img convert, "-C", to enable (attempting) copy offloading
> > explicitly. And mark it incompatible with "-S" and "-c".
>
> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
>
> Not sure why you made this an RFC only, but I think we absolutely need
> this. People are used to using 'qemu-img convert' to compact images and
> this would regress with automatic copy offloading.
>
> Do you think we need more discussion?

I think merging this for 3.0 is the right thing do to.

What worries me is the general usability of the feature. We could
probably explore ideas about how we can better take advantage of copy
offloading. I don't think counting on the user to make the right
decision between disk efficiency (thin provisioning) and BW efficiency
(copy offloading) will ever work. Even if we don't care about breaking
the default '-S 4k' behavior, the lack of SEEK_DATA/SEEK_HOLE support
on host NFS and block devices will make it very hard to use. Making it
worse, if the network to NFS server is good enough, convert with
pread64/pwrite64 with host page cache is also more efficient than
copy_file_range, so we'll be slower by trying to play clever. :(

Any thought?

Fam
