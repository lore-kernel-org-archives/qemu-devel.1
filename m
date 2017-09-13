Received: from eggs.gnu.org ([2001:4830:134:3::10]:47230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ds6Ip-0004lf-2o
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 07:58:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ds6Io-0001Ag-32
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 07:57:59 -0400
References: <20170913091038.2900-1-cohuck@redhat.com>
	<20170913091038.2900-3-cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <cc528e2d-2ade-61f4-617e-46d0332bbab7@redhat.com>
Date: Wed, 13 Sep 2017 13:57:48 +0200
MIME-Version: 1.0
In-Reply-To: <20170913091038.2900-3-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/3] iotests: use -ccw on s390x for 051
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, kwolf@redhat.com, mreitz@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, thuth@redhat.com, haoqf@linux.vnet.ibm.com

On 13.09.2017 11:10, Cornelia Huck wrote:
> The default cpu model on s390x does not provide zPCI, which is
> not yet wired up on tcg. Moreover, virtio-ccw is the standard
> on s390x, so use the -ccw instead of the -pci versions of virtio
> devices on s390x.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  tests/qemu-iotests/051        | 12 +++++++++++-
>  tests/qemu-iotests/051.out    |  2 +-
>  tests/qemu-iotests/051.pc.out |  2 +-
>  3 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/qemu-iotests/051 b/tests/qemu-iotests/051
> index c8cfc764bc..dba8816c9f 100755
> --- a/tests/qemu-iotests/051
> +++ b/tests/qemu-iotests/051
> @@ -103,7 +103,17 @@ echo
>  echo === Device without drive ===
>  echo
>  
> -run_qemu -device virtio-scsi-pci -device scsi-hd
> +case "$QEMU_DEFAULT_MACHINE" in
> +  s390-ccw-virtio)
> +      virtio_scsi=virtio-scsi-ccw
> +      ;;
> +  *)
> +      virtio_scsi=virtio-scsi-pci
> +      ;;
> +esac
> +
> +run_qemu -device $virtio_scsi -device scsi-hd |
> +    sed -e "s/$virtio_scsi/VIRTIO_SCSI/"
>  
>  echo
>  echo === Overriding backing file ===
> diff --git a/tests/qemu-iotests/051.out b/tests/qemu-iotests/051.out
> index 4d3b1ff316..e3c6eaba57 100644
> --- a/tests/qemu-iotests/051.out
> +++ b/tests/qemu-iotests/051.out
> @@ -49,7 +49,7 @@ QEMU_PROG: -drive file=TEST_DIR/t.qcow2,driver=qcow2,format=qcow2: Cannot specif
>  
>  === Device without drive ===
>  
> -Testing: -device virtio-scsi-pci -device scsi-hd
> +Testing: -device VIRTIO_SCSI -device scsi-hd
>  QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) QEMU_PROG: -device scsi-hd: drive property not set
>  
> diff --git a/tests/qemu-iotests/051.pc.out b/tests/qemu-iotests/051.pc.out
> index 76d7205460..ae7801b44b 100644
> --- a/tests/qemu-iotests/051.pc.out
> +++ b/tests/qemu-iotests/051.pc.out
> @@ -49,7 +49,7 @@ QEMU_PROG: -drive file=TEST_DIR/t.qcow2,driver=qcow2,format=qcow2: Cannot specif
>  
>  === Device without drive ===
>  
> -Testing: -device virtio-scsi-pci -device scsi-hd
> +Testing: -device VIRTIO_SCSI -device scsi-hd
>  QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) QEMU_PROG: -device scsi-hd: drive property not set
>  
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David
