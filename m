Received: from eggs.gnu.org ([2001:4830:134:3::10]:55353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1egtuZ-0004c2-8M
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 10:03:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1egtuU-00076n-8R
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 10:02:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58588)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1egtuU-00075d-0U
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 10:02:50 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180129183307.19689-1-marcandre.lureau@redhat.com>
	<20180129183307.19689-6-marcandre.lureau@redhat.com>
Date: Wed, 31 Jan 2018 16:01:43 +0100
In-Reply-To: <20180129183307.19689-6-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Mon, 29 Jan 2018 19:33:07 +0100")
Message-ID: <87tvv2vzqg.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 5/5] tpm: add CRB device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, stefanb@linux.vnet.ibm.com, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Richard Henderson <rth@twiddle.net>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> tpm_crb is a device for TPM 2.0 Command Response Buffer (CRB)
> Interface as defined in TCG PC Client Platform TPM Profile (PTP)
> Specification Family =E2=80=9C2.0=E2=80=9D Level 00 Revision 01.03 v22.
>
> The PTP allows device implementation to switch between TIS and CRB
> model at run time, but given that CRB is a simpler device to
> implement, I chose to implement it as a different device.
>
> The device doesn't implement other locality than 0 for now (my laptop
> TPM doesn't either, so I assume this isn't so bad)
>
> Tested with some success with Linux upstream and Windows 10, seabios &
> modified ovmf. The device is recognized and correctly transmit
> command/response with passthrough & emu. However, we are missing PPI
> ACPI part atm.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qapi/tpm.json                      |   5 +-
>  include/hw/acpi/tpm.h              |  51 +++++++
>  include/sysemu/tpm.h               |   3 +
>  hw/i386/acpi-build.c               |  34 ++++-
>  hw/tpm/tpm_crb.c                   | 303 +++++++++++++++++++++++++++++++=
++++++
>  tests/tpm-crb-test.c               | 275 +++++++++++++++++++++++++++++++=
++
>  default-configs/i386-softmmu.mak   |   1 +
>  default-configs/x86_64-softmmu.mak |   1 +
>  hw/tpm/Makefile.objs               |   1 +
>  tests/Makefile.include             |   2 +
>  10 files changed, 666 insertions(+), 10 deletions(-)
>  create mode 100644 hw/tpm/tpm_crb.c
>  create mode 100644 tests/tpm-crb-test.c
>
> diff --git a/qapi/tpm.json b/qapi/tpm.json
> index 7093f268fb..d50deef5e9 100644
> --- a/qapi/tpm.json
> +++ b/qapi/tpm.json
> @@ -11,10 +11,11 @@
>  # An enumeration of TPM models
>  #
>  # @tpm-tis: TPM TIS model
> +# @tpm-crb: TPM CRB model (since 2.12)
>  #
>  # Since: 1.5
>  ##
> -{ 'enum': 'TpmModel', 'data': [ 'tpm-tis' ] }
> +{ 'enum': 'TpmModel', 'data': [ 'tpm-tis', 'tpm-crb' ] }
>=20=20
>  ##
>  # @query-tpm-models:
> @@ -28,7 +29,7 @@
>  # Example:
>  #
>  # -> { "execute": "query-tpm-models" }
> -# <- { "return": [ "tpm-tis" ] }
> +# <- { "return": [ "tpm-tis", "tpm-crb" ] }
>  #
>  ##
>  { 'command': 'query-tpm-models', 'returns': ['TpmModel'] }

QAPI Schema change looks good to me.
