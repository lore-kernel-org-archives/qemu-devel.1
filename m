Received: from eggs.gnu.org ([2001:4830:134:3::10]:51134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f95O2-00071J-Vd
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 04:57:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f95Nz-000424-Ti
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 04:57:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56516 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1f95Nz-00040U-LV
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 04:57:47 -0400
References: <20180417224054.26363-1-lersek@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d83f2e6c-1fe1-324d-aa09-459d37cab292@redhat.com>
Date: Thu, 19 Apr 2018 10:57:22 +0200
MIME-Version: 1.0
In-Reply-To: <20180417224054.26363-1-lersek@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu RFC v2] qapi: add "firmware.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org, libvir-list@redhat.com
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Alexander Graf <agraf@suse.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, David Gibson <dgibson@redhat.com>, Eric Blake <eblake@redhat.com>, Gary Ching-Pang Lin <glin@suse.com>, Gerd Hoffmann <kraxel@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Michal Privoznik <mprivozn@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On 18.04.2018 00:40, Laszlo Ersek wrote:
> Add a schema that describes the different uses and properties of virtual
> machine firmware.
> 
> Each firmware executable installed on a host system should come with at
> least one JSON file that conforms to this schema. Each file informs the
> management applications about the firmware's properties and one possible
> use case / feature set.
> 
> In addition, a configuration directory with symlinks to the JSON files
> should exist, with the symlinks carefully named to reflect a priority
> order. Management applications can then search this directory in priority
> order for the first firmware description that satisfies their search
> criteria. The found JSON file provides the management layer with domain
> configuration bits that are required to run the firmware binary for a
> certain use case or feature set.
[...]
> +##
> +# @FirmwareMappingFlash:
> +#
> +# Describes loading and mapping properties for the firmware executable and its
> +# accompanying NVRAM file, when @FirmwareDevice is @flash.
> +#
> +# @executable: Identifies the firmware executable. The firmware executable may
> +#              be shared by multiple virtual machine definitions. The
> +#              corresponding QEMU command line option is "-drive
> +#              if=pflash,unit=0,readonly=on,file=@executable.@pathname,format=@executable.@format".
> +#
> +# @nvram_template: Identifies the NVRAM template compatible with @executable.
> +#                  Management software instantiates an individual copy -- a
> +#                  specific NVRAM file -- from @nvram_template.@pathname for
> +#                  each new virtual machine definition created.
> +#                  @nvram_template.@pathname itself is never mapped into
> +#                  virtual machines, only individual copies of it are. An NVRAM
> +#                  file is typically used for persistently storing the
> +#                  non-volatile UEFI variables of a virtual machine definition.
> +#                  The corresponding QEMU command line option is "-drive
> +#                  if=pflash,unit=1,readonly=off,file=PATHNAME_OF_PRIVATE_NVRAM_FILE,format=@nvram_template.@format".
> +#
> +# Since: 2.13
> +##
> +{ 'struct' : 'FirmwareMappingFlash',
> +  'data'   : { 'executable'     : 'FirmwareFlashFile',
> +               'nvram_template' : 'FirmwareFlashFile' } }

I think it's more common to use "-" than "_" in these json files, so
maybe better use "nvram-template" instead of "nvram_template" ?

 Thomas
