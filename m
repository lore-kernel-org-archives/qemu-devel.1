Received: from eggs.gnu.org ([209.51.188.92]:38146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hEZLw-0006Mi-4L
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 09:02:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hEZLv-0006u8-5F
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 09:02:52 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:46349)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hEZLu-0006tH-S6
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 09:02:51 -0400
Received: by mail-wr1-f44.google.com with SMTP id t17so7206456wrw.13
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 06:02:49 -0700 (PDT)
Date: Thu, 11 Apr 2019 15:02:45 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190411130245.ltfyp7d2dfe2cr3h@steredhat>
References: <20190411105025.97397-1-sgarzare@redhat.com>
	<20190411105025.97397-2-sgarzare@redhat.com>
	<CA+aFP1AMzNjWtMeGy4MpWBa26qxShgciYkcEZ8mkSmDrtCvfqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+aFP1AMzNjWtMeGy4MpWBa26qxShgciYkcEZ8mkSmDrtCvfqA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH RFC 1/1] block/rbd: increase dynamically
 the image size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dillaman@redhat.com
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Josh Durgin <jdurgin@redhat.com>, qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

On Thu, Apr 11, 2019 at 08:35:44AM -0400, Jason Dillaman wrote:
> On Thu, Apr 11, 2019 at 7:00 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
> >
> > RBD APIs don't allow us to write more than the size set with rbd_create()
> > or rbd_resize().
> > In order to support growing images (eg. qcow2), we resize the image
> > before RW operations that exceed the current size.
> 
> What's the use-case for storing qcow2 images within a RBD image? RBD
> images are already thinly provisioned, they support snapshots, they
> can form a parent/child linked image hierarchy.
> 

Hi Jason,
I understand your point of view, maybe one use case could be if you have
a qcow2 image and you want to put it in the rdb pool without convert it.

I'm going through this BZ [1] and I'll ask if they have other
use cases in mind.

Anyway, if we want to support only raw format on RBD driver, maybe we
should return something different from current behaviour, also avoiding
to create the image:

$ qemu-img create -f qcow2 rbd:test/qcow.img 1G
  qemu-img: rbd:test/qcow.img: Could not write qcow2 header: Invalid argument

What do you think?

Thanks,
Stefano

[1] https://bugzilla.redhat.com/show_bug.cgi?id=1171007
