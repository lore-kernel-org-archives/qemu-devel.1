Received: from eggs.gnu.org ([2001:4830:134:3::10]:51834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePXcv-0006oZ-3V
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:48:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePXcr-0006xl-24
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:48:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50998)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ePXcq-0006vV-Qd
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:48:52 -0500
Date: Thu, 14 Dec 2017 17:48:42 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171214174842.GT14433@stefanha-x1.localdomain>
References: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
	<1512444796-30615-5-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="skzcsJvRJWOW8YcK"
Content-Disposition: inline
In-Reply-To: <1512444796-30615-5-git-send-email-wei.w.wang@intel.com>
Subject: Re: [Qemu-devel] [PATCH v3 4/7] vhost-pci-slave: add vhost-pci
 slave implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, jan.kiszka@siemens.com, avi.cohen@huawei.com, zhiyong.yang@intel.com


--skzcsJvRJWOW8YcK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 05, 2017 at 11:33:13AM +0800, Wei Wang wrote:
> The vhost-pci slave implementation is added to support the creation of
> the vhost-pci-net device. It follows the vhost-user protocol to get the
> master VM's info (e.g. memory regions, vring address).

How does the guest know when the QEMU vhost-user slave has finished
initializing everything?  It seems like a guest driver could access the
device before things are initialized.

How will reconnection work?

> +static int vp_slave_get_features(VhostPCINet *vpnet, CharBackend *chr_be,
> +                                 VhostUserMsg *msg)
> +{
> +    /* Offer the initial features, which have the protocol feature bit set */
> +    msg->payload.u64 = (uint64_t)vpnet->host_features |
> +                       (1 << VHOST_USER_F_PROTOCOL_FEATURES);

How can the vhost-user slave inside the guest participate in feature
negotiation?  It must be able to participate, otherwise slaves cannot
disable features that QEMU supports but they don't want to support.

It's not feasible to pass in host_features as a QEMU parameter because
that would require libvirt, OpenStack, cloud providers, etc to add
support so users can manually set the bits for their slave
implementation.

> +static int vp_slave_get_queue_num(CharBackend *chr_be, VhostUserMsg *msg)
> +{
> +    msg->payload.u64 = VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MAX;

The guest cannot limit the number of virtqueues?

--skzcsJvRJWOW8YcK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaMrl6AAoJEJykq7OBq3PIXKgH/0YBlqyEsOSLujfwqFGlx//c
s6xRj8aECV9s7rrQp8VQAzCIOJAgCGhzlDZHkJgs/JvlFgdGpS7SoLiNMewSvd7q
jWQoOISMxrfnDd5OIeDReRZqbi2eYejCeEIXRMHyCOEv+8UpP9XIks3wG7e0T/ky
JtZ+cvMhAtTuxpzS49bcA1r8L6PGNW7LZEv4VzW65541IXN7Mjr+tEVnrcIO/RXJ
ugDcLOMc6X+9Yc8rgx2cbZQZ7cR/udNi/s5vs2egCs1YaWmb2FEf6ipv+wzdT4vd
1h/2rZIQf9eHO+8LMGOWGE/tig7Lw+9Blfyti6CHJUJ31tX3p/5VTn/ovE0cs78=
=SWrl
-----END PGP SIGNATURE-----

--skzcsJvRJWOW8YcK--
