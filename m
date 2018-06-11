Received: from eggs.gnu.org ([2001:4830:134:3::10]:39033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fSMsC-0002a5-3a
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 09:28:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fSMs8-0000ZC-4J
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 09:28:40 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:53051)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fSMs7-0000Xs-UI
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 09:28:36 -0400
Received: by mail-wm0-x22b.google.com with SMTP id p126-v6so14717374wmb.2
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 06:28:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180514123855.30188-1-marcandre.lureau@redhat.com>
References: <20180514123855.30188-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 11 Jun 2018 15:28:33 +0200
Message-ID: <CAJ+F1C+JaARZ_bdHEMOv8PFEkFBCoZEe72TyXTgdnRiXfYQpNA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] qemu-ga: make get-fsinfo work over pci
 bridges
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU <qemu-devel@nongnu.org>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Hi Michael

On Mon, May 14, 2018 at 2:38 PM, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
> Iterate over the PCI bridges to lookup the PCI device associated with
> the block device.
>
> This allows to lookup the driver under the following syspath:
> /sys/devices/pci0000:00/0000:00:02.2/0000:03:00.0/virtio2/block/vda/vda3
>
> It also works with an "old-style" Q35 libvirt hierarchy: root complex
> -> DMI-PCI bridge -> PCI-PCI bridge -> virtio controller, ex:
> /sys/devices/pci0000:00/0000:00:03.0/0000:01:01.0/0000:02:01.0/virtio1/bl=
ock/vda/vda3
>
> The setup can be reproduced with the following qemu command line
> (Thanks Marcel for help):
>
> qemu-system-x86_64 -M q35 \
>   -device i82801b11-bridge,id=3Ddmi2pci_bridge,bus=3Dpcie.0
>   -device pci-bridge,id=3Dpci_bridge,bus=3Ddmi2pci_bridge,addr=3D0x1,chas=
sis_nr=3D1
>   -device virtio-blk-pci,scsi=3Doff,drive=3Ddrive-virtio-disk0,id=3Dvirti=
o-disk0,bootindex=3D1,bus=3Dpci_bridge,addr=3D0x1
>
> For consistency with other syspath-related debug messages, replace a
> \"%s\" in the message with '%s'.
>
> Fixes:
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1567041
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> ---

ping,

are you planning to send a pull request for qga patches

>
> v3:
>  - replace \"%s\" in the debug message with '%s'
>  - simplify the code by getting rid of an "else if"
>
> qga/commands-posix.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 0dc219dbcf..624b0dc0c3 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -875,13 +875,28 @@ static void build_guest_fsinfo_for_real_device(char=
 const *syspath,
>      p =3D strstr(syspath, "/devices/pci");
>      if (!p || sscanf(p + 12, "%*x:%*x/%x:%x:%x.%x%n",
>                       pci, pci + 1, pci + 2, pci + 3, &pcilen) < 4) {
> -        g_debug("only pci device is supported: sysfs path \"%s\"", syspa=
th);
> +        g_debug("only pci device is supported: sysfs path '%s'", syspath=
);
>          return;
>      }
>
> -    driver =3D get_pci_driver(syspath, (p + 12 + pcilen) - syspath, errp=
);
> -    if (!driver) {
> -        goto cleanup;
> +    p +=3D 12 + pcilen;
> +    while (true) {
> +        driver =3D get_pci_driver(syspath, p - syspath, errp);
> +        if (driver && (g_str_equal(driver, "ata_piix") ||
> +                       g_str_equal(driver, "sym53c8xx") ||
> +                       g_str_equal(driver, "virtio-pci") ||
> +                       g_str_equal(driver, "ahci"))) {
> +            break;
> +        }
> +
> +        if (sscanf(p, "/%x:%x:%x.%x%n",
> +                          pci, pci + 1, pci + 2, pci + 3, &pcilen) =3D=
=3D 4) {
> +            p +=3D pcilen;
> +            continue;
> +        }
> +
> +        g_debug("unsupported driver or sysfs path '%s'", syspath);
> +        return;
>      }
>
>      p =3D strstr(syspath, "/target");
> --
> 2.17.0.253.g3dd125b46d
>
>



--=20
Marc-Andr=C3=A9 Lureau
