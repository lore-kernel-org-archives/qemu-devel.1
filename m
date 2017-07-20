Received: from eggs.gnu.org ([2001:4830:134:3::10]:60417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1dYJKa-0003TK-RW
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 17:50:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1dYJKX-0006V7-Oy
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 17:50:00 -0400
Received: from mail-bl2nam02on0113.outbound.protection.outlook.com
	([104.47.38.113]:30482
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Andrew.Baumann@microsoft.com>)
	id 1dYJKX-0006TV-El
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 17:49:57 -0400
From: Andrew Baumann <Andrew.Baumann@microsoft.com>
Date: Thu, 20 Jul 2017 21:49:54 +0000
Message-ID: <DM2PR21MB00604522F0A851502DF8B4FD9EA70@DM2PR21MB0060.namprd21.prod.outlook.com>
References: <DM2PR21MB0060B20A50AEEC8B6816154C9EA00@DM2PR21MB0060.namprd21.prod.outlook.com>
	<1263c0a6-263f-0b3b-c84a-f882df33856b@redhat.com>
	<edae6aa7-34ef-a3a8-94e0-175f05728345@redhat.com>
	<DM2PR21MB0060A68EDF44A9FC4B018C909EA10@DM2PR21MB0060.namprd21.prod.outlook.com>
	<20170720065324.GH11032@lemon>
In-Reply-To: <20170720065324.GH11032@lemon>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] Disable image locking for snapshot drive?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

> From: Fam Zheng [mailto:famz@redhat.com]
> Sent: Wednesday, 19 July 2017 23:53
>=20
> On Tue, 07/18 16:19, Andrew Baumann wrote:
> > > From: Eric Blake [mailto:eblake@redhat.com]
> > > Sent: Tuesday, 18 July 2017 8:07
> > > On 07/17/2017 07:33 PM, John Snow wrote:
> > > > On 07/17/2017 07:30 PM, Andrew Baumann via Qemu-devel wrote:
> > > >> I'm running a recent Linux build of qemu on Windows Subsystem for
> Linux
> > > (WSL) which doesn't appear to implement file locking:
> > > >>
> > > >> $ qemu-system-aarch64 ... -drive file=3Dtest.vhdx,if=3Dnone,id=3Dh=
d0 -
> device
> > > virtio-blk-pci,drive=3Dhd0
> > > >> qemu-system-aarch64: -drive file=3Dtest.vhdx,if=3Dnone,id=3Dhd0: F=
ailed to
> > > unlock byte 100
> > >
> > > Does WSL implement fcntl(F_SETLK) but not fcntl(F_OFD_SETLK)?
> >
> > Yes, this appears to be the case (there's also one report that it's bro=
ken):
> > https://github.com/Microsoft/BashOnWindows/issues/1927
>=20
> What does fcntl(F_OFD_SETLK) return? If it is -ENOTSUP, we can probably
> detect
> that and disable locking. Can you try the patch pasted in the end?

It returns -EINVAL. Your patch works, if I change the error code. Maybe tes=
ting for either ENOTSUP or EINVAL, and only allowing the fallback if the us=
er didn't force locking on, would be a reasonable compromise?

Cheers,
Andrew

> ---
>=20
> diff --git a/block/file-posix.c b/block/file-posix.c
> index cfbb236f6f..0be5bbbd53 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -493,6 +493,12 @@ static int raw_open_common(BlockDriverState *bs,
> QDict *options,
>      }
>      s->fd =3D fd;
>=20
> +    if (s->use_lock) {
> +        int ret0 =3D qemu_unlock_fd(fd, 0, 0);
> +        if (ret0 =3D=3D -ENOTSUP) {
> +            s->use_lock =3D false;
> +        }
> +    }
>      s->lock_fd =3D -1;
>      if (s->use_lock) {
>          fd =3D qemu_open(filename, s->open_flags);
