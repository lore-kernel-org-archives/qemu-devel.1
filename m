Received: from eggs.gnu.org ([2001:4830:134:3::10]:42172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gMxvX-00053G-Jw
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 11:22:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gMxvT-0006Tu-K2
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 11:22:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gMxvR-0005iz-Uq
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 11:21:59 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181109110221.10553-1-david@redhat.com>
	<20181109110221.10553-6-david@redhat.com>
Date: Wed, 14 Nov 2018 17:21:30 +0100
In-Reply-To: <20181109110221.10553-6-david@redhat.com> (David Hildenbrand's
	message of "Fri, 9 Nov 2018 12:02:20 +0100")
Message-ID: <87h8gjocj9.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC 5/6] test-string-input-visitor: split
 off uint64 list tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

David Hildenbrand <david@redhat.com> writes:

> Basically copy all int64 list tests but adapt them to work on uint64
> instead.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  tests/test-string-input-visitor.c | 71 +++++++++++++++++++++++++++++--
>  1 file changed, 67 insertions(+), 4 deletions(-)
>
> diff --git a/tests/test-string-input-visitor.c b/tests/test-string-input-visitor.c
> index 2f6360e9ca..731094f789 100644
> --- a/tests/test-string-input-visitor.c
> +++ b/tests/test-string-input-visitor.c
> @@ -111,7 +111,6 @@ static void test_visitor_in_intList(TestInputVisitorData *data,
>                            6, 7, 8 };
>      int64_t expect2[] = { 32767, -32768, -32767 };
>      int64_t expect3[] = { INT64_MIN, INT64_MAX };
> -    uint64_t expect4[] = { UINT64_MAX };
>      Error *err = NULL;
>      int64List *res = NULL;
>      Visitor *v;
> @@ -129,9 +128,6 @@ static void test_visitor_in_intList(TestInputVisitorData *data,
>                                  "-9223372036854775808,9223372036854775807");
>      check_ilist(v, expect3, ARRAY_SIZE(expect3));
>  
> -    v = visitor_input_test_init(data, "18446744073709551615");
> -    check_ulist(v, expect4, ARRAY_SIZE(expect4));
> -

Hmm.  Testing behavior for this input is still worthwhile, isn't it?

The use of check_ulist() here is admittedly unclean.

>      /* Empty list */
>  
>      v = visitor_input_test_init(data, "");
> @@ -174,6 +170,71 @@ static void test_visitor_in_intList(TestInputVisitorData *data,
>      visit_end_list(v, NULL);
>  }
>  
> +static void test_visitor_in_uintList(TestInputVisitorData *data,
> +                                     const void *unused)
> +{
> +    uint64_t expect1[] = { 1, 2, 0, 2, 3, 4, 20, 5, 6, 7, 8, 9, 1, 2, 3, 4, 5,

Please wrap this line a bit earlier.

> +                           6, 7, 8 };
> +    uint64_t expect2[] = { 32767, -32768, -32767 };
> +    uint64_t expect3[] = { UINT64_MAX };
> +    Error *err = NULL;
> +    uint64List *res = NULL;
> +    Visitor *v;
> +    uint64_t val;
> +
> +    /* Valid lists */
> +
> +    v = visitor_input_test_init(data, "1,2,0,2-4,20,5-9,1-8");
> +    check_ulist(v, expect1, ARRAY_SIZE(expect1));
> +
> +    v = visitor_input_test_init(data, "32767,-32768--32767");
> +    check_ulist(v, expect2, ARRAY_SIZE(expect2));
> +
> +    v = visitor_input_test_init(data, "18446744073709551615");
> +    check_ulist(v, expect3, ARRAY_SIZE(expect3));

Test behavior for large negative numbers?

> +
> +    /* Empty list */
> +
> +    v = visitor_input_test_init(data, "");
> +    visit_type_uint64List(v, NULL, &res, &error_abort);
> +    g_assert(!res);
> +
> +    /* Not a list */
> +
> +    v = visitor_input_test_init(data, "not an uint list");
> +
> +    visit_type_uint64List(v, NULL, &res, &err);
> +    error_free_or_abort(&err);
> +    g_assert(!res);
> +
> +    /* Unvisited list tail */
> +
> +    v = visitor_input_test_init(data, "0,2-3");
> +
> +    visit_start_list(v, NULL, NULL, 0, &error_abort);
> +    visit_type_uint64(v, NULL, &val, &error_abort);
> +    g_assert_cmpuint(val, ==, 0);
> +    visit_type_uint64(v, NULL, &val, &error_abort);
> +    g_assert_cmpuint(val, ==, 2);
> +
> +    visit_check_list(v, &err);
> +    error_free_or_abort(&err);
> +    visit_end_list(v, NULL);
> +
> +    /* Visit beyond end of list */
> +
> +    v = visitor_input_test_init(data, "0");
> +
> +    visit_start_list(v, NULL, NULL, 0, &error_abort);
> +    visit_type_uint64(v, NULL, &val, &err);
> +    g_assert_cmpuint(val, ==, 0);
> +    visit_type_uint64(v, NULL, &val, &err);
> +    error_free_or_abort(&err);
> +
> +    visit_check_list(v, &error_abort);
> +    visit_end_list(v, NULL);
> +}
> +
>  static void test_visitor_in_bool(TestInputVisitorData *data,
>                                   const void *unused)
>  {
> @@ -334,6 +395,8 @@ int main(int argc, char **argv)
>                             &in_visitor_data, test_visitor_in_int);
>      input_visitor_test_add("/string-visitor/input/intList",
>                             &in_visitor_data, test_visitor_in_intList);
> +    input_visitor_test_add("/string-visitor/input/uintList",
> +                           &in_visitor_data, test_visitor_in_uintList);
>      input_visitor_test_add("/string-visitor/input/bool",
>                             &in_visitor_data, test_visitor_in_bool);
>      input_visitor_test_add("/string-visitor/input/number",
