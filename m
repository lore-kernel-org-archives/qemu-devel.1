Received: from eggs.gnu.org ([2001:4830:134:3::10]:56954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1cxl6V-0001tk-24
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 22:00:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1cxl6R-0002O7-VT
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 22:00:23 -0400
Received: from mga14.intel.com ([192.55.52.115]:54467)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anthony.xu@intel.com>)
	id 1cxl6R-0002Ns-JW
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 22:00:19 -0400
From: "Xu, Anthony" <anthony.xu@intel.com>
Date: Tue, 11 Apr 2017 02:00:16 +0000
Message-ID: <4712D8F4B26E034E80552F30A67BE0B1A58A80@ORSMSX112.amr.corp.intel.com>
References: <4712D8F4B26E034E80552F30A67BE0B1A4E7F0@ORSMSX112.amr.corp.intel.com>
In-Reply-To: <4712D8F4B26E034E80552F30A67BE0B1A4E7F0@ORSMSX112.amr.corp.intel.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] centos 7.2 guest doesn't boot without kvmvapic in
 TCG mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "'qemu-devel@nongnu.org'" <qemu-devel@nongnu.org>
Cc: 'Paolo Bonzini' <pbonzini@redhat.com>, 'Stefan Hajnoczi' <stefanha@gmail.com>, "rth@twiddle.net" <rth@twiddle.net>

+ Richard Henderson

Anthony

> -----Original Message-----
> From: Xu, Anthony
> Sent: Tuesday, April 4, 2017 5:19 PM
> To: 'qemu-devel@nongnu.org' <qemu-devel@nongnu.org>
> Cc: 'Paolo Bonzini' <pbonzini@redhat.com>; 'Stefan Hajnoczi'
> <stefanha@gmail.com>
> Subject: [Qemu-devel] centos 7.2 guest doesn't boot without kvmvapic in
> TCG mode
>=20
> I disabled kvmvapic by
>=20
> diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
> index c3829e3..52be2b0 100644
> --- a/hw/intc/apic_common.c
> +++ b/hw/intc/apic_common.c
> @@ -440,7 +440,7 @@ static const VMStateDescription
> vmstate_apic_common =3D {
>  static Property apic_properties_common[] =3D {
>      DEFINE_PROP_UINT8("version", APICCommonState, version, 0x14),
>      DEFINE_PROP_BIT("vapic", APICCommonState, vapic_control,
> VAPIC_ENABLE_BIT,
> -                    true),
> +                    false),
>      DEFINE_PROP_BOOL("legacy-instance-id", APICCommonState,
> legacy_instance_id,
>                       false),
>      DEFINE_PROP_END_OF_LIST(),
>=20
>=20
> Tried to boot centos guest with this command
>=20
> ./x86_64-softmmu/qemu-system-x86_64 -bios
> /home/root/guest/seabios.bin
> -machine q35 -m 1G -drive
> format=3Draw,file=3D/home/root/images/centos7.2.img,if=3Dide,index=3D0
> -nographic  -nodefaults  -serial pty -monitor pty
> -chardev stdio,id=3Dseabios -device isa-
> debugcon,iobase=3D0x402,chardev=3Dseabios
>=20
>=20
> Seabios complained
>=20
> Seabios output
> "
> Booting from Hard Disk...
> WARNING - Timeout at ahci_command:154!
> Boot failed: could not read the boot disk
>=20
> enter handle_18:
>   NULL
> Booting from Floppy...
> Boot failed: could not read the boot disk
>=20
> enter handle_18:
>   NULL
> No bootable device.
> "
>=20
> It can boot with kvmvapic enabled by using the same command.
>=20
> Seabios output
> "
> Booting from Hard Disk...
> Booting from 0000:7c00
> "
>=20
> In the original commit,
> " Therefore, the VAPI is enabled by default, even in TCG mode. Here, no
> speedup can be achieved as the emulation overhead of the TPR register is
> marginal compared to instruction emulation."
>=20
> Seems no performance benefit for TCG mode
> What's the other benefit of using kvmvapic in TCG mode?
>=20
> Should we make TCG mode work without kvmvapic?
>=20
> If we don't need to use kvmvapic in TCG mode,
> we can make kvmvapic code clearer by removing all TCG related code in
> kvmvapic.c.
>=20
>=20
> Anthony
