Received: from eggs.gnu.org ([2001:4830:134:3::10]:50463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daD0B-0003Rg-8b
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 23:28:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daD06-0006YG-Be
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 23:28:47 -0400
Received: from mail-ua0-x233.google.com ([2607:f8b0:400c:c08::233]:34452)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daD06-0006Xu-5g
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 23:28:42 -0400
Received: by mail-ua0-x233.google.com with SMTP id q25so93757661uah.1
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 20:28:42 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170725011530.17958-1-f4bug@amsat.org>
	<150102382734.26979.483898024984598924@loki>
	<cb21f5d1-18be-51a4-5e51-e429ab4b1b46@amsat.org>
	<150103762159.26979.13316299204767598566@loki>
	<150103777491.26979.16844695290515425301@loki>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <cd92adf7-d750-a4e3-d4b6-b339cd7e7e11@amsat.org>
Date: Wed, 26 Jul 2017 00:28:34 -0300
MIME-Version: 1.0
In-Reply-To: <150103777491.26979.16844695290515425301@loki>
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
To: Michael Roth <mdroth@linux.vnet.ibm.com>, "Daniel P. Berrange" <berrange@redhat.com>, =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>, Sameeh Jubran <sjubran@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org

On 07/25/2017 11:56 PM, Michael Roth wrote:
> Quoting Michael Roth (2017-07-25 21:53:41)
>> Quoting Philippe Mathieu-Daudé (2017-07-25 20:45:31)
[...]
>> That change was done explicitly via fafcaf1d so that `make qemu-ga` and
>> `make` without --disable-tools specified to configure will generate the
>> MSI package when the user configures it. So, unlike the other $TOOLS
>> targets, the qemu-ga "distributables" encompass more than just the .exe
>> on w32, so we use the "qemu-ga" target instead of "qemu-ga.exe" directly.

I see, I didn't think about running git blame on this line, sorry.

>>
>> Reverting that change to coax `make clean` into cleaning up qemu-ga.exe
>> means that `make` no longer builds the qemu-ga-*.msi when the user
>> configures it, which is a regression.
>>
>>> The only executables which doesn't match %.exe is qemu-ga, so the
>>> 'clean' target remove all .exe _but_ qemu-ga.exe.
>>
>> As with Sameeh's original patch, the qemu-ga target would already
>> require special handling to deal with qemu-ga-*.msi file. We should
>> similarly just cleanup qemu-ga.exe as a special case instead of
>> modifying $TOOLS, since that brings about unecessary side-effects
>> described above.
>>
>> As a workaround to the issue you/Peter pointed out with Sameeh's patch
>> (nuking the entire source tree for posix builds where $EXESUF == ""), I
>> proposed we just do:
>>
>>    make clean:
>>      ...
>>    ifneq($EXESUF,)
>>      rm -f *$(EXESUF)
>>    endif
>>

Now I understand your fix. And looking at the Makefile structure it 
seems to be written with only UNIX system in mind (well, Windows world 
was not written with UNIX philosophy and GNU Make has some limitations 
out of it).
I can't think of a non-ugly short way to resolve Sameeh's issue. So I'll 
drop the patch I purposed for 2.10.

>> But given your clarification here, I understand that $TOOLS already
>> takes care of everything except qemu-ga.exe, so I think you've already
>> mentioned the most straightforward fix in the other thread:
>>
>> - rm -f $(filter-out %.tlb,$(TOOLS)) $(HELPERS-y) qemu-ga TAGS cscope.* *.pod *~ */*~
>> + rm -f $(filter-out %.tlb,$(TOOLS)) $(HELPERS-y) qemu-ga${EXESUF} TAGS cscope.* *.pod *~ */*~
>>
>> It's a bit ugly since `rm -f qemu-ga.exe` would silently fail on posix,
> 
> On w32 I mean, sorry.

side question: should we use $(RM) with something like:

ifeq ($(OS),Windows_NT)
     RM = cmd //C del //Q //F
else
     RM = rf -f
endif

> 
>> but `rm -f $TOOLS qemu-ga ...` already silently fails since it already gets
>> removed via $TOOLS.
>>
>> Alternatively, you can explicitly check for qemu-ga.exe and remove it if
>> it exists. I would consider either acceptable, but not this patch as it
>> currently stands.
