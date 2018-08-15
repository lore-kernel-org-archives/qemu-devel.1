Received: from eggs.gnu.org ([2001:4830:134:3::10]:44295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fponq-0000bd-3j
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 01:57:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fponm-0004ro-KM
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 01:57:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41448 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fponm-0004qk-6y
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 01:57:02 -0400
References: <1534258018-22859-1-git-send-email-thuth@redhat.com>
	<1534258018-22859-3-git-send-email-thuth@redhat.com>
	<87a7pou95a.fsf@dusky.pond.sub.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <50453f7e-ef0e-bff4-e229-728b51017c62@redhat.com>
Date: Wed, 15 Aug 2018 07:56:59 +0200
MIME-Version: 1.0
In-Reply-To: <87a7pou95a.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/6] tests/device-introspection: Check that
 the qom-tree and qtree do not change
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 08/14/2018 07:53 PM, Markus Armbruster wrote:
> Thomas Huth <thuth@redhat.com> writes:
> 
>> Introspection should not change the qom-tree / qtree, so we should check
>> this in the device-introspect-test, too. This patch helped to find lots
>> of instrospection bugs during the QEMU v3.0 soft/hard-freeze period in the
>> last two months.
> 
> Clever idea.
> 
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  tests/device-introspect-test.c | 23 +++++++++++++++++++----
>>  1 file changed, 19 insertions(+), 4 deletions(-)
>>
>> diff --git a/tests/device-introspect-test.c b/tests/device-introspect-test.c
>> index 0b4f221..5b7ec05 100644
>> --- a/tests/device-introspect-test.c
>> +++ b/tests/device-introspect-test.c
>> @@ -103,7 +103,14 @@ static QList *device_type_list(bool abstract)
>>  static void test_one_device(const char *type)
>>  {
>>      QDict *resp;
>> -    char *help, *qom_tree;
>> +    char *help;
>> +    char *qom_tree_start, *qom_tree_end;
>> +    char *qtree_start, *qtree_end;
>> +
>> +    g_debug("Testing device '%s'", type);
> 
> This is only the second use of g_debug() in tests/.  What are you trying
> to accomplish?

When the test crashes, I need a way to determine the device which caused
the crash. To avoid that I've then got to insert fprintf statements
manually here and recompile, the g_debug() seems to be a good solution,
since you can enable its output by setting some environment variable (I
use G_MESSAGES_DEBUG=all and G_MESSAGES_PREFIXED=none).

Or do you see a better way to provide a possibility to determine the
device that caused a crash?

 Thomas
