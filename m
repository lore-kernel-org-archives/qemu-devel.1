Received: from eggs.gnu.org ([2001:4830:134:3::10]:44650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dAbbg-0004oF-Mt
	for qemu-devel@nongnu.org; Tue, 16 May 2017 08:29:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dAbbd-0006hG-JK
	for qemu-devel@nongnu.org; Tue, 16 May 2017 08:29:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43654)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dAbbd-0006gk-9h
	for qemu-devel@nongnu.org; Tue, 16 May 2017 08:29:37 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2186C3B71C
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 12:29:36 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170516111123.17692-1-quintela@redhat.com>
	<20170516111123.17692-2-quintela@redhat.com>
Date: Tue, 16 May 2017 14:29:32 +0200
In-Reply-To: <20170516111123.17692-2-quintela@redhat.com> (Juan Quintela's
	message of "Tue, 16 May 2017 13:11:19 +0200")
Message-ID: <87o9uthtn7.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/5] hmp: Use visitor api for
 hmp_migrate_set_parameter()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

Juan Quintela <quintela@redhat.com> writes:

> We only use it for int64 at this point, I am not able to find a way to
> parse an int with MiB units.

Use the string input visitor and visit_type_size() to parse with unit
suffixes.  The problem is hmp_migrate_set_parameter() wants "no suffix"
to mean "mebibytes", which the string input visitor can't do.  Good for
new code, because it helps keeping things consistent.  Not so good for
converting existing code.

> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  hmp.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/hmp.c b/hmp.c
> index b9dd933..acbbc5c 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -29,6 +29,7 @@
>  #include "monitor/qdev.h"
>  #include "qapi/opts-visitor.h"
>  #include "qapi/qmp/qerror.h"
> +#include "qapi/string-input-visitor.h"
>  #include "qapi/string-output-visitor.h"
>  #include "qapi/util.h"
>  #include "qapi-visit.h"
> @@ -1523,8 +1524,9 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
>  {
>      const char *param = qdict_get_str(qdict, "parameter");
>      const char *valuestr = qdict_get_str(qdict, "value");
> +    Visitor *v = string_input_visitor_new(valuestr);
>      uint64_t valuebw = 0;
> -    long valueint = 0;
> +    int64_t valueint = 0;
>      Error *err = NULL;
>      bool use_int_value = false;
>      int i, ret;
> @@ -1582,9 +1584,8 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
>              }
>  
>              if (use_int_value) {
> -                if (qemu_strtol(valuestr, NULL, 10, &valueint) < 0) {
> -                    error_setg(&err, "Unable to parse '%s' as an int",
> -                               valuestr);
> +                visit_type_int(v, param, &valueint, &err);

I figure the error message changes from

    Unable to parse 'PARAM' as an int

to

    Parameter 'PARAM' expects an int64 value or range

The "or range" part is due to the string input visitor's support for
integer list, which is basically horrible.


> +                if (err) {
>                      goto cleanup;
>                  }
>                  /* Set all integers; only one has_FOO will be set, and
> @@ -1608,6 +1609,7 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
>      }
>  
>   cleanup:
> +    visit_free(v);
>      if (err) {
>          error_report_err(err);
>      }

Reviewed-by: Markus Armbruster <armbru@redhat.com>
