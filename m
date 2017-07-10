Received: from eggs.gnu.org ([2001:4830:134:3::10]:45502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dUTmL-000334-Mn
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 04:10:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dUTmI-0000E3-Hm
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 04:10:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dUTmI-0000Dn-7V
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 04:10:46 -0400
Date: Mon, 10 Jul 2017 10:10:41 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170710101041.553a792a@nial.brq.redhat.com>
In-Reply-To: <20170707213052.13087-2-ehabkost@redhat.com>
References: <20170707213052.13087-1-ehabkost@redhat.com>
	<20170707213052.13087-2-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] tests: Test case for
 object_resolve_path*()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Andreas =?UTF-8?B?RsOkcmJlcg==?= <afaerber@suse.de>

On Fri,  7 Jul 2017 18:30:51 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> Test for partial path lookup using object_resolve_path*().
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  tests/check-qom-proplist.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/tests/check-qom-proplist.c b/tests/check-qom-proplist.c
> index 8e432e9..abafbd7 100644
> --- a/tests/check-qom-proplist.c
> +++ b/tests/check-qom-proplist.c
> @@ -568,6 +568,46 @@ static void test_dummy_delchild(void)
>      object_unparent(OBJECT(dev));
>  }
>  
> +static void test_qom_partial_path(void)
> +{
> +    Object *root  = object_get_objects_root();
> +    Object *cont1 = container_get(root, "/cont1");
> +    Object *obj1  = object_new(TYPE_DUMMY);
> +    Object *obj2a = object_new(TYPE_DUMMY);
> +    Object *obj2b = object_new(TYPE_DUMMY);
> +    bool ambiguous;
> +
> +    /* Objects created:
> +     * /cont1
> +     * /cont1/obj1
> +     * /cont1/obj2 (obj2a)
> +     * /obj2 (obj2b)
> +     */
> +    object_property_add_child(cont1, "obj1", obj1, &error_abort);
> +    object_unref(obj1);
> +    object_property_add_child(cont1, "obj2", obj2a, &error_abort);
> +    object_unref(obj2a);
> +    object_property_add_child(root,  "obj2", obj2b, &error_abort);
> +    object_unref(obj2b);
> +
> +    ambiguous = false;
> +    g_assert(!object_resolve_path_type("", TYPE_DUMMY, &ambiguous));
> +    g_assert(ambiguous);
> +
> +    ambiguous = false;
> +    g_assert(!object_resolve_path("obj2", &ambiguous));
> +    g_assert(ambiguous);
> +
> +    ambiguous = false;
> +    g_assert(object_resolve_path("obj1", &ambiguous) == obj1);
> +    g_assert(!ambiguous);

I'd also add test case for
  object_resolve_path(..., NULL)

> +
> +    object_unparent(obj1);
> +    object_unparent(obj2a);
> +    object_unparent(obj2b);
Are above unparenting is necessary?

> +    object_unparent(cont1);
Wouldn't parent destruction sufficient to trigger
implicit destruction of children?

> +}
> +
>  int main(int argc, char **argv)
>  {
>      g_test_init(&argc, &argv, NULL);
> @@ -585,6 +625,7 @@ int main(int argc, char **argv)
>      g_test_add_func("/qom/proplist/getenum", test_dummy_getenum);
>      g_test_add_func("/qom/proplist/iterator", test_dummy_iterator);
>      g_test_add_func("/qom/proplist/delchild", test_dummy_delchild);
> +    g_test_add_func("/qom/resolve/partial", test_qom_partial_path);
>  
>      return g_test_run();
>  }
