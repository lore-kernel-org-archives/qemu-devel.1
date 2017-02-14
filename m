Received: from eggs.gnu.org ([2001:4830:134:3::10]:50296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cdcgo-0006hV-LU
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 07:58:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cdcgl-00022N-LJ
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 07:58:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43466)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cdcgl-000222-Cw
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 07:58:35 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
	<1487067971-10443-9-git-send-email-armbru@redhat.com>
	<CAFEAcA_utp4m28Lk20vZ4u1UT7zPdkgywxJp2GS8WNFsNh_AOQ@mail.gmail.com>
Date: Tue, 14 Feb 2017 13:58:32 +0100
In-Reply-To: <CAFEAcA_utp4m28Lk20vZ4u1UT7zPdkgywxJp2GS8WNFsNh_AOQ@mail.gmail.com>
	(Peter Maydell's message of "Tue, 14 Feb 2017 10:53:01 +0000")
Message-ID: <871sv1dj47.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 08/24] util/cutils: Clean up control flow
 around qemu_strtol() a bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On 14 February 2017 at 10:25, Markus Armbruster <armbru@redhat.com> wrote:
>> Reorder check_strtox_error() to make it obvious that we always store
>> through a non-null @endptr.
>>
>> Transform
>>
>>     if (some error) {
>>         error case ...
>>         err = value for error case;
>>     } else {
>>         normal case ...
>>         err = value for normal case;
>>     }
>>     return err;
>>
>> to
>>
>>     if (some error) {
>>         error case ...
>>         return value for error case;
>>     }
>>     normal case ...
>>     return value for normal case;
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  util/cutils.c | 89 ++++++++++++++++++++++++++++++-----------------------------
>>  1 file changed, 45 insertions(+), 44 deletions(-)
>>
>> diff --git a/util/cutils.c b/util/cutils.c
>> index 7d165bc..7442d46 100644
>> --- a/util/cutils.c
>> +++ b/util/cutils.c
>> @@ -265,15 +265,20 @@ int64_t qemu_strtosz(const char *nptr, char **end)
>>  static int check_strtox_error(const char *nptr, char *ep,
>>                                const char **endptr, int eno)
>>  {
>> -    if (eno == 0 && ep == nptr) {
>> -        eno = EINVAL;
>> -    }
>> -    if (!endptr && *ep) {
>> -        return -EINVAL;
>> -    }
>>      if (endptr) {
>>          *endptr = ep;
>>      }
>> +
>> +    /* Turn "no conversion" into an error */
>> +    if (eno == 0 && ep == nptr) {
>> +        return -EINVAL;
>> +    }
>> +
>> +    /* Fail when we're expected to consume the string, but didn't */
>> +    if (!endptr && *ep) {
>> +        return -EINVAL;
>> +    }
>> +
>>      return -eno;
>>  }
>
> Doesn't this change the semantics? Previously, for the
> case of (eno == 0 && ep == nptr) we would both set
> *endptr to ep and return -EINVAL. Now we only return -EINVAL
> and leave *endptr alone.

Behavior before the patch:

    if (eno == 0 && ep == nptr) {
        eno = EINVAL;           // set return value to EINVAL, but continue
    }
    if (!endptr && *ep) {
        return -EINVAL;         // return -EINVAL without setting *endptr
                                // correct because endptr is null
    }
    if (endptr) {
        *endptr = ep;           // set *endptr unless endptr is null
    }
    return -eno;                // *endptr got set unless endptr is null

As you say, we set *endptr unless it's null.

After the patch:

    if (endptr) {
        *endptr = ep;           // set *endptr unless endptr is null
    }

    // no matter what happens below, *endptr got set unless endptr is null

    /* Turn "no conversion" into an error */
    if (eno == 0 && ep == nptr) {
        return -EINVAL;
    }

    /* Fail when we're expected to consume the string, but didn't */
    if (!endptr && *ep) {
        return -EINVAL;
    }

    return -eno;

No change, as far as I can tell.

>                          The comment describing the
> qemu_strtol() API is a bit vague about what exactly we keep
> from the strtol() semantics for "no convertable characters"
> but I would assume that retaining "*endptr is written with
> the original value of nptr" is intentional.

I rewrite the comment PATCH 05.  Relevant part:

 * @nptr may be null, and no conversion is performed then.
 *
 * If no conversion is performed, store @nptr in *@endptr and return
 * -EINVAL.

I guess I should qualify "store @nptr in *@endptr" with "unless @endptr
is null" for completeness.  Anything else to improve?
