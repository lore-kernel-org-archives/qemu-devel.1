Received: from eggs.gnu.org ([2001:4830:134:3::10]:52825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1etaGY-0002a4-LX
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 09:42:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1etaGT-0004b3-HQ
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 09:42:02 -0500
Date: Wed, 7 Mar 2018 15:41:51 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180307154151.4e51b2fb.cohuck@redhat.com>
In-Reply-To: <36825fd8-fb91-069a-01d7-520a97c743d9@linux.vnet.ibm.com>
References: <1519746259-27710-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1519746259-27710-6-git-send-email-akrowiak@linux.vnet.ibm.com>
	<00b392ee-c928-3b22-4caf-33e7ce04f7f7@redhat.com>
	<e0b24000-0d2a-46f5-c880-89bf6a394bbb@linux.vnet.ibm.com>
	<bf963413-21ad-9b33-bd6c-e096e5686c59@redhat.com>
	<20180228124058.6166d957.cohuck@redhat.com>
	<b60e70b9-f076-8cc9-7c29-2887954b1404@linux.vnet.ibm.com>
	<c739f2ad-8e9a-1fa0-4277-3c4447c6ef15@redhat.com>
	<c0ff3874-e933-e30b-bc37-60abc4732a23@linux.vnet.ibm.com>
	<05cd3b46-1fa6-6cf6-b414-5dfa2af13105@redhat.com>
	<36825fd8-fb91-069a-01d7-520a97c743d9@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 5/5] s390x/cpumodel: Set up CPU model
 for AP device support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, bjsdjshi@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net

On Wed, 7 Mar 2018 11:09:46 +0100
Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:

> What I mean is the reverse implication
>=20
> ECA_APIE =3D> ap=3Don
>=20
> But you can have ap =3D on and ECA_APIE =3D off
> This is interception or emulation.
>=20
> and the second thing is that we need two QEMU cpu features
> AP : guest API to say we provide AP instructions to the guest (what ever=
=20
> we do to provide it)
> ECA_APIE : kernel will setup the SIE with interpretation
>=20
> other said:
> if( !ap)
>  =C2=A0=C2=A0=C2=A0 return -ENODEVICE
> if(ECA_API)
>  =C2=A0=C2=A0=C2=A0 set_interpretation()
> else
>  =C2=A0=C2=A0=C2=A0 set_interception()

This discussion is giving me a headache, so let's take a step back and
figure out what is needed/wanted/possible.

* straight passthrough of tuples, SIE doing the heavy lifting
  -> what this patchset is doing, and should be fine, even regarding
     nesting

* remapping of tuples, SIE doing most of the work (IIRC it's possible
  to only intercept for a subset of instructions?)
  -> that's where it gets complicated, and IIUC we can't have any mixed
     straight/remap setups, and we may have issues regarding nesting
  Question: How important is that use case? Can we drop it and make our
  lives much easier?

* full emulation (which would be the only option for tcg, obviously)
  -> even if it were doable, I doubt it would be very useful
  It would be great if we could have a design that would also
  accommodate this (and I have rooted for that in the past), but the
  more I hear about the issues here, the more I doubt whether this is
  something we should spend time on.

Another question: Can some of the use cases be serviced via
virtio-crypto as well (clear key)? Would that in combination with
straight passthrough be enough?
