Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB47C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 19:36:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 081A12065C
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 19:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HBxW2kCK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 081A12065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZJf6-0004Zx-7W
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 15:36:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jZJaM-00070Q-Nb
 for qemu-devel@nongnu.org; Thu, 14 May 2020 15:32:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23167
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jZJaK-00019V-Re
 for qemu-devel@nongnu.org; Thu, 14 May 2020 15:32:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589484720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=n2QUdrADBKjcI7kRXuoN81HU3oCBkyJI/5WNlxx5b54=;
 b=HBxW2kCK0a9ZO0b0LeOwWrQ4/ye4QOaGT09pm67WaItPzF+0wyyMxnUKTUxjNRitSxE8ou
 1OiecSNXoG9fEb19okrd5T4mK42YWeGlfcxSA4THAmXaLbZ/ZQHUZ5aqMbcI4ArWziDwQ8
 7q+6Uqs/e/nqXPyklcxw39LLhF1XeMw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-_AUU8EEkNHy0J0pPZ8ii8g-1; Thu, 14 May 2020 15:31:56 -0400
X-MC-Unique: _AUU8EEkNHy0J0pPZ8ii8g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B23B8730BD;
 Thu, 14 May 2020 19:31:55 +0000 (UTC)
Received: from [10.10.119.184] (ovpn-119-184.rdu2.redhat.com [10.10.119.184])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 204375D9F1;
 Thu, 14 May 2020 19:31:51 +0000 (UTC)
Subject: Re: [PATCH v4 1/3] qmp.py: change event_wait to use a dict
To: Kevin Wolf <kwolf@redhat.com>
References: <20200514022536.2568-1-jsnow@redhat.com>
 <20200514022536.2568-2-jsnow@redhat.com>
 <20200514144732.GJ5518@linux.fritz.box>
 <de1026e4-9815-f89c-4cfd-6da35ac23197@redhat.com>
 <20200514155952.GM5518@linux.fritz.box>
From: John Snow <jsnow@redhat.com>
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <3fda28e5-2049-1667-4da7-bbabac1fee15@redhat.com>
Date: Thu, 14 May 2020 15:31:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200514155952.GM5518@linux.fritz.box>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 11:35:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 5/14/20 11:59 AM, Kevin Wolf wrote:
> Am 14.05.2020 um 17:07 hat John Snow geschrieben:
>>
>>
>> On 5/14/20 10:47 AM, Kevin Wolf wrote:
>>> Am 14.05.2020 um 04:25 hat John Snow geschrieben:
>>>> It's easier to work with than a list of tuples, because we can check the
>>>> keys for membership.
>>>>
>>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>>> ---
>>>>  python/qemu/machine.py        | 10 +++++-----
>>>>  tests/qemu-iotests/040        | 12 ++++++------
>>>>  tests/qemu-iotests/260        |  5 +++--
>>>>  tests/qemu-iotests/iotests.py | 16 ++++++++--------
>>>>  4 files changed, 22 insertions(+), 21 deletions(-)
>>>
>>> I think you need to convert scripts/simplebench/bench_block_job.py, too.
>>
>> Oh, right -- that one is new since I did this. A lot of these scripts
>> need to be moved over into the python/ directory and managed under the
>> same pylint/mypy regime as everything else.
>>
>> A *ton* of our scripts are in various states of disrepair.
> 
> Is python/ actually supposed to have executable files in it? I thought
> it was more for libraries.
> 

Welllllllllllllll. At the moment it's library only. but one of the
things you can do with a library is define executable entry-points into
that library.

If you haven't cast an eye at that 32 patch series yet, it basically
creates a structure like this:

> ./python/qemu/lib/[qmp|machine|qtest|accel].py

qemu/ forms a PEP420 namespace; the idea is to be able to modularly
create and independently package subpackages.

qemu/lib forms a proper python package in which there are no
executables, just a library, as you say.

