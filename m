Received: from eggs.gnu.org ([2001:4830:134:3::10]:54823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ctT7b-0000PW-5s
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 01:59:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ctT7Y-0001dY-5C
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 01:59:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34152)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1ctT7Y-0001as-0u
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 01:59:44 -0400
References: <1490767970-23689-1-git-send-email-jasowang@redhat.com>
	<20170330002612-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <e63339c3-e368-b5d8-a60f-69684bb5496a@redhat.com>
Date: Thu, 30 Mar 2017 13:59:33 +0800
MIME-Version: 1.0
In-Reply-To: <20170330002612-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] exec: don't return int64_t in
 address_space_cache_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: pbonzini@redhat.com, crosthwaite.peter@gmail.com, rth@twiddle.net, qemu-devel@nongnu.org, Cornelia Huck <cornelia.huck@de.ibm.com>



On 2017=E5=B9=B403=E6=9C=8830=E6=97=A5 05:26, Michael S. Tsirkin wrote:
> On Wed, Mar 29, 2017 at 02:12:50PM +0800, Jason Wang wrote:
>> We return int64_t as the length of region cache but accept hwaddr as
>> the required length. This is wrong and may confuse the caller since
>> the it can lead comparison between signed and unsigned types. The
>> caller can not catch the failure in this case. Fixing this by
>> returning hwaddr and return zero on failure.
>>
>> Fixes: 5eba0404b9829 ("virtio: use MemoryRegionCache to access descrip=
tors")
>> Fixes: e45da65322386 ("virtio: validate address space cache during ini=
t")
>> Cc: Cornelia Huck<cornelia.huck@de.ibm.com>
>> Cc: Paolo Bonzini<pbonzini@redhat.com>
>> Signed-off-by: Jason Wang<jasowang@redhat.com>
> Can you be more specific about the symptoms this fixes in the
> commit log?
> E.g. "This actually triggers on XYZ when using ABC".
>
>

I want do this, but in fact this was triggered by a bug of qemu (see the=20
thread of iommu reset vs region cache).

In that case, when used map fails, then check

      if (len < size) {
         virtio_error(vdev, "Cannot map used");
         goto err_used;
     }

can not catch the -EFAULT, since len is converted to unsigned.

Thanks
