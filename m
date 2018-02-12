Received: from eggs.gnu.org ([2001:4830:134:3::10]:36766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elMFO-0006Kl-If
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 17:06:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elMFL-0003K4-QY
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 17:06:50 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39984 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1elMFL-0003JN-L0
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 17:06:47 -0500
References: <20180211093607.27351-1-armbru@redhat.com>
	<20180211093607.27351-23-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cfdefa70-ce8c-5afd-0ddf-5fad17062171@redhat.com>
Date: Mon, 12 Feb 2018 16:06:28 -0600
MIME-Version: 1.0
In-Reply-To: <20180211093607.27351-23-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 22/29] qapi: Generate separate .h,
 .c for each module
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com

On 02/11/2018 03:36 AM, Markus Armbruster wrote:
> Our qapi-schema.json is composed of modules connected by include
> directives, but the generated code is monolithic all the same: one
> qapi-types.h with all the types, one qapi-visit.h with all the
> visitors, and so forth.  These monolithic headers get included all
> over the place.  In my "build everything" tree, adding a QAPI type
> recompiles about 4800 out of 5100 objects.
> 
> We wouldn't write such monolithic headers by hand.  It stands to
> reason that we shouldn't generate them, either.
> 
> Split up generated qapi-types.h to mirror the schema's modular
> structure: one header per module.  Name the main module's header
> qapi-types.h, and sub-module D/B.json's header D/qapi-types-B.h.
> 
> Mirror the schema's includes in the headers, so that qapi-types.h gets
> you everything exactly as before.  If you need less, you can include
> one or more of the sub-module headers.  To be exploited shortly.
> 
> Split up qapi-types.c, qapi-visit.h, qapi-visit.c, qmp-commands.h,
> qmp-commands.c, qapi-event.h, qapi-event.c the same way.
> qmp-introspect.h, qmp-introspect.c and qapi.texi remain monolithic.

Make sense.

> 
> The split of qmp-commands.c duplicates static helper function
> qmp_marshal_output_str() in qapi-commands-char.c and
> qapi-commands-misc.c.  This happens when commands returning the same
> type occur in multiple modules.  Not worth avoiding.

As long as it is static, and neither .c file includes the other, we're 
fine (gdb may have a harder time figuring out which copy to put a 
breakpoint on, but that's not too terrible).

> 
> Since I'm going to rename qapi-event.[ch] to qapi-events.[ch], and
> qmp-commands.[ch] to qapi-commands.[ch], name the shards that way
> already, to reduce churn.  This requires temporary hacks in
> commands.py and events.py.  They'll go away with the rename.

The planned rename makes sense; prepping now is fine.

> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   .gitignore               |  60 ++++++++++++++++++++++++
>   Makefile                 | 120 +++++++++++++++++++++++++++++++++++++++++++++++
>   Makefile.objs            |  65 ++++++++++++++++++++++++-
>   scripts/qapi/commands.py |  35 +++++++++-----
>   scripts/qapi/common.py   |  21 +++++++--
>   scripts/qapi/events.py   |  19 ++++++--
>   6 files changed, 300 insertions(+), 20 deletions(-)
> 
> diff --git a/.gitignore b/.gitignore
> index 9477a08b6b..42c57998fd 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -31,7 +31,67 @@
>   /qapi-gen-timestamp
>   /qapi-builtin-types.[ch]
>   /qapi-builtin-visit.[ch]
> +/qapi/qapi-commands-block-core.[ch]
> +/qapi/qapi-commands-block.[ch]

Is it worth using a glob instead of specific patterns, as in:

/qapi/qapi-commands-*.[ch]

Maybe being precise doesn't hurt, if we aren't adding sub-modules all 
that often; but being generous with a glob makes it less likely that a 
future module addition will forget to update .gitignore.


> +++ b/Makefile
> @@ -92,10 +92,70 @@ include $(SRC_PATH)/rules.mak
>   GENERATED_FILES = qemu-version.h config-host.h qemu-options.def
>   GENERATED_FILES += qapi-builtin-types.h qapi-builtin-types.c
>   GENERATED_FILES += qapi-types.h qapi-types.c
> +GENERATED_FILES += qapi/qapi-types-block-core.h qapi/qapi-types-block-core.c

For the makefile, I'd suggest using an intermediate list of module 
names, and then using make string operations to expand it into larger 
lists, to cut down on the repetition.  Something like (untested):

QAPI_MODULES = block-core block char common ...
GENERATED_FILES += $(addprefix qapi/qapi-types-,$(addsuffix 
.c,$(QAPI_MODULES))
GENERATED_FILES += $(addprefix qapi/qapi-types-,$(addsuffix 
.h,$(QAPI_MODULES))


> @@ -525,10 +585,70 @@ qapi-modules = $(SRC_PATH)/qapi-schema.json $(SRC_PATH)/qapi/common.json \
>   
>   qapi-builtin-types.c qapi-builtin-types.h \
>   qapi-types.c qapi-types.h \
> +qapi/qapi-types-block-core.c qapi/qapi-types-block-core.h \
> +qapi/qapi-types-block.c qapi/qapi-types-block.h \

And repeating the list of filenames; again, an intermediate variable 
would let you do:

QAPI_GENERATED_FILES = ...
GENERATED_FILES += $(QAPI_GENERATED_FILES)

$(QAPI_GENERATED_FILES): ...

>   qmp-introspect.h qmp-introspect.c \
>   qapi-doc.texi: \
>   qapi-gen-timestamp ;

Not only does it cut down on the repetition, but it will make adding a 
future module easier.

> diff --git a/Makefile.objs b/Makefile.objs
> index 2813e984fd..7a55d45669 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -3,8 +3,56 @@
>   stub-obj-y = stubs/ crypto/
>   util-obj-y = util/ qobject/ qapi/
>   util-obj-y += qapi-builtin-types.o
> +util-obj-y += qapi-types.o
> +util-obj-y += qapi/qapi-types-block-core.o

Perhaps this can also exploit make text manipulation?

Otherwise looks good.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
