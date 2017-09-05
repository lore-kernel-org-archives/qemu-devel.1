Received: from eggs.gnu.org ([2001:4830:134:3::10]:50423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dpB3q-0003sx-G2
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 06:26:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dpB3l-0005K6-N0
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 06:26:26 -0400
References: <20170901180340.30009-1-eblake@redhat.com>
	<20170901180340.30009-17-eblake@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2ad3ad60-1f03-4585-45e1-d12ab593008f@redhat.com>
Date: Tue, 5 Sep 2017 12:26:05 +0200
MIME-Version: 1.0
In-Reply-To: <20170901180340.30009-17-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 16/29] libqos: Use explicit QTestState
 for virtio operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, "open list:virtio-blk" <qemu-block@nongnu.org>, armbru@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>

On 01.09.2017 20:03, Eric Blake wrote:
> Drop one more client of global_qtest by teaching all virtio test
> functionality to pass in an explicit QTestState in constructors,
> where it is then reused for later access.  Adjust all callers.
> This gets us one step closer to eliminating implicit use of
> global_qtest.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/libqos/virtio-mmio.h |  3 +-
>  tests/libqos/virtio.h      |  5 ++-
>  tests/libqos/virtio-mmio.c | 54 +++++++++++++++++---------------
>  tests/libqos/virtio-pci.c  |  3 ++
>  tests/libqos/virtio.c      | 77 ++++++++++++++++++++++++++------------=
--------
>  tests/virtio-blk-test.c    |  3 +-
>  6 files changed, 84 insertions(+), 61 deletions(-)
>=20
> diff --git a/tests/libqos/virtio-mmio.h b/tests/libqos/virtio-mmio.h
> index e3e52b9ce1..bd01386054 100644
> --- a/tests/libqos/virtio-mmio.h
> +++ b/tests/libqos/virtio-mmio.h
> @@ -41,6 +41,7 @@ typedef struct QVirtioMMIODevice {
>=20
>  extern const QVirtioBus qvirtio_mmio;
>=20
> -QVirtioMMIODevice *qvirtio_mmio_init_device(uint64_t addr, uint32_t pa=
ge_size);
> +QVirtioMMIODevice *qvirtio_mmio_init_device(QTestState *qts, uint64_t =
addr,
> +                                            uint32_t page_size);
>=20
>  #endif
> diff --git a/tests/libqos/virtio.h b/tests/libqos/virtio.h
> index 8fbcd1869c..d180d54fc4 100644
> --- a/tests/libqos/virtio.h
> +++ b/tests/libqos/virtio.h
> @@ -19,6 +19,7 @@ typedef struct QVirtioBus QVirtioBus;
>=20
>  typedef struct QVirtioDevice {
>      const QVirtioBus *bus;
> +    QTestState *qts;
>      /* Device type */
>      uint16_t device_type;
>  } QVirtioDevice;
> @@ -35,12 +36,14 @@ typedef struct QVirtQueue {
>      uint16_t last_used_idx;
>      bool indirect;
>      bool event;
> +    QTestState *qts;
>  } QVirtQueue;
>=20
>  typedef struct QVRingIndirectDesc {
>      uint64_t desc; /* This points to an array fo struct vring_desc */
>      uint16_t index;
>      uint16_t elem;
> +    QTestState *qts;
>  } QVRingIndirectDesc;

Adding QTestState to QVRingIndirectDesc and QVirtQueue sounds somewhat
ugly to me. I think they should either rather have a pointer to the
associated QVirtioDevice, or the functions where this is needed
(qvring_init() for example) should get a "QTestState *" parameter instead=
.

Just my 0.02 =E2=82=AC.

 Thomas
