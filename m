Received: from eggs.gnu.org ([2001:4830:134:3::10]:44911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <x1917x@gmail.com>) id 1cxH0h-00051T-JZ
	for qemu-devel@nongnu.org; Sun, 09 Apr 2017 13:52:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <x1917x@gmail.com>) id 1cxH0d-00088n-Lm
	for qemu-devel@nongnu.org; Sun, 09 Apr 2017 13:52:23 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:36304)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <x1917x@gmail.com>) id 1cxH0d-00087g-EI
	for qemu-devel@nongnu.org; Sun, 09 Apr 2017 13:52:19 -0400
Received: by mail-lf0-x243.google.com with SMTP id 75so1339897lfs.3
	for <qemu-devel@nongnu.org>; Sun, 09 Apr 2017 10:52:15 -0700 (PDT)
Date: Mon, 10 Apr 2017 03:52:05 +1000
From: Alexey G <x1917x@gmail.com>
Message-ID: <20170410035205.000050b1@gmail.com>
In-Reply-To: <CADZi59xEg0SvScgo=Jg0MxTbGYY=nTX18Qo-4GMkfayThDU9zw@mail.gmail.com>
References: <CADZi59zNxk-Yr4rpN1E49s=AdsdW-W9YfhpCvpJeBz7oigyFSg@mail.gmail.com>
	<CADZi59xe6OcCasvtkPBjP7nTsgDA5r_E_Rt7W88BszYdJhuxGQ@mail.gmail.com>
	<CADZi59xEg0SvScgo=Jg0MxTbGYY=nTX18Qo-4GMkfayThDU9zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Xen-devel] [RFC/BUG] xen-mapcache: buggy
 invalidate map cache?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: hrg <hrgstephen@gmail.com>
Cc: anthony.perard@citrix.com, xen-devel@lists.xensource.com, qemu-devel@nongnu.org, jun.nakajima@intel.com, agraf@suse.de, sstabellini@kernel.org, xen-devel@lists.xenproject.org, wangxinxin.wang@huawei.com, "Herongguang (Stephen)" <herongguang.he@huawei.com>, xen-devel@lists.xen.org

On Mon, 10 Apr 2017 00:36:02 +0800
hrg <hrgstephen@gmail.com> wrote:

Hi,

> On Sun, Apr 9, 2017 at 11:55 PM, hrg <hrgstephen@gmail.com> wrote:
> > On Sun, Apr 9, 2017 at 11:52 PM, hrg <hrgstephen@gmail.com> wrote: =20
> >> Hi,
> >>
> >> In xen_map_cache_unlocked(), map to guest memory maybe in entry->next
> >> instead of first level entry (if map to rom other than guest memory
> >> comes first), while in xen_invalidate_map_cache(), when VM ballooned
> >> out memory, qemu did not invalidate cache entries in linked
> >> list(entry->next), so when VM balloon back in memory, gfns probably
> >> mapped to different mfns, thus if guest asks device to DMA to these
> >> GPA, qemu may DMA to stale MFNs.
> >>
> >> So I think in xen_invalidate_map_cache() linked lists should also be
> >> checked and invalidated.
> >>
> >> What=E2=80=99s your opinion? Is this a bug? Is my analyze correct? =20
> >
> > Added Jun Nakajima and Alexander Graf =20
> And correct Stefano Stabellini's email address.

There is a real issue with the xen-mapcache corruption in fact. I encounter=
ed
it a few months ago while experimenting with Q35 support on Xen. Q35 emulat=
ion
uses an AHCI controller by default, along with NCQ mode enabled. The issue =
can
be (somewhat) easily reproduced there, though using a normal i440 emulation
might possibly allow to reproduce the issue as well, using a dedicated test
code from a guest side. In case of Q35+NCQ the issue can be reproduced "as =
is".

The issue occurs when a guest domain performs an intensive disk I/O, ex. wh=
ile
guest OS booting. QEMU crashes with "Bad ram offset 980aa000"
message logged, where the address is different each time. The hard thing wi=
th
this issue is that it has a very low reproducibility rate.

The corruption happens when there are multiple I/O commands in the NCQ queu=
e.
So there are overlapping emulated DMA operations in flight and QEMU uses a
sequence of mapcache actions which can be executed in the "wrong" order thus
leading to an inconsistent xen-mapcache - so a bad address from the wrong
entry is returned.

The bad thing with this issue is that QEMU crash due to "Bad ram offset"
appearance is a relatively good situation in the sense that this is a caught
error. But there might be a much worse (artificial) situation where the ret=
urned
address looks valid but points to a different mapped memory.

The fix itself is not hard (ex. an additional checked field in MapCacheEntr=
y),
but there is a need of some reliable way to test it considering the low
reproducibility rate.

Regards,
Alex
