Received: from eggs.gnu.org ([2001:4830:134:3::10]:46159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gUwjM-0000vK-Gw
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 11:42:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gUwjJ-00017E-C6
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 11:42:28 -0500
From: Laurent Vivier <laurent@vivier.eu>
References: <20181206151856.77503-1-eblake@redhat.com>
	<b98ea971-0d16-6586-9595-f9e3922f05c6@vivier.eu>
Message-ID: <9d93b6c0-43bf-a3fb-ae28-dd4541f5319f@vivier.eu>
Date: Thu, 6 Dec 2018 17:42:17 +0100
MIME-Version: 1.0
In-Reply-To: <b98ea971-0d16-6586-9595-f9e3922f05c6@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] cutils: Assert in-range
 base for string-to-integer conversions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, vsementsov@virtuozzo.com, armbru@redhat.com

Le 06/12/2018 à 17:40, Laurent Vivier a écrit :
> Le 06/12/2018 à 16:18, Eric Blake a écrit :
>> POSIX states that the value of endptr is unspecified if strtol()
>> fails with EINVAL due to an invalid base argument.  Since none of
>> the callers to check_strtox_error() initialized endptr, we could
>> end up propagating uninitialized data back to a caller on error.
>> However, passing an out-of-range base is already a sign of poor
>> programming, so let's just assert that base is in range, at which
>> point check_strtox_error() can be tightened to assert that it is
>> receiving an initialized ep that points somewhere within the
>> caller's original string, regardless of whether strto*() succeeded
>> or failed with ERANGE.
>>
>> Reported-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>
>> Also tested that this does not negatively impact David's pending
>> additions of qemu_strtod{,_finite}().  Thus:
>> Based-on: <20181121164421.20780-1-david@redhat.com>
>>
>>  util/cutils.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/util/cutils.c b/util/cutils.c
>> index 91930d1bbeb..e098debdc0c 100644
>> --- a/util/cutils.c
>> +++ b/util/cutils.c
>> @@ -278,6 +278,7 @@ int qemu_strtosz_metric(const char *nptr, const char **end, uint64_t *result)
>>  static int check_strtox_error(const char *nptr, char *ep,
>>                                const char **endptr, int libc_errno)
>>  {
>> +    assert(ep >= nptr);
>>      if (endptr) {
>>          *endptr = ep;
>>      }
>> @@ -325,6 +326,7 @@ int qemu_strtoi(const char *nptr, const char **endptr, int base,
>>      char *ep;
>>      long long lresult;
>>
>> +    assert((unsigned) base <= 36 && base != 1);
> 
> If you want to play with type, I think you can do:
> 
>    assert((unsigned)(base - 2) <= 34)

oops, no, '0' is a valid case. Forgive this...

Laurent
