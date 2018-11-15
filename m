Received: from eggs.gnu.org ([2001:4830:134:3::10]:40049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gNIs6-00041G-IA
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:43:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gNIrt-0001aj-Sy
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:43:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gNIri-0001XM-IN
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:43:34 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181109110221.10553-1-david@redhat.com>
	<20181109110221.10553-3-david@redhat.com>
	<87r2fnod2p.fsf@dusky.pond.sub.org>
	<359e518d-ffdc-e062-c9c7-20034155051e@redhat.com>
	<8d78da85-c758-a281-6a20-9f1335b50fe8@redhat.com>
Date: Thu, 15 Nov 2018 15:43:13 +0100
In-Reply-To: <8d78da85-c758-a281-6a20-9f1335b50fe8@redhat.com> (Eric Blake's
	message of "Thu, 15 Nov 2018 07:17:18 -0600")
Message-ID: <87muqae70e.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC 2/6] qapi: use qemu_strtod() in
 string-input-visitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

Eric Blake <eblake@redhat.com> writes:

> On 11/15/18 5:09 AM, David Hildenbrand wrote:
>
>>> Three more: in qobject-input-visitor.c's
>>> qobject_input_type_number_keyval(),
>>
>> This one is interesting, as it properly bails out when parsing "inf"
>> (via isFinite()). - should we do the same for the string input visitor?
>>
>> Especially, should we forbid "inf" and "NaN" in both scenarios?
>
> JSON can't represent non-finite doubles. Internally, we might be able
> to use them, but you have a point that consistently rejecting
> non-finite in all of our QAPI parsers makes it easier to reason about
> the code base (the command line can't be used to inject a value not
> possible via QMP). So that makes sense to me.

Given the liberties we already take with JSON in QAPI, "JSON can't do X"
need not immediately end a conversation about QAPI.

That said, consistency between QObject and string visitor is desirable.

The QObject input visitor comes in two flavours: one for use with the
JSON parser, and one for use with keyval_parse().

The latter flavour's qobject_input_type_number_keyval() rejects
non-finite numbers.

The former flavour's qobject_input_type_number() leaves rejecting "bad"
numbers to the JSON parser.  The JSON parser doesn't accept special
syntax for NaN or infinity.  It maps large numbers to HUGE_VAL with the
appropriate sign.  Whether +/-HUGE_VAL are infinities depends on the
host.  If we really want to outlaw infinities, we better fix
parse_literal() to check for ERANGE.

>                                                qemu_strtod() shouldn't
> reject non-finite numbers (because it is useful for more than just
> qapi),

Yes.

>        but we could add a new qemu_strtod_finite() if that would help
> avoid duplication.

Maybe.

    qemu_strtod(str, NULL, &dbl) && isfinite(dbl)

isn't that much shorter or clearer than

    qemu_strtod_finite(str, NULL, &dbl)

>> cutil.c's do_strtosz(), and
>> json-parser.c's parse_literal().
>> 
>> The latter doesn't check for errors since the lexer ensures the input is
>> sane.  Overflow can still happen, and is silently ignored.  Feel free
>> not to convert this one.
>> 
>
> I'll do the conversion of all (allowing -ERANGE where it used to be
> allow), we can then discuss with the patches at hand if it makes sense.

Sure!
