Received: from eggs.gnu.org ([2001:4830:134:3::10]:60072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d5wPA-0000hE-T5
	for qemu-devel@nongnu.org; Wed, 03 May 2017 11:41:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d5wP5-0000Da-Qx
	for qemu-devel@nongnu.org; Wed, 03 May 2017 11:41:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40428)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d5wP5-0000Bn-HE
	for qemu-devel@nongnu.org; Wed, 03 May 2017 11:41:23 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170502203115.22233-1-ehabkost@redhat.com>
	<20170502203115.22233-2-ehabkost@redhat.com>
	<0cc1a96d-c828-d055-7024-3d3296e82be1@redhat.com>
	<20170502223531.GH3482@thinpad.lan.raisama.net>
Date: Wed, 03 May 2017 17:41:20 +0200
In-Reply-To: <20170502223531.GH3482@thinpad.lan.raisama.net> (Eduardo
	Habkost's message of "Tue, 2 May 2017 19:35:31 -0300")
Message-ID: <87fugmt0bj.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/4] visitor: Add 'supported_qtypes'
 parameter to visit_start_alternate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Alexander Graf <agraf@suse.de>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Tue, May 02, 2017 at 04:29:32PM -0500, Eric Blake wrote:
>> On 05/02/2017 03:31 PM, Eduardo Habkost wrote:
>> > This will allow visitors to make decisions based on the supported qtypes
>> > of a given alternate type. The new parameter can replace the old
>> > 'promote_int' argument, as qobject-input-visitor can simply check if
>> > QTYPE_QINT is set in supported_qtypes.
>> > 
>> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>> > ---
>> 
>> > @@ -416,7 +417,7 @@ void visit_end_list(Visitor *v, void **list);
>> >   */
>> >  void visit_start_alternate(Visitor *v, const char *name,
>> >                             GenericAlternate **obj, size_t size,
>> > -                           bool promote_int, Error **errp);
>> > +                           unsigned long supported_qtypes, Error **errp);
>> 
>> Why unsigned long (which is platform-dependent in size)? At the moment,
>> even unsigned char happens to be long enough, although I probably would
>> have used uint32_t.
>> 
>> Oh, I see, it's because you use the BIT() macros from bitops.h, which
>> are hardcoded to unsigned long.
>
> Yep. But I don't see a problem with using uint32_t or a simple
> int.
>
>> 
>> > +++ b/scripts/qapi-visit.py
>> > @@ -161,20 +161,21 @@ void visit_type_%(c_name)s(Visitor *v, const char *name, %(c_name)s *obj, Error
>> >  
>> >  
>> >  def gen_visit_alternate(name, variants):
>> > -    promote_int = 'true'
>> > +    qtypes = ['BIT(%s)' % (var.type.alternate_qtype())
>> > +              for var in variants.variants]
>> > +    supported_qtypes = '|'.join(qtypes)
>> 
>> Do you want ' | '.join(qtypes), so that at least the generated code
>> still follows recommended operator spacing? (The line is long no matter
>> what, though, and that's not worth worrying about.)
>
> I can do that in v2.

Yes, please.

>> 
>> >      ret = ''
>> > -    for var in variants.variants:
>> > -        if var.type.alternate_qtype() == 'QTYPE_QINT':
>> > -            promote_int = 'false'
>> >  
>> >      ret += mcgen('''
>> >  
>> >  void visit_type_%(c_name)s(Visitor *v, const char *name, %(c_name)s **obj, Error **errp)
>> >  {
>> >      Error *err = NULL;
>> > +    unsigned long supported_qtypes = %(supported_qtypes)s;
>> >  
>> > +    assert(QTYPE__MAX < BITS_PER_LONG);
>> 
>> Do we really have to generate a separate copy of this assert in every
>> generated function?  Especially when we know it is true by construction,
>> that seems like a lot.  Having the assertion once in a .c file rather
>> than generated in multiple functions might be acceptable, though.
>
> I will probably do this as a single QEMU_BUILD_BUG_ON near
> visit_start_alternate().

Yes, please.

>> 
>> > +++ b/qapi/qobject-input-visitor.c
>> 
>> > @@ -349,7 +351,7 @@ static void qobject_input_start_alternate(Visitor *v, const char *name,
>> >      }
>> >      *obj = g_malloc0(size);
>> >      (*obj)->type = qobject_type(qobj);
>> > -    if (promote_int && (*obj)->type == QTYPE_QINT) {
>> > +    if (!(supported_qtypes & BIT(QTYPE_QINT)) && (*obj)->type == QTYPE_QINT) {
>> 
>> Experimenting, does this read any better:
>> 
>> if (!extract32(supported_qtypes, QTYPE_QINT, 1) && ...
>> 
>> which would be another argument for uint32_t instead of unsigned long in
>> the signature.
>
> I am more used to see this written as "if (s & (1UL << n))" than
> as "if (extract32(s, n, 1))", so I'm not sure.
>
> I see some extract32(..., ..., 1) cases in the tree, so it's not
> as unusual as I thought. I will probably give it a try.

I think (s & (1ul << n)) reads okay.  extract32() I have to look up.  If
we used it all the time, extract32() might be the better choice.

>> The idea makes sense, but I'm still not necessarily sold on using a long.
>
> Thanks!

The generalization from bool to set of QType makes sense to me.
However, bitmap.h/bitops.h seems overkill.  It's for bit vectors of
arbitrary size, represented as unsigned long[].  What we got here is a
need for just eight bits, vanishingly unlikely to grow much.

If we decide we like BIT(n) so much better than the obvious (1ul << n),
let's at least include just bitops.h like you did in one place, not
bitmaps.h like you did in the other place.

As long as we're using no more than BIT(), there's no real need for
unsigned long[1] (which you shortened to just unsigned long).  Plain
unsigned would do.  I could also accept Eric's uint32_t.
