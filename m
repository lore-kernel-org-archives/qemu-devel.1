Received: from eggs.gnu.org ([2001:4830:134:3::10]:38620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dzgS3-0004qS-Lk
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 05:58:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dzgRy-0006zd-VV
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 05:58:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dzgRy-0006xX-P3
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 05:58:46 -0400
References: <20170929110052.6111-1-kraxel@redhat.com>
	<CAFEAcA-8gaOhkuNX9hBt0Ofg-CKkJ-v8puHJ4K3QOq0ZGMgB5w@mail.gmail.com>
	<1507106598.27227.2.camel@redhat.com>
	<9d566b88-7991-b9f4-8b73-737a99d3ac6d@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <84018e17-ecf2-71ff-b70e-0f53c3464e68@redhat.com>
Date: Wed, 4 Oct 2017 11:58:40 +0200
MIME-Version: 1.0
In-Reply-To: <9d566b88-7991-b9f4-8b73-737a99d3ac6d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/3] Usb 20170929 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 04/10/2017 11:37, Thomas Huth wrote:
> Ah, deja vu. I think you've now run into the problem that I had with my
> patch, too - see:
>=20
>  https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg01875.html
>  https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg02082.html
>=20
> I think this is a race condition when building with "make -j" in
> parallel. Just add a line like this and you should be fine:
>=20
> common-obj-$(CONFIG_ALL) +=3D host-stub.o

That's correct!  Maybe it should be documented in build-system.txt.

It's basically an optimization, CONFIG_ALL is used when some stubs are
not used in all subtargets but you still want to build them once-only.

Then the toplevel Makefile will typically see the configuration symbol
as defined (because it operates on the union of all targets'
configuration symbols), and will skip builting the "stubs" file.  Using
CONFIG_ALL for the stubs file ensures that the object file is available
before recursing.

Paolo
