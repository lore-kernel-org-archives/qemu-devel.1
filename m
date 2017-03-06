Received: from eggs.gnu.org ([2001:4830:134:3::10]:40176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ckw6j-0005YF-Kl
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 12:07:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ckw6g-0008Oi-Dk
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 12:07:37 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:33042)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ckw6g-0008OI-7E
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 12:07:34 -0500
Received: by mail-qk0-x244.google.com with SMTP id j127so27677937qke.0
	for <qemu-devel@nongnu.org>; Mon, 06 Mar 2017 09:07:34 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1488544368-30622-1-git-send-email-armbru@redhat.com>
	<1488544368-30622-17-git-send-email-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <49e43891-f2cc-6ba8-5abf-09e24fde70be@amsat.org>
Date: Mon, 6 Mar 2017 14:07:29 -0300
MIME-Version: 1.0
In-Reply-To: <1488544368-30622-17-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 16/28] qapi: Make string input and opts
 visitor require non-null input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

On 03/03/2017 09:32 AM, Markus Armbruster wrote:
> The string input visitor tries to cope with null input.  Null input
> isn't used anywhere, and isn't covered by tests.  Unsurprisingly, it
> doesn't fully work: start_list() crashes because it passes the input
> via parse_str() to strtoll() unchecked.
>
> Make string_input_visitor_new() assert its argument isn't null, and
> drop the code trying to deal with null input.
>
> The opts visitor crashes when you try to actually visit something with
> null input.  Make opts_visitor_new() assert its argument isn't null,
> mostly for clarity.
>
> qobject_input_visitor_new() already asserts its argument isn't null.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  qapi/opts-visitor.c         |  1 +
>  qapi/string-input-visitor.c | 54 ++++++++++++++-------------------------------
>  2 files changed, 18 insertions(+), 37 deletions(-)
>
> diff --git a/qapi/opts-visitor.c b/qapi/opts-visitor.c
> index a0a7c0e..c50dc4b 100644
> --- a/qapi/opts-visitor.c
> +++ b/qapi/opts-visitor.c
> @@ -528,6 +528,7 @@ opts_visitor_new(const QemuOpts *opts)
>  {
>      OptsVisitor *ov;
>
> +    assert(opts);
>      ov = g_malloc0(sizeof *ov);
>
>      ov->visitor.type = VISITOR_INPUT;
> diff --git a/qapi/string-input-visitor.c b/qapi/string-input-visitor.c
> index 1a855c5..f126cd9 100644
> --- a/qapi/string-input-visitor.c
> +++ b/qapi/string-input-visitor.c
> @@ -182,12 +182,6 @@ static void parse_type_int64(Visitor *v, const char *name, int64_t *obj,
>  {
>      StringInputVisitor *siv = to_siv(v);
>
> -    if (!siv->string) {
> -        error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name ? name : "null",
> -                   "integer");
> -        return;
> -    }
> -
>      if (parse_str(siv, name, errp) < 0) {
>          return;
>      }
> @@ -242,13 +236,7 @@ static void parse_type_size(Visitor *v, const char *name, uint64_t *obj,
>      Error *err = NULL;
>      uint64_t val;
>
> -    if (siv->string) {
> -        parse_option_size(name, siv->string, &val, &err);
> -    } else {
> -        error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name ? name : "null",
> -                   "size");
> -        return;
> -    }
> +    parse_option_size(name, siv->string, &val, &err);
>      if (err) {
>          error_propagate(errp, err);
>          return;
> @@ -262,19 +250,17 @@ static void parse_type_bool(Visitor *v, const char *name, bool *obj,
>  {
>      StringInputVisitor *siv = to_siv(v);
>
> -    if (siv->string) {
> -        if (!strcasecmp(siv->string, "on") ||
> -            !strcasecmp(siv->string, "yes") ||
> -            !strcasecmp(siv->string, "true")) {
> -            *obj = true;
> -            return;
> -        }
> -        if (!strcasecmp(siv->string, "off") ||
> -            !strcasecmp(siv->string, "no") ||
> -            !strcasecmp(siv->string, "false")) {
> -            *obj = false;
> -            return;
> -        }
> +    if (!strcasecmp(siv->string, "on") ||
> +        !strcasecmp(siv->string, "yes") ||
> +        !strcasecmp(siv->string, "true")) {
> +        *obj = true;
> +        return;
> +    }
> +    if (!strcasecmp(siv->string, "off") ||
> +        !strcasecmp(siv->string, "no") ||
> +        !strcasecmp(siv->string, "false")) {
> +        *obj = false;
> +        return;
>      }
>
>      error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name ? name : "null",
> @@ -285,13 +271,8 @@ static void parse_type_str(Visitor *v, const char *name, char **obj,
>                             Error **errp)
>  {
>      StringInputVisitor *siv = to_siv(v);
> -    if (siv->string) {
> -        *obj = g_strdup(siv->string);
> -    } else {
> -        *obj = NULL;
> -        error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name ? name : "null",
> -                   "string");
> -    }
> +
> +    *obj = g_strdup(siv->string);
>  }
>
>  static void parse_type_number(Visitor *v, const char *name, double *obj,
> @@ -302,10 +283,8 @@ static void parse_type_number(Visitor *v, const char *name, double *obj,
>      double val;
>
>      errno = 0;
> -    if (siv->string) {
> -        val = strtod(siv->string, &endp);
> -    }
> -    if (!siv->string || errno || endp == siv->string || *endp) {
> +    val = strtod(siv->string, &endp);
> +    if (errno || endp == siv->string || *endp) {
>          error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name ? name : "null",
>                     "number");
>          return;
> @@ -327,6 +306,7 @@ Visitor *string_input_visitor_new(const char *str)
>  {
>      StringInputVisitor *v;
>
> +    assert(str);
>      v = g_malloc0(sizeof(*v));
>
>      v->visitor.type = VISITOR_INPUT;
>
