Received: from eggs.gnu.org ([2001:4830:134:3::10]:45151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dY7P9-0008So-9l
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 05:05:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dY7P6-0005qX-3S
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 05:05:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38556)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dY7P5-0005qB-QZ
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 05:05:52 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170714190827.4083-1-eblake@redhat.com>
	<20170714190827.4083-2-eblake@redhat.com>
Date: Thu, 20 Jul 2017 11:05:48 +0200
In-Reply-To: <20170714190827.4083-2-eblake@redhat.com> (Eric Blake's message
	of "Fri, 14 Jul 2017 14:08:23 -0500")
Message-ID: <87vamnmqab.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/5] qapi: Further enhance visitor virtual
 walk doc example
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

Eric Blake <eblake@redhat.com> writes:

> Markus pointed out that the example given for virtual walks did
> not discuss how to do a virtual walk of an alternate type.  It
> turns out that for output, we don't need to visit an alternate
> (just directly visit the type that we want); and for input,
> visit_start_alternate() is not currently wired up for alternates
> (it requires a QAPI type, rather than permitting NULL for a
> virtual walk).  Also, the example was never updated in commit
> 3b098d5 about where visit_complete() would fit in.  Improve the
> description and example to give more details along these lines.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>

This clashes with some unfinished work I have on alternates.  If I can
finish it quickly, we can compare and decide whether we still need this.

> ---
>  include/qapi/visitor.h | 41 ++++++++++++++++++++++++++++-------------
>  1 file changed, 28 insertions(+), 13 deletions(-)
>
> diff --git a/include/qapi/visitor.h b/include/qapi/visitor.h
> index 74768aa..b0a048f 100644
> --- a/include/qapi/visitor.h
> +++ b/include/qapi/visitor.h
> @@ -183,19 +183,25 @@
>   *
>   * It is also possible to use the visitors to do a virtual walk, where
>   * no actual QAPI struct is present.  In this situation, decisions
> - * about what needs to be walked are made by the calling code, and
> - * structured visits are split between pairs of start and end methods
> - * (where the end method must be called if the start function
> - * succeeded, even if an intermediate visit encounters an error).
> - * Thus, a virtual walk corresponding to '{ "list": [1, 2] }' looks
> - * like:
> + * about what needs to be walked are made by the calling code (that
> + * is, there is no use for QAPI alternate types in a virtual walk,
> + * because the code can just directly visit the appropriate type
> + * within the alternate), and structured visits are split between

The parenthesis makes a long sentence even longer.

> + * pairs of start and end methods (where the end method must be called
> + * if the start function succeeded, even if an intermediate visit
> + * encounters an error).  Thus, a virtual output walk of an object
> + * containing a list of alternates between an integer or nested
> + * object, corresponding to '{ "list": [1, { "value": "2" } ] }',
> + * would look like:

Covering alternates as well makes the example rather complicated.  In
the unfinished work I mentioned above, I explain them separately.

>   *
>   * <example>
>   *  Visitor *v;
>   *  Error *err = NULL;
> - *  int value;
> + *  int i = 1;
> + *  const char *s = "2";
> + *  FOO output;
>   *
> - *  v = FOO_visitor_new(...);
> + *  v = FOO_visitor_new(..., &output);
>   *  visit_start_struct(v, NULL, NULL, 0, &err);
>   *  if (err) {
>   *      goto out;
> @@ -204,16 +210,21 @@
>   *  if (err) {
>   *      goto outobj;
>   *  }
> - *  value = 1;
> - *  visit_type_int(v, NULL, &value, &err);
> + *  visit_type_int(v, NULL, &i, &err);
>   *  if (err) {
>   *      goto outlist;
>   *  }
> - *  value = 2;
> - *  visit_type_int(v, NULL, &value, &err);
> + *  visit_type_start(v, NULL, NULL, 0, &err);
>   *  if (err) {
> - *      goto outlist;
> + *      goto outnest;
> + *  }
> + *  visit_type_str(v, "value", (char **)&s, &err);
> + *  if (err) {
> + *      goto outnest;
>   *  }
> + *  visit_check_struct(v, &err);
> + * outnest:
> + *  visit_end_struct(v, NULL);
>   * outlist:
>   *  visit_end_list(v, NULL);
>   *  if (!err) {
> @@ -221,6 +232,10 @@
>   *  }
>   * outobj:
>   *  visit_end_struct(v, NULL);
> + *  if (!err) {
> + *      visit_complete(v, &output);
> + *      ...use output...
> + *  }
>   * out:
>   *  error_propagate(errp, err);
>   *  visit_free(v);
