Received: from eggs.gnu.org ([2001:4830:134:3::10]:59651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1e0V61-00084J-8P
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 12:03:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1e0V60-0003dx-3Z
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 12:03:29 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:33983)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1e0V5z-0003dU-U1
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 12:03:28 -0400
Received: by mail-oi0-x241.google.com with SMTP id h200so4112855oib.1
	for <qemu-devel@nongnu.org>; Fri, 06 Oct 2017 09:03:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1507222047-20115-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1507222047-20115-1-git-send-email-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 6 Oct 2017 18:03:25 +0200
Message-ID: <CAJ+F1CLo46LvnfH_EBT9CRzuyKojKz3G-NMfJ7poyXZy5QxPJg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] specs: Extend TPM spec with TPM emulator
 description
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: QEMU <qemu-devel@nongnu.org>, Amarnath Valluri <amarnath.valluri@intel.com>

Hi

On Thu, Oct 5, 2017 at 6:47 PM, Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
> Following the recent extension of QEMU with a TPM emulator device,
> update the specs describing for how to interact with the device.
>
> The results of commands run inside a Linux VM are expected to be
> similar to those when the TPM passthrough device is used, so we
> just reuse that.
>
> Fix a typo on the way.
>
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  docs/specs/tpm.txt | 79 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 79 insertions(+)
>
> diff --git a/docs/specs/tpm.txt b/docs/specs/tpm.txt
> index 914daac..9bef8b3 100644
> --- a/docs/specs/tpm.txt
> +++ b/docs/specs/tpm.txt
> @@ -121,3 +121,82 @@ crw-------. 1 root root 10, 224 Jul 11 10:11 /dev/tp=
m0
>  PCR-00: 35 4E 3B CE 23 9F 38 59 ...
>  ...
>  PCR-23: 00 00 00 00 00 00 00 00 ...
> +
> +
> +=3D=3D The QEMU TPM emulator device =3D=3D
> +
> +The TPM emulator device uses an external TPM emulator called 'swtpm' for
> +sending TPM commands to and receiving responses from. The swtpm program
> +must have been started before trying to access it through the TPM emulat=
or
> +with QEMU.
> +
> +The TPM emulator implements a command channel for transferring TPM comma=
nds
> +and responses as well as a control channel over which control commands c=
an
> +be sent. The specification for the control channel can be found here:
> +
> +https://github.com/stefanberger/swtpm/blob/master/man/man3/swtpm_ioctls.=
pod
> +
> +
> +The control channel serves the purpose of resetting, initializing, and
> +migrating the TPM state, among other things.
> +
> +The swtpm program behaves like a hardware TPM and therefore needs to be
> +initialized by the firmware running inside the QEMU virtual machine.
> +One necessary step for initializing the device is to send the TPM_Startu=
p
> +command to it. SeaBIOS, for example, has been instrumented to initialize
> +a TPM 1.2 or TPM 2 device using this command.
> +
> +
> +QEMU files related to the TPM emulator device:
> + - hw/tpm/tpm_emulator.c
> + - hw/tpm/tpm_util.c
> + - hw/tpm/tpm_util.h
> +
> +
> +The following commands start the swtpm with a UnixIO control channel ove=
r
> +a socket interface. They do not need to be run as root.
> +
> +mkdir /tmp/mytpm1

You no longer need swtpm_setup? nice

> +swtpm socket --tpmstate dir=3D/tmp/mytpm1 \
> +  --ctrl type=3Dunixio,path=3D/tmp/mytpm1/swtpm-sock \
> +  --log level=3D20
> +
> +Command line to start QEMU with the TPM emulator device using the host's
> +hardware TPM /dev/tpm0:
> +
> +qemu-system-x86_64 -display sdl -enable-kvm \
> +  -m 1024 -boot d -bios bios-256k.bin -boot menu=3Don \
> +  -chardev socket,id=3Dchrtpm,path=3D/tmp/mytpm1/swtpm-sock \
> +  -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm \
> +  -device tpm-tis,tpmdev=3Dtpm0 test.img
> +
> +
> +In case SeaBIOS is used as firmware, it should show the TPM menu item
> +after entering the menu with 'ESC'.
> +
> +Select boot device:
> +1. DVD/CD [ata1-0: QEMU DVD-ROM ATAPI-4 DVD/CD]
> +[...]
> +5. Legacy option rom
> +
> +t. TPM Configuration
> +
> +
> +The following commands should result in similar output inside the VM wit=
h a
> +Linux kernel that either has the TPM TIS driver built-in or available as=
 a
> +module:
> +
> +#> dmesg | grep -i tpm
> +[    0.711310] tpm_tis 00:06: 1.2 TPM (device=3Did 0x1, rev-id 1)
> +
> +#> dmesg | grep TCPA
> +[    0.000000] ACPI: TCPA 0x0000000003FFD191C 000032 (v02 BOCHS  \
> +    BXPCTCPA 0000001 BXPC 00000001)
> +
> +#> ls -l /dev/tpm*
> +crw-------. 1 root root 10, 224 Jul 11 10:11 /dev/tpm0
> +
> +#> find /sys/devices/ | grep pcrs$ | xargs cat
> +PCR-00: 35 4E 3B CE 23 9F 38 59 ...
> +...
> +PCR-23: 00 00 00 00 00 00 00 00 ...
> --
> 2.5.5
>



--=20
Marc-Andr=C3=A9 Lureau
