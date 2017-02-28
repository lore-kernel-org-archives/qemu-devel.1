Received: from eggs.gnu.org ([2001:4830:134:3::10]:48207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ciled-00083a-49
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:33:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cilec-0003pb-AC
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:33:39 -0500
Date: Tue, 28 Feb 2017 18:33:32 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170228173332.GT4090@noname.redhat.com>
References: <1488194450-28056-1-git-send-email-armbru@redhat.com>
	<1488194450-28056-18-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1488194450-28056-18-git-send-email-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 17/24] qapi: New
 qobject_input_visitor_new_str() for convenience
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, pkrempa@redhat.com, eblake@redhat.com

Am 27.02.2017 um 12:20 hat Markus Armbruster geschrieben:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  include/qapi/qobject-input-visitor.h | 12 ++++++++++++
>  qapi/qobject-input-visitor.c         | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+)
> 
> diff --git a/include/qapi/qobject-input-visitor.h b/include/qapi/qobject-input-visitor.h
> index 282f9d2..b399285 100644
> --- a/include/qapi/qobject-input-visitor.h
> +++ b/include/qapi/qobject-input-visitor.h
> @@ -68,4 +68,16 @@ Visitor *qobject_input_visitor_new(QObject *obj);
>   */
>  Visitor *qobject_input_visitor_new_keyval(QObject *obj);
>  
> +/*
> + * Create a QObject input visitor for parsing @str.
> + *
> + * If @str looks like JSON, parse it as JSON, else as KEY=VALUE,...
> + * @implied_key applies to KEY=VALUE, and works as in keyval_parse().
> + * On failure, store an error through @errp and return NULL.
> + * On success, return a new QObject input visitor for the parse.
> + */
> +Visitor *qobject_input_visitor_new_str(const char *str,
> +                                       const char *implied_key,
> +                                       Error **errp);
> +
>  #endif
> diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
> index 3db5850..64a08d3 100644
> --- a/qapi/qobject-input-visitor.c
> +++ b/qapi/qobject-input-visitor.c
> @@ -18,9 +18,11 @@
>  #include "qapi/visitor-impl.h"
>  #include "qemu/queue.h"
>  #include "qemu-common.h"
> +#include "qapi/qmp/qjson.h"
>  #include "qapi/qmp/types.h"
>  #include "qapi/qmp/qerror.h"
>  #include "qemu/cutils.h"
> +#include "qemu/option.h"
>  
>  typedef struct StackObject {
>      const char *name;            /* Name of @obj in its parent, if any */
> @@ -655,3 +657,34 @@ Visitor *qobject_input_visitor_new_keyval(QObject *obj)
>  
>      return &v->visitor;
>  }
> +
> +Visitor *qobject_input_visitor_new_str(const char *str,
> +                                       const char *implied_key,
> +                                       Error **errp)
> +{
> +    bool is_json = str[0] == '{';
> +    QObject *obj;
> +    QDict *args;
> +    Visitor *v;
> +
> +    if (is_json) {
> +        obj = qobject_from_json(str, errp);
> +        if (!obj) {
> +            /* Work around qobject_from_json() lossage TODO fix that */
> +            if (errp && !*errp) {
> +                error_setg(errp, "JSON parse error");
> +                return NULL;
> +            }
> +            return NULL;
> +        }
> +        args = qobject_to_qdict(obj);
> +        assert(args);
> +        v = qobject_input_visitor_new(QOBJECT(args));
> +    } else {
> +        args = keyval_parse(optarg, implied_key, errp);

No, you don't mean optarg.

Makes all attempts to use -blockdev segfault for me.

> +        v = qobject_input_visitor_new_keyval(QOBJECT(args));
> +    }
> +    QDECREF(args);
> +
> +    return v;
> +}

Kevin
