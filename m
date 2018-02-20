Received: from eggs.gnu.org ([2001:4830:134:3::10]:44743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eo6Nh-0004GF-QL
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 06:46:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eo6Ne-0005BM-P3
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 06:46:45 -0500
References: <20180219174231.10874-1-david@redhat.com>
	<39db6736-b5c5-832f-ffef-1d0a59b85ac2@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <446a343e-dd8d-effe-d660-df55fda16a96@redhat.com>
Date: Tue, 20 Feb 2018 12:46:23 +0100
MIME-Version: 1.0
In-Reply-To: <39db6736-b5c5-832f-ffef-1d0a59b85ac2@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFCv2] s390x/sclp: remove memory hotplug
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>

On 20.02.2018 12:18, Christian Borntraeger wrote:
> Given that we have trouble modeling this properly I somewhat like the i=
dea.
> We should have never folded this into the common code memory hotplug=20
> infrastructure as it is different. Instead we really should have provid=
ed
> a different interface and we should have build it with migration suppor=
t.=20
>=20
> If we need it again in the future, we can certainly add it back via an=20
> s390 specific interface.
>=20

Thinking out load (stuff we could to in the future):

We could model ordinary memory (-m XG) using standby memory. But instead
of creating and deleting memory regions, work on a single huge one (just
as now). (using compat machines to control behavior)

What would be the optimization? When the guest tells us to unassign
memory, we can simply madv(free) that memory.

That means if the guest unplugs(offlines) memory, we can actually free
the backing storage. This way it acts somewhat like a balloon - but also
gets rid of struct pages in the guest.

Of course, this would still not be real memory hot(un)plug, as there is
no way to control it from the outside. Just a possible optimization.


--=20

Thanks,

David / dhildenb
