Received: from eggs.gnu.org ([2001:4830:134:3::10]:46088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1f8lN7-0002EM-KW
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 07:35:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1f8lN3-0005Gj-9f
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 07:35:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54758 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1f8lN3-0005GL-4I
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 07:35:29 -0400
References: <20180417224054.26363-1-lersek@redhat.com>
	<87po2wzysh.fsf@dusky.pond.sub.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <8a52bb49-4194-3b91-8b67-a0e5700fd6ed@redhat.com>
Date: Wed, 18 Apr 2018 13:35:17 +0200
MIME-Version: 1.0
In-Reply-To: <87po2wzysh.fsf@dusky.pond.sub.org>
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
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Michal Privoznik <mprivozn@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>, Alexander Graf <agraf@suse.de>, Gary Ching-Pang Lin <glin@suse.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <dgibson@redhat.com>

On 04/18/18 10:47, Markus Armbruster wrote:
> Laszlo Ersek <lersek@redhat.com> writes:

>> +##
>> +# @FirmwareArchitecture:
>> +#
>> +# Defines the target architectures (emulator binaries) that firmware may
>> +# execute on.
>> +#
>> +# @aarch64: The firmware can be executed by the qemu-system-aarch64 emulator.
>> +#
>> +# @arm: The firmware can be executed by the qemu-system-arm emulator.
>> +#
>> +# @i386: The firmware can be executed by the qemu-system-i386 emulator.
>> +#
>> +# @x86_64: The firmware can be executed by the qemu-system-x86_64 emulator.
>> +#
>> +# Since: 2.13
>> +##
>> +{ 'enum' : 'FirmwareArchitecture',
>> +  'data' : [ 'aarch64', 'arm', 'i386', 'x86_64' ] }
> 
> Partial dupe of CpuInfoArch from misc.json.  Neither covers all our
> target architectures.  Should we have one that does in common.json
> instead?

If we had one there, I'd use it here :)

For collecting the arch identifiers, is it OK to run "./configure
--help", and look for the "*-softmmu" options under
"--target-list=LIST"? Because that's what I need here; the qemu-system-*
emulators.

>> +##
>> +# @FirmwareFeature:
>> +#
>> +# Defines the features that firmware may support, and the platform requirements
>> +# that firmware may present.
>> +#
>> +# @acpi-s3: The firmware supports S3 sleep (suspend to RAM), as defined in the
>> +#           ACPI specification. On the "pc" machine type of the @i386 and
>> +#           @x86_64 emulation targets, S3 can be enabled with "-global
>> +#           PIIX4_PM.disable_s3=0" and disabled with "-global
>> +#           PIIX4_PM.disable_s3=1". On the "q35" machine type of the @i386 and
>> +#           @x86_64 emulation targets, S3 can be enabled with "-global
>> +#           ICH9-LPC.disable_s3=0" and disabled with "-global
>> +#           ICH9-LPC.disable_s3=1".
>> +#
>> +# @acpi-s4: The firmware supports S4 hibernation (suspend to disk), as defined
>> +#           in the ACPI specification. On the "pc" machine type of the @i386
>> +#           and @x86_64 emulation targets, S4 can be enabled with "-global
>> +#           PIIX4_PM.disable_s4=0" and disabled with "-global
>> +#           PIIX4_PM.disable_s4=1". On the "q35" machine type of the @i386 and
>> +#           @x86_64 emulation targets, S4 can be enabled with "-global
>> +#           ICH9-LPC.disable_s4=0" and disabled with "-global
>> +#           ICH9-LPC.disable_s4=1".
> 
> Would you mind breaking documentation lines a bit ealier?

Not at all; I aimed at 79 characters (like I do for the QEMU C source
code as well), but perhaps that's too wide for schema docs. What width
do you prefer?

While at it: is it possible to break the documentation for a single
@entry to multiple paragraphs? I tried it (simply by inserting an empty
line, without starting another @entry), and the generator didn't like it.

>> +##
>> +# @FirmwareFlashFile:
>> +#
>> +# Defines common properties that are necessary for loading a firmware file into
>> +# a pflash chip. The corresponding QEMU command line option is "-drive
>> +# file=@pathname,format=@format". Note however that the option-argument shown
>> +# here is incomplete; it is completed under @FirmwareMappingFlash.
>> +#
>> +# @pathname: Specifies the pathname on the host filesystem where the firmware
>> +#            file can be found.
> 
> We use @filename elsewhere in the QAPI schema.  Let's stick to that.
> More of the same below.

Will do.


>> +#
>> +# @format: Specifies the block format of the file pointed-to by @pathname, such
>> +#          as @raw or @qcow2.
>> +#
>> +# Since: 2.13
>> +##
>> +{ 'struct' : 'FirmwareFlashFile',
>> +  'data'   : { 'pathname' : 'str',
>> +               'format'   : 'BlockdevDriver' } }
>> +
>> +##
>> +# @FirmwareMappingFlash:
>> +#
>> +# Describes loading and mapping properties for the firmware executable and its
>> +# accompanying NVRAM file, when @FirmwareDevice is @flash.
>> +#
>> +# @executable: Identifies the firmware executable. The firmware executable may
>> +#              be shared by multiple virtual machine definitions. The
>> +#              corresponding QEMU command line option is "-drive
>> +#              if=pflash,unit=0,readonly=on,file=@executable.@pathname,format=@executable.@format".
> 
> I guess @executable.@pathname means member @pathname of @executable.  I
> read it as two distinct parameters first, then wondered where parameter
> @pathname is.  Perhaps @executable.pathname would be clearer.

I can try that, yes -- in the HTML documentation, will the monospace
style apply to the full field specification?

> 
>> +#
>> +# @nvram_template: Identifies the NVRAM template compatible with @executable.
>> +#                  Management software instantiates an individual copy -- a
>> +#                  specific NVRAM file -- from @nvram_template.@pathname for
>> +#                  each new virtual machine definition created.
>> +#                  @nvram_template.@pathname itself is never mapped into
>> +#                  virtual machines, only individual copies of it are. An NVRAM
>> +#                  file is typically used for persistently storing the
>> +#                  non-volatile UEFI variables of a virtual machine definition.
>> +#                  The corresponding QEMU command line option is "-drive
>> +#                  if=pflash,unit=1,readonly=off,file=PATHNAME_OF_PRIVATE_NVRAM_FILE,format=@nvram_template.@format".
>> +#
>> +# Since: 2.13
>> +##
>> +{ 'struct' : 'FirmwareMappingFlash',
>> +  'data'   : { 'executable'     : 'FirmwareFlashFile',
>> +               'nvram_template' : 'FirmwareFlashFile' } }

Here's one thing I'll comment on myself: "nvram_template" should have
been spelled "nvram-template" :)

