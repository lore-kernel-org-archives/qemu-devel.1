Received: from eggs.gnu.org ([209.51.188.92]:53977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hMbFw-0002uD-NE
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:41:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hMbFv-0001s6-He
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:41:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51786)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hMbFt-0001mm-FF
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:41:51 -0400
References: <20190503004130.8285-1-ehabkost@redhat.com>
	<20190503004130.8285-20-ehabkost@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <40c4d236-ed76-e433-51d5-c9feabb4374a@redhat.com>
Date: Fri, 3 May 2019 18:41:43 +0200
MIME-Version: 1.0
In-Reply-To: <20190503004130.8285-20-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 19/19] configure: automatically pick python3
 is available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>

On 03/05/2019 02.41, Eduardo Habkost wrote:
> From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>=20
> Unless overridden via an env var or configure arg, QEMU will only look
> for the 'python' binary in $PATH. This is unhelpful on distros which
> are only shipping Python 3.x (eg Fedora) in their default install as,
> if they comply with PEP 394, the bare 'python' binary won't exist.
>=20
> This changes configure so that by default it will search for all three
> common python binaries, preferring to find Python 3.x versions.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Message-Id: <20190327170701.23798-1-berrange@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  configure | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)

I haven't bisected it, but I think this patch here broke the gitlab-ci te=
sts:

 https://gitlab.com/huth/qemu/-/jobs/206806257

Seems like the test is now failing when you don't have an UTF-8 locale:

 LANG=3DC make check-qapi-schema
 [...]
 TEST    tests/qapi-schema/union-base-empty.out
 --- /builds/huth/qemu/tests/qapi-schema/unicode-str.err	2019-05-03 15:21=
:39.000000000 +0000
 +++ -	2019-05-03 15:42:01.561762978 +0000
 @@ -1 +1 @@
 -tests/qapi-schema/unicode-str.json:2: 'command' uses invalid name '=C3=A9=
'
 +tests/qapi-schema/unicode-str.json:2: 'command' uses invalid name '\xe9=
'
 /builds/huth/qemu/tests/Makefile.include:1105: recipe for target 'check-=
tests/qapi-schema/unicode-str.json' failed
 make: *** [check-tests/qapi-schema/unicode-str.json] Error 1

Any ideas how to fix this?

 Thomas
