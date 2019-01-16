Received: from eggs.gnu.org ([209.51.188.92]:60656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gje3K-000230-NH
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 00:47:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gje3J-00050x-WC
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 00:47:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53492)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gje3J-0004uE-Q1
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 00:47:49 -0500
Date: Wed, 16 Jan 2019 13:47:35 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20190116054735.GA29461@xz-x1>
References: <20190115145256.9593-1-berrange@redhat.com>
	<20190115145256.9593-7-berrange@redhat.com>
	<7aa007ec-126d-2a97-aa45-91468f7f8ad4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7aa007ec-126d-2a97-aa45-91468f7f8ad4@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 06/12] chardev: remove unused 'sioc'
 variable & cleanup paths
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, qemu-devel@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Yongji Xie <elohimes@gmail.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Wed, Jan 16, 2019 at 06:24:49AM +0100, Thomas Huth wrote:
> On 2019-01-15 15:52, Daniel P. Berrang=C3=A9 wrote:
> > The 'sioc' variable in qmp_chardev_open_socket was unused since
> >=20
> >   commit 3e7d4d20d3a528b1ed10b1dc3d83119bfb0c5f24
> >   Author: Peter Xu <peterx@redhat.com>
> >   Date:   Tue Mar 6 13:33:17 2018 +0800
> >=20
> >     chardev: use chardev's gcontext for async connect
> [...]
> > -error:
> > -    if (sioc) {
> > -        object_unref(OBJECT(sioc));
> > -    }
>=20
> So who is doing the object_unref() now in case of errors? That commit
> did not take care of it ... so it sounds like we could be leaving
> references behind in case of errors here?

IMHO it'll be done finally in qemu_chr_socket_connected() no matter
whether it's succeeded or not:

    cleanup:
        object_unref(OBJECT(sioc));

In other words, I think the old error path is not valid even before
commit 3e7d4d20d3 because IIUC when reaching the error label the sioc
should never be set (and if it tries to do an object_unref here it
would be a real bug).

Thanks,

--=20
Peter Xu
