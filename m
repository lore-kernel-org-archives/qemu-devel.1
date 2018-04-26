Received: from eggs.gnu.org ([2001:4830:134:3::10]:60685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fBns0-0006GW-5L
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 16:52:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fBnrz-00089Q-F5
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 16:52:00 -0400
Received: from mail-pf0-x22b.google.com ([2607:f8b0:400e:c00::22b]:35184)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fBnrz-00088T-92
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 16:51:59 -0400
Received: by mail-pf0-x22b.google.com with SMTP id j5so19296267pfh.2
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 13:51:58 -0700 (PDT)
References: <20180424152405.10304-1-alex.bennee@linaro.org>
	<20180424152405.10304-44-alex.bennee@linaro.org>
	<84e43559-54ee-315b-24c9-c7e62e5a6d64@linaro.org>
	<87604el3g1.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ddb06ea5-2296-3de9-c720-70d060afeefd@linaro.org>
Date: Thu, 26 Apr 2018 10:51:52 -1000
MIME-Version: 1.0
In-Reply-To: <87604el3g1.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 43/46] tests/tcg/Makefile: update to be
 called from Makefile.target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, qemu-devel@nongnu.org

On 04/25/2018 11:30 PM, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> On 04/24/2018 05:24 AM, Alex Bennée wrote:
>>> +run-%: %
>>> +	$(call quiet-command, $(QEMU) $< > $<.out, "TEST", "$< on $(TARGET_NAME)")
>>
>> I've just had an x86_64 guest test run for 70 minutes.  We need to limit the
>> amount of time spent here in some way, with excessive time reported as test
>> failure.
>>
>> One potential way would be to add "ulimit -t $TIMEOUT" to the subshell before
>> running qemu.  A default TIMEOUT might be e.g. 15 seconds.  I'm not sure what
>> we should expect for the largest test on the smallest hosts...
> 
> Sounds reasonable - test-i386-fprem is probably the longest - I'm not
> sure it needs to be so exhaustive.

Better, not via ulimit but via something that measures wall time.  That way we
don't stall on e.g. a locked mutex when the child isn't spinning in a loop as
it was here.

I'd guess a small python script would be most maintainable...


r~
