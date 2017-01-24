Received: from eggs.gnu.org ([2001:4830:134:3::10]:56502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cW6EN-0006lA-RL
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:54:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cW6EL-0000qE-A2
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:54:11 -0500
Received: from roura.ac.upc.es ([147.83.33.10]:54653)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cW6EK-0000ph-TY
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:54:09 -0500
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <20170124110151.937-1-berrange@redhat.com>
	<20170124110151.937-7-berrange@redhat.com>
Date: Tue, 24 Jan 2017 20:53:57 +0200
In-Reply-To: <20170124110151.937-7-berrange@redhat.com> (Daniel P. Berrange's
	message of "Tue, 24 Jan 2017 11:01:49 +0000")
Message-ID: <87d1fci916.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 6/8] trace: switch to modular code
 generation for sub-directories
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Daniel P Berrange writes:

> Introduce rules in the top level Makefile that are able to generate
> trace.[ch] files in every subdirectory which has a trace-events file.

> The top level directory is handled specially, so instead of creating
> trace.h, it creates trace-root.h. This allows sub-directories to
> include the top level trace-root.h file, without ambiguity wrt to
> the trace.g file in the current sub-dir.

> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
[...]
> diff --git a/Makefile b/Makefile
> index 9f8968d..a8fa28a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -56,25 +56,136 @@ GENERATED_SOURCES += qmp-marshal.c qapi-types.c qapi-visit.c qapi-event.c
>  GENERATED_HEADERS += qmp-introspect.h
>  GENERATED_SOURCES += qmp-introspect.c
 
> -GENERATED_HEADERS += trace/generated-tracers.h
> -ifeq ($(findstring dtrace,$(TRACE_BACKENDS)),dtrace)
> -GENERATED_HEADERS += trace/generated-tracers-dtrace.h
> -endif
> -GENERATED_SOURCES += trace/generated-tracers.c
> -
>  GENERATED_HEADERS += trace/generated-tcg-tracers.h
 
>  GENERATED_HEADERS += trace/generated-helpers-wrappers.h
>  GENERATED_HEADERS += trace/generated-helpers.h
>  GENERATED_SOURCES += trace/generated-helpers.c
 
> -ifeq ($(findstring ust,$(TRACE_BACKENDS)),ust)
> -GENERATED_HEADERS += trace/generated-ust-provider.h
> -GENERATED_SOURCES += trace/generated-ust.c
> +ifdef CONFIG_TRACE_UST
> +GENERATED_HEADERS += trace-ust-all.h
> +GENERATED_SOURCES += trace-ust-all.c
>  endif
 
>  GENERATED_HEADERS += module_block.h
 
> +TRACE_HEADERS = trace-root.h $(trace-events-subdirs:%=%/trace.h)
> +TRACE_SOURCES = trace-root.c $(trace-events-subdirs:%=%/trace.c)
> +TRACE_DTRACE =
> +ifdef CONFIG_TRACE_DTRACE
> +TRACE_HEADERS += trace-dtrace-root.h $(trace-events-subdirs:%=%/trace-dtrace.h)
> +TRACE_DTRACE += trace-dtrace-root.dtrace $(trace-events-subdirs:%=%/trace-dtrace.dtrace)
> +endif
> +ifdef CONFIG_TRACE_UST
> +TRACE_HEADERS += trace-ust-root.h $(trace-events-subdirs:%=%/trace-ust.h)
> +endif
> +
> +GENERATED_HEADERS += $(TRACE_HEADERS)
> +GENERATED_SOURCES += $(TRACE_SOURCES)
> +
> +trace-group-name = $(shell dirname $1 | sed -e 's/[^a-zA-Z0-9]/_/g')
> +
> +%/trace.h: %/trace.h-timestamp
> +	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
> +%/trace.h-timestamp: $(SRC_PATH)/%/trace-events $(tracetool-y)
> +	$(call quiet-command,$(TRACETOOL) \
> +		--group=$(call trace-group-name,$@) \

Shouldn't you call trace-group-name with $*? To make sure it only contains the
directories *below* SRC_PATH.


Cheers,
  Lluis
