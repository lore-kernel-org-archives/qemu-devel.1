Received: from eggs.gnu.org ([2001:4830:134:3::10]:40656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1epHGx-0000BT-MX
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:36:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1epHGs-0000B6-Qm
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:36:39 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40006 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1epHGs-0000Am-M1
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:36:34 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180211093607.27351-1-armbru@redhat.com>
	<20180211093607.27351-21-armbru@redhat.com>
	<c1d0433c-267c-6874-290b-b1189f70046d@redhat.com>
Date: Fri, 23 Feb 2018 18:36:32 +0100
In-Reply-To: <c1d0433c-267c-6874-290b-b1189f70046d@redhat.com> (Eric Blake's
	message of "Mon, 12 Feb 2018 15:44:32 -0600")
Message-ID: <87k1v3k3q7.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 20/29] qapi/types qapi/visit: Generate
 built-in stuff into separate files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

Eric Blake <eblake@redhat.com> writes:

> On 02/11/2018 03:35 AM, Markus Armbruster wrote:
>> Linking code from multiple separate QAPI schemata into the same
>> program is possible, but involves some weirdness around built-in
>> types:
>>
>> * We generate code for built-in types into .c only with option
>>    --builtins.  The user is responsible for generating code for exactly
>>    one QAPI schema per program with --builtins.
>>
>> * We generate code for built-in types into .h regardless of
>>    --builtins, but guarded by #ifndef QAPI_VISIT_BUILTIN.  Because all
>>    copies of this code are exactly the same, including any combination
>>    of these headers works.
>>
>> Replace this contraption by something more conventional: generate code
>> for built-in types into their very own files: qapi-builtin-types.c,
>> qapi-builtin-visit.c, qapi-builtin-types.h, qapi-builtin-visit.h, but
>> only with --builtins.  Obey --output-dir, but ignore --prefix for
>> them.
>>
>> Make qapi-types.h include qapi-builtin-types.h.  With multiple
>> schemata you now have multiple qapi-types.[ch], but only one
>> qapi-builtin-types.[ch].  Same for qapi-visit.[ch] and
>> qapi-builtin-visit.[ch].
>>
>> Bonus: if all you need is built-in stuff, you can include a much
>> smaller header.  To be exploited shortly.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>> @@ -2046,6 +2046,7 @@ class QAPIGenH(QAPIGenC):
>>       class QAPIGenDoc(QAPIGen):
>> +
>>       def _top(self, fname):
>>           return (QAPIGen._top(self, fname)
>>                   + '@c AUTOMATICALLY GENERATED, DO NOT MODIFY\n\n')
>
> Does this hunk belong in an earlier patch?

Yes: PATCH 05.

> Otherwise,
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
