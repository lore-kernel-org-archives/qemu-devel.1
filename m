Received: from eggs.gnu.org ([2001:4830:134:3::10]:46929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eEcfF-0002kF-Jg
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 09:58:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eEcfA-0002dS-MD
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 09:58:13 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20171110221329.24176-1-mreitz@redhat.com>
	<20171110221329.24176-2-mreitz@redhat.com>
Date: Tue, 14 Nov 2017 15:57:52 +0100
In-Reply-To: <20171110221329.24176-2-mreitz@redhat.com> (Max Reitz's message
	of "Fri, 10 Nov 2017 23:13:27 +0100")
Message-ID: <874lpwsya7.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-2.12 1/3] qapi: Add qdict_is_null()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

Max Reitz <mreitz@redhat.com> writes:

> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  include/qapi/qmp/qdict.h |  1 +
>  qobject/qdict.c          | 10 ++++++++++
>  2 files changed, 11 insertions(+)
>
> diff --git a/include/qapi/qmp/qdict.h b/include/qapi/qmp/qdict.h
> index fc218e7be6..c65ebfc748 100644
> --- a/include/qapi/qmp/qdict.h
> +++ b/include/qapi/qmp/qdict.h
> @@ -76,6 +76,7 @@ int64_t qdict_get_try_int(const QDict *qdict, const char *key,
>                            int64_t def_value);
>  bool qdict_get_try_bool(const QDict *qdict, const char *key, bool def_value);
>  const char *qdict_get_try_str(const QDict *qdict, const char *key);
> +bool qdict_is_qnull(const QDict *qdict, const char *key);
>  
>  void qdict_copy_default(QDict *dst, QDict *src, const char *key);
>  void qdict_set_default_str(QDict *dst, const char *key, const char *val);
> diff --git a/qobject/qdict.c b/qobject/qdict.c
> index e8f15f1132..a032ea629a 100644
> --- a/qobject/qdict.c
> +++ b/qobject/qdict.c
> @@ -294,6 +294,16 @@ const char *qdict_get_try_str(const QDict *qdict, const char *key)
>  }
>  
>  /**
> + * qdict_is_qnull(): Return true if the value for 'key' is QNull
> + */
> +bool qdict_is_qnull(const QDict *qdict, const char *key)
> +{
> +    QObject *value = qdict_get(qdict, key);
> +
> +    return value && value->type == QTYPE_QNULL;
> +}
> +
> +/**
>   * qdict_iter(): Iterate over all the dictionary's stored values.
>   *
>   * This function allows the user to provide an iterator, which will be

As far as I can tell, the new helper function is going to be used just
once, by bdrv_open_inherit() in PATCH 2:

    qdict_is_qnull(options, "backing")

I dislike abstracting from just one concrete instance.

Perhaps a more general helper could be more generally useful.  Something
like:

    qobject_is(qdict_get(options, "backing", QTYPE_QNULL))

There are numerous instances of

    !obj || qobject_type(obj) == T

in the tree, which could then be replaced by

    qobject_is(obj, T)

An alternative helper: macro qobject_dynamic_cast(obj, T) that returns
(T *)obj if obj is a T, else null.  Leads to something like

    qobject_dynamic_cast(qdict_get(options, "backing", QNull))
