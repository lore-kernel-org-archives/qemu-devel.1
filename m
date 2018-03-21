Received: from eggs.gnu.org ([2001:4830:134:3::10]:45019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eydhu-0002NL-Kp
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:23:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eydhq-0004fy-M9
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:23:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44378 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1eydhq-0004fG-Gk
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:23:06 -0400
References: <20180321124026.70292-1-marcel@redhat.com>
	<8fc94472-c9dc-edf6-d89b-90f6d6ac281a@redhat.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <1fa66dae-b6e4-af3c-f3ec-8e4dd03d74f0@redhat.com>
Date: Wed, 21 Mar 2018 15:23:00 +0200
MIME-Version: 1.0
In-Reply-To: <8fc94472-c9dc-edf6-d89b-90f6d6ac281a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.12] hw/rdma: fix clang compilation
 errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: yuval.shaia@oracle.com, mst@redhat.com

On 21/03/2018 15:20, Eric Blake wrote:
> On 03/21/2018 07:40 AM, Marcel Apfelbaum wrote:
>> Fix some enum castings and extra parentheses.
>>
>> Reported-by: Michael S. Tsirkin <mst@redhat.com>
>> Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
>> ---
>> =C2=A0 hw/rdma/vmw/pvrdma_cmd.c=C2=A0 | 5 +++--
>> =C2=A0 hw/rdma/vmw/pvrdma_main.c | 5 +++--
>> =C2=A0 2 files changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/rdma/vmw/pvrdma_cmd.c b/hw/rdma/vmw/pvrdma_cmd.c
>> index 293dfed29f..25f747a190 100644
>> --- a/hw/rdma/vmw/pvrdma_cmd.c
>> +++ b/hw/rdma/vmw/pvrdma_cmd.c
>> @@ -73,7 +73,7 @@ static void *pvrdma_map_to_pdir(PCIDevice *pdev, uin=
t64_t pdir_dma,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tbl_idx =3D 1;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 addr_idx =3D 1;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (addr_idx < nchunks) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((tbl_idx =3D=3D (TARGE=
T_PAGE_SIZE / sizeof(uint64_t)))) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (tbl_idx =3D=3D (TARGET=
_PAGE_SIZE / sizeof(uint64_t))) {
>=20
> Can't you still simplify that further to
>=20
> if (tbl_idx =3D=3D TARGET_PAGE_SIZE / sizeof(uint64_t)) {
>=20

I'll try, thanks.

>> @@ -292,7 +292,8 @@ static void init_ports(PVRDMADev *dev, Error **err=
p)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memset(dev->rdma_dev_res.ports, 0, size=
of(dev->rdma_dev_res.ports));
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < MAX_PORTS; i++=
) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev->rdma_dev_res.ports[i]=
.state =3D PVRDMA_PORT_DOWN;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev->rdma_dev_res.ports[i]=
.state =3D
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (e=
num ibv_port_state)PVRDMA_PORT_DOWN;
>> =C2=A0=20
>=20
> This one looks suspicious - shouldn't you instead be using IBV_PORT_DOW=
N instead of having to cast?=C2=A0 (Even if
> IBV_PORT_DOWN and PVRDMA_PORT_DOWN both have the value of 1 for now, th=
e compiler warning is telling you that either one
> of the two enums can change independently in the future, and using a ca=
st to shut up the compiler feels unsafe).
>=20

Yes, Yuval pointed it out too, I'll change it.

Thanks,
Marcel
