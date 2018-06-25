Received: from eggs.gnu.org ([2001:4830:134:3::10]:33428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXURJ-0001HS-9J
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:34:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXURI-00050D-Cy
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:34:05 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:46984)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fXURI-0004zi-68
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:34:04 -0400
Received: by mail-oi0-x243.google.com with SMTP id h79-v6so13070007oig.13
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 09:34:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180622022035.18490-1-f4bug@amsat.org>
References: <20180622022035.18490-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Jun 2018 17:33:42 +0100
Message-ID: <CAFEAcA_BC5b8uJemM_aVW03D7tsxnDAwB6_ibW8owP_SCSjJSw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] Makefile: Enable synchronized parallel
 output when possible
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Eric Blake <eblake@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Daniel P . Berrange" <berrange@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

On 22 June 2018 at 03:20, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wro=
te:
> The '--output-sync' option is available since GNU make 4.0.

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> Maybe 'line' is better for workstation and 'target/recurse' for
> unattended builds.
>
> doc: https://www.gnu.org/software/make/manual/html_node/Parallel-Output.h=
tml
> ---
>  Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index e46f2b625a..e94c687afe 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -367,6 +367,10 @@ DOCS=3D
>  endif
>
>  SUBDIR_MAKEFLAGS=3D$(if $(V),,--no-print-directory --quiet) BUILD_DIR=3D=
$(BUILD_DIR)
> +ifeq ($(shell test $(firstword $(subst ., ,$(MAKE_VERSION))) -ge 4; echo=
 $$?),0)

A comment here would help in figuring out what version check
you were intending to perform. Also surely we don't need to
go out to the shell just to do a comparison...

Make seems to advertise --output-sync support as part of its
.FEATURES variable, so probably the most reliable way to do
this test is to check whether .FEATURES contains "output-sync".

> +SUBDIR_MAKEFLAGS+=3D--output-sync=3Dtarget
> +endif
> +
>  SUBDIR_DEVICES_MAK=3D$(patsubst %, %/config-devices.mak, $(TARGET_LIST))
>  SUBDIR_DEVICES_MAK_DEP=3D$(patsubst %, %-config-devices.mak.d, $(TARGET_=
LIST))

This only affects our sub-makes, though, right? So the user
would have to specify it on the command line anyway so that
it applies to the top level make process...

thanks
-- PMM
