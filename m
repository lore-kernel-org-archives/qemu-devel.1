Received: from eggs.gnu.org ([2001:4830:134:3::10]:59062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f8gBJ-0008T7-5w
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 02:03:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f8gBE-00064f-Ag
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 02:03:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45176 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1f8gBE-00064B-6M
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 02:02:56 -0400
Date: Wed, 18 Apr 2018 08:02:43 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180418060243.iafg4wj5gwsruop5@sirius.home.kraxel.org>
References: <20180417224054.26363-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180417224054.26363-1-lersek@redhat.com>
Subject: Re: [Qemu-devel] [qemu RFC v2] qapi: add "firmware.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>, Alexander Graf <agraf@suse.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, David Gibson <dgibson@redhat.com>, Eric Blake <eblake@redhat.com>, Gary Ching-Pang Lin <glin@suse.com>, Kashyap Chamarthy <kchamart@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Michal Privoznik <mprivozn@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>

On Wed, Apr 18, 2018 at 12:40:54AM +0200, Laszlo Ersek wrote:
> Add a schema that describes the different uses and properties of virtual
> machine firmware.

Looks good to me overall.

> +{ 'enum' : 'FirmwareType',
> +  'data' : [ 'bios', 'slof', 'uboot', 'uefi' ] }

openbios missing.

> +{ 'enum' : 'FirmwareArchitecture',
> +  'data' : [ 'aarch64', 'arm', 'i386', 'x86_64' ] }

ppc(64) missing (but you have slof above ;) ...
s390 too.

> +# @machines: Lists the machine types (known by the emulator that is specified
> +#            through @architecture) that can execute the firmware. Elements of
> +#            @machines are not supposed to be versioned; if a machine type is
> +#            versioned in QEMU (e.g. "pc-i440fx-2.12"), then its unversioned
> +#            variant, which typically refers to the latest version (e.g. "pc"),
> +#            should be listed in @machines. On the QEMU command line, "-machine
> +#            type=..." specifies the requested machine type.

Hmm, I'd tend to ignore the aliases here (pc, q35, virt) and use
wildcards instead (pc-i440fx-*, pc-q35-*, virt-*).

I think that will be easier for libvirt to work with because it always
resolves aliases to actual machine types when storing them in the domain
xml.

> +# @secure-boot: The firmware implements the software interfaces for UEFI Secure
> +#               Boot, as defined in the UEFI specification. Note that without
> +#               @requires-smm, guest code running with kernel privileges can
> +#               undermine the security of Secure Boot.
> +#
> +# @secure-boot-enrolled-keys: The variable store (NVRAM) template associated

I think "enrolled-keys" should better be a separate feature.

cheers,
  Gerd
