Received: from eggs.gnu.org ([209.51.188.92]:41110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1goh1s-000794-8K
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 22:59:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1goh1r-0006i5-HW
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 22:59:12 -0500
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:41980)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1goh1r-0006hp-8p
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 22:59:11 -0500
Received: by mail-yw1-xc44.google.com with SMTP id f65so9107328ywc.8
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 19:59:11 -0800 (PST)
MIME-Version: 1.0
References: <20190122083152.10705-1-xieyongji@baidu.com>
	<20190122083152.10705-4-xieyongji@baidu.com>
	<09287313-0f6e-38a3-be36-9bf65bba7b9d@redhat.com>
In-Reply-To: <09287313-0f6e-38a3-be36-9bf65bba7b9d@redhat.com>
From: Yongji Xie <elohimes@gmail.com>
Date: Wed, 30 Jan 2019 11:58:58 +0800
Message-ID: <CAONzpcaQhfSa-Uw2-r_XTqvw8fYq_haJ6zKR-9NkK=fBkZky0w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 3/6] libvhost-user: Support tracking
 inflight I/O in shared memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, "Coquelin, Maxime" <maxime.coquelin@redhat.com>, Yury Kotov <yury-kotov@yandex-team.ru>, =?UTF-8?B?0JXQstCz0LXQvdC40Lkg0K/QutC+0LLQu9C10LI=?= <wrfsh@yandex-team.ru>, nixun@baidu.com, qemu-devel <qemu-devel@nongnu.org>, lilin24@baidu.com, zhangyu31@baidu.com, chaiwen@baidu.com, Xie Yongji <xieyongji@baidu.com>

On Wed, 30 Jan 2019 at 10:32, Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2019/1/22 =E4=B8=8B=E5=8D=884:31, elohimes@gmail.com wrote:
> > +static int
> > +vu_queue_inflight_get(VuDev *dev, VuVirtq *vq, int desc_idx)
> > +{
> > +    if (!has_feature(dev->protocol_features,
> > +        VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
> > +        return 0;
> > +    }
> > +
> > +    if (unlikely(!vq->inflight)) {
> > +        return -1;
> > +    }
> > +
> > +    vq->inflight->desc[desc_idx].inuse =3D 1;
> > +
> > +    vq->inflight->desc[desc_idx].avail_idx =3D vq->last_avail_idx;
> > +
> > +    return 0;
> > +}
> > +
> > +static int
> > +vu_queue_inflight_pre_put(VuDev *dev, VuVirtq *vq, int desc_idx)
> > +{
> > +    if (!has_feature(dev->protocol_features,
> > +        VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
> > +        return 0;
> > +    }
> > +
> > +    if (unlikely(!vq->inflight)) {
> > +        return -1;
> > +    }
> > +
> > +    vq->inflight->desc[desc_idx].used_idx =3D vq->used_idx;
> > +
> > +    barrier();
> > +
> > +    vq->inflight->desc[desc_idx].version++;
> > +
> > +    return 0;
> > +}
>
>
> You probably need WRITE_ONCE() semantic (e.g volatile) to make sure the
> value reach memory.
>

Is it enough to declare those variables as volatile?

Thanks,
Yongji
