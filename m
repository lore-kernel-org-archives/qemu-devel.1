Received: from eggs.gnu.org ([2001:4830:134:3::10]:43561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liang.z.li@intel.com>) id 1cEcNk-0008J5-Sf
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 08:35:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liang.z.li@intel.com>) id 1cEcNf-0005Gz-SX
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 08:35:36 -0500
Received: from mga14.intel.com ([192.55.52.115]:64643)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liang.z.li@intel.com>)
	id 1cEcNf-0005FR-Jq
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 08:35:31 -0500
From: "Li, Liang Z" <liang.z.li@intel.com>
Date: Wed, 7 Dec 2016 13:35:26 +0000
Message-ID: <F2CBF3009FA73547804AE4C663CAB28E3A130C01@shsmsx102.ccr.corp.intel.com>
References: <1480495397-23225-1-git-send-email-liang.z.li@intel.com>
	<f67ca79c-ad34-59dd-835f-e7bc9dcaef58@redhat.com>
In-Reply-To: <f67ca79c-ad34-59dd-835f-e7bc9dcaef58@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH kernel v5 0/5] Extend virtio-balloon for
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
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "mhocko@suse.com" <mhocko@suse.com>, "mst@redhat.com" <mst@redhat.com>, "Hansen, Dave" <dave.hansen@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>

> Am 30.11.2016 um 09:43 schrieb Liang Li:
> > This patch set contains two parts of changes to the virtio-balloon.
> >
> > One is the change for speeding up the inflating & deflating process,
> > the main idea of this optimization is to use bitmap to send the page
> > information to host instead of the PFNs, to reduce the overhead of
> > virtio data transmission, address translation and madvise(). This can
> > help to improve the performance by about 85%.
>=20
> Do you have some statistics/some rough feeling how many consecutive bits =
are
> usually set in the bitmaps? Is it really just purely random or is there s=
ome
> granularity that is usually consecutive?
>=20

I did something similar. Filled the balloon with 15GB for a 16GB idle guest=
, by
using bitmap, the madvise count was reduced to 605. when using the PFNs, th=
e madvise count
was 3932160. It means there are quite a lot consecutive bits in the bitmap.
I didn't test for a guest with heavy memory workload.=20

> IOW in real examples, do we have really large consecutive areas or are al=
l
> pages just completely distributed over our memory?
>=20

The buddy system of Linux kernel memory management shows there should be qu=
ite a lot of
 consecutive pages as long as there are a portion of free memory in the gue=
st.
If all pages just completely distributed over our memory, it means the memo=
ry=20
fragmentation is very serious, the kernel has the mechanism to avoid this h=
appened.
In the other hand, the inflating should not happen at this time because the=
 guest is almost
'out of memory'.

Liang

> Thanks!
>=20
> --
>=20
> David
