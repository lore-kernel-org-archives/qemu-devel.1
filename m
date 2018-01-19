Received: from eggs.gnu.org ([2001:4830:134:3::10]:41595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ecV2p-0004Hp-Rs
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 06:41:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ecV2k-0003Ex-Ub
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 06:41:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48930)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ecV2k-0003EX-OH
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 06:41:10 -0500
References: <20180119084219.31187-1-peterx@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b84e60fb-a527-204b-f355-b051e30d519f@redhat.com>
Date: Fri, 19 Jan 2018 12:41:01 +0100
MIME-Version: 1.0
In-Reply-To: <20180119084219.31187-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 0/2] memory/vfio: notify region_del() when
 unregister listeners
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Alexey Kardashevskiy <aik@ozlabs.ru>, Alex Williamson <alex.williamson@redhat.com>

On 19/01/2018 09:42, Peter Xu wrote:
> I encountered an event loss problem during unplugging vfio devices:
>=20
>   https://bugzilla.redhat.com/show_bug.cgi?id=3D1531393
>=20
> I thought it should be a simple VT-d issue but I was wrong.  The whole
> debugging leads me to these patches.
>=20
> Basically I think what we missed is that when unregistering memory
> listeners, we don't really call region_del() at all.  Instead we just
> remove ourselves from the listener list.  IMHO that's not enough.  A
> clean unregister should undo all possible changes that have done
> during region_add().  That's patch 1.
>=20
> Patch 2 fixes a vfio issue when patch 1 is applied.

It makes sense, though of course patch 1 must come second for
bisectability.  Of the other listeners, most do not implement
region_del, but commit must be audited as well.  What matters is whether
the listener is unregistered, and only few are:

- kvm_arm_machine_init_done must unregister the listener after the
QSLIST_FOREACH_SAFE loop.

- Xen seems okay

- vhost needs to remove the memory_region_unref loop after unregistering
the listener - and this must be done at the same time as patch 1, not bef=
ore

- virtio seems okay

Thanks,

Paolo
