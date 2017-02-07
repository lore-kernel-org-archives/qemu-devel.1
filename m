Received: from eggs.gnu.org ([2001:4830:134:3::10]:55771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cbCG2-0001e9-Il
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 15:20:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cbCFx-0002FR-JX
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 15:20:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34888)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cbCFx-0002E7-D5
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 15:20:53 -0500
References: <cover.1486285434.git.ben@skyportsystems.com>
	<2bb2dd455ea355b279867a312924add82ae685e4.1486285434.git.ben@skyportsystems.com>
	<20170206165517-mutt-send-email-mst@kernel.org>
	<65C02079-7702-4819-8852-1EB294B701FF@skyportsystems.com>
	<20170206192919-mutt-send-email-mst@kernel.org>
	<20170207131143.7572c006@nial.brq.redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <24ec8f18-4e4e-7d5d-4c0e-60a91fe5e62f@redhat.com>
Date: Tue, 7 Feb 2017 21:20:49 +0100
MIME-Version: 1.0
In-Reply-To: <20170207131143.7572c006@nial.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 02/10] linker-loader: Add new 'write
 pointer' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Ben Warren <ben@skyportsystems.com>

On 02/07/17 13:11, Igor Mammedov wrote:
> On Mon, 6 Feb 2017 19:31:24 +0200
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>=20
>> On Mon, Feb 06, 2017 at 09:16:25AM -0800, Ben Warren wrote:
>>>>> @@ -257,8 +263,11 @@ void bios_linker_loader_add_pointer(BIOSLinker=
 *linker,
>>>>>     const BiosLinkerFileEntry *source_file =3D
>>>>>         bios_linker_find_file(linker, src_file);
>>>>>
>>>>> -    assert(dst_patched_offset < dst_file->blob->len);
>>>>> -    assert(dst_patched_offset + dst_patched_size <=3D dst_file->bl=
ob->len);
>>>>> +    /* dst_file need not exist if writing back */ =20
>>>>
>>>> Why not? =20
>>> Because WRITE_POINTER can be called without having first called
>>> ALLOCATE.  In the Vm Generation ID example, there=E2=80=99s no reason=
 for BIOS
>>> to allocate memory for the address fw_cfg, since it=E2=80=99s a const=
ruct that
>>> only matters to QEMU.  This is something that was requested by Laszlo=
. =20
>>
>> Well all other commands require you to first allocate.
>> How does bios know e.g. which zone to put it in then?
> There is no need to know which zone to put it in as file
> is writeback only, i.e. there is no need to allocate
> RAM for file (shadow it) which won't be read by guest side ever
> if I got idea right.
> Issue in the patch is combining new command with existing API
> bios_linker_loader_add_pointer(),
> as you suggested new API function + good description what it does
> would be better than reusing.

Agreed on all points (and sorry about the delayed response):

- The writeable fw_cfg file that receives the address from the guest
firmware need not and should not be downloaded by the guest firmware,
into guest memory. Such a blob, in guest memory, is entirely useless to
the guest.

- I also strongly prefer a separate command structure, and function
name, for the new command. (The structure can be shared by a typedef or
another sub-structure, but it should have its own separate struct tag /
type name.)

Thanks!
Laszlo

>=20
>=20
>>
>> I don't like the asymmetry ... Laszlo?=20
>=20
>=20
