Received: from eggs.gnu.org ([2001:4830:134:3::10]:35561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnKCx-0007bO-6R
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 03:15:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnKCt-0004AO-S3
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 03:15:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:11105)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cnKCt-0004A6-Ju
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 03:15:51 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170311132256.22951-1-marcandre.lureau@redhat.com>
	<20170311132256.22951-5-marcandre.lureau@redhat.com>
	<84148275-6410-68f7-4da0-345b635c42f3@redhat.com>
Date: Mon, 13 Mar 2017 08:15:48 +0100
In-Reply-To: <84148275-6410-68f7-4da0-345b635c42f3@redhat.com> (Eric Blake's
	message of "Sat, 11 Mar 2017 14:17:11 -0600")
Message-ID: <87h92xk5p7.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 04/21] qobject: add quint type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, pbonzini@redhat.com, anderson@redhat.com, mdroth@linux.vnet.ibm.com, lersek@redhat.com

Eric Blake <eblake@redhat.com> writes:

> On 03/11/2017 07:22 AM, Marc-Andr=C3=A9 Lureau wrote:
>> The type is not used at all yet. Add some tests to exercice it.
>
> s/exercice/exercise/
>
> I wonder if we need this patch at all.
>
> I've been thinking about a possible alternative representation, such
> that a single QInt type can cover _both_ signed and unsigned types, by
> having QInt track a sign bit bool in addition to a uint64_t value.
>
> If the user passes in a value in the range [0, INT64_MAX], the number is
> representable in both uint64_t and int64_t. So the internal sign bit
> would be omitted, as in { value=3Dv, sign=3Dfalse }.  Input visitors can
> visit this value with both the 'uint64' and the 'int64' visitors, and
> output visitors will output the same value.
>
> If the user passes in a value in the range [-INT64_MAX-1, -1], the
> number is intended to be used as a negative signed number.  So the QInt
> representation would be the 2s complement representation, { value=3D-v,
> sign=3Dtrue }.  On input, the uint64_t visitor would reject the value as
> out of range, the int64_t visitor would return the appropriate negative
> value, and the generic int visitor will return the uint64_t value.  On
> output, the number would be given the negative signed value
> representation in anything that stringizes the value.
>
> If the user passes in a value in the range [INT64_MAX+1, UINT64_MAX},
> the number is intended to be used as a large unsigned number. So the
> QInt representation would be { value=3Dv, sign=3Dfalse }.  On input, the
> uint64_t visitor would accept the value, the int64_t visitor would
> reject it as out of range, and the generic int visitor will return the
> uint64_t value.  On output, the number would be given the positive
> unsigned value representation in the stringized form.
>
> That way, you don't have to complicate the (already-awkward) type
> promotion rules of QFloat vs QInt with yet another scalar type.  The
> input parser becomes friendlier - you can either use generic 'int' when
> you want to allow the user to pass in either signed or unsigned values
> (important for back-compat, where callers like libvirt learned that only
> signed values worked even when large unsigned values were wanted); or
> the specific 'int64' and 'uint64' types to force proper ranges.
>
> It's definitely an alternative implementation to the one you pursued in
> your series, so maybe we should first figure out WHAT we want
> represented, before implementing something that will be more baggage
> than we want (you at least have the advantage of patches that are
> written; my idea of adding a sign bool to QInt is still just in the
> initial idea stage).

RFC 7159 gives implementations wide latitude on number representation
(this is one of the several reasons why JSON is a poor standard from an
interoperability point of view).  Our current representation effectively
is "if it fits into int64_t, use that, else double".  What we need is
something that can represent uint64_t exactly, too.

You say you've been thinking about extending QInt's range to cover
uint64_t.  I've been thinking even more radically: replace both QInt and
QFloat by QNumber.  This is how JSON *actually* works.

The new QNumber type provides constructors from double, int64_t and
uint64_t.  It also provides conversion functions to double, int64_t and
uint64_t.  The latter two can fail.

I'd expect these to be perfectly servicable for the visitors.

Code messing with QObject directly might become slightly more elaborate.
But such code should be minimized anyway.
