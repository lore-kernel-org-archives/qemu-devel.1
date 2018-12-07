Received: from eggs.gnu.org ([2001:4830:134:3::10]:55262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gVBvx-00020Z-Vc
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 03:56:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gVBvw-0008Es-TH
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 03:56:29 -0500
Received: from mail-yw1-xc42.google.com ([2607:f8b0:4864:20::c42]:37727)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1gVBvw-0008Dz-N6
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 03:56:28 -0500
Received: by mail-yw1-xc42.google.com with SMTP id h193so747954ywc.4
	for <qemu-devel@nongnu.org>; Fri, 07 Dec 2018 00:56:28 -0800 (PST)
MIME-Version: 1.0
References: <20181206063552.6701-1-xieyongji@baidu.com>
	<561e0d7a-af2f-caad-aec3-c15952665687@redhat.com>
In-Reply-To: <561e0d7a-af2f-caad-aec3-c15952665687@redhat.com>
From: Yongji Xie <elohimes@gmail.com>
Date: Fri, 7 Dec 2018 16:56:15 +0800
Message-ID: <CAONzpcaMp464cQEaHwfh7Eox+5Yi4U0K8627Wnqmuxfs2FpezQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 0/6] vhost-user-blk: Add support
 for backend reconnecting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jasowang@redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>, marcandre.lureau@redhat.com, nixun@baidu.com, qemu-devel@nongnu.org, lilin24@baidu.com, zhangyu31@baidu.com, chaiwen@baidu.com, Xie Yongji <xieyongji@baidu.com>

On Thu, 6 Dec 2018 at 21:57, Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2018/12/6 =E4=B8=8B=E5=8D=882:35, elohimes@gmail.com wrote:
> > From: Xie Yongji <xieyongji@baidu.com>
> >
> > This patchset is aimed at supporting qemu to reconnect
> > vhost-user-blk backend after vhost-user-blk backend crash or
> > restart.
> >
> > The patch 1 tries to implenment the sync connection for
> > "reconnect socket".
> >
> > The patch 2 introduces a new message VHOST_USER_SET_VRING_INFLIGHT
> > to support offering shared memory to backend to record
> > its inflight I/O.
> >
> > The patch 3,4 are the corresponding libvhost-user patches of
> > patch 2. Make libvhost-user support VHOST_USER_SET_VRING_INFLIGHT.
> >
> > The patch 5 supports vhost-user-blk to reconnect backend when
> > connection closed.
> >
> > The patch 6 tells qemu that we support reconnecting now.
> >
> > To use it, we could start qemu with:
> >
> > qemu-system-x86_64 \
> >          -chardev socket,id=3Dchar0,path=3D/path/vhost.socket,reconnect=
=3D1,wait \
> >          -device vhost-user-blk-pci,chardev=3Dchar0 \
> >
> > and start vhost-user-blk backend with:
> >
> > vhost-user-blk -b /path/file -s /path/vhost.socket
> >
> > Then we can restart vhost-user-blk at any time during VM running.
>
>
> I wonder whether or not it's better to handle this at the level of
> virtio protocol itself instead of vhost-user level. E.g expose
> last_avail_idx to driver might be sufficient?
>
> Another possible issue is, looks like you need to deal with different
> kinds of ring layouts e.g packed virtqueues.
>

Yes, we should be able to deal with the packed virtqueues. But this
should be processed in backend rather than in qemu. Qemu just sends
a shared memory to backend. Then backend use it to record inflight I/O
and do I/O replay when necessary.

Thanks,
Yongji
