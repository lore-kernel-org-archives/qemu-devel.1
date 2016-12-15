Received: from eggs.gnu.org ([2001:4830:134:3::10]:37010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cHSa9-0005vc-7v
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 04:44:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cHSa6-0005qt-4F
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 04:44:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cHSa5-0005qX-Ri
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 04:44:06 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <148173506053.2583.5116401313254785036.stgit@bahia>
Date: Thu, 15 Dec 2016 10:44:02 +0100
In-Reply-To: <148173506053.2583.5116401313254785036.stgit@bahia> (Greg Kurz's
	message of "Wed, 14 Dec 2016 18:04:20 +0100")
Message-ID: <87zijx34t9.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

Greg Kurz <groug@kaod.org> writes:

> This may be used for deprecated object properties that are kept for
> backwards compatibility.
>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
> v2: - input visitor to reject non-empty strings
>
> This is needed for David's patch to work:
>
> [RFCv2 10/12] pseries: Move CPU compatibility property to machine

Recommend to insert this patch less the fixup to David's patch before
David's patch, then squash in the fixup, if it's needed.

> Messag-Id: <1479248275-18889-11-git-send-email-david@gibson.dropbear.id.au>
>
> Since this v2 changes the behavior to reject non-empty null properties,
> it is up to getset_compat_deprecated() to ignore the error. The following
> folded into patch [RFCv2 10/12] does the trick:
>
> --- a/target-ppc/translate_init.c
> +++ b/target-ppc/translate_init.c
> @@ -8446,7 +8446,7 @@ static void getset_compat_deprecated(Object *obj, Visitor
>      if (!qtest_enabled()) {
>          error_report("CPU 'compat' property is deprecated and has no effect; us
>      }
> -    visit_type_null(v, name, errp);
> +    visit_type_null(v, name, NULL);

Are you sure we want to ignore errors here?

>  }
>
>  static PropertyInfo ppc_compat_deprecated_propinfo = {
> ---
>  qapi/string-input-visitor.c  |   11 +++++++++++
>  qapi/string-output-visitor.c |   14 ++++++++++++++
>  2 files changed, 25 insertions(+)
>
> diff --git a/qapi/string-input-visitor.c b/qapi/string-input-visitor.c
> index 8dfa5612522b..9e9d2a1d2865 100644
> --- a/qapi/string-input-visitor.c
> +++ b/qapi/string-input-visitor.c
> @@ -314,6 +314,16 @@ static void parse_type_number(Visitor *v, const char *name, double *obj,
>      *obj = val;
>  }
>  
> +static void parse_type_null(Visitor *v, const char *name, Error **errp)
> +{
> +    StringInputVisitor *siv = to_siv(v);
> +
> +    if (siv->string && siv->string[0]) {
> +        error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name ? name : "null",
> +                   "null");
> +    }
> +}

When !siv->string, the other parse_type_FOO() generally do

    error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name ? name : "null",
               ... a description of the expected type...);

This one doesn't.  Why?

Should the conditional be !siv->string || siv->string[0]?

> +
>  static void parse_optional(Visitor *v, const char *name, bool *present)
>  {
>      StringInputVisitor *siv = to_siv(v);
> @@ -348,6 +358,7 @@ Visitor *string_input_visitor_new(const char *str)
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
