Received: from eggs.gnu.org ([2001:4830:134:3::10]:60830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1f9fe3-00038D-EN
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 19:40:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1f9fe0-0005Ya-1H
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 19:40:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44972 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1f9fdz-0005Xu-RX
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 19:40:43 -0400
References: <20180420152511.18878-1-marcandre.lureau@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <e130d54a-0ea3-f149-e101-0f1ffd1cb60f@redhat.com>
Date: Sat, 21 Apr 2018 01:40:34 +0200
MIME-Version: 1.0
In-Reply-To: <20180420152511.18878-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qemu-ga: make get-fsinfo work over pci
 bridges
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com

Hi Marc-Andr=C3=A9,

On 04/20/18 17:25, Marc-Andr=C3=A9 Lureau wrote:
> Iterate over the PCI bridges to lookup the PCI device associated with
> the block device.
>=20
> Fixes:
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1567041
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qga/commands-posix.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
>=20
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 0dc219dbcf..5d4e5f627f 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -879,9 +879,24 @@ static void build_guest_fsinfo_for_real_device(cha=
r const *syspath,
>          return;
>      }
> =20
> -    driver =3D get_pci_driver(syspath, (p + 12 + pcilen) - syspath, er=
rp);
> -    if (!driver) {
> -        goto cleanup;
> +    p +=3D 12 + pcilen;
> +    while (true) {
> +        driver =3D get_pci_driver(syspath, p - syspath, errp);
> +        if (!driver) {
> +            goto cleanup;
> +        }
> +
> +        if (g_str_equal(driver, "pcieport")) {
> +            if (sscanf(p, "/%x:%x:%x.%x%n",
> +                       pci, pci + 1, pci + 2, pci + 3, &pcilen) < 4) {
> +                g_debug("only pci device is supported: sysfs path \"%s=
\"",
> +                        syspath);
> +                return;
> +            }
> +            p +=3D pcilen;
> +            continue;
> +        }
> +        break;
>      }
> =20
>      p =3D strstr(syspath, "/target");
>=20

this patch looked like suitable chewing gum for my brain before I turn
off my work laptop (Saturday 01:36AM, me at work, what else is new), so
here goes:

- Please consider adding a few example pathnames to the commit message
or even the code (as comments). Up to you.

- More importantly, I think this will only work if you use PCIe root
ports and maybe PCIe switches. The original environment where at least I
reproduced it was the "old-style" Q35 libvirt hierarchy: root complex ->
DMI-PCI bridge -> PCI-PCI bridge -> virtio-scsi controller. And, in that
case, the DMI-PCI bridge had no associated driver with it at all in the
guest -- meaning that get_pci_driver() in your patch would return NULL
just the same.

So, I think you should continue scanning as long as:
- driver is either missing or not on the list of desired drivers, AND
- the next pathname component looks PCI-like, and can be parsed.

If the first sub-condition fails, then you found a driver that we can
report about. If the second sub-condition fails, then we give up.

My understanding anyway.

Thanks
Laszlo
