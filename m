Received: from eggs.gnu.org ([2001:4830:134:3::10]:42144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eh993-0001eR-A7
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 02:18:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eh98y-0000Ff-7F
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 02:18:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35278)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eh98x-0000F0-Uj
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 02:18:48 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180131144846.31697-1-armbru@redhat.com>
	<20180131144846.31697-5-armbru@redhat.com>
	<2bd84a3b-7aa2-8939-63ae-b8f2c830cf71@redhat.com>
Date: Thu, 01 Feb 2018 08:18:43 +0100
In-Reply-To: <2bd84a3b-7aa2-8939-63ae-b8f2c830cf71@redhat.com> (Eric Blake's
	message of "Wed, 31 Jan 2018 09:16:00 -0600")
Message-ID: <871si5rxd8.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 04/19] Include qapi/error.h exactly
 where needed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, f4bug@amsat.org, Gerd Hoffmann <kraxel@redhat.com>

Cc: Gerd for an idea; please skip to bottom of the message.

Eric Blake <eblake@redhat.com> writes:

> On 01/31/2018 08:48 AM, Markus Armbruster wrote:
>> This cleanup makes the number of objects depending on qapi/error.h
>> drop from 1910 (out of 4743) to 1612 in my "build everything" tree.
>>=20
>> While there, separate #include from file comment with a blank line,
>> and drop a useless comment on why qemu/osdep.h is included first.
>>=20
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>
>> +++ b/block/write-threshold.c
>> @@ -16,6 +16,7 @@
>>  #include "block/write-threshold.h"
>>  #include "qemu/notify.h"
>>  #include "qapi-event.h"
>> +#include "qapi/error.h"
>>  #include "qmp-commands.h"
>>=20=20
>>=20=20
>
> Worth squashing a double blank line while here?

Yes.  Same for the other too.

>> +++ b/hw/pci-bridge/i82801b11.c
>> @@ -44,7 +44,6 @@
>>  #include "qemu/osdep.h"
>>  #include "hw/pci/pci.h"
>>  #include "hw/i386/ich9.h"
>> -#include "qapi/error.h"
>>=20=20
>>=20=20
>>  /**********************************************************************=
*******/
>
> And here
>
>> +++ b/include/crypto/random.h
>> @@ -22,7 +22,6 @@
>>  #define QCRYPTO_RANDOM_H
>>=20=20
>>  #include "qemu-common.h"
>> -#include "qapi/error.h"
>>=20=20
>>=20=20
>>  /**
>> diff --git a/include/crypto/xts.h b/include/crypto/xts.h
>> index da32ab82b6..719971afb7 100644
>> --- a/include/crypto/xts.h
>> +++ b/include/crypto/xts.h
>> @@ -27,7 +27,6 @@
>>  #define QCRYPTO_XTS_H
>>=20=20
>>  #include "qemu-common.h"
>> -#include "qapi/error.h"
>>=20=20
>>=20=20
>>  #define XTS_BLOCK_SIZE 16
>
> And here
>
>> +++ b/include/ui/console.h
>> @@ -6,7 +6,9 @@
>>  #include "qapi/qmp/qdict.h"
>>  #include "qemu/notify.h"
>>  #include "qemu/error-report.h"
>> +#ifndef CONFIG_VNC
>>  #include "qapi/error.h"
>> +#endif
>
> Interesting conditional; it's because of the static inline fallbacks
> that are also conditional.  Makes sense.  An alternative would be having
> the fallbacks be in a .c rather than static inline in the .h, but it
> doesn't bother me enough to worry about it.

In my opinion, they should really, really be made a stub so we don't
have to include qapi/error.h in any configuration, but right now this
simple ifdeffery is all I can do.

> My R-b stands whether or not you make more whitespace tweaks.

Thanks!
