Received: from eggs.gnu.org ([2001:4830:134:3::10]:55456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liang.z.li@intel.com>) id 1cTqJV-0006rF-Et
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 08:30:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liang.z.li@intel.com>) id 1cTqJS-0004hW-PW
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 08:30:09 -0500
Received: from mga09.intel.com ([134.134.136.24]:16017)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liang.z.li@intel.com>)
	id 1cTqJS-0004gB-F6
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 08:30:06 -0500
From: "Li, Liang Z" <liang.z.li@intel.com>
Date: Wed, 18 Jan 2017 13:29:59 +0000
Message-ID: <F2CBF3009FA73547804AE4C663CAB28E3C356F1B@shsmsx102.ccr.corp.intel.com>
References: <1482303148-22059-1-git-send-email-liang.z.li@intel.com>
	<2a32f616-25a8-ba5a-f74c-d619fc8ab333@redhat.com>
In-Reply-To: <2a32f616-25a8-ba5a-f74c-d619fc8ab333@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v6 kernel 0/5] Extend virtio-balloon for
 fast (de)inflating & fast live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "Hansen, Dave" <dave.hansen@intel.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "aarcange@redhat.com" <aarcange@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "quintela@redhat.com" <quintela@redhat.com>

> Am 21.12.2016 um 07:52 schrieb Liang Li:
> > This patch set contains two parts of changes to the virtio-balloon.
> >
> > One is the change for speeding up the inflating & deflating process,
> > the main idea of this optimization is to use {pfn|length} to present
> > the page information instead of the PFNs, to reduce the overhead of
> > virtio data transmission, address translation and madvise(). This can
> > help to improve the performance by about 85%.
> >
> > Another change is for speeding up live migration. By skipping process
> > guest's unused pages in the first round of data copy, to reduce
> > needless data processing, this can help to save quite a lot of CPU
> > cycles and network bandwidth. We put guest's unused page information
> > in a {pfn|length} array and send it to host with the virt queue of
> > virtio-balloon. For an idle guest with 8GB RAM, this can help to
> > shorten the total live migration time from 2Sec to about 500ms in
> > 10Gbps network environment. For an guest with quite a lot of page
> > cache and with little unused pages, it's possible to let the guest
> > drop it's page cache before live migration, this case can benefit from =
this
> new feature too.
>=20
> I agree that both changes make sense (although the second change just
> smells very racy, as you also pointed out in the patch description), howe=
ver I
> am not sure if virtio-balloon is really the right place for the latter ch=
ange.
>=20
> virtio-balloon is all about ballooning, nothing else. What you're doing i=
s using
> it as a way to communicate balloon-unrelated data from/to the hypervisor.
> Yes, it is also about guest memory, but completely unrelated to the purpo=
se
> of the balloon device.
>=20
> Maybe using virtio-balloon for this purpose is okay - I have mixed feelin=
gs
> (especially as I can't tell where else this could go). I would like to ge=
t a second
> opinion on this.
>=20

We have ever discussed the implementation for a long time, making use the c=
urrent
virtio balloon seems better than the other solutions and is recommended by =
Michael.

Thanks!
Liang
> --
>=20
> David
