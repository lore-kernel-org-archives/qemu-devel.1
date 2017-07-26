Received: from eggs.gnu.org ([2001:4830:134:3::10]:55912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daBOj-00053R-Mo
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 21:46:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daBOe-00032z-QS
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 21:46:01 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:37936)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daBOe-000329-LE
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 21:45:56 -0400
Received: by mail-qt0-x243.google.com with SMTP id p3so5995982qtg.5
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 18:45:56 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170725011530.17958-1-f4bug@amsat.org>
	<150102382734.26979.483898024984598924@loki>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <cb21f5d1-18be-51a4-5e51-e429ab4b1b46@amsat.org>
Date: Tue, 25 Jul 2017 22:45:31 -0300
MIME-Version: 1.0
In-Reply-To: <150102382734.26979.483898024984598924@loki>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] configure: fix qemu-ga missing '.exe'
 extension on windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Sameeh Jubran <sjubran@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org

Hi Michael,

On 07/25/2017 08:03 PM, Michael Roth wrote:
> Quoting Philippe Mathieu-Daudé (2017-07-24 20:15:30)
>> Reported-by: Sameeh Jubran <sjubran@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>> original report from Sameeh Jubran:
>> http://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg00906.html
> 
> AFAICT the issue discussed in the context of that patch is simply that
> the qemu-ga.exe file isn't deleted as part of `make clean`, which does
> seem to be an issue.
> 
> But qemu.ga.exe is created just fine as part of `make qemu-ga`, at least
> as of:
> 
>    fafcaf1d build: qemu-ga: add 'qemu-ga' build target for w32
> 

Yes, on w32 if "make ASDF" invokes the linker, it will create ASDF.exe.

> The 'qemu-ga' target is actually an intermediate target which, on w32,
> creates the MSI package (if configured) as well as qemu-ga.exe.
> 
>>
>>   Makefile  | 2 +-
>>   configure | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/Makefile b/Makefile
>> index ef721480eb..5f18243d05 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -490,7 +490,7 @@ clean:
>>          rm -f qemu-options.def
>>          rm -f *.msi
>>          find . \( -name '*.so' -o -name '*.dll' -o -name '*.mo' -o -name '*.[oda]' \) -type f -exec rm {} +
>> -       rm -f $(filter-out %.tlb,$(TOOLS)) $(HELPERS-y) qemu-ga TAGS cscope.* *.pod *~ */*~
>> +       rm -f $(filter-out %.tlb,$(TOOLS)) $(HELPERS-y) TAGS cscope.* *.pod *~ */*~

On win32, this patch add qemu-ga.exe instead of qemu-ga in $TOOLS, so 
when the 'clean' target is executed it removes qemu-ga.exe (Sameeh 
Jubran report). Before this patch the $TOOLS looks like:
"qemu-img.exe qemu-io.exe qemu-nbd.exe ivshmem-client.exe 
ivshmem-server.exe qemu-ga fsdev/virtfs-proxy-helper.exe"
The only executables which doesn't match %.exe is qemu-ga, so the 
'clean' target remove all .exe _but_ qemu-ga.exe.

Now if by "this is not an issue" you mean it is not a bug, I agree this 
can wait 2.11.

Regards,

Phil.

>>          rm -f fsdev/*.pod
>>          rm -f qemu-img-cmds.h
>>          rm -f ui/shader/*-vert.h ui/shader/*-frag.h
>> diff --git a/configure b/configure
>> index 48d4d7a2a7..f8b1d014d7 100755
>> --- a/configure
>> +++ b/configure
>> @@ -5073,7 +5073,7 @@ fi
>>
>>   if [ "$guest_agent" != "no" ]; then
>>     if [ "$linux" = "yes" -o "$bsd" = "yes" -o "$solaris" = "yes" -o "$mingw32" = "yes" ] ; then
>> -      tools="qemu-ga $tools"
>> +      tools="qemu-ga\$(EXESUF) $tools"
>>         guest_agent=yes
>>     elif [ "$guest_agent" != yes ]; then
>>         guest_agent=no
>> -- 
>> 2.13.3
>>
>>
> 
