Received: from eggs.gnu.org ([2001:4830:134:3::10]:40485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gMJD7-0006NM-Q6
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 15:53:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gMJCz-0005yL-8O
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 15:53:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54924)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gMJCz-0005y0-08
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 15:53:21 -0500
Date: Mon, 12 Nov 2018 15:53:16 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181112155208-mutt-send-email-mst@kernel.org>
References: <20181109145827.23076-1-yuri.benditovich@daynix.com>
	<20181109125947-mutt-send-email-mst@kernel.org>
	<CAOEp5OdXFYYDB_7vNFsrtf=iwpL+ys9Hf_0gR-JXJ+wLnmDw5g@mail.gmail.com>
	<20181111215232-mutt-send-email-mst@kernel.org>
	<CAOEp5Oe_TFTpQ_yBGJ-OyCw_Zne7bF0nUGV8XpG+4Fd+TJ7i8g@mail.gmail.com>
	<b800852b-e81e-459c-c6e1-15d4c99fc0eb@redhat.com>
	<CAOEp5OeNpxdmuNqSTr8C2NZ=oSOY6S4TO3Y5PY+1dKDbap4zDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOEp5OeNpxdmuNqSTr8C2NZ=oSOY6S4TO3Y5PY+1dKDbap4zDw@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] virtio-net: support RSC v4/v6 tcp traffic
 for Windows HCK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-devel@nongnu.org, Yan Vugenfirer <yan@daynix.com>

On Mon, Nov 12, 2018 at 01:31:36PM +0200, Yuri Benditovich wrote:
>=20
>=20
> On Mon, Nov 12, 2018 at 11:26 AM Jason Wang <jasowang@redhat.com> wrote=
:
>=20
>=20
>     On 2018/11/12 =E4=B8=8B=E5=8D=884:57, Yuri Benditovich wrote:
>     >
>     > On Mon, Nov 12, 2018 at 4:54 AM Michael S. Tsirkin <mst@redhat.co=
m
>     > <mailto:mst@redhat.com>> wrote:
>     >
>     >=C2=A0 =C2=A0 =C2=A0On Sun, Nov 11, 2018 at 12:18:54PM +0200, Yuri=
 Benditovich wrote:
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0> @@ -66,12 +143,16 @@ ty=
pedef struct VirtIONet {
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0 Vir=
tIONetQueue *vqs;
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0 Vir=
tQueue *ctrl_vq;
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0 NIC=
State *nic;
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0> +=C2=A0 =C2=A0 QTAILQ_H=
EAD(, NetRscChain) rsc_chains;
>     >=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0what exactly happens with=
 these chains on migration?
>     >=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0> This feature (software implementation of RSC=
 in QEMU) is
>     >=C2=A0 =C2=A0 =C2=A0intended to be used in
>     >=C2=A0 =C2=A0 =C2=A0> the environment of certification tests which=
 never uses migration.
>     >
>     >=C2=A0 =C2=A0 =C2=A0Should this feature disable migration then?
>     >
>     >
>     > IMO, this should not. But if you find it mandatory, please respon=
d and
>     > I will add the migration blocker.
>=20
>=20
>     So if my understanding is correct, it's safe to do nothing even if =
we
>     allow migration for RSC?
>=20
>=20
> This does not create any unrecoverable failure (assertion, BSOD), altho=
ugh
> some data (coalesced parts of packets not delivered yet to guest) will =
be lost.

If guest has no way to detect none of these packets were ever
received by card, then I guess it's fine. Needs a
comment in case we start caring about packet loss around
migration.

>=20
>=20
>     Thanks
>=20
>=20
>=20
