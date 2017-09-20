Received: from eggs.gnu.org ([2001:4830:134:3::10]:44453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duZtq-0007G2-Md
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 03:58:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duZtn-0007pc-H5
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 03:58:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45992)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1duZtn-0007m2-B6
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 03:58:23 -0400
Date: Wed, 20 Sep 2017 09:58:18 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170920095818.17c52249.cohuck@redhat.com>
In-Reply-To: <20170919182745.90280-4-pasic@linux.vnet.ibm.com>
References: <20170919182745.90280-1-pasic@linux.vnet.ibm.com>
	<20170919182745.90280-4-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 3/5] virtio-ccw: use ccw data stream
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On Tue, 19 Sep 2017 20:27:43 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> Replace direct access which implicitly assumes no IDA
> or MIDA with the new ccw data stream interface which should
> cope with these transparently in the future.
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Reviewed-by: Pierre Morel<pmorel@linux.vnet.ibm.com>
> ---
>  hw/s390x/virtio-ccw.c | 157 +++++++++++++++-----------------------------------
>  1 file changed, 46 insertions(+), 111 deletions(-)
> 

> @@ -417,9 +382,9 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
>                  /* Return zeroes if the guest supports more feature bits. */
>                  features.features = 0;
>              }
> -            address_space_stl_le(&address_space_memory, ccw.cda,
> -                                 features.features, MEMTXATTRS_UNSPECIFIED,
> -                                 NULL);
> +            ccw_dstream_rewind(&sch->cds);
> +            cpu_to_le32s(&features.features);
> +            ccw_dstream_write(&sch->cds, features.features);
>              sch->curr_status.scsw.count = ccw.count - sizeof(features);

Hm, didn't you want to convert these as well? Or do you plan to do it
as an add-on patch?

>              ret = 0;
>          }
