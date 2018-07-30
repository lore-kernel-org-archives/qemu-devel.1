Received: from eggs.gnu.org ([2001:4830:134:3::10]:43605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fk1f6-0003GW-0g
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 02:28:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fk1f2-0000o9-Sq
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 02:28:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55504 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fk1f2-0000o0-LT
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 02:28:04 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180727151359.29061-1-armbru@redhat.com>
	<20180727151359.29061-22-armbru@redhat.com>
	<25e13fab-fe25-7577-a0ec-e87914abf730@redhat.com>
Date: Mon, 30 Jul 2018 08:28:03 +0200
In-Reply-To: <25e13fab-fe25-7577-a0ec-e87914abf730@redhat.com> (Eric Blake's
	message of "Fri, 27 Jul 2018 12:05:33 -0500")
Message-ID: <87muu91bm4.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 21/23] libqtest: Remove
 qtest_qmp_discard_response() & friends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, thuth@redhat.com, f4bug@amsat.org

Eric Blake <eblake@redhat.com> writes:

> On 07/27/2018 10:13 AM, Markus Armbruster wrote:
>> qtest_qmp_discard_response(...) is shorthand for
>> qobject_unref(qtest_qmp(...), except it's not actually shorter.
>> Moreover, the presence of these functions encourage sloppy testing.
>> Remove them.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>
> Reviewed-by: Eric Blake <eblake@redhat.com>
>
>
>> +++ b/tests/ahci-test.c
>> @@ -1607,14 +1607,14 @@ static void test_atapi_tray(void)
>>       atapi_wait_tray(true);
>>         /* Re-insert media */
>> -    qmp_discard_response("{'execute': 'blockdev-add', "
>> +    qobject_unref(qmp("{'execute': 'blockdev-add', "
>>                             "'arguments': {'node-name': 'node0', "
>>                                           "'driver': 'raw', "
>>                                           "'file': { 'driver': 'file', "
>> -                                                  "'filename': %s }}}", iso);
>> -    qmp_discard_response("{'execute': 'blockdev-insert-medium',"
>> +                      "'filename': %s }}}", iso));
>
> Why did you fix indentation for some, but not all, of the lines here?

Editing accident, fixing.

>> +    qobject_unref(qmp("{'execute': 'blockdev-insert-medium',"
>>                             "'arguments': { 'id': 'cd0', "
>> -                                         "'node-name': 'node0' }}");
>> +                      "'node-name': 'node0' }}"));
>
> Again, indentation looks odd.

Likewise.

>> +++ b/tests/fdc-test.c
>> @@ -26,6 +26,7 @@
>>       #include "libqtest.h"
>> +#include "qapi/qmp/qdict.h"
>>   #include "qemu-common.h"
>>     #define TEST_IMAGE_SIZE 1440 * 1024
>> @@ -298,9 +299,9 @@ static void test_media_insert(void)
>>         /* Insert media in drive. DSKCHK should not be reset until a
>> step pulse
>>        * is sent. */
>> -    qmp_discard_response("{'execute':'blockdev-change-medium', 'arguments':{"
>> +    qobject_unref(qmp("{'execute':'blockdev-change-medium', 'arguments':{"
>>                            " 'id':'floppy0', 'filename': %s, 'format': 'raw' }}",
>> -                         test_image);
>> +                      test_image));
>
> Another place where indentation looks odd.

Likewise.

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
