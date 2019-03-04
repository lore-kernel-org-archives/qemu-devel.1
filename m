Received: from eggs.gnu.org ([209.51.188.92]:58555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h0ivy-00029F-G6
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 03:26:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h0ivx-00021y-Jp
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 03:26:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50664)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1h0ivw-00020P-Gy
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 03:26:48 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190301154051.23317-1-armbru@redhat.com>
	<20190301154051.23317-5-armbru@redhat.com>
	<1432b833-99b1-90f1-7a0a-3dd1f8301c3b@redhat.com>
Date: Mon, 04 Mar 2019 09:26:44 +0100
In-Reply-To: <1432b833-99b1-90f1-7a0a-3dd1f8301c3b@redhat.com> (Eric Blake's
	message of "Fri, 1 Mar 2019 10:00:44 -0600")
Message-ID: <874l8jcaez.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 4/7] qapi: Fix code generation for
 sub-modules in other directories
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, quintela@redhat.com

Eric Blake <eblake@redhat.com> writes:

> On 3/1/19 9:40 AM, Markus Armbruster wrote:
>> The #include directives to pull in sub-modules use file names relative
>> to the main module.  Works only when all modules are in the same
>> directory, or the main module's output directory is in the compiler's
>> include path.  Use relative file names instead.
>> 
>> The dummy variable we generate to avoid empty .o files has an invalid
>> name for sub-modules in other directories.  Fix that.
>> 
>> Both messed up in commit 252dc3105fc "qapi: Generate separate .h, .c
>> for each module".  Escaped testing because tests/qapi-schema-test.json
>> doesn't cover sub-modules in other directories, only
>> tests/qapi-schema/include-relpath.json does, and we generate and
>> compile C code only for the former, not the latter.  Fold the latter
>> into the former.  This would have caught the mistakes fixed in this
>> commit.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>
>> +++ b/tests/.gitignore
>> @@ -11,9 +11,17 @@ test-*
>>  !test-*.c
>>  !docker/test-*
>>  test-qapi-commands.[ch]
>> +include/test-qapi-commands-sub-module.[ch]
>> +test-qapi-commands-sub-sub-module.[ch]
>>  test-qapi-events.[ch]
>> +include/test-qapi-events-sub-module.[ch]
>> +test-qapi-events-sub-sub-module.[ch]
>>  test-qapi-types.[ch]
>> +include/test-qapi-types-sub-module.[ch]
>> +test-qapi-types-sub-sub-module.[ch]
>>  test-qapi-visit.[ch]
>> +include/test-qapi-visit-sub-module.[ch]
>> +test-qapi-visit-sub-sub-module.[ch]
>>  test-qapi-introspect.[ch]
>>  *-test
>
> Messes with sorting, and makes me wonder if any globs could compress it
> further, but I can live with it (as I don't have any concrete
> suggestions on how better to write it).

I do: support only out-of-tree builds ;-P

>> @@ -505,8 +504,18 @@ qapi-schema += unknown-expr-key.json
>>  
>>  check-qapi-schema-y := $(addprefix tests/qapi-schema/, $(qapi-schema))
>>  
>> -GENERATED_FILES += tests/test-qapi-types.h tests/test-qapi-visit.h \
>> -	tests/test-qapi-commands.h tests/test-qapi-events.h \
>> +GENERATED_FILES += tests/test-qapi-types.h \
>> +	tests/include/test-qapi-types-sub-module.h \
>> +	tests/test-qapi-types-sub-sub-module.h \
>> +	tests/test-qapi-visit.h \
>> +	tests/include/test-qapi-visit-sub-module.h \
>> +	tests/test-qapi-visit-sub-sub-module.h \
>> +	tests/test-qapi-commands.h \
>> +	tests/include/test-qapi-commands-sub-module.h \
>> +	tests/test-qapi-commands-sub-sub-module.h \
>> +	tests/test-qapi-events.h \
>> +	tests/include/test-qapi-events-sub-module.h \
>> +	tests/test-qapi-events-sub-sub-module.h \
>>  	tests/test-qapi-introspect.h
>
> Worth declaring a good portion of this list in a separate variable, then
> appending that variable to GENERATED FILES as well as...
>
>
>> @@ -609,12 +623,32 @@ tests/test-replication$(EXESUF): tests/test-replication.o $(test-util-obj-y) \
>>  	$(test-block-obj-y)
>>  
>>  tests/test-qapi-types.c tests/test-qapi-types.h \
>> +tests/include/test-qapi-types-sub-module.c \
>> +tests/include/test-qapi-types-sub-module.h \
>> +tests/test-qapi-types-sub-sub-module.c \
>> +tests/test-qapi-types-sub-sub-module.h \
>>  tests/test-qapi-visit.c tests/test-qapi-visit.h \
>> +tests/include/test-qapi-visit-sub-module.c \
>> +tests/include/test-qapi-visit-sub-module.h \
>> +tests/test-qapi-visit-sub-sub-module.c \
>> +tests/test-qapi-visit-sub-sub-module.h \
>>  tests/test-qapi-commands.h tests/test-qapi-commands.c \
>> +tests/include/test-qapi-commands-sub-module.h \
>> +tests/include/test-qapi-commands-sub-module.c \
>> +tests/test-qapi-commands-sub-sub-module.h \
>> +tests/test-qapi-commands-sub-sub-module.c \
>>  tests/test-qapi-events.c tests/test-qapi-events.h \
>> +tests/include/test-qapi-events-sub-module.c \
>> +tests/include/test-qapi-events-sub-module.h \
>> +tests/test-qapi-events-sub-sub-module.c \
>> +tests/test-qapi-events-sub-sub-module.h \
>>  tests/test-qapi-introspect.c tests/test-qapi-introspect.h: \
>
> ...reusing it here for less duplication?

We compute stuff from ${QAPI_MODULES} for qapi/qapi-schema.json.
Reduces verbosity somewhat, for a price in complexity.  Verbosity
increases with number of modules, complexity stays flat.
qapi/qapi-schema.json has 20 sub-modules,
tests/qapi-schema/qapi-schema-test.json has two.  I'd prefer to stick
with stupid for now.

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
