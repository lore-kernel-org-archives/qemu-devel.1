Received: from eggs.gnu.org ([2001:4830:134:3::10]:39458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cPYCL-0000HN-9t
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 12:21:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cPYCG-0001t7-8z
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 12:21:01 -0500
Received: from roura.ac.upc.edu ([147.83.33.10]:40757 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cPYCF-0001ss-SS
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 12:20:56 -0500
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <20170106155543.12827-1-berrange@redhat.com>
	<20170106155543.12827-2-berrange@redhat.com>
Date: Fri, 06 Jan 2017 18:20:51 +0100
In-Reply-To: <20170106155543.12827-2-berrange@redhat.com> (Daniel
	P. Berrange's message of "Fri, 6 Jan 2017 15:54:57 +0000")
Message-ID: <878tqo2jgs.fsf@ac.upc.edu>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 01/47] trace: introduce some Makefile
 rules for module code gen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

Daniel P Berrange writes:

> Introduce rules that are able to generate trace.[ch] files
> in every subdirectory which has a trace-events file.

> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  .gitignore                               |  6 +++
>  Makefile                                 | 65 +++++++++++++++++++++++++++-----
>  Makefile.objs                            |  5 +++
>  Makefile.target                          |  7 +++-
>  scripts/tracetool/backend/dtrace.py      |  7 +++-
>  scripts/tracetool/backend/ust.py         |  7 +++-
>  scripts/tracetool/format/ust_events_c.py |  2 +-
>  scripts/tracetool/format/ust_events_h.py |  7 +++-
>  tests/Makefile.include                   |  2 +-
>  trace/Makefile.objs                      | 23 ++++++++---
>  10 files changed, 109 insertions(+), 22 deletions(-)

> diff --git a/.gitignore b/.gitignore
> index e43c304..fe6add3 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -111,3 +111,9 @@ tags
>  TAGS
>  docker-src.*
>  *~
> +trace.h
> +trace.c
> +trace-events-common
> +trace-ust.h
> +trace-dtrace.h
> +trace-dtrace.dtrace
> diff --git a/Makefile b/Makefile
> index 214cbad..181802b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -70,11 +70,53 @@ GENERATED_SOURCES += trace/generated-helpers.c
 
>  ifeq ($(findstring ust,$(TRACE_BACKENDS)),ust)
>  GENERATED_HEADERS += trace/generated-ust-provider.h
> +GENERATED_HEADERS += trace/generated-ust-provider-all.h
>  GENERATED_SOURCES += trace/generated-ust.c
>  endif
 
>  GENERATED_HEADERS += module_block.h
 
> +GENERATED_HEADERS += $(trace-events-subdirs:%=%/trace.h)
> +GENERATED_SOURCES += $(trace-events-subdirs:%=%/trace.c)
> +GENERATED_DTRACE =
> +ifdef CONFIG_TRACE_DTRACE
> +GENERATED_HEADERS += $(trace-events-subdirs:%=%/trace-dtrace.h)
> +GENERATED_DTRACE += $(trace-events-subdirs:%=%/trace-dtrace.dtrace)
> +endif
> +ifdef CONFIG_TRACE_UST
> +GENERATED_HEADERS += $(trace-events-subdirs:%=%/trace-ust.h)
> +endif
> +
> +%/trace.h: $(SRC_PATH)/%/trace-events $(tracetool-y)
> +	$(call quiet-command,$(TRACETOOL) \
> +		--format=h \
> +		--backends=$(TRACE_BACKENDS) \
> +		$< > $@,"GEN","$@")
> +
> +%/trace.c: $(SRC_PATH)/%/trace-events $(tracetool-y)
> +	$(call quiet-command,$(TRACETOOL) \
> +		--format=c \
> +		--backends=$(TRACE_BACKENDS) \
> +		$< > $@,"GEN","$@")
> +
> +%/trace-ust.h: $(SRC_PATH)/%/trace-events $(tracetool-y)
> +	$(call quiet-command,$(TRACETOOL) \
> +		--format=ust-events-h \
> +		--backends=$(TRACE_BACKENDS) \
> +		$< > $@,"GEN","$@")

There's a discrepancy between generation in trace/Makefile.objs, where timestamp
files are used to filter out internal changes in tracetool, and here.


[...]
> diff --git a/scripts/tracetool/backend/dtrace.py b/scripts/tracetool/backend/dtrace.py
> index 79505c6..1319990 100644
> --- a/scripts/tracetool/backend/dtrace.py
> +++ b/scripts/tracetool/backend/dtrace.py
> @@ -36,7 +36,12 @@ def binary():
 
 
>  def generate_h_begin(events, group):
> -    out('#include "trace/generated-tracers-dtrace.h"',
> +    if group == "common":
> +        include = "trace/generated-tracers-dtrace.h"
> +    else:
> +        include = "trace-dtrace.h"
> +
> +    out('#include "%s"' % include,
>          '')

Why is the top-level events file treated as a special case?


[...]


Cheers,
  Lluis
