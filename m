Received: from eggs.gnu.org ([2001:4830:134:3::10]:36948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fGmxd-0000ht-Lx
	for qemu-devel@nongnu.org; Thu, 10 May 2018 10:54:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fGmxc-0007VV-MZ
	for qemu-devel@nongnu.org; Thu, 10 May 2018 10:54:25 -0400
References: <20180509165530.29561-1-mreitz@redhat.com>
	<20180509165530.29561-7-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <105c40ee-d81a-2ebb-cd3a-63aa9e518d80@redhat.com>
Date: Thu, 10 May 2018 09:54:18 -0500
MIME-Version: 1.0
In-Reply-To: <20180509165530.29561-7-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 06/13] block: Add block-specific QDict
 header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 05/09/2018 11:55 AM, Max Reitz wrote:
> There are numerous QDict functions that have been introduced for and are
> used only by the block layer.  Move their declarations into an own

s/an own/their own/

> header file to reflect that.
> 
> While qdict_extract_subqdict() is in fact used outside of the block
> layer (in util/qemu-config.c), it is still a function related very
> closely to how the block layer works with nested QDicts, namely by
> sometimes flattening them.  Therefore, its declaration is put into this
> header as well and util/qemu-config.c includes it with a comment stating
> exactly which function it needs.
> 
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---

> +++ b/include/block/qdict.h
> @@ -0,0 +1,35 @@
> +/*
> + * Special QDict functions used by the block layer
> + *
> + * Copyright (c) 2018 Red Hat, Inc.

You are extracting this from qdict.h which has:
  * Copyright (C) 2009 Red Hat Inc.

Is it worth listing 2009-2018, instead of just this year?


> +
> +void qdict_copy_default(QDict *dst, QDict *src, const char *key);
> +void qdict_set_default_str(QDict *dst, const char *key, const char *val);

These two might be useful outside of the block layer; we can move them 
back in a later patch if so.  But for now, I agree with your choice of 
moving them.

> +
> +void qdict_join(QDict *dest, QDict *src, bool overwrite);

This is borderline whether it would be useful outside of the block layer.

> +
> +void qdict_extract_subqdict(QDict *src, QDict **dst, const char *start);
> +void qdict_array_split(QDict *src, QList **dst);
> +int qdict_array_entries(QDict *src, const char *subqdict);
> +QObject *qdict_crumple(const QDict *src, Error **errp);
> +void qdict_flatten(QDict *qdict);

And these are definitely hacks that the block layer relies on, where 
hopefully someday long term we can rewrite the block layer to use QAPI 
types directly instead of constant reconversion between QemuOpts and 
QDict and QAPI types.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
