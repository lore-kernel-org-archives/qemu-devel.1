Received: from eggs.gnu.org ([2001:4830:134:3::10]:43231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dVM1s-0000Hp-Bk
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 14:06:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dVM1o-0007cT-C6
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 14:06:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34136)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dVM1o-0007bs-1s
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 14:06:24 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6CI3hUe018522
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 14:06:20 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bnndjh44k-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 14:06:20 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 12 Jul 2017 19:06:18 +0100
References: <20170711004303.3902-1-ehabkost@redhat.com>
	<20170711004303.3902-3-ehabkost@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 12 Jul 2017 20:06:14 +0200
MIME-Version: 1.0
In-Reply-To: <20170711004303.3902-3-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <6c43bf15-772e-2f8c-737c-6789d8ae28f2@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] test-qdev-global-props: Test global
 property ordering
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Greg Kurz <groug@kaod.org>



On 07/11/2017 02:43 AM, Eduardo Habkost wrote:
> Test case to detect the bug fixed by commit
> "qdev: fix the order compat and global properties are applied".
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>

Please see below nevertheless.

> ---
>  tests/test-qdev-global-props.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/tests/test-qdev-global-props.c b/tests/test-qdev-global-props.c
> index 48e5b73..ef2951f 100644
> --- a/tests/test-qdev-global-props.c
> +++ b/tests/test-qdev-global-props.c
> @@ -33,6 +33,8 @@
>  #define STATIC_TYPE(obj) \
>      OBJECT_CHECK(MyType, (obj), TYPE_STATIC_PROPS)
> 
> +#define TYPE_SUBCLASS "static_prop_subtype"
> +
>  #define PROP_DEFAULT 100
> 
>  typedef struct MyType {
> @@ -63,6 +65,11 @@ static const TypeInfo static_prop_type = {
>      .class_init = static_prop_class_init,
>  };
> 
> +static const TypeInfo subclass_type = {
> +    .name = TYPE_SUBCLASS,
> +    .parent = TYPE_STATIC_PROPS,
> +};
> +
>  /* Test simple static property setting to default value */
>  static void test_static_prop_subprocess(void)
>  {
> @@ -279,12 +286,35 @@ static void test_dynamic_globalprop_nouser(void)
>      g_test_trap_assert_stdout("");
>  }
> 
> +/* Test if global props affecting subclasses are applied in the right order */

Now that I think about it this is affecting an  external and
(end-)user facing interface. You say this is the right order.
Based on what is this the right order? Do we need to update some
documentation too?

I've checked out the user manual. There we talk about 'driver' but
I could not find a spot where 'driver' is explained.

If I would have to translate between user manual terminology and
code terminology, I would say a driver is a not abstract class
inheriting from device. If that's right I wonder if it should
be allowed for a non-abstract class inheriting from device to
inherit form another non-abstract class.

Another question is -global with an abstract class seems to be
accepted on the command line. Is that an undocumented feature?

Sorry for expanding the front. I also trying to figure out the design
for my own benefit.

Regards,
Halil 


> +static void test_subclass_global_props(void)
> +{
> +    MyType *mt;
> +    /* Global properties must be applied in the order they were registered */
> +    static GlobalProperty props[] = {
> +        { TYPE_STATIC_PROPS, "prop1", "101" },
> +        { TYPE_SUBCLASS,     "prop1", "102" },
> +        { TYPE_SUBCLASS,     "prop2", "103" },
> +        { TYPE_STATIC_PROPS, "prop2", "104" },
> +        {}
> +    };
> +
> +    qdev_prop_register_global_list(props);
> +
> +    mt = STATIC_TYPE(object_new(TYPE_SUBCLASS));
> +    qdev_init_nofail(DEVICE(mt));
> +
> +    g_assert_cmpuint(mt->prop1, ==, 102);
> +    g_assert_cmpuint(mt->prop2, ==, 104);
> +}
> +
>  int main(int argc, char **argv)
>  {
>      g_test_init(&argc, &argv, NULL);
> 
>      module_call_init(MODULE_INIT_QOM);
>      type_register_static(&static_prop_type);
> +    type_register_static(&subclass_type);
>      type_register_static(&dynamic_prop_type);
>      type_register_static(&hotplug_type);
>      type_register_static(&nohotplug_type);
> @@ -310,6 +340,9 @@ int main(int argc, char **argv)
>      g_test_add_func("/qdev/properties/dynamic/global/nouser",
>                      test_dynamic_globalprop_nouser);
> 
> +    g_test_add_func("/qdev/properties/global/subclass",
> +                    test_subclass_global_props);
> +
>      g_test_run();
> 
>      return 0;
> 
