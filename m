Received: from eggs.gnu.org ([2001:4830:134:3::10]:51395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1ceRLY-0006ec-AK
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 14:04:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1ceRLV-0000dx-7c
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 14:04:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1ceRLV-0000cj-13
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 14:04:01 -0500
References: <cover.1487224954.git.ben@skyportsystems.com>
	<625570854359178b416000644f68695bc50630ae.1487224954.git.ben@skyportsystems.com>
	<20170216105649.43944bad@nial.brq.redhat.com>
	<41F19D95-ED58-427E-944A-00F872F8DD48@skyportsystems.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <fb101b08-988a-494d-6ede-783ebe4ae4af@redhat.com>
Date: Thu, 16 Feb 2017 20:03:57 +0100
MIME-Version: 1.0
In-Reply-To: <41F19D95-ED58-427E-944A-00F872F8DD48@skyportsystems.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 4/8] ACPI: Add Virtual Machine
 Generation ID support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ben Warren <ben@skyportsystems.com>, Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com

On 02/16/17 19:32, Ben Warren wrote:
>=20
>> On Feb 16, 2017, at 1:56 AM, Igor Mammedov <imammedo@redhat.com> wrote=
:
>>
>> On Wed, 15 Feb 2017 22:18:14 -0800
>> ben@skyportsystems.com wrote:
>>
>>> From: Ben Warren <ben@skyportsystems.com>
>>>
>>> This implements the VM Generation ID feature by passing a 128-bit
>>> GUID to the guest via a fw_cfg blob.
>>> Any time the GUID changes, an ACPI notify event is sent to the guest
>>>
>>> The user interface is a simple device with one parameter:
>>> - guid (string, must be "auto" or in UUID format
>>>   xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx)
>>>
>>> Signed-off-by: Ben Warren <ben@skyportsystems.com>
>> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
>>
>> Thing to get fixed on top is to check
>> that there isn't vmgenid device present already
>> into realizefn() and fail gracefully is there is.
>>
> I made the change as follows:
> =3D=3D=3D
>=20
> diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
> index c8465df..fa3de6d 100644
> --- a/hw/acpi/vmgenid.c
> +++ b/hw/acpi/vmgenid.c
> @@ -207,8 +207,15 @@ static void vmgenid_handle_reset(void *opaque)
> =20
>  static void vmgenid_realize(DeviceState *dev, Error **errp)
>  {
> +    static bool is_realized =3D false;
>      VmGenIdState *vms =3D VMGENID(dev);
> +
> +    if (is_realized) {
> +        error_setg(errp, "Device %s may only be specified once",
> +                   VMGENID_DEVICE);
> +    }
>      qemu_register_reset(vmgenid_handle_reset, vms);
> +    is_realized =3D true;
>  }
>=20
> =3D=3D=3D
> Sample output:
> $ ../workspace/qemu/x86_64-softmmu/qemu-system-x86_64 -nographic -bios =
../workspace/seabios/out/bios.bin -machine type=3Dq35 -hda beiwe-with-vmg=
enid-driver.qcow2 -qmp unix:./qmp-sock,server,nowait -device vmgenid,guid=
=3D"324e6eaf-d1d1-4bf6-bf41-b9bb6c91fb66" -device vmgenid,guid=3D"324e6ea=
f-d1d1-4bf6-bf41-b9bb6c91fb67"
> qemu-system-x86_64: -device vmgenid,guid=3D324e6eaf-d1d1-4bf6-bf41-b9bb=
6c91fb67: Device vmgenid may only be specified once
>=20
>=20
> Good enough?  If so, I=E2=80=99ll roll it in.  Otherwise, it=E2=80=99ll=
 be a supplemental patch.

Ehm, I'd say let's postpone that patch. Function (or even file) scope
static variables that plaster over QOM shortcomings (or, well,
"non-trivial QOM patterns") are strongly frowned upon. I've done it
myself before (totally as a last resort, really -- not kidding!), and it
was real hard to get into the tree.

This deserves more discussion, so please delay it.

(While at it, please remember my other recommendation for realize():
enforcing that the running machine type / version provides the guest
with the DMA interface for fw_cfg. For that, based on prior consensus,
you'll need another device property, to be set in parallel to
fw_cfg_mem's and fw_cfg_io's "dma-enabled" property. So I think it makes
sense to address all of these things in a separate, followup series.)

Thanks!
Laszlo
