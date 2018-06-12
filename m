Received: from eggs.gnu.org ([2001:4830:134:3::10]:56663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fSmED-0004VS-3c
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 12:33:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fSmEB-0007Mm-PM
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 12:33:05 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180607062559.16127-1-armbru@redhat.com>
	<20180607062559.16127-11-armbru@redhat.com>
	<20180612144308.GD4355@localhost.localdomain>
Date: Tue, 12 Jun 2018 18:32:56 +0200
In-Reply-To: <20180612144308.GD4355@localhost.localdomain> (Kevin Wolf's
	message of "Tue, 12 Jun 2018 16:43:08 +0200")
Message-ID: <874li8othj.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC PATCH 10/19] block: Make remaining uses of
 qobject input visitor more robust
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, jcody@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

Kevin Wolf <kwolf@redhat.com> writes:

> Am 07.06.2018 um 08:25 hat Markus Armbruster geschrieben:
>> Remaining uses of qobject_input_visitor_new_keyval() in the block
>> subsystem:
>> 
>> * block_crypto_create_opts_init()
>>   Currently doesn't visit any non-string scalars, thus safe.  It's
>>   called from
>>   - block_crypto_open_luks()
>>     Creates the QDict with qemu_opts_to_qdict_filtered(), which
>>     creates only string scalars, but has a TODO asking for other types.
>>   - qcow_open()
>>   - qcow2_open(), qcow2_co_invalidate_cache(), qcow2_reopen_prepare()
>
> Do you mean block_crypto_open_opts_init()?

Yes.  Fixing...

>> * block_crypto_create_opts_init(), called from
>>   - block_crypto_co_create_opts_luks()
>>     Also creates the QDict with qemu_opts_to_qdict_filtered().
>> 
>> * vdi_co_create_opts()
>>   Also creates the QDict with qemu_opts_to_qdict_filtered().
>> 
>> Replace these uses by qobject_input_visitor_new_flat_confused() for
>> robustness.  This adds crumpling.  Right now, that's a no-op, but if
>> we ever extend these things in non-flat ways, crumpling will be
>> needed.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  block/crypto.c | 6 +++---
>>  block/vdi.c    | 4 ++--
>>  2 files changed, 5 insertions(+), 5 deletions(-)
>> 
>> diff --git a/block/crypto.c b/block/crypto.c
>> index bc322b50f5..25d12e9d47 100644
>> --- a/block/crypto.c
>> +++ b/block/crypto.c
>> @@ -21,11 +21,11 @@
>>  #include "qemu/osdep.h"
>>  
>>  #include "block/block_int.h"
>> +#include "block/qdict.h"
>>  #include "sysemu/block-backend.h"
>>  #include "crypto/block.h"
>>  #include "qapi/opts-visitor.h"
>>  #include "qapi/qapi-visit-crypto.h"
>> -#include "qapi/qmp/qdict.h"
>>  #include "qapi/qobject-input-visitor.h"
>>  #include "qapi/error.h"
>>  #include "qemu/option.h"
>> @@ -159,7 +159,7 @@ block_crypto_open_opts_init(QCryptoBlockFormat format,
>>      ret = g_new0(QCryptoBlockOpenOptions, 1);
>>      ret->format = format;
>>  
>> -    v = qobject_input_visitor_new_keyval(QOBJECT(opts));
>> +    v = qobject_input_visitor_new_flat_confused(opts, &error_abort);
>
> At least this &error_abort is not correct:
>
> $ ./qemu-img create -f qcow2 --object secret,id=sec0,data=foo -oencrypt.format=luks,encrypt.key-secret=sec0 /tmp/test.qcow2 64M
> Formatting '/tmp/test.qcow2', fmt=qcow2 size=67108864 encrypt.format=luks encrypt.key-secret=sec0 cluster_size=65536 lazy_refcounts=off refcount_bits=16
> $ x86_64-softmmu/qemu-system-x86_64 -drive driver=qcow2,encrypt.foo=1,encrypt.foo.bar=2,file.filename=/tmp/test.qcow2
> Unexpected error in qdict_crumple() at qobject/block-qdict.c:452:
> qemu-system-x86_64: -drive driver=qcow2,encrypt.foo=1,encrypt.foo.bar=2,file.filename=/tmp/test.qcow2: Key foo prefix is already set as a dict
> Abgebrochen (Speicherabzug geschrieben)
>
>>      visit_start_struct(v, NULL, NULL, 0, &local_err);
>>      if (local_err) {
>> @@ -210,7 +210,7 @@ block_crypto_create_opts_init(QCryptoBlockFormat format,
>>      ret = g_new0(QCryptoBlockCreateOptions, 1);
>>      ret->format = format;
>>  
>> -    v = qobject_input_visitor_new_keyval(QOBJECT(opts));
>> +    v = qobject_input_visitor_new_flat_confused(opts, &error_abort);
>>  
>>      visit_start_struct(v, NULL, NULL, 0, &local_err);
>>      if (local_err) {
>> diff --git a/block/vdi.c b/block/vdi.c
>> index 668af0a828..6b6eed126d 100644
>> --- a/block/vdi.c
>> +++ b/block/vdi.c
>> @@ -51,10 +51,10 @@
>>  
>>  #include "qemu/osdep.h"
>>  #include "qapi/error.h"
>> -#include "qapi/qmp/qdict.h"
>>  #include "qapi/qobject-input-visitor.h"
>>  #include "qapi/qapi-visit-block-core.h"
>>  #include "block/block_int.h"
>> +#include "block/qdict.h"
>>  #include "sysemu/block-backend.h"
>>  #include "qemu/module.h"
>>  #include "qemu/option.h"
>> @@ -934,7 +934,7 @@ static int coroutine_fn vdi_co_create_opts(const char *filename, QemuOpts *opts,
>>      }
>>  
>>      /* Get the QAPI object */
>> -    v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
>> +    v = qobject_input_visitor_new_flat_confused(qdict, &error_abort);
>>      visit_type_BlockdevCreateOptions(v, NULL, &create_options, &local_err);
>>      visit_free(v);
>
> The other two &error_aborts _might_ be correct today because I couldn't
> see callers where the keys weren't already checked by QemuOpts, but I'm
> not sure if I looked at everything nor whether review would catch a
> future patch that added a new such call.

Okay, I'm getting rid of all three.

Thanks!
