Received: from eggs.gnu.org ([2001:4830:134:3::10]:40698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1epgsg-0004Wr-JN
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 15:57:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1epgsf-00074s-SX
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 15:57:18 -0500
References: <20180224154033.29559-1-mreitz@redhat.com>
	<20180224154033.29559-3-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c8a20a6d-039f-544a-3b58-098f6be19ecf@redhat.com>
Date: Sat, 24 Feb 2018 14:57:00 -0600
MIME-Version: 1.0
In-Reply-To: <20180224154033.29559-3-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/7] qapi: Add qobject_to()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Alberto Garcia <berto@igalia.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 02/24/2018 09:40 AM, Max Reitz wrote:
> This is a dynamic casting macro that, given a QObject type, returns an
> object as that type or NULL if the object is of a different type (or
> NULL itself).
> 
> The macro uses lower-case letters because:
> 1. There does not seem to be a hard rule on whether qemu macros have to
>     be upper-cased,
> 2. The current situation in qapi/qmp is inconsistent (compare e.g.
>     QINCREF() vs. qdict_put()),
> 3. qobject_to() will evaluate its @obj parameter only once, thus it is
>     generally not important to the caller whether it is a macro or not,
> 4. I prefer it aesthetically.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   include/qapi/qmp/qobject.h | 30 ++++++++++++++++++++++++++++++
>   1 file changed, 30 insertions(+)
> 

> +++ b/include/qapi/qmp/qobject.h
> @@ -50,6 +50,22 @@ struct QObject {
>   #define QDECREF(obj)              \
>       qobject_decref(obj ? QOBJECT(obj) : NULL)
>   
> +/* Required for qobject_to() */
> +#define QTYPE_CAST_TO_QNull     QTYPE_QNULL
> +#define QTYPE_CAST_TO_QNum      QTYPE_QNUM
> +#define QTYPE_CAST_TO_QString   QTYPE_QSTRING
> +#define QTYPE_CAST_TO_QDict     QTYPE_QDICT
> +#define QTYPE_CAST_TO_QList     QTYPE_QLIST
> +#define QTYPE_CAST_TO_QBool     QTYPE_QBOOL
> +
> +QEMU_BUILD_BUG_MSG(QTYPE__MAX != 7,
> +                   "The QTYPE_CAST_TO_* list needs to be extended");
> +
> +#define qobject_to(obj, type) \
> +    container_of(qobject_check_type(obj, glue(QTYPE_CAST_TO_, type)) ?: \
> +                     QOBJECT((type *)NULL), \

I guess the third (second?) branch of the ternary is written this way, 
rather than the simpler 'NULL', to ensure that 'type' is still something 
that can have the QOBJECT() macro applied to it?  Should be okay.

> +                 type, base)
> +

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
