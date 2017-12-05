Received: from eggs.gnu.org ([2001:4830:134:3::10]:52718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eMFiq-0004Bv-RC
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 11:05:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eMFil-000476-2M
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 11:05:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eMFik-00046f-EB
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 11:05:22 -0500
Date: Tue, 5 Dec 2017 16:05:12 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171205160512.GI31150@stefanha-x1.localdomain>
References: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
	<1512444796-30615-8-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IbA9xpzOQlG26JSn"
Content-Disposition: inline
In-Reply-To: <1512444796-30615-8-git-send-email-wei.w.wang@intel.com>
Subject: Re: [Qemu-devel] [PATCH v3 7/7] virtio/vhost.c: vhost-pci needs
 remote gpa
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


--IbA9xpzOQlG26JSn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2017 at 11:33:16AM +0800, Wei Wang wrote:
> The vhost-pci driver uses the remote guest physical address to send/recei=
ve
> packets from the remote guest, so when sending the ving info to the vhost=
-pci
> device, send the guest physical adress directly.
>=20
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> ---
>  hw/virtio/vhost.c | 56 +++++++++++++++++++++++++++++++++++--------------=
------
>  1 file changed, 36 insertions(+), 20 deletions(-)

Can you do it inside vhost_memory_map()/vhost_memory_unmap() instead of
modifying callers?

Looks like vhost_dev_has_iommu() already takes this approach:

  static void *vhost_memory_map(struct vhost_dev *dev, hwaddr addr,
                                hwaddr *plen, int is_write)
  {
      if (!vhost_dev_has_iommu(dev)) {
          return cpu_physical_memory_map(addr, plen, is_write);
      } else {
          return (void *)(uintptr_t)addr;
      }
  }

  static void vhost_memory_unmap(struct vhost_dev *dev, void *buffer,
                                 hwaddr len, int is_write,
                                 hwaddr access_len)
  {
      if (!vhost_dev_has_iommu(dev)) {
          cpu_physical_memory_unmap(buffer, len, is_write, access_len);
      }
  }

--IbA9xpzOQlG26JSn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaJsO4AAoJEJykq7OBq3PIndIIAJVDu+kYHihu0Wpt55t8Skhh
9hiaomoNoIUoB1w9gkPvS/HkSgs93FaUrBCdbhSUb/J5NvaOzq2uiHPLx3w7tOCx
25ImbA2BBk+r+gMjCKbe1drpszrBzQ83C6IIDt6RZq+KgLDkzn6VcvupLMg1siSU
f0Z/1n5byD3kutBQ/oo2i9mopJ7D1GEiYJNr3+pLh/ON4vaSZOjNis+43s0f8WV6
diU18Hmh9K96yir793Pa50sL1vaBjP4enc+ujXEY7UlxLHwK31LmUTP0WqHyl+/F
+8K14mJs1cAZ718yCuednPmaxbH6PWd9E6JByr++G52STY6JahAlVP2uSLEQdZ0=
=U1Pb
-----END PGP SIGNATURE-----

--IbA9xpzOQlG26JSn--
