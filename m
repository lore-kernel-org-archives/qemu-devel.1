Received: from eggs.gnu.org ([2001:4830:134:3::10]:58758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWT8Y-0000VT-5b
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 16:58:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWT8X-0006FY-0T
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 16:58:30 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180622201122.9358-1-jsnow@redhat.com>
	<63db09f9-1f4a-15d3-cd5b-f1f5006e3eac@amsat.org>
	<fbc39ad9-21c1-89f0-cc25-95c9223c0e2d@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <382ee459-de15-e3ef-5ab8-0b9d0fab658c@amsat.org>
Date: Fri, 22 Jun 2018 17:58:17 -0300
MIME-Version: 1.0
In-Reply-To: <fbc39ad9-21c1-89f0-cc25-95c9223c0e2d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] migration: Appease coverity,
 skip empty block trees
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: peter.maydell@linaro.org, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>

On 06/22/2018 05:35 PM, John Snow wrote:
> On 06/22/2018 04:24 PM, Philippe Mathieu-Daudé wrote:
>> On 06/22/2018 05:11 PM, John Snow wrote:
>>> If a tree consists exclusively of implicit filter nodes, we might crash
>>> QEMU. This configuration should not exist in practice, but if it did,
>>> skipping it would be fine.
>>>
>>> For the purposes of debug builds, throw an assert to remind us that
>>> this configuration is truly unexpected, but if it's compiled out we
>>> will cope just fine.
>>
>> Well... with your explanation, your patch is correct.
>> But do we really want to maintain a 'debug with assert' vs 'production
>> without assertions' codebase?
>>
> 
> I might have misremembered, but I seem to recall that it is literally
> possible to disable glib assertions. We endeavor not to, but it's
> *possible*.

There was a thread once [1] which resulted in 262a69f4282:

commit 262a69f4282e44426c7a132138581d400053e0a1
Author: Eric Blake <eblake@redhat.com>
Date:   Mon Sep 11 16:13:20 2017 -0500

    osdep.h: Prohibit disabling assert() in supported builds

    We already have several files that knowingly require assert()
    to work, sometimes because refactoring the code for proper
    error handling has not been tackled yet; there are probably
    other files that have a similar situation but with no comments
    documenting the same.  In fact, we have places in migration
    that handle untrusted input with assertions, where disabling
    the assertions risks a worse security hole than the current
    behavior of losing the guest to SIGABRT when migration fails
    because of the assertion.  Promote our current per-file
    safety-valve to instead be project-wide, and expand it to also
    cover glib's g_assert().

    Note that we do NOT want to encourage 'assert(side-effects);'
    (that is a bad practice that prevents copy-and-paste of code to
    other projects that CAN disable assertions; plus it costs
    unnecessary reviewer mental cycles to remember whether a project
    special-cases the crippling of asserts); and we would LIKE to
    fix migration to not rely on asserts (but that takes a big code
    audit).  But in the meantime, we DO want to send a message
    that anyone that disables assertions has to tweak code in order
    to compile, making it obvious that they are taking on additional
    risk that we are not going to support.  At the same time, leave
    comments mentioning NDEBUG in files that we know still need to
    be scrubbed, so there is at least something to grep for.

    It would be possible to come up with some other mechanism for
    doing runtime checking by default, but which does not abort
    the program on failure, while leaving side effects in place
    (unlike how crippling assert() avoids even the side effects),
    perhaps under the name q_verify(); but it was not deemed worth
    the effort (developers should not have to learn a replacement
    when the standard C macro works just fine, and it would be a lot
    of churn for little gain).  The patch specifically uses #error
    rather than #warn so that a user is forced to tweak the header
    to acknowledge the issue, even when not using a -Werror
    compilation.

which added in include/qemu/osdep.h:

  /*
   * We have a lot of unaudited code that may fail in strange ways, or
   * even be a security risk during migration, if you disable assertions
   * at compile-time.  You may comment out these safety checks if you
   * absolutely want to disable assertion overhead, but it is not
   * supported upstream so the risk is all yours.  Meanwhile, please
   * submit patches to remove any side-effects inside an assertion, or
   * fixing error handling that should use Error instead of assert.
   */
  #ifdef NDEBUG
  #error building with NDEBUG is not supported
  #endif
  #ifdef G_DISABLE_ASSERT
  #error building with G_DISABLE_ASSERT is not supported
  #endif

So this shouldn't be a problem.

[1] http://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg03608.html

> In this case I'd prefer to have a runtime behavior that makes sense:
> skipping such trees is sensible because they won't have any bitmaps for
> us to migrate.
> 
> However, this is a really bizarre block configuration that I suspect
> cannot exist in practice. If it does, I'd rather not ignore it in the
> development context.
> 
>> $ git grep g_assert_not_reached | egrep -v '^tests/' | wc -l
>> 406
>>
>> Does Coverity require all these 406 lines to behave with a
>> "configuration [that] should not exist in practice"?
>>
>>>
>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>> ---
>>>  migration/block-dirty-bitmap.c | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
>>> index 3bafbbdc4c..02725293dd 100644
>>> --- a/migration/block-dirty-bitmap.c
>>> +++ b/migration/block-dirty-bitmap.c
>>> @@ -287,6 +287,10 @@ static int init_dirty_bitmap_migration(void)
>>>          while (bs && bs->drv && bs->implicit) {
>>>              bs = backing_bs(bs);
>>>          }
>>> +        if (!bs) {
>>> +            g_assert_not_reached();
>>> +            continue;
>>
>> Can we choose one or the other?
>>
> 
> Ask someone more familiar with assert policy and a fondness for paint hues.
> 
> --js
> 
>>> +        }
>>>  
>>>          for (bitmap = bdrv_dirty_bitmap_next(bs, NULL); bitmap;
>>>               bitmap = bdrv_dirty_bitmap_next(bs, bitmap))
>>>
