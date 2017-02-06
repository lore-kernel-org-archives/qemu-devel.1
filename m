Received: from eggs.gnu.org ([2001:4830:134:3::10]:58229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1canrN-00036F-8p
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 13:17:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1canrH-0005Ls-M5
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 13:17:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1canrH-0005L1-D9
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 13:17:47 -0500
Date: Mon, 6 Feb 2017 20:17:46 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170206201249-mutt-send-email-mst@kernel.org>
References: <cover.1486285434.git.ben@skyportsystems.com>
	<28ff6ff023dd041fc7557955dea916adce72efea.1486285434.git.ben@skyportsystems.com>
	<20170206170455-mutt-send-email-mst@kernel.org>
	<E609277C-1E60-48F6-B83E-2A6AEFB242F3@skyportsystems.com>
	<20170206193300-mutt-send-email-mst@kernel.org>
	<769A787B-3A08-4A63-8521-9825C2DA0101@skyportsystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <769A787B-3A08-4A63-8521-9825C2DA0101@skyportsystems.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 05/10] ACPI: Add Virtual Machine
 Generation ID support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ben Warren <ben@skyportsystems.com>
Cc: qemu-devel@nongnu.org, lersek@redhat.com, imammedo@redhat.com

On Mon, Feb 06, 2017 at 09:59:55AM -0800, Ben Warren wrote:
>                +void vmgenid_add_fw_cfg(FWCfgState *s, GArray *guid)
>                +{
>                +    Object *obj =3D find_vmgenid_dev(NULL);
>                +    assert(obj);
>                +    VmGenIdState *vms =3D VMGENID(obj);
>                +
>                +    /* Create a read-only fw_cfg file for GUID */
>                +    fw_cfg_add_file(s, VMGENID_GUID_FW_CFG_FILE, guid->=
data,
>                +                    VMGENID_FW_CFG_SIZE);
>                +    /* Create a read-write fw_cfg file for Address */
>                +    fw_cfg_add_file_callback(s, VMGENID_ADDR_FW_CFG_FIL=
E, NULL,
>         NULL,
>=20
>=20
>            Seems wrong. What if guest updates the address after command=
 line
>            set it? You want a callback to copy guid there.
>=20
>=20
>         Sure, I can do that.  My understanding was that this is a read
>         callback, but if
>         it also is called upon a write, we should do what you suggest.
>=20
>=20
>     Hmm you are right. But we really need to call something
>     on write though - unlike read, it must be called after write.
>     Otherwise I don't see how it can work if you set gen id before
>     guest boots.
>=20
>     I guess this means we need yet another callback per file.
>     FWCfgWriteCallback ?
>=20
>     Can you implement this in hw/nvram/fw_cfg.c?
>     It's rather straight-forward to do.
>=20
>=20
> The reason it works is that we put the initial contents of the GUID (as
> supplied by command-line) into the GUID fw_cfg in the =E2=80=98vmgenid_=
build_acpi()=E2=80=99
> function, which is guaranteed to happen before the guest boots.  The on=
ly time
> QEMU needs to know VGIA is on later updates to the GUID (via monitor) o=
r when
> restoring.  If you really think this extra complexity is needed, I can =
do so,
> but it seems to work very well as-is.

I see. So it's a race condition I think.  It works unless you change the
gen id after bios read the guid from the guid file but before it wrote
out the address.

Or do I miss something?

--=20
MST
