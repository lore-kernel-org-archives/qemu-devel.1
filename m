Received: from eggs.gnu.org ([2001:4830:134:3::10]:58558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cy8jt-00010H-PJ
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 23:14:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cy8jp-0002Cs-MJ
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 23:14:37 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:36535)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cy8jp-0002BX-HC
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 23:14:33 -0400
Received: by mail-qt0-x243.google.com with SMTP id v3so2252601qtd.3
	for <qemu-devel@nongnu.org>; Tue, 11 Apr 2017 20:14:31 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170411185034.13460-1-eblake@redhat.com>
	<20170411185034.13460-9-eblake@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <aaf80d6f-e931-ffc4-ccc3-723d3b1c485c@amsat.org>
Date: Wed, 12 Apr 2017 00:14:26 -0300
MIME-Version: 1.0
In-Reply-To: <20170411185034.13460-9-eblake@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 08/13] tests: Use simpler QDict/QList
 scalar insertion macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, Michael Roth <mdroth@linux.vnet.ibm.com>

On 04/11/2017 03:50 PM, Eric Blake wrote:
> We now have macros in place to make it less verbose to add a scalar
> to QDict and QList, so use them.
>
> Patch created mechanically via:
>   spatch --sp-file scripts/coccinelle/qobject.cocci \
>     --macro-file scripts/cocci-macro-file.h --dir tests --in-place
> then manually checked that no touch-ups were needed.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> v4: no change
> v3: new patch
> ---
>  tests/check-qdict.c                 | 134 ++++++++++++++++++------------------
>  tests/check-qlist.c                 |   4 +-
>  tests/device-introspect-test.c      |   4 +-
>  tests/test-qemu-opts.c              |   4 +-
>  tests/test-qmp-commands.c           |  24 +++----
>  tests/test-qmp-event.c              |  30 ++++----
>  tests/test-qobject-output-visitor.c |   6 +-
>  7 files changed, 103 insertions(+), 103 deletions(-)
>
> diff --git a/tests/check-qdict.c b/tests/check-qdict.c
> index 9cdc985..3effca5 100644
> --- a/tests/check-qdict.c
> +++ b/tests/check-qdict.c
> @@ -47,7 +47,7 @@ static void qdict_put_obj_test(void)
>      qdict = qdict_new();
>
>      // key "" will have tdb hash 12345
> -    qdict_put(qdict, "", qint_from_int(num));
> +    qdict_put_int(qdict, "", num);
>
>      g_assert(qdict_size(qdict) == 1);
>      ent = QLIST_FIRST(&qdict->table[12345 % QDICT_BUCKET_MAX]);
> @@ -66,8 +66,8 @@ static void qdict_destroy_simple_test(void)
>      QDict *qdict;
>
>      qdict = qdict_new();
> -    qdict_put(qdict, "num", qint_from_int(0));
> -    qdict_put(qdict, "str", qstring_from_str("foo"));
> +    qdict_put_int(qdict, "num", 0);
> +    qdict_put_str(qdict, "str", "foo");
>
>      QDECREF(qdict);
>  }
> @@ -80,7 +80,7 @@ static void qdict_get_test(void)
>      const char *key = "test";
>      QDict *tests_dict = qdict_new();
>
> -    qdict_put(tests_dict, key, qint_from_int(value));
> +    qdict_put_int(tests_dict, key, value);
>
>      obj = qdict_get(tests_dict, key);
>      g_assert(obj != NULL);
> @@ -98,7 +98,7 @@ static void qdict_get_int_test(void)
>      const char *key = "int";
>      QDict *tests_dict = qdict_new();
>
> -    qdict_put(tests_dict, key, qint_from_int(value));
> +    qdict_put_int(tests_dict, key, value);
>
>      ret = qdict_get_int(tests_dict, key);
>      g_assert(ret == value);
> @@ -113,7 +113,7 @@ static void qdict_get_try_int_test(void)
>      const char *key = "int";
>      QDict *tests_dict = qdict_new();
>
> -    qdict_put(tests_dict, key, qint_from_int(value));
> +    qdict_put_int(tests_dict, key, value);
>
>      ret = qdict_get_try_int(tests_dict, key, 0);
>      g_assert(ret == value);
> @@ -128,7 +128,7 @@ static void qdict_get_str_test(void)
>      const char *str = "string";
>      QDict *tests_dict = qdict_new();
>
> -    qdict_put(tests_dict, key, qstring_from_str(str));
> +    qdict_put_str(tests_dict, key, str);
>
>      p = qdict_get_str(tests_dict, key);
>      g_assert(p != NULL);
> @@ -144,7 +144,7 @@ static void qdict_get_try_str_test(void)
>      const char *str = "string";
>      QDict *tests_dict = qdict_new();
>
> -    qdict_put(tests_dict, key, qstring_from_str(str));
> +    qdict_put_str(tests_dict, key, str);
>
>      p = qdict_get_try_str(tests_dict, key);
>      g_assert(p != NULL);
> @@ -188,7 +188,7 @@ static void qdict_haskey_test(void)
>      const char *key = "test";
>      QDict *tests_dict = qdict_new();
>
> -    qdict_put(tests_dict, key, qint_from_int(0));
> +    qdict_put_int(tests_dict, key, 0);
>      g_assert(qdict_haskey(tests_dict, key) == 1);
>
>      QDECREF(tests_dict);
> @@ -199,7 +199,7 @@ static void qdict_del_test(void)
>      const char *key = "key test";
>      QDict *tests_dict = qdict_new();
>
> -    qdict_put(tests_dict, key, qstring_from_str("foo"));
> +    qdict_put_str(tests_dict, key, "foo");
>      g_assert(qdict_size(tests_dict) == 1);
>
>      qdict_del(tests_dict, key);
> @@ -226,9 +226,9 @@ static void qdict_iterapi_test(void)
>
>      g_assert(qdict_first(tests_dict) == NULL);
>
> -    qdict_put(tests_dict, "key1", qint_from_int(1));
> -    qdict_put(tests_dict, "key2", qint_from_int(2));
> -    qdict_put(tests_dict, "key3", qint_from_int(3));
> +    qdict_put_int(tests_dict, "key1", 1);
> +    qdict_put_int(tests_dict, "key2", 2);
> +    qdict_put_int(tests_dict, "key3", 3);
>
>      count = 0;
>      for (ent = qdict_first(tests_dict); ent; ent = qdict_next(tests_dict, ent)){
> @@ -294,20 +294,20 @@ static void qdict_flatten_test(void)
>       * }
>       */
>
> -    qdict_put(dict1, "a", qint_from_int(0));
> -    qdict_put(dict1, "b", qint_from_int(1));
> +    qdict_put_int(dict1, "a", 0);
> +    qdict_put_int(dict1, "b", 1);
>
> -    qlist_append(list1, qint_from_int(23));
> -    qlist_append(list1, qint_from_int(66));
> +    qlist_append_int(list1, 23);
> +    qlist_append_int(list1, 66);
>      qlist_append(list1, dict1);
> -    qlist_append(list2, qint_from_int(42));
> +    qlist_append_int(list2, 42);
>      qlist_append(list2, list1);
>
> -    qdict_put(dict2, "c", qint_from_int(2));
> -    qdict_put(dict2, "d", qint_from_int(3));
> +    qdict_put_int(dict2, "c", 2);
> +    qdict_put_int(dict2, "d", 3);
>      qdict_put(dict3, "e", list2);
>      qdict_put(dict3, "f", dict2);
> -    qdict_put(dict3, "g", qint_from_int(4));
> +    qdict_put_int(dict3, "g", 4);
>
>      qdict_flatten(dict3);
>
> @@ -369,12 +369,12 @@ static void qdict_array_split_test(void)
>       * This example is given in the comment of qdict_array_split().
>       */
>
> -    qdict_put(test_dict, "1.x", qint_from_int(0));
> -    qdict_put(test_dict, "4.y", qint_from_int(1));
> -    qdict_put(test_dict, "0.a", qint_from_int(42));
> -    qdict_put(test_dict, "o.o", qint_from_int(7));
> -    qdict_put(test_dict, "0.b", qint_from_int(23));
> -    qdict_put(test_dict, "2", qint_from_int(66));
> +    qdict_put_int(test_dict, "1.x", 0);
> +    qdict_put_int(test_dict, "4.y", 1);
> +    qdict_put_int(test_dict, "0.a", 42);
> +    qdict_put_int(test_dict, "o.o", 7);
> +    qdict_put_int(test_dict, "0.b", 23);
> +    qdict_put_int(test_dict, "2", 66);
>
>      qdict_array_split(test_dict, &test_list);
>
> @@ -441,9 +441,9 @@ static void qdict_array_split_test(void)
>
>      test_dict = qdict_new();
>
> -    qdict_put(test_dict, "0", qint_from_int(42));
> -    qdict_put(test_dict, "1", qint_from_int(23));
> -    qdict_put(test_dict, "1.x", qint_from_int(84));
> +    qdict_put_int(test_dict, "0", 42);
> +    qdict_put_int(test_dict, "1", 23);
> +    qdict_put_int(test_dict, "1.x", 84);
>
>      qdict_array_split(test_dict, &test_list);
>
> @@ -472,38 +472,38 @@ static void qdict_array_entries_test(void)
>
>      g_assert_cmpint(qdict_array_entries(dict, "foo."), ==, 0);
>
> -    qdict_put(dict, "bar", qint_from_int(0));
> -    qdict_put(dict, "baz.0", qint_from_int(0));
> +    qdict_put_int(dict, "bar", 0);
> +    qdict_put_int(dict, "baz.0", 0);
>      g_assert_cmpint(qdict_array_entries(dict, "foo."), ==, 0);
>
> -    qdict_put(dict, "foo.1", qint_from_int(0));
> +    qdict_put_int(dict, "foo.1", 0);
>      g_assert_cmpint(qdict_array_entries(dict, "foo."), ==, -EINVAL);
> -    qdict_put(dict, "foo.0", qint_from_int(0));
> +    qdict_put_int(dict, "foo.0", 0);
>      g_assert_cmpint(qdict_array_entries(dict, "foo."), ==, 2);
> -    qdict_put(dict, "foo.bar", qint_from_int(0));
> +    qdict_put_int(dict, "foo.bar", 0);
>      g_assert_cmpint(qdict_array_entries(dict, "foo."), ==, -EINVAL);
>      qdict_del(dict, "foo.bar");
>
> -    qdict_put(dict, "foo.2.a", qint_from_int(0));
> -    qdict_put(dict, "foo.2.b", qint_from_int(0));
> -    qdict_put(dict, "foo.2.c", qint_from_int(0));
> +    qdict_put_int(dict, "foo.2.a", 0);
> +    qdict_put_int(dict, "foo.2.b", 0);
> +    qdict_put_int(dict, "foo.2.c", 0);
>      g_assert_cmpint(qdict_array_entries(dict, "foo."), ==, 3);
>      g_assert_cmpint(qdict_array_entries(dict, ""), ==, -EINVAL);
>
>      QDECREF(dict);
>
>      dict = qdict_new();
> -    qdict_put(dict, "1", qint_from_int(0));
> +    qdict_put_int(dict, "1", 0);
>      g_assert_cmpint(qdict_array_entries(dict, ""), ==, -EINVAL);
> -    qdict_put(dict, "0", qint_from_int(0));
> +    qdict_put_int(dict, "0", 0);
>      g_assert_cmpint(qdict_array_entries(dict, ""), ==, 2);
> -    qdict_put(dict, "bar", qint_from_int(0));
> +    qdict_put_int(dict, "bar", 0);
>      g_assert_cmpint(qdict_array_entries(dict, ""), ==, -EINVAL);
>      qdict_del(dict, "bar");
>
> -    qdict_put(dict, "2.a", qint_from_int(0));
> -    qdict_put(dict, "2.b", qint_from_int(0));
> -    qdict_put(dict, "2.c", qint_from_int(0));
> +    qdict_put_int(dict, "2.a", 0);
> +    qdict_put_int(dict, "2.b", 0);
> +    qdict_put_int(dict, "2.c", 0);
>      g_assert_cmpint(qdict_array_entries(dict, ""), ==, 3);
>
>      QDECREF(dict);
> @@ -529,7 +529,7 @@ static void qdict_join_test(void)
>
>          /* First iteration: Test movement */
>          /* Second iteration: Test empty source and non-empty destination */
> -        qdict_put(dict2, "foo", qint_from_int(42));
> +        qdict_put_int(dict2, "foo", 42);
>
>          for (i = 0; i < 2; i++) {
>              qdict_join(dict1, dict2, overwrite);
> @@ -541,7 +541,7 @@ static void qdict_join_test(void)
>          }
>
>          /* Test non-empty source and destination without conflict */
> -        qdict_put(dict2, "bar", qint_from_int(23));
> +        qdict_put_int(dict2, "bar", 23);
>
>          qdict_join(dict1, dict2, overwrite);
>
> @@ -552,7 +552,7 @@ static void qdict_join_test(void)
>          g_assert(qdict_get_int(dict1, "bar") == 23);
>
>          /* Test conflict */
> -        qdict_put(dict2, "foo", qint_from_int(84));
> +        qdict_put_int(dict2, "foo", 84);
>
>          qdict_join(dict1, dict2, overwrite);
>
> @@ -594,15 +594,15 @@ static void qdict_crumple_test_recursive(void)
>      QList *rules;
>
>      src = qdict_new();
> -    qdict_put(src, "vnc.listen.addr", qstring_from_str("127.0.0.1"));
> -    qdict_put(src, "vnc.listen.port", qstring_from_str("5901"));
> -    qdict_put(src, "vnc.acl.rules.0.match", qstring_from_str("fred"));
> -    qdict_put(src, "vnc.acl.rules.0.policy", qstring_from_str("allow"));
> -    qdict_put(src, "vnc.acl.rules.1.match", qstring_from_str("bob"));
> -    qdict_put(src, "vnc.acl.rules.1.policy", qstring_from_str("deny"));
> -    qdict_put(src, "vnc.acl.default", qstring_from_str("deny"));
> -    qdict_put(src, "vnc.acl..name", qstring_from_str("acl0"));
> -    qdict_put(src, "vnc.acl.rule..name", qstring_from_str("acl0"));
> +    qdict_put_str(src, "vnc.listen.addr", "127.0.0.1");
> +    qdict_put_str(src, "vnc.listen.port", "5901");
> +    qdict_put_str(src, "vnc.acl.rules.0.match", "fred");
> +    qdict_put_str(src, "vnc.acl.rules.0.policy", "allow");
> +    qdict_put_str(src, "vnc.acl.rules.1.match", "bob");
> +    qdict_put_str(src, "vnc.acl.rules.1.policy", "deny");
> +    qdict_put_str(src, "vnc.acl.default", "deny");
> +    qdict_put_str(src, "vnc.acl..name", "acl0");
> +    qdict_put_str(src, "vnc.acl.rule..name", "acl0");
>
>      dst = qobject_to_qdict(qdict_crumple(src, &error_abort));
>      g_assert(dst);
> @@ -669,8 +669,8 @@ static void qdict_crumple_test_bad_inputs(void)
>
>      src = qdict_new();
>      /* rule.0 can't be both a string and a dict */
> -    qdict_put(src, "rule.0", qstring_from_str("fred"));
> -    qdict_put(src, "rule.0.policy", qstring_from_str("allow"));
> +    qdict_put_str(src, "rule.0", "fred");
> +    qdict_put_str(src, "rule.0.policy", "allow");
>
>      g_assert(qdict_crumple(src, &error) == NULL);
>      g_assert(error != NULL);
> @@ -680,8 +680,8 @@ static void qdict_crumple_test_bad_inputs(void)
>
>      src = qdict_new();
>      /* rule can't be both a list and a dict */
> -    qdict_put(src, "rule.0", qstring_from_str("fred"));
> -    qdict_put(src, "rule.a", qstring_from_str("allow"));
> +    qdict_put_str(src, "rule.0", "fred");
> +    qdict_put_str(src, "rule.a", "allow");
>
>      g_assert(qdict_crumple(src, &error) == NULL);
>      g_assert(error != NULL);
> @@ -692,7 +692,7 @@ static void qdict_crumple_test_bad_inputs(void)
>      src = qdict_new();
>      /* The input should be flat, ie no dicts or lists */
>      qdict_put(src, "rule.a", qdict_new());
> -    qdict_put(src, "rule.b", qstring_from_str("allow"));
> +    qdict_put_str(src, "rule.b", "allow");
>
>      g_assert(qdict_crumple(src, &error) == NULL);
>      g_assert(error != NULL);
> @@ -702,8 +702,8 @@ static void qdict_crumple_test_bad_inputs(void)
>
>      src = qdict_new();
>      /* List indexes must not have gaps */
> -    qdict_put(src, "rule.0", qstring_from_str("deny"));
> -    qdict_put(src, "rule.3", qstring_from_str("allow"));
> +    qdict_put_str(src, "rule.0", "deny");
> +    qdict_put_str(src, "rule.3", "allow");
>
>      g_assert(qdict_crumple(src, &error) == NULL);
>      g_assert(error != NULL);
> @@ -713,8 +713,8 @@ static void qdict_crumple_test_bad_inputs(void)
>
>      src = qdict_new();
>      /* List indexes must be in %zu format */
> -    qdict_put(src, "rule.0", qstring_from_str("deny"));
> -    qdict_put(src, "rule.+1", qstring_from_str("allow"));
> +    qdict_put_str(src, "rule.0", "deny");
> +    qdict_put_str(src, "rule.+1", "allow");
>
>      g_assert(qdict_crumple(src, &error) == NULL);
>      g_assert(error != NULL);
> @@ -733,8 +733,8 @@ static void qdict_put_exists_test(void)
>      const char *key = "exists";
>      QDict *tests_dict = qdict_new();
>
> -    qdict_put(tests_dict, key, qint_from_int(1));
> -    qdict_put(tests_dict, key, qint_from_int(2));
> +    qdict_put_int(tests_dict, key, 1);
> +    qdict_put_int(tests_dict, key, 2);
>
>      value = qdict_get_int(tests_dict, key);
>      g_assert(value == 2);
> diff --git a/tests/check-qlist.c b/tests/check-qlist.c
> index e16da5e..4983867 100644
> --- a/tests/check-qlist.c
> +++ b/tests/check-qlist.c
> @@ -74,7 +74,7 @@ static void qlist_destroy_test(void)
>      qlist = qlist_new();
>
>      for (i = 0; i < 42; i++)
> -        qlist_append(qlist, qint_from_int(i));
> +        qlist_append_int(qlist, i);
>
>      QDECREF(qlist);
>  }
> @@ -103,7 +103,7 @@ static void qlist_iter_test(void)
>      qlist = qlist_new();
>
>      for (i = 0; i < iter_max; i++)
> -        qlist_append(qlist, qint_from_int(i));
> +        qlist_append_int(qlist, i);
>
>      iter_called = 0;
>      qlist_iter(qlist, iter_func, NULL);
> diff --git a/tests/device-introspect-test.c b/tests/device-introspect-test.c
> index c5637cc..b1abb2a 100644
> --- a/tests/device-introspect-test.c
> +++ b/tests/device-introspect-test.c
> @@ -32,9 +32,9 @@ static QList *qom_list_types(const char *implements, bool abstract)
>      QList *ret;
>      QDict *args = qdict_new();
>
> -    qdict_put(args, "abstract", qbool_from_bool(abstract));
> +    qdict_put_bool(args, "abstract", abstract);
>      if (implements) {
> -        qdict_put(args, "implements", qstring_from_str(implements));
> +        qdict_put_str(args, "implements", implements);
>      }
>      resp = qmp("{'execute': 'qom-list-types',"
>                 " 'arguments': %p }", args);
> diff --git a/tests/test-qemu-opts.c b/tests/test-qemu-opts.c
> index 0ad74b4..cc1bb1a 100644
> --- a/tests/test-qemu-opts.c
> +++ b/tests/test-qemu-opts.c
> @@ -299,7 +299,7 @@ static void test_qemu_opt_get_size(void)
>      dict = qdict_new();
>      g_assert(dict != NULL);
>
> -    qdict_put(dict, "size1", qstring_from_str("10"));
> +    qdict_put_str(dict, "size1", "10");
>
>      qemu_opts_absorb_qdict(opts, dict, &error_abort);
>      g_assert(error_abort == NULL);
> @@ -309,7 +309,7 @@ static void test_qemu_opt_get_size(void)
>      g_assert(opt == 10);
>
>      /* reset value */
> -    qdict_put(dict, "size1", qstring_from_str("15"));
> +    qdict_put_str(dict, "size1", "15");
>
>      qemu_opts_absorb_qdict(opts, dict, &error_abort);
>      g_assert(error_abort == NULL);
> diff --git a/tests/test-qmp-commands.c b/tests/test-qmp-commands.c
> index ac3fd03..acdded4 100644
> --- a/tests/test-qmp-commands.c
> +++ b/tests/test-qmp-commands.c
> @@ -94,7 +94,7 @@ static void test_dispatch_cmd(void)
>      QDict *req = qdict_new();
>      QObject *resp;
>
> -    qdict_put(req, "execute", qstring_from_str("user_def_cmd"));
> +    qdict_put_str(req, "execute", "user_def_cmd");
>
>      resp = qmp_dispatch(&qmp_commands, QOBJECT(req));
>      assert(resp != NULL);
> @@ -111,7 +111,7 @@ static void test_dispatch_cmd_failure(void)
>      QDict *args = qdict_new();
>      QObject *resp;
>
> -    qdict_put(req, "execute", qstring_from_str("user_def_cmd2"));
> +    qdict_put_str(req, "execute", "user_def_cmd2");
>
>      resp = qmp_dispatch(&qmp_commands, QOBJECT(req));
>      assert(resp != NULL);
> @@ -122,10 +122,10 @@ static void test_dispatch_cmd_failure(void)
>
>      /* check that with extra arguments it throws an error */
>      req = qdict_new();
> -    qdict_put(args, "a", qint_from_int(66));
> +    qdict_put_int(args, "a", 66);
>      qdict_put(req, "arguments", args);
>
> -    qdict_put(req, "execute", qstring_from_str("user_def_cmd"));
> +    qdict_put_str(req, "execute", "user_def_cmd");
>
>      resp = qmp_dispatch(&qmp_commands, QOBJECT(req));
>      assert(resp != NULL);
> @@ -164,14 +164,14 @@ static void test_dispatch_cmd_io(void)
>      QDict *ret_dict_dict2, *ret_dict_dict2_userdef;
>      QInt *ret3;
>
> -    qdict_put(ud1a, "integer", qint_from_int(42));
> -    qdict_put(ud1a, "string", qstring_from_str("hello"));
> -    qdict_put(ud1b, "integer", qint_from_int(422));
> -    qdict_put(ud1b, "string", qstring_from_str("hello2"));
> +    qdict_put_int(ud1a, "integer", 42);
> +    qdict_put_str(ud1a, "string", "hello");
> +    qdict_put_int(ud1b, "integer", 422);
> +    qdict_put_str(ud1b, "string", "hello2");
>      qdict_put(args, "ud1a", ud1a);
>      qdict_put(args, "ud1b", ud1b);
>      qdict_put(req, "arguments", args);
> -    qdict_put(req, "execute", qstring_from_str("user_def_cmd2"));
> +    qdict_put_str(req, "execute", "user_def_cmd2");
>
>      ret = qobject_to_qdict(test_qmp_dispatch(req));
>
> @@ -190,9 +190,9 @@ static void test_dispatch_cmd_io(void)
>      assert(!strcmp(qdict_get_str(ret_dict_dict2, "string"), "blah4"));
>      QDECREF(ret);
>
> -    qdict_put(args3, "a", qint_from_int(66));
> +    qdict_put_int(args3, "a", 66);
>      qdict_put(req, "arguments", args3);
> -    qdict_put(req, "execute", qstring_from_str("guest-get-time"));
> +    qdict_put_str(req, "execute", "guest-get-time");
>
>      ret3 = qobject_to_qint(test_qmp_dispatch(req));
>      assert(qint_get_int(ret3) == 66);
> @@ -244,7 +244,7 @@ static void test_dealloc_partial(void)
>          Visitor *v;
>
>          ud2_dict = qdict_new();
> -        qdict_put(ud2_dict, "string0", qstring_from_str(text));
> +        qdict_put_str(ud2_dict, "string0", text);
>
>          v = qobject_input_visitor_new(QOBJECT(ud2_dict));
>          visit_type_UserDefTwo(v, NULL, &ud2, &err);
> diff --git a/tests/test-qmp-event.c b/tests/test-qmp-event.c
> index 7bb621b..4c0f096 100644
> --- a/tests/test-qmp-event.c
> +++ b/tests/test-qmp-event.c
> @@ -153,7 +153,7 @@ static void test_event_a(TestEventData *data,
>  {
>      QDict *d;
>      d = data->expect;
> -    qdict_put(d, "event", qstring_from_str("EVENT_A"));
> +    qdict_put_str(d, "event", "EVENT_A");
>      qapi_event_send_event_a(&error_abort);
>  }
>
> @@ -162,7 +162,7 @@ static void test_event_b(TestEventData *data,
>  {
>      QDict *d;
>      d = data->expect;
> -    qdict_put(d, "event", qstring_from_str("EVENT_B"));
> +    qdict_put_str(d, "event", "EVENT_B");
>      qapi_event_send_event_b(&error_abort);
>  }
>
> @@ -177,16 +177,16 @@ static void test_event_c(TestEventData *data,
>      b.has_enum1 = false;
>
>      d_b = qdict_new();
> -    qdict_put(d_b, "integer", qint_from_int(2));
> -    qdict_put(d_b, "string", qstring_from_str("test1"));
> +    qdict_put_int(d_b, "integer", 2);
> +    qdict_put_str(d_b, "string", "test1");
>
>      d_data = qdict_new();
> -    qdict_put(d_data, "a", qint_from_int(1));
> +    qdict_put_int(d_data, "a", 1);
>      qdict_put(d_data, "b", d_b);
> -    qdict_put(d_data, "c", qstring_from_str("test2"));
> +    qdict_put_str(d_data, "c", "test2");
>
>      d = data->expect;
> -    qdict_put(d, "event", qstring_from_str("EVENT_C"));
> +    qdict_put_str(d, "event", "EVENT_C");
>      qdict_put(d, "data", d_data);
>
>      qapi_event_send_event_c(true, 1, true, &b, "test2", &error_abort);
> @@ -213,22 +213,22 @@ static void test_event_d(TestEventData *data,
>      a.enum2 = ENUM_ONE_VALUE2;
>
>      d_struct1 = qdict_new();
> -    qdict_put(d_struct1, "integer", qint_from_int(2));
> -    qdict_put(d_struct1, "string", qstring_from_str("test1"));
> -    qdict_put(d_struct1, "enum1", qstring_from_str("value1"));
> +    qdict_put_int(d_struct1, "integer", 2);
> +    qdict_put_str(d_struct1, "string", "test1");
> +    qdict_put_str(d_struct1, "enum1", "value1");
>
>      d_a = qdict_new();
>      qdict_put(d_a, "struct1", d_struct1);
> -    qdict_put(d_a, "string", qstring_from_str("test2"));
> -    qdict_put(d_a, "enum2", qstring_from_str("value2"));
> +    qdict_put_str(d_a, "string", "test2");
> +    qdict_put_str(d_a, "enum2", "value2");
>
>      d_data = qdict_new();
>      qdict_put(d_data, "a", d_a);
> -    qdict_put(d_data, "b", qstring_from_str("test3"));
> -    qdict_put(d_data, "enum3", qstring_from_str("value3"));
> +    qdict_put_str(d_data, "b", "test3");
> +    qdict_put_str(d_data, "enum3", "value3");
>
>      d = data->expect;
> -    qdict_put(d, "event", qstring_from_str("EVENT_D"));
> +    qdict_put_str(d, "event", "EVENT_D");
>      qdict_put(d, "data", d_data);
>
>      qapi_event_send_event_d(&a, "test3", false, NULL, true, ENUM_ONE_VALUE3,
> diff --git a/tests/test-qobject-output-visitor.c b/tests/test-qobject-output-visitor.c
> index c213fce..94b9518 100644
> --- a/tests/test-qobject-output-visitor.c
> +++ b/tests/test-qobject-output-visitor.c
> @@ -343,9 +343,9 @@ static void test_visitor_out_any(TestOutputVisitorData *data,
>
>      visitor_reset(data);
>      qdict = qdict_new();
> -    qdict_put(qdict, "integer", qint_from_int(-42));
> -    qdict_put(qdict, "boolean", qbool_from_bool(true));
> -    qdict_put(qdict, "string", qstring_from_str("foo"));
> +    qdict_put_int(qdict, "integer", -42);
> +    qdict_put_bool(qdict, "boolean", true);
> +    qdict_put_str(qdict, "string", "foo");
>      qobj = QOBJECT(qdict);
>      visit_type_any(data->ov, NULL, &qobj, &error_abort);
>      qobject_decref(qobj);
>
