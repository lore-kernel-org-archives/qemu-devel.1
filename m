Received: from eggs.gnu.org ([2001:4830:134:3::10]:47493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dXaLb-000385-6z
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:48:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dXaLY-0002RH-3e
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:48:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37068)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1dXaLX-0002R0-QH
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:48:00 -0400
References: <15fc8a05-daff-d2af-7389-7253cb0b3517@linux.vnet.ibm.com>
	<96e5169c-6149-fd7a-3347-0994089e01ac@redhat.com>
	<ac3a06a2-bc47-92bb-50e2-0b8174c2b515@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <ed31f3b8-a754-deca-beae-55e98ce2e9f3@redhat.com>
Date: Tue, 18 Jul 2017 17:47:57 -0400
MIME-Version: 1.0
In-Reply-To: <ac3a06a2-bc47-92bb-50e2-0b8174c2b515@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Question for iotests 188, 189 and 087
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, Jing Liu <liujbjl@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: Lukas Doktor <ldoktor@redhat.com>, Amador Segundo <asegundo@redhat.com>



On 07/18/2017 05:22 PM, Cleber Rosa wrote:
> 
> 
> On 07/18/2017 02:07 PM, John Snow wrote:
>>
>>
>> On 07/17/2017 11:01 PM, Jing Liu wrote:
>>> Hi all,
>>>
>>> Do you anybody have iotests failure: 188, 189 and 087 of the latest qemu
>>> upsteam?
>>>
>>> I just wondered if it has something wrong with my test machines because
>>> I have different results with two machines.
>>>
>>>
>>> Thanks.
>>>
>>> Jing
>>>
>>>
>>
>> Presumably you are missing aio=native support for 087,
>>
> 
> I see 6 different "tests" as part of 087, and only one them requires AIO
> support ("aio=native without O_DIRECT"), which can fail like this:
> 
> --- /home/cleber/src/qemu/tests/qemu-iotests/087.out    2017-07-17
> 19:33:26.409758360 -0400
> +++ 087.out.bad 2017-07-18 17:01:37.736038689 -0400
> @@ -27,7 +27,7 @@
>  Testing:
>  QMP_VERSION
>  {"return": {}}
> -{"error": {"class": "GenericError", "desc": "aio=native was specified,
> but it requires cache.direct=on, which was not specified."}}
> +{"error": {"class": "GenericError", "desc": "aio=native was specified,
> but is not supported in this build."}}
>  {"return": {}}
>  {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},
> "event": "SHUTDOWN", "data": {"guest": false}}
> 
> Failures: 087
> Failed 1 of 1 tests
> 
> When either "--disable-linux-aio" is given or when libaio headers are
> missing, which in the end means that CONFIG_LINUX_AIO won't be set in
> config-host.mak or config-host.h.
> 
>> and 188/189 I believe require compression and/or LUKS libraries.
>>
> 
> I did not check if/which optional configure time option would end up
> disabling LUKS support and affecting those tests, but it's possible that
> something similar exists.
> 
>> These are false positives caused by missing libraries. We should
>> probably work out a proper solution to meaningfully skipping tests we
>> didn't compile support for.
>>
>> --js
>>
> 
> I see issues here:
> 
> 1) The qemu-iotests "runner", that is, "./check", understands that a
> file number is a test.  No further granularity is (currently?)
> achievable here.
> 

Yes.

> The easy solution would be to split tests which depend on optional
> features to separate test files.  In the 087 test given as example,
> the "=== aio=native without O_DIRECT ===" block would become, say, 190.
> 

Are we married to the numbers? Can we do 087a, 087b? Or even start
naming them so we can organize them in some meaningful sense?

> 2) Skip tests based on features more easily.  There's already support
> for skipping tests on various situations.  From 087:
> 
> ...
> _supported_fmt qcow2
> _supported_proto file
> _supported_os Linux
> ...
> 
> It's trivial to also have access to other compile time settings.  I did
> a quick experiment that would add a "_required_feature" function to
> "common.rc".  For 087 (or 190?) it would look like:
> 
> ...
> _supported_fmt qcow2
> _supported_proto file
> _supported_os Linux
> _required_feature CONFIG_LINUX_AIO
> ...
> 
> Does it make sense?  Would a patch series along those lines would be
> welcomed by reviews?
> 
> Thanks!
> 

Makes a lot of sense to me, but it would be nice to differentiate the
output from the ./check script into some broad categories:

(1) We ran the test(s), and it/they passed!
(2) We ran the test(s), and it/they failed.
(3) We didn't run the test, but that's OK (e.g. ./check -v -raw for a
test that only supports qcow2; that is, it's normal/expected for this
test to have been skipped in this way)
(4) We didn't run the test, and this is a coverage gap (e.g. libaio
support missing, so we cannot meaningfully test.)


Importantly, 3 and 4 are very different and we only support 1-3 today.
Most people run ./check -qcow2 or ./check -raw (if they run iotests at
all) but that still leaves some protocols and formats in the lurch, but
they're fairly regularly skipped regardless.

We have no "run EVERYTHING!" invocation that does raw, qcow2, luks (and
everything!!) all at once, so "SKIPS" currently have the semantic meaning:

"I didn't run this, but it's not a big deal, really."

If we start skipping tests because of missing libraries or compile
options, some skips take on the meaning:

"We didn't run this, but that means you didn't test some stuff that you
really ought to have."

I guess the key difference here is:

(1) The first skip mode doesn't change depending on what your
environment is, it only changes based on what you ask it to run, but

(2) These skips are environmentally dependent, and should be visually
identified as failures of the test runner to even attempt the test,
which is semantically rather distinct from (1) above

Clear as mud?

Great!

--js
