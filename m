Received: from eggs.gnu.org ([2001:4830:134:3::10]:43148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cHZDn-0006ng-Et
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 11:49:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cHZDk-0000Nb-Cn
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 11:49:31 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:34251)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashijeetacharya@gmail.com>)
	id 1cHZDk-0000N9-7x
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 11:49:28 -0500
Received: by mail-io0-f193.google.com with SMTP id y124so9075539iof.1
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 08:49:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161215152914.GL2509@work-vm>
References: <1481742422-15969-1-git-send-email-ashijeetacharya@gmail.com>
	<1481742422-15969-2-git-send-email-ashijeetacharya@gmail.com>
	<20161215152914.GL2509@work-vm>
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Thu, 15 Dec 2016 22:18:26 +0530
Message-ID: <CAC2QTZZxEfy0YU2uEjt-P3VrJJWPzGfUW-mvFyyrAiiBQ6LorA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 1/3] migration: Add a new option to enable
 only-migratable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: John Snow <jsnow@redhat.com>, amit.shah@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, quintela@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, marcandre.lureau@redhat.com, groug@kaod.org, aneesh.kumar@linux.vnet.ibm.com, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, Dec 15, 2016 at 8:59 PM, Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
> * Ashijeet Acharya (ashijeetacharya@gmail.com) wrote:
>> Add a new option "--only-migratable" in qemu which will allow to add
>> only those devices which will not fail qemu after migration. Devices
>> set with the flag 'unmigratable' cannot be added when this option will
>> be used.
>>
>> Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
>> ---
>>  include/migration/migration.h |  3 +++
>>  qemu-options.hx               | 10 ++++++++++
>>  vl.c                          |  4 ++++
>>  3 files changed, 17 insertions(+)
>>
>> diff --git a/include/migration/migration.h b/include/migration/migration.h
>> index c309d23..40b3697 100644
>> --- a/include/migration/migration.h
>> +++ b/include/migration/migration.h
>> @@ -38,6 +38,9 @@
>>  #define QEMU_VM_COMMAND              0x08
>>  #define QEMU_VM_SECTION_FOOTER       0x7e
>>
>> +/* for vl.c */
>> +extern int only_migratable;
>> +
>>  struct MigrationParams {
>>      bool blk;
>>      bool shared;
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index c534a2f..7cc2cc5 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -3574,6 +3574,16 @@ be used to change settings (such as migration parameters) prior to issuing
>>  the migrate_incoming to allow the migration to begin.
>>  ETEXI
>>
>> +DEF("only-migratable", 0, QEMU_OPTION_only_migratable, \
>> +    "-only-migratable     allow only migratable devices\n", QEMU_ARCH_ALL)
>> +STEXI
>> +@item -only-migratable
>> +@findex -only-migratable
>> +Don't allow adding devices that will fail QEMU after migration. Devices set with
>> +the flag unmigratable are not allowed to be added neither statically nor
>> +dynamically
>> +ETEXI
>
> Can I suggest rewording that as:
> Only allow migratable devices.  Devices will not be allowed to enter an unmigratable
> state.

No problem, will fix that in v2.

>>  DEF("nodefaults", 0, QEMU_OPTION_nodefaults, \
>>      "-nodefaults     don't create default devices\n", QEMU_ARCH_ALL)
>>  STEXI
>> diff --git a/vl.c b/vl.c
>> index d77dd86..82bffb9 100644
>> --- a/vl.c
>> +++ b/vl.c
>> @@ -180,6 +180,7 @@ bool boot_strict;
>>  uint8_t *boot_splash_filedata;
>>  size_t boot_splash_filedata_size;
>>  uint8_t qemu_extra_params_fw[2];
>> +int only_migratable = 0; /* turn it off unless user states otherwise */
>>
>>  int icount_align_option;
>>
>> @@ -3914,6 +3915,9 @@ int main(int argc, char **argv, char **envp)
>>                  }
>>                  incoming = optarg;
>>                  break;
>> +            case QEMU_OPTION_only_migratable:
>> +                only_migratable = 1;
>> +                break;
>>              case QEMU_OPTION_nodefaults:
>>                  has_defaults = 0;
>>                  break;
>
> Does this need to go in the 'first pass of option parsing' loop
> to make sure that it doesn't matter which order it's in and it
> stops other devices on the command line?

I am not sure what you meant by order here;

Do you mean the order as in the place --only-migratable is used,

1. ./bin/qemu-system-x86_64 -m 1024 -name f15 -device
nec-usb-xhci,id=xhci -device usb-uas,id=uas,bus=xhci.0
--only-migratable
2. ./bin/qemu-system-x86_64 -m 1024 -name f15 --only-migratable
-device nec-usb-xhci,id=xhci -device usb-uas,id=uas,bus=xhci.0

Because I have tested both and they seem to be working equally fine.
Sorry if I understood wrong.

Ashijeet

> Dave
>
>> --
>> 2.6.2
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
