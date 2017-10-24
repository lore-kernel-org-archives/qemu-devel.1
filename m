Received: from eggs.gnu.org ([2001:4830:134:3::10]:59245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1e6zOs-0000YQ-Mu
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 09:37:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1e6zOn-0000EA-M8
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 09:37:46 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <20171024120956.GD18756@stefanha-x1.localdomain>
Date: Tue, 24 Oct 2017 09:37:38 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <A3F46379-E6BA-4971-A0EE-E667C68832F3@gmail.com>
References: <20171023025016.3088-1-programmingkidx@gmail.com>
	<20171023160959.GC10220@stefanha-x1.localdomain>
	<2ACA132F-70DF-488A-AE41-59FFF08E8755@gmail.com>
	<20171024120956.GD18756@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [libfdt][PATCH v3] implement strnlen for systems
 that need it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: david@gibson.dropbear.id.au, richard.henderson@linaro.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, peter.maydell@linaro.org, devicetree-compiler@vger.kernel.org, ian@freebsd.org


> On Oct 24, 2017, at 8:09 AM, Stefan Hajnoczi <stefanha@gmail.com> =
wrote:
>=20
> On Mon, Oct 23, 2017 at 11:13:13PM -0400, Programmingkid wrote:
>>=20
>>> On Oct 23, 2017, at 12:09 PM, Stefan Hajnoczi <stefanha@gmail.com> =
wrote:
>>>=20
>>> On Sun, Oct 22, 2017 at 10:50:16PM -0400, John Arbuckle wrote:
>>>> Prior the Mac OS 10.7, the function strnlen() was not available. =
This patch
>>>> implements strnlen() on Mac OS X versions that are below 10.7.
>>>>=20
>>>> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
>>>> ---
>>>> v3 changes:
>>>> - Replaced loop with memchr()
>>>>=20
>>>> v2 changes:
>>>> - Simplified the code to make it static inline'ed
>>>> - Changed the type of count to size_t
>>>>=20
>>>> libfdt/libfdt_env.h | 24 ++++++++++++++++++++++++
>>>> 1 file changed, 24 insertions(+)
>>>>=20
>>>> diff --git a/libfdt/libfdt_env.h b/libfdt/libfdt_env.h
>>>> index 952056c..d43b66b 100644
>>>> --- a/libfdt/libfdt_env.h
>>>> +++ b/libfdt/libfdt_env.h
>>>> @@ -109,4 +109,28 @@ static inline fdt64_t cpu_to_fdt64(uint64_t x)
>>>> #undef CPU_TO_FDT16
>>>> #undef EXTRACT_BYTE
>>>>=20
>>>> +#ifdef __APPLE__
>>>> +#include <AvailabilityMacros.h>
>>>> +
>>>> +#define MAC_OS_X_VERSION_10_7 1070
>>>=20
>>> Apple has already defined MAC_OS_X_VERSION_10_7 here:
>>> =
https://opensource.apple.com/source/xnu/xnu-1699.24.8/EXTERNAL_HEADERS/Ava=
ilabilityMacros.h
>>>=20
>>> To avoid a compiler warning, please use:
>>>=20
>>> #ifndef MAC_OS_X_VERSION_10_7
>>> #define MAC_OS_X_VERSION_10_7 1070
>>> #endif
>>=20
>> Sounds logical.
>>=20
>>>=20
>>>> +/* strnlen() is not available on Mac OS < 10.7 */
>>>> +# if (MAC_OS_X_VERSION_MAX_ALLOWED < MAC_OS_X_VERSION_10_7)
>>>=20
>>> Does this cover the case where MAC_OS_X_VERSION_MAX_ALLOWED is set =
to
>>> <1070 on a 10.7+ build machine?  It's possible that the <string.h>
>>> header would define strnlen() and your code redefines the function
>>> (compiler error).
>>=20
>> If MAC_OS_X_VERSION_MAX_ALLOWED is equal to 1070 then this code would =
not be executed. This branch would only be taken if =
MAC_OS_X_VERSION_MAX_ALLOWED is less than 1070. So there would not be a =
compiler error.
>>=20
>>>=20
>>> It would be best to check how <string.h>, <Availability.h>, and
>>> <AvailabilityMacros.h> work to make sure that all cases are handled. =
 I
>>> don't have access to a Mac right now, sorry.
>>>=20
>>> Perhaps this approach works better:
>>>=20
>>> # ifndef MAC_OS_X_VERSION_10_7
>>=20
>> I think you are saying I should remove the "#ifdef __APPLE__" code =
and just check to see if MAC_OS_X_VERSION_10_7 is defined. That might =
work on Mac OS 10.6 and 10.5, but it would probably cause problems with =
non-Mac-OS platforms.=20
>=20
> No, the ifndef is still "indented" and it would be like this:
>=20
> #ifdef __APPLE_
> ...
> # ifndef MAC_OS_X_VERSION_10_7

I see. This is a more compact way of doing things.=20=
