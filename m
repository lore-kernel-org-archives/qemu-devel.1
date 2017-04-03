Received: from eggs.gnu.org ([2001:4830:134:3::10]:33329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <slopezpa@redhat.com>) id 1cv4VW-0008V1-Vl
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 12:07:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <slopezpa@redhat.com>) id 1cv4VT-0007Dh-Js
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 12:07:06 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:35531)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <slopezpa@redhat.com>) id 1cv4VT-0007Ce-FQ
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 12:07:03 -0400
Received: by mail-qk0-f180.google.com with SMTP id g195so46411195qke.2
	for <qemu-devel@nongnu.org>; Mon, 03 Apr 2017 09:07:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170403094015.57368766@t450s.home>
References: <20170403085822.13863-1-slp@redhat.com>
	<20170403094015.57368766@t450s.home>
From: Sergio Lopez Pascual <slp@redhat.com>
Date: Mon, 3 Apr 2017 18:07:01 +0200
Message-ID: <CAAiTLFUhrTPEB2PRLXF=5mmUsQ8B70RQpc82bJBFjvGpmTkTQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] vfio: If DMA map returns ENOMEM wait and
 try again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org

On Mon, Apr 3, 2017 at 5:40 PM, Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> On Mon,  3 Apr 2017 10:58:22 +0200
> Sergio Lopez <slp@redhat.com> wrote:
>
> > When quickly unmapping and mapping memory regions (as may happen in
> > address_space_update_topology), if running with a non-unlimited
> > RLIMIT_MEMLOCK, the kernel may return ENOMEM for a map request
> > because the previous unmap has been processed, but accounted yet.
> >
> > Probably this should be fixed in the kernel ensuring a deterministic
> > behavior for VFIO map and unmap operations. Until then, this works
> > around the issue, waiting 10ms and trying again.
>
> I think we need to know what that kernel fix is before adding arbitrary
> delays and retries in userspace code (Do we know why 10ms works?  Is
> it too long/short?).

AFAIK from userspace we can't know when a certain work scheduled in a
kernel workqueue has been completed. Calling usleep ensures the
process will yield, and 10ms looks enough time for a full world of
context switches, but I agree with you that's pretty arbitrary.

On the other hand, this code is only reached in a pretty exceptional
situation, which is not relevant from a performance point of view, and
there's already a workaround for a non-deterministic EBUSY while
mapping VGA ROM space.

There's the option of leaving this as is, and waiting for a fix in the
kernel, but I think I'd a good idea to work around the issue for older
kernels too.

Sergio.
