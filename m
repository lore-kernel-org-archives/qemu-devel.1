Received: from eggs.gnu.org ([2001:4830:134:3::10]:40112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d6kTl-0008DT-PQ
	for qemu-devel@nongnu.org; Fri, 05 May 2017 17:09:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d6kTf-0003PO-Lw
	for qemu-devel@nongnu.org; Fri, 05 May 2017 17:09:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d6kTf-0003OU-CL
	for qemu-devel@nongnu.org; Fri, 05 May 2017 17:09:27 -0400
Date: Fri, 5 May 2017 18:09:23 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170505210923.GP3482@thinpad.lan.raisama.net>
References: <20170505201128.12099-1-ehabkost@redhat.com>
	<20170505201128.12099-4-ehabkost@redhat.com>
	<a30986e0-6a07-509d-a2c0-969847bc4906@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a30986e0-6a07-509d-a2c0-969847bc4906@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] string-input-visitor: Support
 alternate types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On Fri, May 05, 2017 at 03:53:40PM -0500, Eric Blake wrote:
> On 05/05/2017 03:11 PM, Eduardo Habkost wrote:
> > When parsing alternates from a string, there are some limitations in
> > what we can do, but it is a valid use case in some situations. We can
> > support booleans, integer types, and enums.
> 
> Stale comment, given...
> 
> > 
> > This will be used to support 'feature=force' in -cpu options, while
> > keeping 'feature=on|off|true|false' represented as boolean values.
> > 
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> > Changes v1 -> v2:
> > * Updated string_input_visitor_new() documentation
> >   to mention alternate support (Markus Armbruster)
> > * Detect ambiguous alternates at runtime. Test case included.
> > * Removed support for integers. We don't need it yet, and
> 
> ...this.

Oops.

> 
> >   it would require sorting out the parse_str() mess.
> > * Change supported_qtypes to uint32_t (Eric Blake)
> > * Update tests/qapi-schema/qapi-schema-test.out to match
> >   qapi-schema-test.json updates
> >   (Eric Blake)
> > * Code indentation fix (Markus Armbruster)
> > * Use &error_abort on test cases instead of g_assert(!err)
> >   (Markus Armbruster)
> > ---
> 
> >  
> > +/*
> > + * Check if alternate type string representation is ambiguous and
> > + * can't be parsed by StringInputVisitor
> > + */
> > +static bool ambiguous_alternate(uint32_t qtypes, const char *const enum_table[])
> > +{
> > +    uint32_t non_str_qtypes = qtypes & ~(1U << QTYPE_QSTRING);
> > +
> > +    if ((qtypes & (1U << QTYPE_QSTRING)) && !enum_table && non_str_qtypes) {
> > +        return true;
> > +    }
> > +
> > +    if (qtypes & (1U << QTYPE_QBOOL)) {
> > +        const char *const *e;
> > +        /*
> > +         * If the string representation of enum members can be parsed as
> > +         * booleans, the alternate string representation is ambiguous.
> > +         */
> > +        for (e = enum_table; e && *e; e++) {
> > +            if (try_parse_bool(*e, NULL) == 0) {
> > +                return true;
> > +            }
> > +        }
> > +    }
> > +
> > +    return false;
> > +}
> 
> Seems okay for detecting ambiguity, but it is a runtime cost (one that
> you will run every single time you parse, even though the answer will be
> the same every single time you run it); I still think doing it at QAPI
> compile time will be more efficient in the long run.  And as this is the
> only use of enum_table added in 2/3, I'm still not sold on needing that
> patch.

I'm OK with deleting this part. That's the main reason I moved it
to a separate function.

> 
> > +
> > +static void start_alternate(Visitor *v, const char *name,
> > +                            GenericAlternate **obj, size_t size,
> > +                            uint32_t qtypes, const char *const enum_table[],
> > +                            Error **errp)
> > +{
> > +    /*
> > +     * Enum types are represented as QTYPE_QSTRING, so this is
> > +     * the default. Actual parsing of the string as an enum is
> > +     * done by visit_type_<EnumType>(), which is called just
> > +     * after visit_start_alternate().
> > +     */
> > +    QType qtype = QTYPE_QSTRING;
> > +    uint32_t unsupported_qtypes = qtypes & ~((1U << QTYPE_QSTRING) |
> > +                                             (1U << QTYPE_QBOOL));
> > +    StringInputVisitor *siv = to_siv(v);
> > +
> > +    if (ambiguous_alternate(qtypes, enum_table)) {
> > +        error_setg(errp, "Can't parse ambiguous alternate type");
> > +        return;
> > +    }
> > +
> > +    if (unsupported_qtypes) {
> > +        error_setg(errp, "Can't parse %s' alternate member",
> > +                   QType_lookup[ctz32(unsupported_qtypes)]);
> > +        return;
> > +    }
> > +
> > +    if ((qtypes & (1U << QTYPE_QBOOL)) &&
> > +        try_parse_bool(siv->string, NULL) == 0) {
> > +        qtype = QTYPE_QBOOL;
> > +    }
> > +
> > +    *obj = g_malloc0(size);
> > +    (*obj)->type = qtype;
> 
> Slightly simpler for ignoring int for now, while still something we
> could add in later.  I've been wanting to have an alternate for
> 'int'/'str' for InetAddress port, since we want to support named ports
> but most often use just integers.  On the command line, port=1 is fine,
> but in QMP, we currently have to spell it port="1".  That's a case where
> we'd allow a pairing of any string with an integer, rather than just an
> enum.

Does that mean we already have an use case where we will have to
relax the restrictions on ambiguous enums? :)

I won't mind at all if we remove the runtime detection of
ambiguous enums. It will make the code much simpler.

-- 
Eduardo
