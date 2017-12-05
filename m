Received: from eggs.gnu.org ([2001:4830:134:3::10]:49331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eMFa3-0007Lb-Om
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 10:56:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eMFZz-0007Da-UW
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 10:56:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eMFZz-0007DD-KS
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 10:56:19 -0500
Date: Tue, 5 Dec 2017 15:56:01 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171205155601.GG31150@stefanha-x1.localdomain>
References: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
	<1512444796-30615-5-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bFsKbPszpzYNtEU6"
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


--bFsKbPszpzYNtEU6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 05, 2017 at 11:33:13AM +0800, Wei Wang wrote:
> +static int vp_slave_write(CharBackend *chr_be, VhostUserMsg *msg)
> +{
> +    int size;
> +
> +    if (!msg) {
> +        return 0;
> +    }
> +
> +    /* The payload size has been assigned, plus the header size here */
> +    size = msg->size + VHOST_USER_HDR_SIZE;
> +    msg->flags &= ~VHOST_USER_VERSION_MASK;
> +    msg->flags |= VHOST_USER_VERSION;
> +
> +    return qemu_chr_fe_write_all(chr_be, (const uint8_t *)msg, size)
> +           == size ? 0 : -1;
> +}

qemu_chr_fe_write_all() is a blocking operation.  If the socket fd
cannot accept more data then this thread will block!

This is a reliability problem.  If the vhost-user master process hangs
then the vhost-pci vhost-user slave will also hang :(.

Please implement vhost-pci so that it does not hang.  A guest with
multiple vhost-pci devices should work even if one or more of them
cannot communicate with the vhost-pci master.  This is necessary for
preventing denial-of-service on a software-defined network switch, for
example.

> +static void vp_slave_set_vring_num(VhostPCINet *vpnet, VhostUserMsg *msg)
> +{
> +    struct vhost_vring_state *state = &msg->payload.state;
> +
> +    vpnet->metadata->vq[state->index].vring_num = state->num;

The vhost-pci code cannot trust vhost-user input.  This function allows
the vhost-user master to perform out-of-bounds memory stores by setting
state->index outside the vq[] array.

All input must be validated!  The security model is:

1. Guest must be able to corrupt QEMU memory or execute arbitrary code.
2. vhost-user master guest must not be able to corrupt vhost-user slave
   guest memory or execute arbitrary code.
3. vhost-user master must not be able to corrupt vhost-user memory or
   execute arbitrary code in vhost-user slave.
4. vhost-user slave must not be able to corrupt vhost-user memory or
   execute arbitrary code in vhost-user master.

The only thing that is allowed is vhost-user slave QEMU and guest may
write to vhost-user master guest memory.

> +void vp_slave_read(void *opaque, const uint8_t *buf, int size)
> +{
> +    int ret, fd_num, fds[VHOST_MEMORY_MAX_NREGIONS];
> +    VhostUserMsg msg;
> +    uint8_t *p = (uint8_t *) &msg;
> +    VhostPCINet *vpnet = (VhostPCINet *)opaque;
> +    CharBackend *chr_be = &vpnet->chr_be;
> +
> +    if (size != VHOST_USER_HDR_SIZE) {
> +        error_report("%s: wrong message size received %d", __func__, size);
> +        return;
> +    }
> +
> +    memcpy(p, buf, VHOST_USER_HDR_SIZE);
> +
> +    if (msg.size) {
> +        p += VHOST_USER_HDR_SIZE;
> +        size = qemu_chr_fe_read_all(chr_be, p, msg.size);

This is a blocking operation.  See my comment about
qemu_chr_fe_write_all().

This is also a buffer overflow since msg.size is not validated.  All
input from the vhost-user master needs to be validated.

--bFsKbPszpzYNtEU6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaJsGRAAoJEJykq7OBq3PIz/kIAJe/WvHXod265x1o3g20lOb0
y/0V3HRQz8YDGNO1JhSJcbLek/cBIo8cEhrxIljC3Q2kfHCoQzFXAGkL3O0Qrkwo
wAzl9U9rpSZnSQWS9J0Vc31qUEENixUW/C0iEDy/JcJoowXLJpDu5t7fi3Bo2aWq
vAWU67dl/GQmewRijKkKkCofbyVHjKEytoygk2JEoZJzXbzoHNjo7xC1FaXKNm6J
CUCvNh+B6sAU1EloGuoBKe0n/lR/kaQxjPOWUk2IBkuAkNCVADaWcwOZp/E2f59N
YZTbMagmPmfBD8hO1Dbd222PiPEkXIeaL9NyDGIPeWvHsIAvW3T8HqIXylFjp34=
=jtTG
-----END PGP SIGNATURE-----

--bFsKbPszpzYNtEU6--
