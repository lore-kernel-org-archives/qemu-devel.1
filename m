Received: from eggs.gnu.org ([209.51.188.92]:32952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mhines@scalecomputing.com>) id 1gj8zl-0007ce-0N
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 15:38:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mhines@scalecomputing.com>) id 1gj8zj-0001rB-NQ
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 15:38:04 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634]:46777)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mhines@scalecomputing.com>)
	id 1gj8zj-0001na-1N
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 15:38:03 -0500
Received: by mail-pl1-x634.google.com with SMTP id t13so140518ply.13
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 12:37:59 -0800 (PST)
Message-ID: <5c3cf325.1c69fb81.8b2b9.48d4@mx.google.com>
MIME-Version: 1.0
From: Matt Hines <mhines@scalecomputing.com>
Date: Mon, 14 Jan 2019 12:37:56 -0800
In-Reply-To: <95f3ade6-5a10-5ebf-7f8e-91fc40fd45bc@redhat.com>
References: <20190114090324.16176-1-mhines@scalecomputing.com>
	<95f3ade6-5a10-5ebf-7f8e-91fc40fd45bc@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] QGA: Fix guest-get-fsinfo PCI
 addresscollection in Windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>

Number here is specific to the device type (and otherwise opaque) unfortuna=
tely per this IOCtl: https://docs.microsoft.com/en-us/windows/desktop/api/w=
inioctl/ni-winioctl-ioctl_storage_get_device_number
Should I put a comment in qapi-schema.json pointing to this?


From: Eric Blake
Sent: Monday, January 14, 2019 11:41
To: mhines@scalecomputing.com; qemu-devel@nongnu.org
Cc: Michael Roth
Subject: Re: [Qemu-devel] [PATCH] QGA: Fix guest-get-fsinfo PCI addresscoll=
ection in Windows

On 1/14/19 3:03 AM, mhines@scalecomputing.com wrote:
> From: Matt Hines <mhines@scalecomputing.com>
>=20
> Signed-off-by: Matt Hines <mhines@scalecomputing.com>

The title says what (a fix), but no description of that fix or a "why"
in the commit body.

> ---
>  configure            |   2 +-
>  qga/commands-win32.c | 295 +++++++++++++++++++++++++++++++++------------=
------
>  qga/qapi-schema.json |   3 +-
>  3 files changed, 197 insertions(+), 103 deletions(-)

> +++ b/qga/qapi-schema.json
> @@ -836,6 +836,7 @@
>  # @unit: unit id
>  # @serial: serial number (since: 3.1)
>  # @dev: device node (POSIX) or device UNC (Windows) (since: 3.1)
> +# @number: device slot index (Windows)

Adding a member is more than just a fix.  Also, this is missing a
'(since 4.0)' tag.

>  #
>  # Since: 2.2
>  ##
> @@ -843,7 +844,7 @@
>    'data': {'pci-controller': 'GuestPCIAddress',
>             'bus-type': 'GuestDiskBusType',
>             'bus': 'int', 'target': 'int', 'unit': 'int',
> -           '*serial': 'str', '*dev': 'str'} }
> +           '*serial': 'str', '*dev': 'str', 'number':'int'} }
> =20
>  ##
>  # @GuestFilesystemInfo:
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
