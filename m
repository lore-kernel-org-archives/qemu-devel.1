Received: from eggs.gnu.org ([2001:4830:134:3::10]:55392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVbMs-0008JI-8B
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 07:33:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVbMr-0004fZ-6Z
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 07:33:42 -0400
References: <20180609151758.17343-1-vsementsov@virtuozzo.com>
	<20180609151758.17343-7-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <be6cae77-ed51-320f-8a86-fda7865c84b0@redhat.com>
Date: Wed, 20 Jun 2018 06:33:34 -0500
MIME-Version: 1.0
In-Reply-To: <20180609151758.17343-7-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 6/6] docs/interop: add nbd.txt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

On 06/09/2018 10:17 AM, Vladimir Sementsov-Ogievskiy wrote:
> Describe new metadata namespace: "qemu".
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   docs/interop/nbd.txt | 37 +++++++++++++++++++++++++++++++++++++
>   MAINTAINERS          |  1 +
>   2 files changed, 38 insertions(+)
>   create mode 100644 docs/interop/nbd.txt
> 
> diff --git a/docs/interop/nbd.txt b/docs/interop/nbd.txt
> new file mode 100644
> index 0000000000..7366269fc0
> --- /dev/null
> +++ b/docs/interop/nbd.txt
> @@ -0,0 +1,37 @@
> +Qemu supports NBD protocol, and has internal NBD client (look at

s/supports/supports the/

> +block/nbd.c), internal NBD server (look at blockdev-nbd.c) as well as

s/internal/an internal/2

> +external NBD server tool - qemu-nbd.c. The common code is placed in

s/external/an external/

> +nbd/*.
> +
> +NBD protocol is specified here:

s/NBD/The NBD/

> +https://github.com/NetworkBlockDevice/nbd/blob/master/doc/proto.md
> +
> +This following paragraphs describe some specific properties of NBD
> +protocol realization in Qemu.
> +
> +
> += Metadata namespaces =
> +
> +Qemu supports "base:allocation" metadata context as defined in the NBD

s/supports/supports the/

> +protocol specification and defines own metadata namespace: "qemu".

s/own/an additional/

> +
> +
> +== "qemu" namespace ==
> +
> +For now, the only type of metadata context in the namespace is dirty
> +bitmap. All available metadata contexts have the following form:

maybe:

The "qemu" namespace currently contains only one type of context, 
related to exposing the contents of a dirty bitmap alongside the 
associated disk contents.  The available metadata context has the 
following form:

> +
> +   qemu:dirty-bitmap:<dirty-bitmap-export-name>
> +
> +Each dirty-bitmap metadata context defines the only one flag for
> +extents in reply for NBD_CMD_BLOCK_STATUS:
> +
> +    bit 0: NBD_STATE_DIRTY, means that the extent is "dirty"
> +
> +For NBD_OPT_LIST_META_CONTEXT the following queries are supported
> +additionally to "qemu:dirty-bitmap:<dirty-bitmap-export-name>":

s/additionally/in addition/

> +
> +* "qemu:" : returns list of all available metadata contexts in the
> +            namespace.
> +* "qemu:dirty-bitmap:" : returns list of all available dirty-bitmap
> +                         metadata contexts.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e187b1f18f..887b479440 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1923,6 +1923,7 @@ F: nbd/
>   F: include/block/nbd*
>   F: qemu-nbd.*
>   F: blockdev-nbd.c
> +F: docs/interop/nbd.txt
>   T: git git://repo.or.cz/qemu/ericb.git nbd
>   
>   NFS
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

At this point, I think I'll touch up the issues I've spotted and submit 
a pull request, in order to make it easier for me to test my libvirt code.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
