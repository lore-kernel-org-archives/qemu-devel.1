Received: from eggs.gnu.org ([2001:4830:134:3::10]:37410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehtxv-0004jK-Qd
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 04:18:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehtxq-0005Pm-P9
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 04:18:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ehtxq-0005PU-J2
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 04:18:26 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180202130336.24719-1-armbru@redhat.com>
	<20180202164446.GP15403@redhat.com>
Date: Sat, 03 Feb 2018 10:18:19 +0100
In-Reply-To: <20180202164446.GP15403@redhat.com> ("Daniel P. =?utf-8?Q?Ber?=
	=?utf-8?Q?rang=C3=A9=22's?=
	message of "Fri, 2 Feb 2018 16:44:46 +0000")
Message-ID: <874lmy4ejo.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC 00/21] Modularize generated QAPI code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Fri, Feb 02, 2018 at 02:03:15PM +0100, Markus Armbruster wrote:
>> Our qapi-schema.json is composed of modules connected by include
>> directives, but the generated code is monolithic all the same: one
>> qapi-types.h with all the types, one qapi-visit.h with all the
>> visitors, and so forth.  These monolithic headers get included all
>> over the place.  In my "build everyhing" tree, adding a QAPI type
>> recompiles about 4500 out of 4800 objects.
>>=20
>> Nobody would write such monolithic headers by hand.  It stands to
>> reason that one shouldn't generate them, either.
>>=20
>> This series' basic idea is to split up generated headers to mirror the
>> schema's modular structure: one header per module.  That way, you can
>> include just what you need.
>>=20
>> The series is RFC for a number of reasons:
>>=20
>> * The split is implemented only for qapi-types.h.  That one should
>>   provide the biggest benefits, though.
>>=20
>> * There's a bit of code duplication.
>>=20
>> * I haven't re-read my patches, yet.
>>=20
>> Even in this incomplete state, the compile-time improvements can be
>> massive.  Before this series, any QAPI schema change recompiles some
>> 4500 out of 4800 objects in my "build everything" tree.  Afterwards,
>> adding a type to qapi/migration.json recompiles less than 400, adding
>> a QMP event recompiles less than 200, and a documentation change no
>> longer recompiles anything.
>
> Having gone through the same exercise for trace.h, I very much welcome
> this effort for QAPI too !

Thanks!

> If I consider the crypto stuff I maintain, the QAPI definitions are
> in qapi/crypto.json.
>
> From my POV, I feel it would be natural to have them move to instead
> be at  crypto/qapi.json, and have the generated headers/source files be
> crypto/qapi-types.h, crypto/qapi-visit.h, etc.
>
> This would mirror what we did with tracing, crypto/trace-events, and
> generating crypto/trace*.{c,h}

Make sense from a QAPI-using subsystem's point of view.

However, from the QAPI/QMP external interface point of view, keeping the
interface in one place also makes sense.  Not least for ease of grep
(I'm admittedly biased there).

If we decide we want to move the QAPI schema sub-modules anyway, we can
do that on top.
