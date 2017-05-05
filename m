Received: from eggs.gnu.org ([2001:4830:134:3::10]:33051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d6gGR-0000ZN-Po
	for qemu-devel@nongnu.org; Fri, 05 May 2017 12:39:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d6gGO-0007bg-MA
	for qemu-devel@nongnu.org; Fri, 05 May 2017 12:39:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1d6gGO-0007al-Fd
	for qemu-devel@nongnu.org; Fri, 05 May 2017 12:39:28 -0400
Date: Fri, 5 May 2017 17:39:12 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170505163912.GN12773@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <cover.1493191677.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1493191677.git.maozy.fnst@cn.fujitsu.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/4] Convert non-blocking connect and
 fix its error reporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, pbonzini@redhat.com, jasowang@redhat.com, armbru@redhat.com

On Wed, Apr 26, 2017 at 04:04:14PM +0800, Mao Zhongyi wrote:
> v2:
> * PATCH 02 reworking of patch 2 following Markus's suggestion that conv=
ert error_report()
>   in the function called by net_socket_*_init() to Error. Also add many=
 error handling
>   information.
> * PATCH 03 net_socket_mcast_create(), net_socket_fd_init_dgram() and ne=
t_socket_fd_init()=20
>   use the function such as fprintf, perror to report an error message. =
Convert it to Error.
> * PATCH 04 parse_host_port() may fail without reporting an error. Now, =
fix it to set an
>   error when it fails.

FYI, I discovered that previous change

  commit 883e4f7624e10b98d16d9adaffb8b1795664d899
  Author: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
  Date:   Sat Jun 18 13:24:02 2016 +0530

    Change net/socket.c to use socket_*() functions

has seriously broken the current code because net_socket_fd_init()
was not called from the right place. Fixing the current code is
somewhat painful, so I've sent a revert of that broken patch.

To demo the problem first run:

  $ ./x86_64-softmmu/qemu-system-x86_64  \
      -device e1000,id=3De0,netdev=3Duser.0,mac=3DDE:AD:BE:EF:AF:04 \
      -netdev socket,id=3Duser.0,listen=3D:1234=20

and then run:

   $ ./x86_64-softmmu/qemu-system-x86_64 \
           -device e1000,id=3De0,netdev=3Dhn0,mac=3DDE:AD:BE:EF:AF:05 \
           -netdev socket,id=3Dhn0,connect=3Dlocalhost:1234

currently the second command fails with

  qemu-system-x86_64: -device e1000,id=3De0,netdev=3Dhn0,mac=3DDE:AD:BE:E=
F:AF:05: Property 'e1000.netdev' can't find value 'hn0'

and my revert fixes that. Just something for you to test with your
new patch series...

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
