Received: from eggs.gnu.org ([209.51.188.92]:38571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1grmbZ-0001VA-CI
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 11:32:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1grmbY-0008BU-AD
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 11:32:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59100)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1grmbX-000899-FO
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 11:32:48 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DEEF280F7C
	for <qemu-devel@nongnu.org>; Thu,  7 Feb 2019 16:32:43 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20190206181725.14337-1-armbru@redhat.com>
	<20190206181725.14337-8-armbru@redhat.com>
	<5426a5c4-421e-4a4b-6063-9fb38bc02ab4@redhat.com>
Date: Thu, 07 Feb 2019 17:32:41 +0100
In-Reply-To: <5426a5c4-421e-4a4b-6063-9fb38bc02ab4@redhat.com> (Eric Blake's
	message of "Thu, 7 Feb 2019 08:58:53 -0600")
Message-ID: <87ftsz8spi.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 07/17] qapi: New module target.json
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com

Eric Blake <eblake@redhat.com> writes:

> On 2/6/19 12:17 PM, Markus Armbruster wrote:
>> We can't add appropriate target-specific conditionals to misc.json,
>> because that would make all of misc.json unusable in
>> target-independent code.  To keep misc.json target-independent, we
>> need to split off target-dependent target.json.
>> 
>> This commit doesn't actually split off anything, it merely creates the
>> empty module.  The next few patches will move stuff from misc.json
>> there.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  Makefile.objs         | 20 +++++++++-----------
>>  Makefile.target       | 10 ++++++++++
>>  qapi/qapi-schema.json |  1 +
>>  qapi/target.json      | 13 +++++++++++++
>>  4 files changed, 33 insertions(+), 11 deletions(-)
>>  create mode 100644 qapi/target.json
>
>> +++ b/Makefile.target
>> @@ -164,6 +164,16 @@ endif
>>  
>>  GENERATED_FILES += hmp-commands.h hmp-commands-info.h
>>  
>> +# FIXME duplicates Makefile.obj's
>
> Is this addressed later in the series, or should the commit message call
> it out?

It's not addressed.

I added the FIXME for my RFC v2, which went out in a bit of a hurry
right before my Christmas break.  I promptly forgot it exists.

Either I find a way to avoid the duplication, or I mention the FIXME in
my commit message.

Thanks!

>> +QAPI_TARGET_MODULES = target
>> +obj-y += $(QAPI_TARGET_MODULES:%=qapi/qapi-types-%.o)
>> +obj-y += qapi/qapi-types.o
>> +obj-y += $(QAPI_TARGET_MODULES:%=qapi/qapi-visit-%.o)
>> +obj-y += qapi/qapi-visit.o
>> +obj-y += $(QAPI_TARGET_MODULES:%=qapi/qapi-events-%.o)
>> +obj-y += qapi/qapi-events.o
>> +obj-y += $(QAPI_TARGET_MODULES:%=qapi/qapi-commands-%.o)
>> +obj-y += qapi/qapi-commands.o
>>  obj-y += qapi/qapi-introspect.o
>>  