>> +
>> +##
>> +# @FirmwareMappingKernel:
>> +#
>> +# Describes loading and mapping properties for the firmware executable, when
>> +# @FirmwareDevice is @kernel.
>> +#
>> +# @pathname: Identifies the firmware executable. The firmware executable may be
>> +#            shared by multiple virtual machine definitions. The corresponding
>> +#            QEMU command line option is "-kernel @pathname".
>> +#
>> +# Since: 2.13
>> +##
>> +{ 'struct' : 'FirmwareMappingKernel',
>> +  'data'   : { 'pathname' : 'str' } }
>> +
>> +##
>> +# @FirmwareMappingMemory:
>> +#
>> +# Describes loading and mapping properties for the firmware executable, when
>> +# @FirmwareDevice is @memory.
>> +#
>> +# @pathname: Identifies the firmware executable. The firmware executable may be
>> +#            shared by multiple virtual machine definitions. The corresponding
>> +#            QEMU command line option is "-bios @pathname".
>> +#
>> +# Since: 2.13
>> +##
>> +{ 'struct' : 'FirmwareMappingMemory',
>> +  'data'   : { 'pathname' : 'str' } }
>> +
>> +##
>> +# @FirmwareMapping:
>> +#
>> +# Provides a discriminated structure for firmware to describe its loading /
>> +# mapping properties.
>> +#
>> +# @device: Selects the device type that the firmware must be mapped into.
>> +#
>> +# Since: 2.13
>> +##
>> +{ 'union'         : 'FirmwareMapping',
>> +  'base'          : { 'device' : 'FirmwareDevice' },
>> +  'discriminator' : 'device',
>> +  'data'          : { 'flash'  : 'FirmwareMappingFlash',
>> +                      'kernel' : 'FirmwareMappingKernel',
>> +                      'memory' : 'FirmwareMappingMemory' } }
> 
> The FirmwareMapping* all have a member @pathname.  It could be moved to
> the base.  Makes sense if we think future FirmwareMappingFOOs will also
> have it.  Your choice.

