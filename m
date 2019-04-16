Received: from eggs.gnu.org ([209.51.188.92]:41919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGQAb-0004SY-BJ
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 11:38:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGQAa-0000jv-5T
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 11:38:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60226)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hGQAZ-0000jd-Re
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 11:38:48 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20190413160732.55505-1-vsementsov@virtuozzo.com>
	<87zhorbytu.fsf@dusky.pond.sub.org>
	<3381f703-4fc1-ac3c-658c-f7399403acf9@virtuozzo.com>
	<874l6za00z.fsf@dusky.pond.sub.org>
	<e432f8cf-4014-8175-4a56-167a14534528@virtuozzo.com>
	<87k1fu791j.fsf@dusky.pond.sub.org>
	<da576bee-8ed5-13d9-7f29-74110d6ccb4b@virtuozzo.com>
Date: Tue, 16 Apr 2019 17:38:45 +0200
In-Reply-To: <da576bee-8ed5-13d9-7f29-74110d6ccb4b@virtuozzo.com> (Vladimir
	Sementsov-Ogievskiy's message of "Tue, 16 Apr 2019 06:38:17 +0000")
Message-ID: <87a7gq55a2.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] util/error: do not free error on
 error_abort
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> 16.04.2019 9:34, Markus Armbruster wrote:
>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>> 
>>> 15.04.2019 16:08, Markus Armbruster wrote:
>>>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>>>>
>>>>> 15.04.2019 8:51, Markus Armbruster wrote:
>>>>>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>>>>>>
>>>>>>> It would be nice to have Error object not freed away when debugging a
>>>>>>> coredump.
>>>>>>>
>>>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>>>>> ---
>>>>>>>     util/error.c | 8 +++++---
>>>>>>>     1 file changed, 5 insertions(+), 3 deletions(-)
>>>>>>>
>>>>>>> diff --git a/util/error.c b/util/error.c
>>>>>>> index 934a78e1b1..f9180c0f30 100644
>>>>>>> --- a/util/error.c
>>>>>>> +++ b/util/error.c
>>>>>>> @@ -32,9 +32,11 @@ Error *error_fatal;
>>>>>>>     static void error_handle_fatal(Error **errp, Error *err)
>>>>>>>     {
>>>>>>>         if (errp == &error_abort) {
>>>>>>> -        fprintf(stderr, "Unexpected error in %s() at %s:%d:\n",
>>>>>>> -                err->func, err->src, err->line);
>>>>>>> -        error_report_err(err);
>>>>>>> +        error_report("Unexpected error in %s() at %s:%d: %s",
>>>>>>> +                     err->func, err->src, err->line, error_get_pretty(err));
>>>>>>> +        if (err->hint) {
>>>>>>> +            error_printf_unless_qmp("%s", err->hint->str);
>>>>>>> +        }
>>>>>>>             abort();
>>>>>>>         }
>>>>>>>         if (errp == &error_fatal) {
>>>>>>
>>>>>> No objections to not freeing the error object on the path to abort().
>>>>>>
>>>>>> You also format the error message differently.  Commit 1e9b65bb1ba's
>>>>>> example
>>>>>>
>>>>>>            Unexpected error in parse_block_error_action() at .../qemu/blockdev.c:322:
>>>>>>            qemu-system-x86_64: -drive if=none,werror=foo: 'foo' invalid write error action
>>>>>>            Aborted (core dumped)
>>>>>>
>>>>>> changes to (guesswork, not tested):
>>>>>>
>>>>>>            qemu-system-x86_64: -drive if=none,werror=foo: Unexpected error in parse_block_error_action() at .../qemu/blockdev.c:322: 'foo' invalid write error action
>>>>>>            Aborted (core dumped)
>>>>>
>>>>> hm. checkpatch don't allow to put \n into error_report. So, should I call error_report twice?
>>>>>
>>>>> Transition from fprintf to error_report is OK for you?
>>>>
>>>> Let's simply not mess with the formatting at all.  Something like:
>>>>
>>>> (1) Inline error_report_err(), delete the error_free()
>>>>
>>>> (2) Optional: replace fprintf() by error_printf()
>>>>
>>>> (3) Optional: clean up the additional copy of
>>>>
>>>>           if (err->hint) {
>>>>               error_printf_unless_qmp("%s", err->hint->str);
>>>>           }
>>>>
>>>> (3a) Either create a helper function, replacing all three copies,
>>>>
>>>> (3b) Or simply delete the new copy from the path leading to abort(),
>>>>        since the hint is unlikely to be useful there.
>>>>
>>>
>>> Why we print error always but hint only "unless_qmp"?
>> 
>> "Hints" are intended for giving hints to a human user (although they are
>> misused for other purposes in places):
>> 
>> /*
>>   * Append a printf-style human-readable explanation to an existing error.
>>   * If the error is later reported to a human user with
>>   * error_report_err() or warn_report_err(), the hints will be shown,
>>   * too.  If it's reported via QMP, the hints will be ignored.
>>   * Intended use is adding helpful hints on the human user interface,
>>   * e.g. a list of valid values.  It's not for clarifying a confusing
>>   * error message.
>>   * @errp may be NULL, but not &error_fatal or &error_abort.
>>   * Trivially the case if you call it only after error_setg() or
>>   * error_propagate().
>>   * May be called multiple times.  The resulting hint should end with a
>>   * newline.
>>   */
>> void error_append_hint(Error **errp, const char *fmt, ...)
>>      GCC_FMT_ATTR(2, 3);
>> 
>
> Hmm, this means, that in error_report_err checking for qmp monitor is wrong thing,
> as error_report_err is exactly for human user who will read qemu log and will need
> maximum information.

You're right.  I'll post a patch.
