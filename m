Received: from eggs.gnu.org ([2001:4830:134:3::10]:60295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fHD1U-00037o-Jg
	for qemu-devel@nongnu.org; Fri, 11 May 2018 14:44:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fHD1T-0004Hj-MO
	for qemu-devel@nongnu.org; Fri, 11 May 2018 14:44:08 -0400
References: <20180509165530.29561-1-mreitz@redhat.com>
	<20180509165530.29561-10-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3e69f163-3ed0-5f52-25c1-150b32060a48@redhat.com>
Date: Fri, 11 May 2018 13:44:01 -0500
MIME-Version: 1.0
In-Reply-To: <20180509165530.29561-10-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 09/13] qdict: Make qdict_flatten()
 shallow-clone-friendly
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
> In its current form, qdict_flatten() removes all entries from nested
> QDicts that are moved to the root QDict.  It is completely sufficient to
> remove all old entries from the root QDict, however.  If the nested
> dicts have a refcount of 1, this will automatically delete them, too.
> And if they have a greater refcount, we probably do not want to modify
> them in the first place.
> 
> The latter observation means that it was currently (in general)
> impossible to qdict_flatten() a shallowly cloned dict because that would
> empty nested QDicts in the original dict as well.  This patch changes
> this, so you can now use qdict_flatten(qdict_shallow_clone(dict)) to get
> a flattened copy without disturbing the original.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   qobject/qdict.c | 23 ++++++++++++++++-------
>   1 file changed, 16 insertions(+), 7 deletions(-)
> 

>   
>           g_free(new_key);
>   
> -        if (delete) {
> +        if (copied_value && qdict == target) {
> +            /* If we have copied a value, and if we are on the root
> +             * level, we need to remove the old entry.  Otherwise, we
> +             * do not, because by removing these entries on the root
> +             * level, the reference counts of nested dicts and listed

s/listed/lists/

> +             * will be reduced automatically.  In fact, we probably do
> +             * not want to modify nested dicts and lists with
> +             * refcounts greater than 1 anyway. */
>               qdict_del(qdict, entry->key);
>   
> -            /* Restart loop after modifying the iterated QDict */
> +            /* Restart loop after modifying the iterated QDict.  We
> +             * only need to do this if qdict == target, because
> +             * otherwise copying the value did not affect qdict. */
>               entry = qdict_first(qdict);
>               continue;
>           }
> 

With the typo fix,
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
