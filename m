Received: from eggs.gnu.org ([2001:4830:134:3::10]:60801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cGigy-0004J2-4S
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 03:44:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cGigb-00046e-Q0
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 03:44:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48726)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cGigb-00045G-EA
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 03:43:45 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <147954362297.28064.5118492606031513925.stgit@bahia>
Date: Tue, 13 Dec 2016 09:43:41 +0100
In-Reply-To: <147954362297.28064.5118492606031513925.stgit@bahia> (Greg Kurz's
	message of "Sat, 19 Nov 2016 09:28:13 +0100")
Message-ID: <87vauote0y.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

Greg Kurz <groug@kaod.org> writes:

> This may be used for deprecated object properties that are kept for
> backwards compatibility.
>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>
> This is enough to fix David's patch:
>
> [RFCv2 10/12] pseries: Move CPU compatibility property to machine
>
> Messag-Id: <1479248275-18889-11-git-send-email-david@gibson.dropbear.id.au>
>
>  qapi/string-input-visitor.c  |    5 +++++
>  qapi/string-output-visitor.c |   14 ++++++++++++++
>  2 files changed, 19 insertions(+)
>
> diff --git a/qapi/string-input-visitor.c b/qapi/string-input-visitor.c
> index 8dfa5612522b..4a378d7b67e6 100644
> --- a/qapi/string-input-visitor.c
> +++ b/qapi/string-input-visitor.c
> @@ -314,6 +314,10 @@ static void parse_type_number(Visitor *v, const char *name, double *obj,
>      *obj = val;
>  }
>  
> +static void parse_type_null(Visitor *v, const char *name, Error **errp)
> +{
> +}
> +

I figure this accepts an arbitrary string.  The output visitor ...


>  static void parse_optional(Visitor *v, const char *name, bool *present)
>  {
>      StringInputVisitor *siv = to_siv(v);
> @@ -348,6 +352,7 @@ Visitor *string_input_visitor_new(const char *str)
>      v->visitor.type_bool = parse_type_bool;
>      v->visitor.type_str = parse_type_str;
>      v->visitor.type_number = parse_type_number;
> +    v->visitor.type_null = parse_type_null;
>      v->visitor.start_list = start_list;
>      v->visitor.next_list = next_list;
>      v->visitor.end_list = end_list;
> diff --git a/qapi/string-output-visitor.c b/qapi/string-output-visitor.c
> index 94ac8211d144..5ec5352ca87c 100644
> --- a/qapi/string-output-visitor.c
> +++ b/qapi/string-output-visitor.c
> @@ -266,6 +266,19 @@ static void print_type_number(Visitor *v, const char *name, double *obj,
>      string_output_set(sov, g_strdup_printf("%f", *obj));
>  }
>  
> +static void print_type_null(Visitor *v, const char *name, Error **errp)
> +{
> +    StringOutputVisitor *sov = to_sov(v);
> +    char *out;
> +
> +    if (sov->human) {
> +        out = g_strdup("<null>");
> +    } else {
> +        out = g_strdup("");

... produces an empty string.  Sure this makes sense?

Shouldn't the input visitor reject anything but the empty string?

> +    }
> +    string_output_set(sov, out);
> +}
> +
>  static void
>  start_list(Visitor *v, const char *name, GenericList **list, size_t size,
>             Error **errp)
> @@ -351,6 +364,7 @@ Visitor *string_output_visitor_new(bool human, char **result)
>      v->visitor.type_bool = print_type_bool;
>      v->visitor.type_str = print_type_str;
>      v->visitor.type_number = print_type_number;
> +    v->visitor.type_null = print_type_null;
>      v->visitor.start_list = start_list;
>      v->visitor.next_list = next_list;
>      v->visitor.end_list = end_list;
