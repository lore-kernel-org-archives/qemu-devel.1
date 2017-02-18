Received: from eggs.gnu.org ([2001:4830:134:3::10]:58381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cf2AV-0001vF-An
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 05:23:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cf2AU-0007Wd-73
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 05:23:07 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
	<1487067971-10443-22-git-send-email-armbru@redhat.com>
	<49e87de6-431a-43b9-14d1-78abe9da7aaf@redhat.com>
Date: Sat, 18 Feb 2017 11:22:58 +0100
In-Reply-To: <49e87de6-431a-43b9-14d1-78abe9da7aaf@redhat.com> (Eric Blake's
	message of "Fri, 17 Feb 2017 15:21:16 -0600")
Message-ID: <87shnb6bnh.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 21/24] util/cutils: Let qemu_strtosz*()
 optionally reject trailing crap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

Eric Blake <eblake@redhat.com> writes:

> On 02/14/2017 04:26 AM, Markus Armbruster wrote:
>> Change the qemu_strtosz() & friends to return -EINVAL when @endptr is
>> null and the conversion doesn't consume the string completely.
>> Matches how qemu_strtol() & friends work.
>> 
>> Only test_qemu_strtosz_simple() passes a null @endptr.  No functional
>> change there, because its conversion consumes the string.
>> 
>> Simplify callers that use @endptr only to fail when it doesn't point
>> to '\0' to pass a null @endptr instead.
>> 
>> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> Cc: Eduardo Habkost <ehabkost@redhat.com> (maintainer:X86)
>> Cc: Kevin Wolf <kwolf@redhat.com> (supporter:Block layer core)
>> Cc: Max Reitz <mreitz@redhat.com> (supporter:Block layer core)
>> Cc: qemu-block@nongnu.org (open list:Block layer core)
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  hmp.c               |  6 ++----
>>  hw/misc/ivshmem.c   |  6 ++----
>>  qapi/opts-visitor.c |  5 ++---
>>  qemu-img.c          |  7 +------
>>  qemu-io-cmds.c      |  7 +------
>>  target/i386/cpu.c   |  5 ++---
>>  tests/test-cutils.c |  6 ++++++
>>  util/cutils.c       | 14 +++++++++-----
>>  8 files changed, 25 insertions(+), 31 deletions(-)
>
> Nice cleanup.
>
> Reviewed-by: Eric Blake <eblake@redhat.com>
>
>
>> +++ b/qemu-img.c
>> @@ -370,14 +370,9 @@ static int add_old_style_options(const char *fmt, QemuOpts *opts,
>>  
>>  static int64_t cvtnum(const char *s)
>>  {
>
>> +++ b/qemu-io-cmds.c
>> @@ -137,14 +137,9 @@ static char **breakline(char *input, int *count)
>>  
>>  static int64_t cvtnum(const char *s)
>>  {
>> -    char *end;
>
> Why do we reimplement cvtnum() as copied static functions instead of
> exporting it?  But that would be a separate cleanup (perhaps squashed
> into 20/24, where you use cvtnum in qemu-img).

At the end of this series, the two cvtnum() look like this:

    static int64_t cvtnum(const char *s)
    {
        int err;
        uint64_t value;

        err = qemu_strtosz(s, NULL, &value);
        if (err < 0) {
            return err;
        }
        if (value > INT64_MAX) {
            return -ERANGE;
        }
        return value;
    }

Does two things: limit value range to 0..INT64_MAX, merge error into
value.

Perhaps their callers should simply use qemu_strtosz() directly.  I
chose not to go there to limit churn in this series.

>> @@ -217,7 +217,8 @@ static int64_t do_strtosz(const char *nptr, char **end,
>>      errno = 0;
>>      val = strtod(nptr, &endptr);
>>      if (isnan(val) || endptr == nptr || errno != 0) {
>
> Hmm - we explicitly reject "NaN", but not "infinity".  But when strtod()
> accepts infinity, ...
>
>> -        goto fail;
>> +        retval = -EINVAL;
>> +        goto out;
>>      }
>>      fraction = modf(val, &integral);
>
> then modf() returns 0 with integral left at infinity...
>
>>      if (fraction != 0) {
>> @@ -232,17 +233,20 @@ static int64_t do_strtosz(const char *nptr, char **end,
>>          assert(mul >= 0);
>>      }
>>      if (mul == 1 && mul_required) {
>> -        goto fail;
>> +        retval = -EINVAL;
>> +        goto out;
>>      }
>>      if ((val * mul >= INT64_MAX) || val < 0) {
>
> ...and the multiply exceeds INT64_MAX, so we still end up rejecting it
> (with ERANGE instead of EINVAL).  Weird way but seems to work, and is
> pre-existing, so not this patch's problem.

Yes.

We could easily check !isfinite() rather than isnan(), but then we'd get
-EINVAL rather than -ERANGE for infinities.  Matter of taste, I guess.
