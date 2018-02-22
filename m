Received: from eggs.gnu.org ([2001:4830:134:3::10]:51550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ep06l-0006uD-GD
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 18:17:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ep05w-0004Np-Hz
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 18:16:59 -0500
References: <20180221135404.27598-1-kwolf@redhat.com>
	<20180221135404.27598-12-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <83887ef6-4e27-13e3-f29d-b3df08056eb1@redhat.com>
Date: Thu, 22 Feb 2018 17:13:52 -0600
MIME-Version: 1.0
In-Reply-To: <20180221135404.27598-12-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 11/36] qdict: Introduce
 qdict_rename_keys()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, pkrempa@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

On 02/21/2018 07:53 AM, Kevin Wolf wrote:
> A few block drivers will need to rename .bdrv_create options for their
> QAPIfication, so let's have a helper function for that.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   include/qapi/qmp/qdict.h |   6 +++
>   qobject/qdict.c          |  34 ++++++++++++++
>   tests/check-qdict.c      | 113 +++++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 153 insertions(+)
> 

> +/**
> + * qdict_rename_keys(): Rename keys in qdict according to the replacements
> + * specified in the array renames. The array must be terminated by an entry
> + * with from = NULL.
> + *
> + * The renames are performed individually in the order of the array, so entries
> + * may be renamed multiple times and may or may not conflict depending on the
> + * order of the renames array.

Oh interesting - so I could rename a->tmp, b->a, tmp->b in the classic 
strategy to intentionally avoid conflicts.  But I hope none of our 
actual clients ever abuse the interface that directly.

> + *
> + * Returns true for success, false in error cases.

I won't make you change it, but is 0/-1 any easier to understand 
intuitively?  With bool, it's often a case of "I'd better check the docs 
for whether true meant the sense I wanted"

> + */
> +bool qdict_rename_keys(QDict *qdict, const QDictRenames *renames, Error **errp)
> +{

> +++ b/tests/check-qdict.c

> +    copy = qdict_clone_shallow(dict);
> +    qdict_rename_keys(copy, renames, &error_abort);
> +
> +    g_assert_cmpstr(qdict_get_str(copy, "abc"), ==, "foo");
> +    g_assert_cmpstr(qdict_get_str(copy, "abcdef"), ==, "bar");
> +    g_assert_cmpint(qdict_get_int(copy, "number"), ==, 42);
> +    g_assert_cmpint(qdict_get_bool(copy, "flag"), ==, true);
> +    g_assert(qobject_type(qdict_get(copy, "nothing")) == QTYPE_QNULL);

Also worth an assert that there are exactly 5 keys, so that rename 
didn't botch something to leave a different straggler key behind?

> +
> +    QDECREF(copy);
> +
> +    /* Simple rename of all entries */
> +    renames = (QDictRenames[]) {
> +        { "abc",        "str1" },
> +        { "abcdef",     "str2" },
> +        { "number",     "int" },
> +        { "flag",       "bool" },
> +        { "nothing",    "null" },
> +        { NULL , NULL }
> +    };
> +    copy = qdict_clone_shallow(dict);
> +    qdict_rename_keys(copy, renames, &error_abort);
> +
> +    g_assert(!qdict_haskey(copy, "abc"));
> +    g_assert(!qdict_haskey(copy, "abcdef"));
> +    g_assert(!qdict_haskey(copy, "number"));
> +    g_assert(!qdict_haskey(copy, "flag"));
> +    g_assert(!qdict_haskey(copy, "nothing"));

Direct check for the obvious keys that should have been renamed,

> +
> +    g_assert_cmpstr(qdict_get_str(copy, "str1"), ==, "foo");
> +    g_assert_cmpstr(qdict_get_str(copy, "str2"), ==, "bar");
> +    g_assert_cmpint(qdict_get_int(copy, "int"), ==, 42);
> +    g_assert_cmpint(qdict_get_bool(copy, "bool"), ==, true);
> +    g_assert(qobject_type(qdict_get(copy, "null")) == QTYPE_QNULL);

but again, an assert that there are 5 keys rules out all other mistakes, 
too.

Up to you whether to further tweak the tests; and with the spelling fix 
Max already found,

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
