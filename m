Received: from eggs.gnu.org ([209.51.188.92]:57304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1grR7v-0003pi-89
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 12:36:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1grR7s-0000Bg-8h
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 12:36:47 -0500
References: <20190202005610.24048-1-crosa@redhat.com>
	<20190202005610.24048-3-crosa@redhat.com>
	<20190206153639.61a5411c.cohuck@redhat.com>
	<85b0f519-38d8-cf7d-a22a-537dab8470a7@redhat.com>
	<20190206182043.49a18542.cohuck@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <12a1b55d-bb0b-8a5d-20ba-9777172144c3@redhat.com>
Date: Wed, 6 Feb 2019 12:36:23 -0500
MIME-Version: 1.0
In-Reply-To: <20190206182043.49a18542.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 02/20] Acceptance tests: show avocado
 test execution by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>, Stefan Markovic <smarkovic@wavecomp.com>, qemu-s390x@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>, Caio Carrara <ccarrara@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>



On 2/6/19 12:20 PM, Cornelia Huck wrote:
> On Wed, 6 Feb 2019 12:02:55 -0500
> Cleber Rosa <crosa@redhat.com> wrote:
> 
>> On 2/6/19 9:36 AM, Cornelia Huck wrote:
>>> On Fri,  1 Feb 2019 19:55:52 -0500
>>> Cleber Rosa <crosa@redhat.com> wrote:
>>>   
>>>> The current version of the "check-acceptance" target will only show
>>>> one line for execution of all tests.  That's probably OK if the tests
>>>> to be run are quick enough and they're always the same.
>>>>
>>>> But, there's already one test alone that takes on average ~5 seconds
>>>> to run, we intend to adapt the list of tests to match the user's build
>>>> environment (among other choices).  
>>>
>>> Btw: What are our expectations regarding execution time for tests?
>>> Especially if we continue adding tests, and architecture-specific tests
>>> are bound to be slower if run on a foreign architecture via tcg.
>>>
>>> Would a make check-acceptance-quick command make sense? ("I only want
>>> to verify quickly that I didn't break too much, so run the quicker
>>> tests only, probably only for my host architecture")
>>>   
>>
>> Yes, it definitely makes sense.  Now, let me know if the following also
>> makes sense to you:
>>
>> 1) Because these tests focus on functional testing, the default
>> target/shortcut ("make check-acceptance") should run the complete set of
>> test cases (including the slow ones).
> 
> Nod.
> 
>>
>> 2) Requirements vary greatly from user to user, to while adding a
>> "check-acceptance-quick" is fine, you just mentioned one extra test
>> execution variation ("for my host architecture").  For those, the idea
>> is that:
>>
>>  a) "make check-acceptance[-quick]" will adapt to the build environment
>> (if you only built s390x targets, that's all it's going to use)
> 
> Yes. However, I usually build some extra targets (just to verify that
> files that e.g. include headers I modify don't break for other
> environments), but don't necessarily want to run all acceptance tests
> for them (as I don't expect functional changes for them). That's
> probably something I only want to do when I run the full set anyway.
> 

Right, that's an interesting point I haven't thought of.

>>
>>  b) "avocado" command line interface *should* be easy enough to fulfill
>> other requirements, and not necessarily require a "make" target.  For
>> instance, if you're only interested in your host arch and one specific
>> machine type, a command line such as the following should do the trick:
>>
>>   $ make check-venv
>>   $ ./tests/venv/bin/avocado run -t arch:`uname -m` -t
>> machine:WHAT_I_CARE_ABOUT tests/acceptance/
>>
>> How does that sound?
> 
> Yes, that looks quite usable (I can easily define aliases locally for
> shortcuts) and solves the case I mentioned above.
> 
> So, to summarize:
> - add 'make check-acceptance-quick' that excludes tests marked as 'slow'

Yes... with one caveat: since the default is to have functional tests
that are not necessarily quick, the other approach has been used.  Tests
that are known to be quick are currently marked as such.

Anyway, this task is being tracked here:

https://trello.com/c/9HZWfKeE/79-add-a-make-check-acceptance-quick-target

> - use the avocado command line interface to further narrow down
>   architectures and machines, if wanted
> ?
> 

Yes.  Do you think this deserves a section in the docs?

Thanks!
- Cleber.
