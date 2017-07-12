Received: from eggs.gnu.org ([2001:4830:134:3::10]:54625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dVIai-0004CT-Dq
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 10:26:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dVIae-0000bl-IE
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 10:26:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dVIae-0000Zh-Bk
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 10:26:08 -0400
References: <1499864265-144136-1-git-send-email-borntraeger@de.ibm.com>
	<1499864265-144136-12-git-send-email-borntraeger@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <27238e54-2a92-dbb8-73b0-e3f5b0e67934@redhat.com>
Date: Wed, 12 Jul 2017 16:26:02 +0200
MIME-Version: 1.0
In-Reply-To: <1499864265-144136-12-git-send-email-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 11/11] s390x/css: update
 css_adapter_interrupt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, Fei Li <sherrylf@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>

On 12.07.2017 14:57, Christian Borntraeger wrote:
> From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
>=20
> Let's use the new inject_airq callback of flic to inject adapter
> interrupts. For kvm case, if the kernel flic doesn't support the new
> interface, the irq routine remains unchanged. For non-kvm case,
> qemu-flic handles the suppression process.
>=20
> Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
> Signed-off-by: Fei Li <sherrylf@linux.vnet.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  hw/s390x/css.c          | 18 ++++++++++++++++--
>  hw/s390x/s390-pci-bus.c |  2 +-
>  hw/s390x/virtio-ccw.c   |  2 +-
>  include/hw/s390x/css.h  |  2 +-
>  4 files changed, 19 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index 7b82176..ee4ebbf 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -547,12 +547,26 @@ out:
>      return r;
>  }
> =20
> -void css_adapter_interrupt(uint8_t isc)
> +void css_adapter_interrupt(CssIoAdapterType type, uint8_t isc)
>  {
> +    S390FLICState *fs =3D s390_get_flic();
> +    S390FLICStateClass *fsc =3D S390_FLIC_COMMON_GET_CLASS(fs);
>      uint32_t io_int_word =3D (isc << 27) | IO_INT_WORD_AI;
> +    IoAdapter *adapter =3D channel_subsys.io_adapters[type][isc];
> +
> +    if (!adapter) {
> +        return;
> +    }
> =20
>      trace_css_adapter_interrupt(isc);
> -    s390_io_interrupt(0, 0, 0, io_int_word);
> +    if (fs->ais_supported) {
> +        if (fsc->inject_airq(fs, type, isc, adapter->flags)) {
> +            fprintf(stderr, "Failed to inject airq with AIS supported\=
n");

Use error_report() instead?

> +            exit(1);
> +        }
> +    } else {
> +        s390_io_interrupt(0, 0, 0, io_int_word);
> +    }
>  }

 Thomas
