Received: from eggs.gnu.org ([2001:4830:134:3::10]:60256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f926y-0002Ss-3O
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 01:28:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f926u-0001ek-VG
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 01:28:00 -0400
References: <1524054707-20663-1-git-send-email-thuth@redhat.com>
	<307f8b80-fca2-d55f-6bc6-85b794afa15e@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <842dc876-dd3e-18d9-bfff-128b357b6281@redhat.com>
Date: Thu, 19 Apr 2018 07:27:38 +0200
MIME-Version: 1.0
In-Reply-To: <307f8b80-fca2-d55f-6bc6-85b794afa15e@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1 for-2.13 0/4]
 pc-bios/s390-ccw: Network boot improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Farhan Ali <alifm@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Cc: Collin Walling <walling@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org

On 18.04.2018 20:21, Farhan Ali wrote:
> On 04/18/2018 08:31 AM, Thomas Huth wrote:
>> Some patches to improve the network boot experience on s390x:
>>
>> First, make sure that we shut down the virtio-net device before jumpin=
g
>> into the kernel. Otherwise some incoming packets might destroy some of
>> the kernel's data if it has not taken over the device yet.
>>
>> Then the last two patches add support for loading kernels via
>> configuration files - pxelinux-style and .INS-file style. This way
>> you don't have to manually glue your ramdisk to your kernel anymore,
>> so this should be quite a relieve for all users who want to boot
>> Linux via the network.
>>
>> The config file parsers have been completely written by myself from
>> scratch and only tested with some config files that I came up with
>> on my own. So if anybody has some pre-existing pxelinux config files
>> already for booting a s390x, I'd appreciate some testing to see whethe=
r
>> this works as expected for you, too!
[...]
>
> I have tried with pxelinux default config file I had and it worked fine=
.
> I will try a couple more tests.

Thanks!

> Also while going through the code again, I noticed a memory leak in the
> function virtio_net_init, and fixed it. I could send a formal patch for
> it, if you want to queue it as part of this series as I think we might
> have missed 2.12 window?
>=20
> diff --git a/pc-bios/s390-ccw/virtio-net.c b/pc-bios/s390-ccw/virtio-ne=
t.c
> index ff7f4da..e83ba08 100644
> --- a/pc-bios/s390-ccw/virtio-net.c
> +++ b/pc-bios/s390-ccw/virtio-net.c
> @@ -61,6 +61,7 @@ int virtio_net_init(void *mac_addr)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IPL_assert(buf !=3D NU=
LL, "Can not allocate memory for receive
> buffers");
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vring_send_buf(rxvq, b=
uf, ETH_MTU_SIZE + sizeof(VirtioNetHdr),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VRING_=
DESC_F_WRITE);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free(buf);
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0 vring_notify(rxvq);

Ah, that's not a memory leak, though it might look like one if you don't
know what the vring_send_buf function is doing: vring_send_buf adds a
buffer to a virtio ring for later use. So the buffer is not unused after
this function, but gets filled in later by the virtio-net device. Thus
we must not free the buffer here.

We could free it in the "uninit" function after shutting down the
device, but OTOH we are then leaving the firmware code anyway by jumping
into the OS kernel, so it does not really matter whether we free()ed the
buffers or not.

 Thomas
