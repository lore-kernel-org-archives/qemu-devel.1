Received: from eggs.gnu.org ([2001:4830:134:3::10]:59267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fHCxB-0003eu-53
	for qemu-devel@nongnu.org; Fri, 11 May 2018 14:39:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fHCxA-0001As-5Q
	for qemu-devel@nongnu.org; Fri, 11 May 2018 14:39:41 -0400
References: <20180509165530.29561-1-mreitz@redhat.com>
	<20180509165530.29561-8-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e0cb86f1-ac04-f7cd-bd19-77abeeb5636a@redhat.com>
Date: Fri, 11 May 2018 13:39:33 -0500
MIME-Version: 1.0
In-Reply-To: <20180509165530.29561-8-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 07/13] qdict: Add
 qdict_stringify_for_keyval()
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
> The purpose of this function is to prepare a QDict for consumption by
> the keyval visitor, which only accepts strings and QNull.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   include/block/qdict.h |  2 ++
>   qobject/qdict.c       | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 59 insertions(+)
> 

> +/**
> + * Convert all values in a QDict so it can be consumed by the keyval
> + * input visitor.  QNull values are left as-is, all other values are
> + * converted to strings.
> + *
> + * @qdict must be flattened, i.e. it may not contain any nested QDicts
> + * or QLists.

Maybe s/flattened/flattened already/

or would it be worth letting this function PERFORM the flattening step 
automatically?

> + */
> +void qdict_stringify_for_keyval(QDict *qdict)
> +{
> +    const QDictEntry *e;
> +
> +    for (e = qdict_first(qdict); e; e = qdict_next(qdict, e)) {
> +        QString *new_value = NULL;
> +
> +        switch (qobject_type(e->value)) {
> +        case QTYPE_QNULL:
> +            /* leave as-is */
> +            break;
> +
> +        case QTYPE_QNUM: {
> +            char *str = qnum_to_string(qobject_to(QNum, e->value));
> +            new_value = qstring_from_str(str);
> +            g_free(str);
> +            break;
> +        }
> +
> +        case QTYPE_QSTRING:
> +            /* leave as-is */
> +            break;
> +
> +        case QTYPE_QDICT:
> +        case QTYPE_QLIST:
> +            /* @qdict must be flattened */
> +            abort();

Matches your documentation about requiring it to be already flattened.

> +
> +        case QTYPE_QBOOL:
> +            if (qbool_get_bool(qobject_to(QBool, e->value))) {
> +                new_value = qstring_from_str("on");
> +            } else {
> +                new_value = qstring_from_str("off");
> +            }
> +            break;
> +
> +        case QTYPE_NONE:
> +        case QTYPE__MAX:
> +            abort();
> +        }
> +
> +        if (new_value) {
> +            QDictEntry *mut_e = (QDictEntry *)e;

A bit of a shame that you have to cast away const. It took me a couple 
reads to figure out this meant 'mutable_e'.  But in the end, the code 
looks correct.

> +            qobject_unref(mut_e->value);
> +            mut_e->value = QOBJECT(new_value);

If we're okay requiring the caller to pre-flatten before calling this, 
instead of offering to do it here,
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
