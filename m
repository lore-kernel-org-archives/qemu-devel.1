Received: from eggs.gnu.org ([2001:4830:134:3::10]:46099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fW1DD-0000Qx-Vs
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 11:09:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fW1D9-0003zX-TF
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 11:09:27 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:38888)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fW1D9-0003zJ-MA
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 11:09:23 -0400
Received: by mail-qk0-x242.google.com with SMTP id y4-v6so1929994qka.5
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 08:09:23 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180621150254.4922-1-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <68a6d7c5-16dc-3204-4d50-f31056eaae51@amsat.org>
Date: Thu, 21 Jun 2018 12:09:18 -0300
MIME-Version: 1.0
In-Reply-To: <20180621150254.4922-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] trace: forbid floating point types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 06/21/2018 12:02 PM, Stefan Hajnoczi wrote:
> Only one existing trace event uses a floating point type.  Unfortunately
> float and double cannot be supported since SystemTap does not have
> floating point types.
> 
> Remove float and double from the whitelist and document this limitation.
> Update the migrate_transferred trace event to use uint64_t instead of
> double.
> 
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Cc: Daniel P. Berrangé <berrange@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  docs/devel/tracing.txt        | 5 +++++
>  migration/trace-events        | 2 +-
>  qapi/trace-events             | 2 +-
>  scripts/tracetool/__init__.py | 2 --
>  4 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/docs/devel/tracing.txt b/docs/devel/tracing.txt
> index 07abbb345c..6f815ecbd7 100644
> --- a/docs/devel/tracing.txt
> +++ b/docs/devel/tracing.txt
> @@ -104,6 +104,11 @@ Trace events should use types as follows:
>   * For everything else, use primitive scalar types (char, int, long) with the
>     appropriate signedness.
>  
> + * Avoid floating point types (float and double) because SystemTap does not
> +   support them.  In most cases it is possible to round to an integer type
> +   instead.  This may require scaling the value first by multiplying it by 1000
> +   or the like when digits after the decimal point need to be preserved.
> +
>  Format strings should reflect the types defined in the trace event.  Take
>  special care to use PRId64 and PRIu64 for int64_t and uint64_t types,
>  respectively.  This ensures portability between 32- and 64-bit platforms.
> diff --git a/migration/trace-events b/migration/trace-events
> index 3f67758893..7ea522e453 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -133,7 +133,7 @@ migrate_global_state_post_load(const char *state) "loaded state: %s"
>  migrate_global_state_pre_save(const char *state) "saved state: %s"
>  migration_thread_low_pending(uint64_t pending) "%" PRIu64
>  migrate_state_too_big(void) ""
> -migrate_transferred(uint64_t tranferred, uint64_t time_spent, double bandwidth, uint64_t size) "transferred %" PRIu64 " time_spent %" PRIu64 " bandwidth %g max_size %" PRId64
> +migrate_transferred(uint64_t tranferred, uint64_t time_spent, uint64_t bandwidth, uint64_t size) "transferred %" PRIu64 " time_spent %" PRIu64 " bandwidth %" PRIu64 " max_size %" PRId64
>  process_incoming_migration_co_end(int ret, int ps) "ret=%d postcopy-state=%d"
>  process_incoming_migration_co_postcopy_end_main(void) ""
>  migration_set_incoming_channel(void *ioc, const char *ioctype) "ioc=%p ioctype=%s"
> diff --git a/qapi/trace-events b/qapi/trace-events
> index 9e9008a1dc..70e049ea80 100644
> --- a/qapi/trace-events
> +++ b/qapi/trace-events
> @@ -29,6 +29,6 @@ visit_type_int64(void *v, const char *name, int64_t *obj) "v=%p name=%s obj=%p"
>  visit_type_size(void *v, const char *name, uint64_t *obj) "v=%p name=%s obj=%p"
>  visit_type_bool(void *v, const char *name, bool *obj) "v=%p name=%s obj=%p"
>  visit_type_str(void *v, const char *name, char **obj) "v=%p name=%s obj=%p"
> -visit_type_number(void *v, const char *name, double *obj) "v=%p name=%s obj=%p"
> +visit_type_number(void *v, const char *name, void *obj) "v=%p name=%s obj=%p"
>  visit_type_any(void *v, const char *name, void *obj) "v=%p name=%s obj=%p"
>  visit_type_null(void *v, const char *name, void *obj) "v=%p name=%s obj=%p"
> diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py
> index b20fac34a3..0e3c9e146c 100644
> --- a/scripts/tracetool/__init__.py
> +++ b/scripts/tracetool/__init__.py
> @@ -53,8 +53,6 @@ ALLOWED_TYPES = [
>      "bool",
>      "unsigned",
>      "signed",
> -    "float",
> -    "double",
>      "int8_t",
>      "uint8_t",
>      "int16_t",
> 
