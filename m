Received: from eggs.gnu.org ([209.51.188.92]:41429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gyBy9-0008Jc-1B
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 03:50:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gyBy8-00026m-08
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 03:50:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gyBy5-00024m-U0
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 03:50:35 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 798103097061
	for <qemu-devel@nongnu.org>; Mon, 25 Feb 2019 08:50:31 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20190222153254.22739-1-stefanha@redhat.com>
Date: Mon, 25 Feb 2019 09:50:26 +0100
In-Reply-To: <20190222153254.22739-1-stefanha@redhat.com> (Stefan Hajnoczi's
	message of "Fri, 22 Feb 2019 15:32:54 +0000")
Message-ID: <87imx8uu99.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] qmp: add query-qemu-capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Krempa <pkrempa@redhat.com>

Stefan Hajnoczi <stefanha@redhat.com> writes:

> QMP clients can usually detect the presence of features via schema
> introspection.  There are rare features that do not involve schema
> changes and are therefore impossible to detect with schema
> introspection.
>
> This patch adds the query-qemu-capabilities command.  It returns a list
> of capabilities that this QEMU supports.

The name "capabilities" could be confusing, because we already have QMP
capabilities, complete with command qmp_capabilities.  Would "features"
work?

> The decision to make this a command rather than something statically
> defined in the schema is intentional.  It allows QEMU to decide which
> capabilities are available at runtime, if necessary.
>
> This new interface is necessary so that QMP clients can discover that
> migrating disk image files is safe with cache.direct=off on Linux.
> There is no other way to detect whether or not QEMU supports this.

I think what's unsaid here is that we don't want to make a completely
arbitrary schema change just to carry this bit of information.  We
could, but we don't want to.  Correct?

>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Peter Krempa <pkrempa@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  qapi/misc.json | 42 ++++++++++++++++++++++++++++++++++++++++++
>  qmp.c          | 18 ++++++++++++++++++
>  2 files changed, 60 insertions(+)
>
> diff --git a/qapi/misc.json b/qapi/misc.json
> index 8b3ca4fdd3..9cf24919a3 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -3051,3 +3051,45 @@
>    'data': 'NumaOptions',
>    'allow-preconfig': true
>  }
> +
> +##
> +# @QemuCapability:
> +#
> +# Capabilities that are not otherwise introspectable.
> +#
> +# @migrate-with-cache-direct-off-on-linux:
> +#  It is safe to migrate disk image files with cache.direct=off on Linux.
> +#  Previously only cache.direct=on was supported for live migration.

Somewhat unusual formatting due to long name.  I double-checked the doc
comment gets processed correctly.  Good.

> +#
> +# Since: 4.0
> +##
> +{ 'enum': 'QemuCapability',
> +  'data': [
> +    'migrate-with-cache-direct-off-on-linux'
> +  ]
> +}
> +
> +##
> +# @QemuCapabilities:
> +#
> +# Capability information.
> +#
> +# @capabilities: supported capabilities
> +#
> +# Since: 4.0
> +##
> +{ 'struct': 'QemuCapabilities',
> +  'data': { 'capabilities': ['QemuCapability'] } }
> +
> +##
> +# @query-qemu-capabilities:
> +#
> +# Return the capabilities supported by this QEMU.  Most features can be
> +# detected via schema introspection but some are not observable from the
> +# schema.  This command offers a way to check for the presence of such
> +# features.
> +#
> +# Since: 4.0
> +##
> +{ 'command': 'query-qemu-capabilities',
> +  'returns': 'QemuCapabilities' }

Capabilities are flags: either present or absent, thus effectively
boolean.  I don't have a specific reason to doubt limiting capabilities
to boolean.  However, doing QemuCapabilities like

   { 'struct': 'QemuCapabilities',
     'data': { 'migrate-with-cache-direct-off-on-linux': 'bool' } }

could grow to support other values more easily.  What do you think?

> diff --git a/qmp.c b/qmp.c
> index b92d62cd5f..91a1228be7 100644
> --- a/qmp.c
> +++ b/qmp.c
> @@ -717,3 +717,21 @@ MemoryInfo *qmp_query_memory_size_summary(Error **errp)
>  
>      return mem_info;
>  }
> +
> +QemuCapabilities *qmp_query_qemu_capabilities(Error **errp)
> +{
> +    QemuCapabilities *caps = g_new0(QemuCapabilities, 1);
> +    QemuCapabilityList **prev = &caps->capabilities;
> +    QemuCapability cap_val;
> +
> +    /* Add all QemuCapability enum values defined in the schema */
> +    for (cap_val = 0; cap_val < QEMU_CAPABILITY__MAX; cap_val++) {
> +        QemuCapabilityList *cap = g_new0(QemuCapabilityList, 1);
> +
> +        cap->value = cap_val;
> +        *prev = cap;
> +        prev = &cap->next;
> +    }
> +
> +    return caps;
> +}

All capabilities known to this build of QEMU are always present.  Okay;
no need to complicate things until we need to.  I just didn't expect it
to be this simple after the commit message's "It allows QEMU to decide
which capabilities are available at runtime, if necessary."
