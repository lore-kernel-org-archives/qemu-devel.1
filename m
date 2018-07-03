Received: from eggs.gnu.org ([2001:4830:134:3::10]:46657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faEnD-0002WA-3t
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 02:28:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faEnA-0006qT-0x
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 02:28:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48278 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faEn9-0006qI-SL
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 02:27:59 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 68819406F8B2
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 06:27:59 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180702162218.13678-1-armbru@redhat.com>
	<20180702162218.13678-9-armbru@redhat.com>
	<42a6b4dd-c278-2ca2-1843-61f35968c0ef@redhat.com>
Date: Tue, 03 Jul 2018 08:27:57 +0200
In-Reply-To: <42a6b4dd-c278-2ca2-1843-61f35968c0ef@redhat.com> (Eric Blake's
	message of "Mon, 2 Jul 2018 16:15:18 -0500")
Message-ID: <87zhz86dg2.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 08/32] tests/test-qga: Demonstrate the
 guest-agent ignores "id"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, stefanha@redhat.com, peterx@redhat.com, dgilbert@redhat.com

Eric Blake <eblake@redhat.com> writes:

> On 07/02/2018 11:21 AM, Markus Armbruster wrote:
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   tests/test-qga.c | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/tests/test-qga.c b/tests/test-qga.c
>> index 30c9643257..4edd35535d 100644
>> --- a/tests/test-qga.c
>> +++ b/tests/test-qga.c
>> @@ -227,6 +227,22 @@ static void test_qga_ping(gconstpointer fix)
>>       qobject_unref(ret);
>>   }
>>   +static void test_qga_invalid_id(gconstpointer fix)
>> +{
>> +    /* FIXME "id" is ignored; it should be rejected */
>
> I might have written:
>
> /* FIXME "id" is ignored; it should either be repeated in the reply,
> or rejected on input */

Sold.

>> +    const TestFixture *fixture = fix;
>> +    QDict *ret, *val;
>> +
>> +    ret = qmp_fd(fixture->fd, "{'execute': 'guest-ping', 'id': 1}");
>> +    g_assert_nonnull(ret);
>> +    qmp_assert_no_error(ret);
>> +
>> +    val = qdict_get_qdict(ret, "return");
>> +    g_assert(!qdict_haskey(val, "id"));
>
> This is documenting what currently happens, along with the FIXME
> showing that it is not ideal, so whether or not you improve the
> comment:
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
