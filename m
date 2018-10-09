Received: from eggs.gnu.org ([2001:4830:134:3::10]:40609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1g9slK-0002lc-J2
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:13:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1g9slC-0000oq-VM
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:13:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45638)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1g9sl9-0000kl-DG
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:13:18 -0400
Date: Tue, 9 Oct 2018 15:13:07 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181009141307.GG22838@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181009125541.24455-1-berrange@redhat.com>
	<CAJ+F1CKAZU+aHuzO8Y-aT20uX-rywZB3BK0=1hqecSrPkUEp1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1CKAZU+aHuzO8Y-aT20uX-rywZB3BK0=1hqecSrPkUEp1Q@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/6] crypto: improve performance of XTS
 cipher mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Alberto Garcia <berto@igalia.com>

On Tue, Oct 09, 2018 at 05:59:46PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Tue, Oct 9, 2018 at 4:57 PM Daniel P. Berrang=C3=A9 <berrange@redhat=
.com> wrote:
> >
> > The XTS cipher mode is significantly slower than CBC mode. This serie=
s
> > approximately doubles the XTS performance which will improve the I/O
> > rate for LUKS disks.
> >
> > Daniel P. Berrang=C3=A9 (6):
> >   crypto: expand algorithm coverage for cipher benchmark
> >   crypto: remove code duplication in tweak encrypt/decrypt
> >   crypto: introduce a xts_uint128 data type
> >   crypto: convert xts_tweak_encdec to use xts_uint128 type
> >   crypto: convert xts_mult_x to use xts_uint128 type
> >   crypto: annotate xts_tweak_encdec as inlineable
> >
> >  crypto/xts.c                    | 147 ++++++++++++++----------------=
-
> >  tests/benchmark-crypto-cipher.c | 149 +++++++++++++++++++++++++++---=
--
> >  2 files changed, 191 insertions(+), 105 deletions(-)
>=20
> By using a constant amount of data to process, it's easier to measure
> perfomance with perf stat:

The problem is that the different encryption modes have wildly
different performance. eg while XTS gets 400 MB/s, ECB gets
3000 MB/s. I want the test to run long enough to minimize the
noise, and picking a data size large enough for best ECB
perf while not being excessively large for XTS is hard. THus
I prefer to have a fixed execution time for each test.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