My idea is that anything under python/*/ ought to form a properly
formatted package. So we could, for instance, have a
python/qemu/devtools namespace which packages and collects a bunch of
our little scripts.

Then we could make sure we hit them with the same
mypy/pylint/flake8/whatever as the core libraries those scripts are
using to keep them in sync better.

And, ideally, if they are all using the same kind of paradigms for
import and dependency management it will be easier to use them and keep
them up to date, etc.

For using them as a developer, you could, say,
cd  ~/src/qemu/python
pip3 install --user -e .

and install the source packages to your local environment and then have
access to e.g.

> qmp-shell

right on your CLI, without having to fuss with PYTHONPATH or anything
else. As you update the source repo, you'll get the new versions of the
package living in your python environment automatically.

Of course, this maybe has downsides too; so you can always use a virtual
environment to adopt a context in which you have these tools. For that,

> pip3 install --user pipenv  # or use dnf, or apt, w/e.
> cd ~/src/qemu/python
> pipenv shell
> pip install -e .

And from here you'll have the dev package installed to a development
venv that you can use.

*cough* anyway, that's wildly off-topic.

Generally, you want to format a library such that you have a callable
entry point, maybe named main(). So you'd have some qmp-shell module and
it has a main() function.

Then, in the setup.py script, you'd define qemu.lib.qmp_shell:main() as
an entry point and give it a name like 'qmp-shell'. When pip/setuptools
processes your package installation, it'll create a shim for you in e.g.
~/.local/bin/qmp-shell that will just load the library and execute that
entrypoint for you.

I was thinking I'd do this for all of our python scripts so I could
spend my energy on a pylint/mypy test infrastructure *once* and *in one
place* and then it would be easier to detect regressions for scripts
that don't actually run as part of the test suite.

>>>
>>>> diff --git a/python/qemu/machine.py b/python/qemu/machine.py
>>>> index b9a98e2c86..eaedc25172 100644
>>>> --- a/python/qemu/machine.py
>>>> +++ b/python/qemu/machine.py
>>>> @@ -478,21 +478,21 @@ def event_wait(self, name, timeout=60.0, match=None):
>>>>          timeout: QEMUMonitorProtocol.pull_event timeout parameter.
>>>>          match: Optional match criteria. See event_match for details.
>>>>          """
>>>> -        return self.events_wait([(name, match)], timeout)
>>>> +        return self.events_wait({name: match}, timeout)
>>>>  
>>>>      def events_wait(self, events, timeout=60.0):
>>>>          """
>>>>          events_wait waits for and returns a named event from QMP with a timeout.
>>>>  
>>>> -        events: a sequence of (name, match_criteria) tuples.
>>>> +        events: a mapping containing {name: match_criteria}.
>>>>                  The match criteria are optional and may be None.
>>>>                  See event_match for details.  timeout:
>>>>                  QEMUMonitorProtocol.pull_event timeout parameter.
>>>>                  """
>>>>          def _match(event):
>>>> -            for name, match in events:
>>>> -                if event['event'] == name and self.event_match(event, match):
>>>> -                    return True
>>>> +            name = event['event']
>>>> +            if name in events:
>>>> +                return self.event_match(event, events[name])
>>>
>>> This part confused me a bit for a second. Of course, that's probably
>>> mostly just me, but I feel 'events' isn't a good name any more when the
>>> values of the dict are match strings rather than events.
>>>
>>
>> This is honestly a really bad function. When I was trying to type
>> everything, this one was at the bottom of the pile and it was the worst.
>>
>> It needs an overhaul.
>>
>> In my 32 patch series, I left the "match" types as "Any" pretty much
>> everywhere, because it's such a laissez-faire series of functions.
> 
> It would require recursive types, which aren't supported yet. So I guess
> Any is the best we can do at the moment.
> 

It would also do well with a fully schema-validated API if we actually
knew exactly what a "QMP Message" was and had some guarantee about
exactly what fields and types it had.

This is where a generated validator would really help for type-safe SDK
tooling.

... We of course do not have that right now, and might not ever, so
yeah, 'Any' type is fine -- but I really want to rewrite this function
because it does stick out as ugly and hard to read, I admit :(

Anything that's hard to type -- by the person who wrote most of it -- is
going to be hard to use or understand. Time for a rework.

>> I'll keep the feedback in mind.
>>
>>>>              return False
>>>>  
>>>>          # Search cached events
>>>> diff --git a/tests/qemu-iotests/040 b/tests/qemu-iotests/040
>>>> index 32c82b4ec6..90b59081ff 100755
>>>> --- a/tests/qemu-iotests/040
>>>> +++ b/tests/qemu-iotests/040
>>>> @@ -485,12 +485,12 @@ class TestErrorHandling(iotests.QMPTestCase):
>>>>  
>>>>      def run_job(self, expected_events, error_pauses_job=False):
>>>>          match_device = {'data': {'device': 'job0'}}
>>>> -        events = [
>>>> -            ('BLOCK_JOB_COMPLETED', match_device),
>>>> -            ('BLOCK_JOB_CANCELLED', match_device),
>>>> -            ('BLOCK_JOB_ERROR', match_device),
>>>> -            ('BLOCK_JOB_READY', match_device),
>>>> -        ]
>>>> +        events = {
>>>> +            'BLOCK_JOB_COMPLETED': match_device,
>>>> +            'BLOCK_JOB_CANCELLED': match_device,
>>>> +            'BLOCK_JOB_ERROR': match_device,
>>>> +            'BLOCK_JOB_READY': match_device,
>>>> +        }
>>>>  
>>>>          completed = False
>>>>          log = []
>>>> diff --git a/tests/qemu-iotests/260 b/tests/qemu-iotests/260
>>>> index 804a7addb9..729f031122 100755
>>>> --- a/tests/qemu-iotests/260
>>>> +++ b/tests/qemu-iotests/260
>>>> @@ -67,8 +67,9 @@ def test(persistent, restart):
>>>>  
>>>>      vm.qmp_log('block-commit', device='drive0', top=top,
>>>>                 filters=[iotests.filter_qmp_testfiles])
>>>> -    ev = vm.events_wait((('BLOCK_JOB_READY', None),
>>>> -                         ('BLOCK_JOB_COMPLETED', None)))
>>>> +    ev = vm.events_wait({
>>>> +        'BLOCK_JOB_READY': None,
>>>> +        'BLOCK_JOB_COMPLETED': None })
>>>
>>> So, I'm not sure if this is nitpicking or rather bikeshedding, but
>>> having the closing brackets on the next line would be more consistent
>>> with the other instances in this patch.
>>>
>>
>> Nah, it's fine. I'll clean it up. This is pretty close to an RFC series
>> anyway, so I didn't really polish it.
>>
>> (Or, I will try to clean it up. I probably won't work on it again in the
>> near term. I think I just wanted to see if this seemed useful in general
>> to people.
> 
> Ah, there isn't much missing for this series, though. We don't have to
> wait for a fix-the-world series when we can incrementally improve
> things.
> 

Alright, I'll try to hit it halfway -- I spent some time thinking about
a "full" job running framework but ran into some dead-ends I wasn't too
happy with, and wasn't convinced this was a simplification of any kind.

Still, seeing part of the job running code get duplicated in 040 was a
motivation to try and provide some universal job-running monster that
would be extensible for nearly any task.

Unfortunately that complexity does generally make the calling sites look
worse, so I cooled off on the idea since.

So I did intend this as an RFC, because I'm not really 100% happy with
the design.

>> As part of maybe moving the python library onto a package, I thought
>> that maybe developing a JobRunner tool would be useful to have in that
>> library. As you can see, I nestled it into iotests.py, though.)
> 
> Let's just do that now, we can always move it somewhere else later.
> 

I assume you mean "Let's just put it in iotests.py for now."

If we do decide to take that 32 patch series to formalize a qemu lib, it
will not be hard to start moving things from here to there.

I will probably take an eye to our iotests and see what functionality
gets duplicated or used a lot and try to push more things down into the
stack where possible.

The QMP event handling stuff in particular seems needlessly split
between qmp.py, machine.py, iotests.py, etc.

> Kevin
> 


