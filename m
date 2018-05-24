Received: from eggs.gnu.org ([2001:4830:134:3::10]:33842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fLhAV-00028s-F7
	for qemu-devel@nongnu.org; Wed, 23 May 2018 23:44:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fLhAS-0007VC-CV
	for qemu-devel@nongnu.org; Wed, 23 May 2018 23:43:59 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:35903)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fLhAS-0007V2-8s
	for qemu-devel@nongnu.org; Wed, 23 May 2018 23:43:56 -0400
Received: by mail-qk0-x242.google.com with SMTP id n207-v6so186587qke.3
	for <qemu-devel@nongnu.org>; Wed, 23 May 2018 20:43:56 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180523115719.26679-1-f4bug@amsat.org>
	<7f524be8-4807-64f1-7761-1d163524f2ec@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5ab5b52a-9dbc-6252-30bb-c8a39dc2ec78@amsat.org>
Date: Thu, 24 May 2018 00:43:50 -0300
MIME-Version: 1.0
In-Reply-To: <7f524be8-4807-64f1-7761-1d163524f2ec@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] tests: Allow GTESTER_OPTIONS variable
 expansion from command line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>

On 05/23/2018 03:33 PM, Thomas Huth wrote:
> On 23.05.2018 13:57, Philippe Mathieu-Daudé wrote:
>> The gtester utility offers the "-p=TESTPATH" option to
>> "only run test cases matching TESTPATH".  We already use
>> a $GTESTER_OPTIONS variable.
>> Use make variable expansion to allow qtest path matching
>> from command line:
>>
>>   $ time make check-qtest-arm GTESTER_OPTIONS="-p /arm/boot-serial"
>>     GTESTER check-qtest-arm
>>
>>   user 0m1.548s
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>> I am more interested in the "-s" option (exclude pattern) but
>> can't have it working :(
>>
>> i.e. "run all but qom/hmp":
>> make check-qtest-arm GTESTER_OPTIONS="-s /arm/qom -s /arm/hmp"
>>
>>  tests/Makefile.include | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>> index 3b9a5e31a2..b0ff3d988c 100644
>> --- a/tests/Makefile.include
>> +++ b/tests/Makefile.include
>> @@ -870,7 +870,7 @@ tests/test-qga$(EXESUF): qemu-ga$(EXESUF)
>>  tests/test-qga$(EXESUF): tests/test-qga.o $(qtest-obj-y)
>>  
>>  SPEED = quick
>> -GTESTER_OPTIONS = -k $(if $(V),--verbose,-q)
>> +GTESTER_OPTIONS += -k $(if $(V),--verbose,-q)
>>  GCOV_OPTIONS = -n $(if $(V),-f,)
>>  
>>  # gtester tests, possibly with verbose output
> 
> "make check-help" says:
> 
>  Default options are -k and (for make V=1) --verbose; they can be
>  changed with variable GTESTER_OPTIONS.
> 
> So if you change the behavior here to amend to the variable instead, I
> think you should also adjust the help text. Not sure if it's a good
> idea, though, there might be people who want to run without "-k" and
> this can not be disabled anymore with your patch.

Ok I see.  I'm interested in hearing how people run/use this option.

Anyway I'm fine using:

$ make check-qtest-arm GTESTER_OPTIONS="-p /arm/boot-serial --verbose"

Thanks for your review,

Phil.
