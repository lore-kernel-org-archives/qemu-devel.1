Received: from eggs.gnu.org ([2001:4830:134:3::10]:35832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fId9f-0005rZ-Q8
	for qemu-devel@nongnu.org; Tue, 15 May 2018 12:50:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fId9f-0003wT-2T
	for qemu-devel@nongnu.org; Tue, 15 May 2018 12:50:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42284 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fId9e-0003uj-8X
	for qemu-devel@nongnu.org; Tue, 15 May 2018 12:50:26 -0400
References: <20180501085939.6201-1-peter.maydell@linaro.org>
	<c338d0d3-2b02-26e7-f745-fbc5c1893453@redhat.com>
	<CAFEAcA_Dei48HtKk6GnEgXYcXdY2htCXej4pSfY+q9V6f=abdA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1738f78f-b310-3cde-ac5e-1a147d3ca5f6@redhat.com>
Date: Tue, 15 May 2018 18:50:16 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_Dei48HtKk6GnEgXYcXdY2htCXej4pSfY+q9V6f=abdA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 00/12] iommu: add MemTxAttrs
 argument to IOMMU translate function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Eric Auger <eric.auger@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 15/05/2018 18:28, Peter Maydell wrote:
>=20
> Presumably we also want a way for notifier users like vfio to
> detect "I'm dealing with an IOMMU that is txattrs aware in a
> way I can't deal with" so they can usefully bail out rather than
> not working.
>=20
> Unfortunately I don't really know enough about our two current
> users of notifiers (vhost and vfio) to know what they actually
> need the iommu notifications for...

As you guessed on IRC, they basically establish a shadow IOMMU page
table or TLB.  My proposal would be to add two MemTxAttrs arguments to
the IOMMUNotify typedef and to memory_region_notify_one, respectively to
indicate which attributes matter (0 =3D indifferent, 1 =3D matter) and th=
eir
value.  So far so good.

Perhaps memory_region_register_iommu_notifier can also get an argument
with the supported attributes.  The function would then fail if there
are fewer bits set in that argument than what the IOMMU supports...

The only problem with that is that memory_region_register_iommu_notifier
is called late from VFIO, and in a place that really cannot fail (a
MemoryListener's region_add callback).  So I would not be sure about how
to deal with failure in the VFIO code.

Thanks,

Paolo
