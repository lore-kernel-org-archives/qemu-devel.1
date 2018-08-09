Received: from eggs.gnu.org ([2001:4830:134:3::10]:57829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1fnlAY-00041W-3g
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 09:40:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1fnlAS-0005nr-Vm
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 09:40:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37288 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1fnlAS-0005mz-Pf
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 09:39:56 -0400
References: <20180806143412.27722-1-e.emanuelegiuseppe@gmail.com>
	<20180806143412.27722-14-e.emanuelegiuseppe@gmail.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <d0252c8c-801e-5e20-67ef-a36e9819cd59@redhat.com>
Date: Thu, 9 Aug 2018 15:39:53 +0200
MIME-Version: 1.0
In-Reply-To: <20180806143412.27722-14-e.emanuelegiuseppe@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 13/34] test/qgraph: virtio_start_device
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>

On 06/08/2018 16:33, Emanuele Giuseppe Esposito wrote:
> This function is intended to group all the qvirtio_* functions that
> start the qvirtio devices.
> Applied in all tests using this combination of functions.
>=20
> Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com=
>
> ---
>  tests/libqos/virtio.c    |  8 ++++++++
>  tests/libqos/virtio.h    |  1 +
>  tests/vhost-user-test.c  |  5 +----
>  tests/virtio-9p-test.c   |  6 +-----
>  tests/virtio-blk-test.c  | 18 ++----------------
>  tests/virtio-net-test.c  |  6 +-----
>  tests/virtio-scsi-test.c |  4 +---
>  7 files changed, 15 insertions(+), 33 deletions(-)
>=20
> diff --git a/tests/libqos/virtio.c b/tests/libqos/virtio.c
> index 0dad5c19ac..56007ef11b 100644
> --- a/tests/libqos/virtio.c
> +++ b/tests/libqos/virtio.c
> @@ -365,3 +365,11 @@ const char *qvirtio_get_dev_type(void)
>          return "pci";
>      }
>  }
> +
> +void qvirtio_start_device(QVirtioDevice *vdev)
> +{
> +    qvirtio_reset(vdev);
> +    qvirtio_set_acknowledge(vdev);
> +    qvirtio_set_driver(vdev);
> +    qvirtio_set_driver_ok(vdev);

I'm not sure you can put qvirtio_set_driver_ok() here.

qvirtio_set_driver_ok() must be called when the driver is OK, it means
that the virtio device must be fully initialized before (features,
virtqueue, MSI, ...).

http://docs.oasis-open.org/virtio/virtio/v1.0/virtio-v1.0.pdf

3.1.1 Driver Requirements: Device Initialization

The driver MUST follow this sequence to initialize a device:

1. Reset the device.

2. Set the ACKNOWLEDGE status bit: the guest OS has notice the device.

3. Set the DRIVER status bit: the guest OS knows how to drive the device.

4. Read device feature bits, and write the subset of feature bits
understood by the OS and driver to the
device. During this step the driver MAY read (but MUST NOT write) the
device-specific configuration
fields to check that it can support the device before accepting it.

5. Set the FEATURES_OK status bit. The driver MUST NOT accept new
feature bits after this step.

6. Re-read device status to ensure the FEATURES_OK bit is still set:
otherwise, the device does not
support our subset of features and the device is unusable.

7. Perform device-specific setup, including discovery of virtqueues for
the device, optional per-bus setup,
reading and possibly writing the device=E2=80=99s virtio configuration sp=
ace,
and population of virtqueues.

8. Set the DRIVER_OK status bit. At this point the device is =E2=80=9Cliv=
e=E2=80=9D.

Thanks,
Laurent
