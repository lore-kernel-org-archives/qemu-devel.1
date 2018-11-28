Received: from eggs.gnu.org ([2001:4830:134:3::10]:43961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1gS3xV-0001P0-4L
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 12:49:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1gS3iP-0003SU-DW
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 12:33:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53056)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1gS3iP-0003Q4-6r
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 12:33:33 -0500
From: Maxime Coquelin <maxime.coquelin@redhat.com>
References: <1528225683-11413-1-git-send-email-wexu@redhat.com>
	<1528225683-11413-7-git-send-email-wexu@redhat.com>
	<7dc2af60-47ad-1250-fc6c-3fdf288654c3@redhat.com>
Message-ID: <9263a573-ba43-f6f7-37d9-0c86be192fbf@redhat.com>
Date: Wed, 28 Nov 2018 18:33:27 +0100
MIME-Version: 1.0
In-Reply-To: <7dc2af60-47ad-1250-fc6c-3fdf288654c3@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 6/8] virtio: flush/push for packed ring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wexu@redhat.com, qemu-devel@nongnu.org, jfreimann@redhat.com
Cc: jasowang@redhat.com, tiwei.bie@intel.com, mst@redhat.com

Hi Wei,

On 9/20/18 4:13 PM, Maxime Coquelin wrote:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> @@ -575,6 +630,34 @@ void virtqueue_flush(VirtQueue *vq, unsigned int=20
>> count)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vq->signalled_u=
sed_valid =3D false;
>> =C2=A0 }
>> +static void virtqueue_packed_flush(VirtQueue *vq, unsigned int count)
>> +{
>> +=C2=A0=C2=A0=C2=A0 if (unlikely(!vq->vring.desc)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 vq->inuse -=3D count;
>> +=C2=A0=C2=A0=C2=A0 vq->used_idx +=3D count;
>=20
> I think it is wrong, because count seems to be representing the number
> of descriptor chains.
>=20
> But in case of packed ring layout, used index must be incremented by th=
e
> number of descriptors.
>=20
> For example, I'm having trouble with the ctrl queue, where the commands
> sent by the guest use 3 descriptors, but count is 1.

It seems you didn't fixed this issue in your last revision.
I guess it works for virtio-net Kernel driver (with the fix you
proposed) in guest because it is using indirect descs.

But Virtio PMD does not use indirect descs for the control vq.

Thanks,
Maxime
