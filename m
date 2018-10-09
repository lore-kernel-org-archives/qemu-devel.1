Received: from eggs.gnu.org ([2001:4830:134:3::10]:44585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1g9szL-00027l-KX
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:27:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1g9szK-0000Lj-K1
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:27:55 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40784)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1g9szG-0000HQ-OC
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:27:52 -0400
Received: by mail-wr1-x441.google.com with SMTP id d2-v6so2067005wro.7
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 07:27:47 -0700 (PDT)
MIME-Version: 1.0
References: <20181009125541.24455-1-berrange@redhat.com>
	<CAJ+F1CKAZU+aHuzO8Y-aT20uX-rywZB3BK0=1hqecSrPkUEp1Q@mail.gmail.com>
	<20181009141307.GG22838@redhat.com>
In-Reply-To: <20181009141307.GG22838@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 9 Oct 2018 18:27:34 +0400
Message-ID: <CAJ+F1C+V+NvVcxgL2XvjnB4C-DOzGozr9V76YOiMSki19Q-_1g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Alberto Garcia <berto@igalia.com>

Hi

On Tue, Oct 9, 2018 at 6:13 PM Daniel P. Berrang=C3=A9 <berrange@redhat.com=
> wrote:
>
> On Tue, Oct 09, 2018 at 05:59:46PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Tue, Oct 9, 2018 at 4:57 PM Daniel P. Berrang=C3=A9 <berrange@redhat=
.com> wrote:
> > >
> > > The XTS cipher mode is significantly slower than CBC mode. This serie=
s
> > > approximately doubles the XTS performance which will improve the I/O
> > > rate for LUKS disks.
> > >
> > > Daniel P. Berrang=C3=A9 (6):
> > >   crypto: expand algorithm coverage for cipher benchmark
> > >   crypto: remove code duplication in tweak encrypt/decrypt
> > >   crypto: introduce a xts_uint128 data type
> > >   crypto: convert xts_tweak_encdec to use xts_uint128 type
> > >   crypto: convert xts_mult_x to use xts_uint128 type
> > >   crypto: annotate xts_tweak_encdec as inlineable
> > >
> > >  crypto/xts.c                    | 147 ++++++++++++++----------------=
-
> > >  tests/benchmark-crypto-cipher.c | 149 +++++++++++++++++++++++++++---=
--
> > >  2 files changed, 191 insertions(+), 105 deletions(-)
> >
> > By using a constant amount of data to process, it's easier to measure
> > perfomance with perf stat:
>
> The problem is that the different encryption modes have wildly
> different performance. eg while XTS gets 400 MB/s, ECB gets
> 3000 MB/s. I want the test to run long enough to minimize the
> noise, and picking a data size large enough for best ECB
> perf while not being excessively large for XTS is hard. THus
> I prefer to have a fixed execution time for each test.

I understand, I was just giving you some nice numbers to back your patches =
;)

Otoh, I think having a fixed-size work for benchmark is more reliable,
even if the test runs quickly. I wouldn't rely on the current
benchmark results, they are quite unpredictable on my system.

>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|



--=20
Marc-Andr=C3=A9 Lureau
