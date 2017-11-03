Received: from eggs.gnu.org ([2001:4830:134:3::10]:32778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eAaTq-0003oG-U0
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 07:49:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eAaTq-00074d-2T
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 07:49:46 -0400
Received: from mail-vk0-x244.google.com ([2607:f8b0:400c:c05::244]:44412)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eAaTp-00074A-TN
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 07:49:46 -0400
Received: by mail-vk0-x244.google.com with SMTP id x65so1568494vkx.1
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 04:49:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171027181740.32165-1-danielhb@linux.vnet.ibm.com>
References: <20171027181740.32165-1-danielhb@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 3 Nov 2017 12:49:43 +0100
Message-ID: <CAJ+F1CJs7WtU+xYfMViYer9vfRAq3SAMQiEjPRRCGnTUBbsgGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] scripts/device-crash-test: vmcoreinfo in
 error_whitelist for ppc64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eduardo Habkost <ehabkost@redhat.com>

Hi Daniel

On Fri, Oct 27, 2017 at 8:17 PM, Daniel Henrique Barboza
<danielhb@linux.vnet.ibm.com> wrote:
> The device vmcoreinfo depends on the fw_cfg device to work, a device
> that isn't available in most ppc64 machines. This makes device-crash-test
> spams the following error when running with qemu-system-ppc64:
>
> "INFO: log: qemu-system-ppc64: -device vmcoreinfo: vmcoreinfo device
> requires fw_cfg with DMA"
>
> To fix it, this patch adds the following ppc64 machines into the
> error_whitelist for the vmcoreinfo device:
>
> - pseries.*
> - 40p
> - bamboo
> - g3beige
> - mac99
> - mpc8544ds
> - powernv
> - ppce500
> - prep
> - virtex-ml507
>
> After this patch, the only ppc64 machine that reports error on the
> vmcoreinfo device is the 'none' type.
>
> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> ---
>  scripts/device-crash-test | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/scripts/device-crash-test b/scripts/device-crash-test
> index 043b24a4aa..fb8a43d679 100755
> --- a/scripts/device-crash-test
> +++ b/scripts/device-crash-test
> @@ -163,6 +163,18 @@ ERROR_WHITELIST =3D [
>      # "spapr-cpu-core needs a pseries machine"
>      {'machine':'(?!pseries).*', 'device':'.*-spapr-cpu-core', 'expected'=
:True},
>
> +    # vmcoreinfo requires a fw_cfg device and will fail in these ppc64 m=
achines
> +    {'machine':'pseries.*', 'device':'vmcoreinfo', 'expected':True},
> +    {'machine':'40p', 'device':'vmcoreinfo', 'expected':True},
> +    {'machine':'bamboo', 'device':'vmcoreinfo', 'expected':True},
> +    {'machine':'g3beige', 'device':'vmcoreinfo', 'expected':True},
> +    {'machine':'mac99', 'device':'vmcoreinfo', 'expected':True},
> +    {'machine':'mpc8544ds', 'device':'vmcoreinfo', 'expected':True},
> +    {'machine':'powernv', 'device':'vmcoreinfo', 'expected':True},
> +    {'machine':'ppce500', 'device':'vmcoreinfo', 'expected':True},
> +    {'machine':'prep', 'device':'vmcoreinfo', 'expected':True},
> +    {'machine':'virtex-ml507', 'device':'vmcoreinfo', 'expected':True},

You could try to make it fit on one line with
r"(pseries.*|40p|bamboo|...)". Declaring a ppc64_machines before would
probably help too.

Any idea for an alternative vmcoreinfo device approach on ppc64?

> +
>      # KVM-specific devices shouldn't be tried without accel=3Dkvm:
>      {'accel':'(?!kvm).*', 'device':'kvmclock', 'expected':True},
>      {'accel':'(?!kvm).*', 'device':'kvm-pci-assign', 'expected':True},
> --
> 2.13.6
>
>



--=20
Marc-Andr=C3=A9 Lureau
