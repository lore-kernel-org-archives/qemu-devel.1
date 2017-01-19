Received: from eggs.gnu.org ([2001:4830:134:3::10]:47910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cU9Wz-00076L-5T
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 05:01:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cU9Wt-00055p-5Y
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 05:01:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56674)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cU9Wt-000559-0D
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 05:01:15 -0500
References: <1484772931-16272-1-git-send-email-mst@redhat.com>
	<1484772931-16272-4-git-send-email-mst@redhat.com>
	<87r33zii2m.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8721518c-5063-bd5b-60a9-3a3752894e74@redhat.com>
Date: Thu, 19 Jan 2017 11:01:11 +0100
MIME-Version: 1.0
In-Reply-To: <87r33zii2m.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/4] compiler: expression version of
 QEMU_BUILD_BUG_ON
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>



On 19/01/2017 09:12, Markus Armbruster wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
>=20
>> QEMU_BUILD_BUG_ON uses a typedef in order to be safe
>> to use outside functions, but sometimes it's useful
>> to have a version that can be used within an expression.
>> Following what Linux does, introduce QEMU_BUILD_BUG_ON_ZERO
>> that return zero after checking condition at build time.
>=20
> Following Linux's example makes sense, but I can't help but wonder
> whether we need both QEMU_BUILD_BUG_ON_ZERO() and QEMU_BUILD_BUG_ON().

I think so, most notably QEMU_BUILD_BUG_ON was added to C11 as
_Static_assert but QEMU_BUILD_BUG_ON_ZERO wasn't.

But we can indeed redefine QEMU_BUILD_BUG_ON to
(void)QEMU_BUILD_BUG_ON_ZERO(x) like Linux does, until we add optional
support for _Static_assert.


>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> ---
>>  include/qemu/compiler.h | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
>> index 2882470..f4cf13b 100644
>> --- a/include/qemu/compiler.h
>> +++ b/include/qemu/compiler.h
>> @@ -89,6 +89,8 @@
>>      typedef char glue(qemu_build_bug_on__,__LINE__)[(x) ? -1 : 1] \
>>          __attribute__((unused))
>> =20
>> +#define QEMU_BUILD_BUG_ON_ZERO(x) (sizeof(int[(x) ? -1 : 1]) - sizeof=
(int))

Linux here uses:

#define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:-!!(e); }))

and the issue is that sizeof(int[(x) ? -1 : 1]) could be
runtime-evaluated (the type is a variable-length array).

Paolo

>>  #if defined __GNUC__
>>  # if !QEMU_GNUC_PREREQ(4, 4)
>>     /* gcc versions before 4.4.x don't support gnu_printf, so use prin=
tf. */
>=20
> More so since your QEMU_BUILD_BUG_ON_ZERO seems easier to understand: n=
o
> token pasting.
>=20
> Anyway,
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>=20