I could do that, but there would be consequences:

- FirmwareMappingKernel and FirmwareMappingMemory would become empty
  structures,

- in the documentation of @FirmwareMapping, I couldn't document @flash /
@kernel / @memory individually (I tried -- it doesn't work; the
generator wants to generate the documentation automatically).

The issue is that I would like to keep the QEMU cmdline options
"-kernel" and "-bios" *close* to @FirmwareMappingKernel and
@FirmwareMappingMemory. Now, if I make those structs empty, but keep the
-kernel / -bios cmdline options right under them, then I cannot refer to
@pathname (well, @filename) in those options -- because @filename will
no longer be defined under @FirmwareMappingKernel / @FirmwareMappingMemory.

And if I move the documentation of -kernel / -bios under
@FirmwareMapping, then it's awkward again, because then I have to dump
both -kernel and -bios into the documentation of @filename, and explain
which belongs to which union member / discriminator value.

So, if it's not a problem, I'd like to stick with this variant, for the
sake of documenting -kernel and -bios more clearly.

>> +##
>> +# @Firmware:
>> +#
>> +# Describes a firmware (or a firmware use case) to management software.
>> +#
>> +# @description: Provides a human-readable description of the firmware.
>> +#               Management software may or may not display @description.
>> +#
>> +# @type: Exposes the type of the firmware. @type is generally the primary key
>> +#        for which management software looks when picking a firmware for a new
>> +#        virtual machine definition.
>> +#
>> +# @mapping: Describes the loading / mapping properties of the firmware.
>> +#
>> +# @targets: Collects the target architectures (QEMU system emulators) and their
>> +#           machine types that may execute the firmware.
>> +#
>> +# @features: Lists the features that the firmware supports, and the platform
>> +#            requirements it presents.
>> +#
>> +# @tags: A list of auxiliary strings associated with the firmware for which
>> +#        @description is not approprite, due to the latter's possible exposure
> 
> s/approprite/appropriate/
> 
> Feed the new comments to a spell checker?

Right, I got "aspell" installed, and sometimes run it on my status
reports :) I was too tired to do it for the schema. Good catch, thanks.

> Introspection has a similar need for validating data against the schema,
> but it solves it with a test case without adding a QMP command.  Commit
> 39a18158165:
> 
>     A new test-qmp-input-visitor test case feeds its result for both
>     tests/qapi-schema/qapi-schema-test.json and qapi-schema.json to a
>     QmpInputVisitor to verify it actually conforms to the schema.
> 
> The test case has since moved to tests/test-qobject-input-visitor.c,
> function test_visitor_in_qmp_introspect().  Please check it out to see
> whether you can do without a QMP command, too.

Paolo suggested earlier that no C code should be added ultimately; the
schema should be moved under "docs/interop/". I was OK with that, just
wanted to keep the examples verifiable against the schema until the
patch got committed:

http://mid.mail-archive.com/9d6b3e23-ed02-0079-50d0-15de8b11810f@redhat.com

So in the non-RFC version, the QMP command shouldn't exist at all.

Thanks,
Laszlo
