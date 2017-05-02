Received: from eggs.gnu.org ([2001:4830:134:3::10]:57574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d5gdj-0000VC-97
	for qemu-devel@nongnu.org; Tue, 02 May 2017 18:51:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d5gdg-0000eb-6h
	for qemu-devel@nongnu.org; Tue, 02 May 2017 18:51:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52386)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d5gdf-0000dc-TR
	for qemu-devel@nongnu.org; Tue, 02 May 2017 18:51:24 -0400
Date: Tue, 2 May 2017 19:51:19 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170502225119.GI3482@thinpad.lan.raisama.net>
References: <20170502203115.22233-1-ehabkost@redhat.com>
	<20170502203115.22233-3-ehabkost@redhat.com>
	<1153646d-848e-91ca-87f6-7d83b4963174@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1153646d-848e-91ca-87f6-7d83b4963174@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/4] string-input-visitor: Support
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
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On Tue, May 02, 2017 at 04:37:03PM -0500, Eric Blake wrote:
> On 05/02/2017 03:31 PM, Eduardo Habkost wrote:
> > When parsing alternates from a string, there are some limitations in
> > what we can do, but it is a valid use case in some situations. We can
> > support booleans, integer types, and enums.
> > 
> > This will be used to support 'feature=force' in -cpu options, while
> > keeping 'feature=on|off|true|false' represented as boolean values.
> > 
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> 
> >  
> > +/* Support for alternates on string-input-visitor is limited, because
> > + * the input string doesn't have any type information.
> > + *
> > + * Supported alternate member types:
> > + * 1) enums
> > + * 2) integer types
> > + * 3) booleans (but only if the there's no enum variant
> > + *    containing "on", "off", "true", or "false" as members)
> > + *
> > + * UNSUPPORTED alternate member types:
> > + * 1) strings
> > + * 2) complex types
> > + */
> > +static void start_alternate(Visitor *v, const char *name,
> > +                            GenericAlternate **obj, size_t size,
> > +                            unsigned long supported_qtypes, Error **errp)
> > +{
> > +    StringInputVisitor *siv = to_siv(v);
> > +    QType t = QTYPE_QSTRING;
> 
> Why do you document string as unsupported, and yet default to
> QTYPE_QSTRING?  I don't see how a string is fundamentally different from
> an enum (no alternate can have both at the same time, an alternate with
> either type will have QTYPE_QSTRING set in supported_qtypes).

Strings are indistinguishable from enums inside
start_alternate(), that's true. But I wanted to explicitly
document 'str' as unsupported by string-input-visitor because
some string values would necessarily overlap with the string
representation of other variants.

> 
> > +
> > +    if (supported_qtypes & BIT(QTYPE_QBOOL)) {
> > +        if (try_parse_bool(siv->string, NULL) == 0) {
> > +            t = QTYPE_QBOOL;
> > +        }
> > +    }
> > +
> > +    if (supported_qtypes & BIT(QTYPE_QINT)) {
> > +        if (parse_str(siv, name, NULL) == 0) {
> > +            t = QTYPE_QINT;
> > +        }
> > +    }
> > +
> > +    *obj = g_malloc0(size);
> > +    (*obj)->type = t;
> 
> Should you raise an error if you couldn't match the input with
> supported_qtypes, rather than just blindly returning QTYPE_QSTRING?

The generated visitors calling visit_start_alternate() already
generate a (more specific and more useful) error message when
they see unsupported types.

-- 
Eduardo
