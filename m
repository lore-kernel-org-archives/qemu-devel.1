Received: from eggs.gnu.org ([2001:4830:134:3::10]:51516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cGk9g-000766-VK
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 05:17:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cGk9d-000192-Pp
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 05:17:52 -0500
Received: from 3.mo53.mail-out.ovh.net ([178.33.44.239]:60855)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cGk9d-00018r-JZ
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 05:17:49 -0500
Received: from player158.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo53.mail-out.ovh.net (Postfix) with ESMTP id 40B0342769
	for <qemu-devel@nongnu.org>; Tue, 13 Dec 2016 11:17:47 +0100 (CET)
Date: Tue, 13 Dec 2016 11:17:39 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20161213111739.60458b3e@bahia.lan>
In-Reply-To: <87vauote0y.fsf@dusky.pond.sub.org>
References: <147954362297.28064.5118492606031513925.stgit@bahia>
	<87vauote0y.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qapi: add explicit null to string input
 and output visitors
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

On Tue, 13 Dec 2016 09:43:41 +0100
Markus Armbruster <armbru@redhat.com> wrote:

> Greg Kurz <groug@kaod.org> writes:
> 
> > This may be used for deprecated object properties that are kept for
> > backwards compatibility.
> >
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >
> > This is enough to fix David's patch:
> >
> > [RFCv2 10/12] pseries: Move CPU compatibility property to machine
> >
> > Messag-Id: <1479248275-18889-11-git-send-email-david@gibson.dropbear.id.au>
> >
> >  qapi/string-input-visitor.c  |    5 +++++
> >  qapi/string-output-visitor.c |   14 ++++++++++++++
> >  2 files changed, 19 insertions(+)
> >
> > diff --git a/qapi/string-input-visitor.c b/qapi/string-input-visitor.c
> > index 8dfa5612522b..4a378d7b67e6 100644
> > --- a/qapi/string-input-visitor.c
> > +++ b/qapi/string-input-visitor.c
> > @@ -314,6 +314,10 @@ static void parse_type_number(Visitor *v, const char *name, double *obj,
> >      *obj = val;
> >  }
> >  
> > +static void parse_type_null(Visitor *v, const char *name, Error **errp)
> > +{
> > +}
> > +  
> 
> I figure this accepts an arbitrary string.  The output visitor ...
> 

Yes, I assumed that null means "we don't care"... but maybe I'm wrong. :)

> 
> >  static void parse_optional(Visitor *v, const char *name, bool *present)
> >  {
> >      StringInputVisitor *siv = to_siv(v);
> > @@ -348,6 +352,7 @@ Visitor *string_input_visitor_new(const char *str)
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
> 
> ... produces an empty string.  Sure this makes sense?
> 
> Shouldn't the input visitor reject anything but the empty string?
> 

Looking at how null is handled for qobject, I suppose you're right. I'll
send a v2.

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
