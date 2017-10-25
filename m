Received: from eggs.gnu.org ([2001:4830:134:3::10]:56382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e7Lf3-00080P-60
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 09:23:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e7Lf0-0000nZ-1k
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 09:23:57 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:52496)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e7Lez-0000nL-SA
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 09:23:53 -0400
Received: by mail-qt0-x243.google.com with SMTP id 31so34668633qtz.9
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 06:23:53 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171022004621.28372-1-richard.henderson@linaro.org>
	<20171022004621.28372-12-richard.henderson@linaro.org>
	<14d023ad-e635-3a56-533b-2575a03266c4@amsat.org>
	<4880c661-9e6e-e31c-c0cc-810e67d8efea@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ee41dd65-92e1-3697-a508-e574c0494b4e@amsat.org>
Date: Wed, 25 Oct 2017 10:23:45 -0300
MIME-Version: 1.0
In-Reply-To: <4880c661-9e6e-e31c-c0cc-810e67d8efea@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 11/11] disas: Add capstone as submodule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

Hi Richard,

>> On 10/21/2017 09:46 PM, Richard Henderson wrote:
>>> Do not require the submodule, but use it if present.  Allow the
>>> command-line to override system or git submodule either way.
>>>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>  Makefile    | 13 +++++++++++++
>>>  .gitmodules |  3 +++
>>>  capstone    |  1 +
>>>  configure   | 60 +++++++++++++++++++++++++++++++++++++++++++++++++-----------
>>>  4 files changed, 66 insertions(+), 11 deletions(-)
>>>  create mode 160000 capstone
>>>
>>> diff --git a/Makefile b/Makefile
>>> index 9372742f86..beecc85bee 100644
>>> --- a/Makefile
>>> +++ b/Makefile
>>> @@ -383,6 +383,19 @@ subdir-dtc: .git-submodule-status dtc/libfdt dtc/tests
>>>  dtc/%: .git-submodule-status
>>>  	mkdir -p $@
>>>  
>>> +# Overriding CFLAGS causes us to lose defines added in the sub-makefile.
>>> +# Not overriding CFLAGS leads to mis-matches between compilation modes.
>>> +# Therefore we replicate some of the logic in the sub-makefile.
>>
>> I'm having plenty of "missing-prototypes" warnings:
> 
> Yes, we use lots of -Wfoo that upstream Capstone does not.  I do strip -Werror,
> so at least it builds.  Are you suggesting that I drop most of our extra -Wfoo?

Exactly. It's unlikely we try to modify capstone code in the submodule
to silent the warnings, there is enough QEMU work to do :P
I'd personally go with:

CAP_CFLAGS = $(CFLAGS) $(QEMU_CFLAGS) -w

At worst if there is an error while building capstone, it will still get
displayed.

> I suppose that's reasonable.  We don't want our developers worrying about
> warnings coming from upstream code.  If in fact you believe that most of our
> developers won't just install libcapstone-dev and be done?

This was my first reflex, but then you added the git feature and I just
wanted to test it.

Usually if I don't need a cutting edge feature, I try to use distrib
packages, to keep my environment closer to other developers.

A big part of QEMU developers uses Redhat/Fedora or Debian/Ubuntu and
there is an effort to verify QEMU still builds with those distribs using
the Travis CI. Now there even are VMs for BSD folks :)

So I'd not worry about distrib packages and these upstream warnings.

Regards,

Phil.
