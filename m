Received: from eggs.gnu.org ([2001:4830:134:3::10]:51442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cHTg2-0002KK-Nj
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 05:54:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cHTfx-0008Ov-SJ
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 05:54:18 -0500
Received: from mo179.mail-out.ovh.net ([178.32.228.179]:46523)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cHTfx-0008KG-LV
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 05:54:13 -0500
Received: from player732.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id A4941BBE8
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 11:54:09 +0100 (CET)
Date: Thu, 15 Dec 2016 11:54:01 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20161215115401.7f3a58d7@bahia.lan>
In-Reply-To: <87zijx34t9.fsf@dusky.pond.sub.org>
References: <148173506053.2583.5116401313254785036.stgit@bahia>
	<87zijx34t9.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.9 v2] qapi: add explicit null to
 string input and output visitors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

On Thu, 15 Dec 2016 10:44:02 +0100
Markus Armbruster <armbru@redhat.com> wrote:

> Greg Kurz <groug@kaod.org> writes:
> 
> > This may be used for deprecated object properties that are kept for
> > backwards compatibility.
> >
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> > v2: - input visitor to reject non-empty strings
> >
> > This is needed for David's patch to work:
> >
> > [RFCv2 10/12] pseries: Move CPU compatibility property to machine  
> 
> Recommend to insert this patch less the fixup to David's patch before
> David's patch, then squash in the fixup, if it's needed.
> 

This is exactly the state of my test tree. :)

> > Messag-Id: <1479248275-18889-11-git-send-email-david@gibson.dropbear.id.au>
> >
> > Since this v2 changes the behavior to reject non-empty null properties,
> > it is up to getset_compat_deprecated() to ignore the error. The following
> > folded into patch [RFCv2 10/12] does the trick:
> >
> > --- a/target-ppc/translate_init.c
> > +++ b/target-ppc/translate_init.c
> > @@ -8446,7 +8446,7 @@ static void getset_compat_deprecated(Object *obj, Visitor
> >      if (!qtest_enabled()) {
> >          error_report("CPU 'compat' property is deprecated and has no effect; us
> >      }
> > -    visit_type_null(v, name, errp);
> > +    visit_type_null(v, name, NULL);  
> 
> Are you sure we want to ignore errors here?
> 

The following lines come from the changelog of David's patch [RFCv2 10/12]:
---
To reflect this, this removes the CPU 'compat' property and instead
creates a 'max-cpu-compat' property on the pseries machine.  Strictly
speaking this breaks compatibility, but AFAIK the 'compat' option was
never (directly) used with -device or device_add.

The option was used with -cpu.  So, to maintain compatibility, this patch
adds a hack to the cpu option parsing to strip out any compat options
supplied with -cpu and set them on the machine property instead of the new
removed cpu property.
---

i.e. we want to keep -cpu compat=blah because we turn it internally into
-machine max-cpu-compat=blah, and we want the 'compat' property to be
simply ignored by cpu objects.

visit_type_null() can only fail when setting a non-empty 'compat', which
is precisely the case we want to ignore.

> >  }
> >
> >  static PropertyInfo ppc_compat_deprecated_propinfo = {
> > ---
> >  qapi/string-input-visitor.c  |   11 +++++++++++
> >  qapi/string-output-visitor.c |   14 ++++++++++++++
> >  2 files changed, 25 insertions(+)
> >
> > diff --git a/qapi/string-input-visitor.c b/qapi/string-input-visitor.c
> > index 8dfa5612522b..9e9d2a1d2865 100644
> > --- a/qapi/string-input-visitor.c
> > +++ b/qapi/string-input-visitor.c
> > @@ -314,6 +314,16 @@ static void parse_type_number(Visitor *v, const char *name, double *obj,
> >      *obj = val;
> >  }
> >  
> > +static void parse_type_null(Visitor *v, const char *name, Error **errp)
> > +{
> > +    StringInputVisitor *siv = to_siv(v);
> > +
> > +    if (siv->string && siv->string[0]) {
> > +        error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name ? name : "null",
> > +                   "null");
> > +    }
> > +}  
> 
> When !siv->string, the other parse_type_FOO() generally do
> 
>     error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name ? name : "null",
>                ... a description of the expected type...);
> 
> This one doesn't.  Why?
> 
> Should the conditional be !siv->string || siv->string[0]?
> 

Yes, you're right.

> > +
> >  static void parse_optional(Visitor *v, const char *name, bool *present)
> >  {
> >      StringInputVisitor *siv = to_siv(v);
> > @@ -348,6 +358,7 @@ Visitor *string_input_visitor_new(const char *str)
> >      v->visitor.type_bool = parse_type_bool;
> >      v->visitor.type_str = parse_type_str;
> >      v->visitor.type_number = parse_type_number;
> > +    v->visitor.type_null = parse_type_null;
> >      v->visitor.start_list = start_list;
> >      v->visitor.next_list = next_list;
> >      v->visitor.end_list = end_list;
> > diff --git a/qapi/string-output-visitor.c b/qapi/string-output-visitor.c
> > index 94ac8211d144..5ec5352ca87c 100644
> > --- a/qapi/string-output-visitor.c
> > +++ b/qapi/string-output-visitor.c
> > @@ -266,6 +266,19 @@ static void print_type_number(Visitor *v, const char *name, double *obj,
> >      string_output_set(sov, g_strdup_printf("%f", *obj));
> >  }
> >  
> > +static void print_type_null(Visitor *v, const char *name, Error **errp)
> > +{
> > +    StringOutputVisitor *sov = to_sov(v);
> > +    char *out;
> > +
> > +    if (sov->human) {
> > +        out = g_strdup("<null>");
> > +    } else {
> > +        out = g_strdup("");
> > +    }
> > +    string_output_set(sov, out);
> > +}
> > +
> >  static void
> >  start_list(Visitor *v, const char *name, GenericList **list, size_t size,
> >             Error **errp)
> > @@ -351,6 +364,7 @@ Visitor *string_output_visitor_new(bool human, char **result)
> >      v->visitor.type_bool = print_type_bool;
> >      v->visitor.type_str = print_type_str;
> >      v->visitor.type_number = print_type_number;
> > +    v->visitor.type_null = print_type_null;
> >      v->visitor.start_list = start_list;
> >      v->visitor.next_list = next_list;
> >      v->visitor.end_list = end_list;  
