Received: from eggs.gnu.org ([2001:4830:134:3::10]:35348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gJztq-0000pr-5T
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 06:52:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gJztn-0000SO-GK
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 06:52:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52748)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gJztn-0000PS-0Y
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 06:51:59 -0500
References: <20181030214740.2294043-1-stefanb@linux.vnet.ibm.com>
	<20181030214740.2294043-3-stefanb@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e1c724bf-4117-a938-bc20-3056991ce0ec@redhat.com>
Date: Tue, 6 Nov 2018 12:51:53 +0100
MIME-Version: 1.0
In-Reply-To: <20181030214740.2294043-3-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 2/5] tests/tpm: Display if swtpm is not
 found or --tpm2 not supported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 2018-10-30 22:47, Stefan Berger wrote:
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> If swtpm is not found in $PATH or --tpm2 isn't supported, we display
> this in the test log. We cannot mark the test as skipped due to a bug i=
n
> certain versions of the gtester environment that interprets a skipped t=
est
> as failure.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> ---
>  tests/tpm-tests.c | 33 +++++++++++++++++++++------------
>  tests/tpm-util.c  |  8 +-------
>  tests/tpm-util.h  |  2 ++
>  3 files changed, 24 insertions(+), 19 deletions(-)
>=20
> diff --git a/tests/tpm-tests.c b/tests/tpm-tests.c
> index 10c6592aac..93a5beba01 100644
> --- a/tests/tpm-tests.c
> +++ b/tests/tpm-tests.c
> @@ -18,6 +18,17 @@
>  #include "libqtest.h"
>  #include "tpm-tests.h"
> =20
> +static bool
> +tpm_test_swtpm_skip(void)
> +{
> +    if (!tpm_util_swtpm_has_tpm2()) {
> +        fprintf(stderr, "swtpm not in PATH or missing --tpm2 support; =
");
> +        return true;
> +    }

I now get this ugly (4-times duplicated) output each time I run "make che=
ck":

swtpm not in PATH or missing --tpm2 support; swtpm not in PATH or missing=
 --tpm2 support; swtpm not in PATH or missing --tpm2 support; swtpm not i=
n PATH or missing --tpm2 support;

Could you please use g_test_message() here instead like we're doing
it in most of the other tests already?

 Thanks,
  Thomas
