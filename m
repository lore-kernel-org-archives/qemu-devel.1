Received: from eggs.gnu.org ([2001:4830:134:3::10]:49449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dAvxe-0005to-6l
	for qemu-devel@nongnu.org; Wed, 17 May 2017 06:13:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dAvxZ-0006Hc-91
	for qemu-devel@nongnu.org; Wed, 17 May 2017 06:13:42 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3929)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dAvxY-0006Gb-Lm
	for qemu-devel@nongnu.org; Wed, 17 May 2017 06:13:37 -0400
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Wed, 17 May 2017 10:13:12 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA29B2BF@DGGEMA505-MBS.china.huawei.com>
References: <1494243504-127980-1-git-send-email-arei.gonglei@huawei.com>
	<1494243504-127980-7-git-send-email-arei.gonglei@huawei.com>
	<520f45d4-33d7-8836-3140-a92ee5d15421@linux.vnet.ibm.com>
	<33183CC9F5247A488A2544077AF19020DA278AA0@DGGEMA505-MBS.china.huawei.com>
	<1963bfa1-c0ea-156a-59f7-aed744ca49a3@linux.vnet.ibm.com>
	<33183CC9F5247A488A2544077AF19020DA29A0B5@DGGEMA505-MBS.china.huawei.com>
	<b7c20d5f-026e-edf1-6703-6b64ceed375f@linux.vnet.ibm.com>
	<33183CC9F5247A488A2544077AF19020DA29B209@DGGEMA505-MBS.china.huawei.com>
	<a8b185ca-4b8d-e913-cfb3-454d61dbce78@linux.vnet.ibm.com>
In-Reply-To: <a8b185ca-4b8d-e913-cfb3-454d61dbce78@linux.vnet.ibm.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC v1 6/9] virtio-crypto: rework
 virtio_crypto_handle_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "mst@redhat.com" <mst@redhat.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "stefanha@redhat.com" <stefanha@redhat.com>, Luonengjun <luonengjun@huawei.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, Linqiangmin <linqiangmin@huawei.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "Wubin (H)" <wu.wubin@huawei.com>

>=20
> On 05/17/2017 11:12 AM, Gonglei (Arei) wrote:
> >>>> By the way, I'm having a hard time understing how is the requirement
> form
> >>>>
> >>
> http://docs.oasis-open.org/virtio/virtio/v1.0/cs04/virtio-v1.0-cs04.html#=
x1-260
> >>>> 004
> >>>> (2.4.4 Message Framing) satisfied by this code. Could you explain th=
is
> >>>> to me please?
> >>>>
> >>> Sorry for my bad English,
> >>> I don't know which normative formulation the code violates?
> >> I'm not sure it's actually violated, but I'm concerned about the follo=
wing
> >> normative statement: "The device MUST NOT make assumptions about the
> >> particular
> >> arrangement of descriptors. The device MAY have a reasonable limit of
> >> descriptors it will allow in a chain."
> >>
> >> Please also read the explanatory part I've linked, because the normati=
ve
> >> statement is pretty abstract.
> >>
> >> In my understanding, the spec says, that e.g. the virti-crypto device
> >> should not fail if a single request is split up into let's say two chu=
nks
> >> and transmitted by the means of two top level descriptors.
> >>
> >> Do you agree with my reading of the spec?
> >>
> > Yes, I agree. But what's the relationship about the request here?
> > We don't assume the request have to use one desc entity, it can
> > use scatter-gather list for one request header.
> > The device can cover the situation in the QEMU.
> >
> >> What does the virtio-crypto device do if it encounters such a situatio=
n?
> >>
> > This isn't a problem. Pls see blow code segment:
> >
> > virtio_crypto_handle_request()
> > {...
> > if (unlikely(iov_to_buf(out_iov, out_num, 0, &req, sizeof(req))
> >                 !=3D sizeof(req))) {
> >     virtio_error(vdev, "virtio-crypto request outhdr too short");
> >     return -1;
> > }
> > iov_discard_front(&out_iov, &out_num, sizeof(req));
> > ...
> >
>=20
> Thats exactly what worries me. I see a call to virtio_error there...
>=20
>=20
> void GCC_FMT_ATTR(2, 3) virtio_error(VirtIODevice *vdev, const char *fmt,=
 ...)
> {
>     va_list ap;
>=20
>     va_start(ap, fmt);
>     error_vreport(fmt, ap);
>     va_end(ap);
>=20
>     vdev->broken =3D true;
>=20
>     if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
>         virtio_set_status(vdev, vdev->status |
> VIRTIO_CONFIG_S_NEEDS_RESET);
>         virtio_notify_config(vdev);
>     }
> }
>=20
> This however seems to make the device 'broken'. Or am I missing something=
?
>=20
Yes, if the parse process failed, the device will broke.=20
But This is a exception scenario IMHO, which is the same situation
with other virtio devices.=20

Stefan introduced the virtio_error().

Thanks,
-Gonglei
