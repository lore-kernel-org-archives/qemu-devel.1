Received: from eggs.gnu.org ([2001:4830:134:3::10]:41021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <airlied@redhat.com>) id 1eER6J-0001S3-T5
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 21:37:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <airlied@redhat.com>) id 1eER6F-0000VS-Qz
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 21:37:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:26637)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <airlied@redhat.com>) id 1eER6F-0000Uf-Kk
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 21:37:19 -0500
Date: Mon, 13 Nov 2017 21:37:13 -0500 (EST)
From: David Airlie <airlied@redhat.com>
Message-ID: <1537413339.16131761.1510627033195.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAOvnNvYpQSdM5PXoBZXwf6op+FVNd3j0CPBnKGqxfa2V3pnJjA@mail.gmail.com>
References: <CAOvnNvYpQSdM5PXoBZXwf6op+FVNd3j0CPBnKGqxfa2V3pnJjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] qemu+virgl on systems without dmabuf and/or GBM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Joe Kniss <djmk@google.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>


Hi Joe,

> 
>   I am developing using qemu with virglrenderer on linux systems that
> do not support dmabufs or GBM.   I have been successful making this
> work using glx and ignoring egl/dmabuf/gbm use in qemu.
> Unfortunately, there is currently no way to configure qemu to use
> opengl but disable egl/dmabuf/gbm.  This use case could be handled
> with a straight-forward configure fix, but I am not sure what the
> preferred approach would be.  Here are some options for example:

I did originally write the renderer on the nvidia binary driver, but
never really continued to test it.

> 
> 1) Check for gbm in configure, if it is unavailable disable ui/egl*
> since this egl implementation depends on gbm.
> 2) Check for gbm in configure, modify ui/egl* to work when gbm is missing.
> 3) Add disable-egl flag to configure, ignore gbm package when egl is
> disabled.
> 
> For our use case, option 3 is the simplest, since we don't need either
> egl or gbm and gbm is only used with egl in qemu.  We also encountered
> an additional issue with either gtk or qemu (I forget which)
> attempting to share glx and egl contexts.
> 
> Naturally, we want to come up with a solution that is most generally
> useful,  feedback is greatly appreciated.

I'd like to make EGL work without GBM if possible, I realise you can't
do buffer sharing etc, but you should be able to get EGL contexts to
work in place of GLX contexts.

However if there are issues interoperating between SDL2/EGL/GLX, then
I think whatever approach works best. I'd rather it not be a build time
thing if at all possible, if we can detect at runtime what the installed
driver can do it would be much better.

i.e. if you build qemu+SDL2+virglrenderer against mesa, but run it against
nvidia it should work if at all possible.

Dave.
