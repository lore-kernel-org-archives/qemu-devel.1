Received: from eggs.gnu.org ([2001:4830:134:3::10]:54967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gShw6-0006fj-Jq
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 07:30:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gShw3-0008MK-A4
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 07:30:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47502)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gShw2-0008Li-Td
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 07:30:19 -0500
References: <1543574620-17506-1-git-send-email-thuth@redhat.com>
	<20181130111555.GA9162@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2acf4de2-d826-c2a4-c826-8c966b5cce9e@redhat.com>
Date: Fri, 30 Nov 2018 13:30:12 +0100
MIME-Version: 1.0
In-Reply-To: <20181130111555.GA9162@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0] compiler.h: Add an explicit check
 for the compiler version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, pbonzini@redhat.com, peter.maydell@linaro.org

On 2018-11-30 12:15, Daniel P. Berrang=C3=A9 wrote:
> On Fri, Nov 30, 2018 at 11:43:40AM +0100, Thomas Huth wrote:
>> The questions about our minimum compiler requirement pops up every
>> couple of months, and we then have to recall the details each time.
>> So let's document this in a proper way, by adding a comment and
>> check for the right compiler version to our compiler.h header.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  include/qemu/compiler.h | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
>> index ca9bc85..775446b 100644
>> --- a/include/qemu/compiler.h
>> +++ b/include/qemu/compiler.h
>> @@ -22,6 +22,14 @@
>>  # define QEMU_GNUC_PREREQ(maj, min) 0
>>  #endif
>> =20
>> +/*
>> + * We need at least GCC 4.1 for atomics support. Clang also supports =
these,
>> + * and reports itself as GCC 4.2, so it passes this check, too.
>> + */
>> +#if !QEMU_GNUC_PREREQ(4, 1)
>> +#error QEMU needs a compiler that is compatible with GCC v4.1 or newe=
r
>> +#endif
>=20
> This encodes our current minimum which is fine as a first step.
>=20
> I think we could reasonably increase our min version now that we
> have declared explicitly what platforms we intend to support

Do we really want to artificially limit our support here without any
further reasons? If the users want to compile QEMU on an older system,
and one of the libraries does not quite match anymore, it's often easy
enough to recompile a newer version of the library to get things going
again. Recompiling a whole compiler is way more cumbersome, though...

OTOH, we could get rid of some more #if QEMU_GNUC_PREREQ spots in the
source code if we bump the minimum version to 4.8 ... so that might be a
real reason to increase the minimum.

> We would need an explicit check for clang, however, instead of
> relying on it claiming gcc 4.2 support - that's a way inaccurate
> claim anyway so detecting a specific clang version would be
> better regardless IMHO

Fine for me if we bump the minimum Clang version to 3.4 ... then we
could get rid of the the CONFIG_INT128 hacks that we have in various
parts of the code.

 Thomas
