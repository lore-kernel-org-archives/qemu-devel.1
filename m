Received: from eggs.gnu.org ([209.51.188.92]:48139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nsoffer@redhat.com>) id 1gpK8X-0002Oe-7p
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:44:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nsoffer@redhat.com>) id 1gpK8V-0004Gp-G1
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:44:41 -0500
Received: from mail-ua1-f41.google.com ([209.85.222.41]:35383)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nsoffer@redhat.com>) id 1gpK8T-0004FD-Uu
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:44:39 -0500
Received: by mail-ua1-f41.google.com with SMTP id d2so1594697ual.2
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 13:44:37 -0800 (PST)
MIME-Version: 1.0
References: <20190131175549.11691-1-kwolf@redhat.com>
	<20190131175549.11691-2-kwolf@redhat.com>
	<d887367f-053e-6541-a6d7-cc84b23db841@redhat.com>
In-Reply-To: <d887367f-053e-6541-a6d7-cc84b23db841@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Thu, 31 Jan 2019 23:44:24 +0200
Message-ID: <CAMRbyyvq-aeXat=OqGKk=CiW-3Dx8xr6s_S34VsoceWdZ5pUYQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-block] [RFC PATCH 01/11] qcow2: Extend spec
 for external data files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Adam Litke <alitke@redhat.com>

On Thu, Jan 31, 2019 at 8:43 PM Eric Blake <eblake@redhat.com> wrote:
...

> > @@ -450,8 +461,10 @@ Standard Cluster Descriptor:
>
>           1 -  8:    Reserved (set to 0)
> >
> >           9 - 55:    Bits 9-55 of host cluster offset. Must be aligned
> to a
> > -                    cluster boundary. If the offset is 0, the cluster is
> > -                    unallocated.
> > +                    cluster boundary. If the offset is 0 and bit 63 is
> clear,
> > +                    the cluster is unallocated. The offset may only be
> 0 with
> > +                    bit 63 set (indicating a host cluster offset of 0)
> when an
> > +                    external data file is used.
>
> Does that mean that the value 0x00000000 is invalid for external data
> files, and that 0x00000001 is special-cased to mean read the contents of
> the external file (and NOT that the cluster reads as all zeroes)?  Is
> bit 0 allowed to be set for any other clusters when there is an external
> data file?  And if so, are we requiring that it only be set when the
> external file is known to read as zero, or can we run into the situation
> where qcow2 says the cluster reads as 0 but the host file contains
> garbage?  Should the external file header contain a flag that states
> whether writes to the image should wipe vs. leave unchanged a cluster in
> the external file when the qcow2 metadata prefers to grab that cluster's
> contents as all-0s or by reading from the backing file?


I hope we are not going to mix qcow2 layer with data file and backing
file in the same chain.

For oVirt we would never want to have a backing chain when using qcow2
metadata layer. I think this is the same use case for KubeVirt.


> There are
> security vs. speed implications - security insists on wiping the host
> file to NOT leave stale data, but that slows things down compared to
> just leaving garbage if the qcow2 metadata can effectively ignore those
> parts of the external file - hence a knob may be worth exposing?
>

Since qcow2 is just used to managed metadata about a raw file, I don't
think it should do any optimizations like this.

What if we implement this differently - a qcow2 layer that keeps only
metadata for a backing file?

All reads will go directly to the backing file, since there is no data in
the
qcow2 file. All writes will go directly to the backing file, since no data
should
be in the qcow2 file. But before writing, update the qcow2 metadata to
reference
the cluster that will be written to the backing file.

Nir
