Received: from eggs.gnu.org ([2001:4830:134:3::10]:45746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fpurc-0007sI-BA
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 08:25:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fpurY-0008UX-KG
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 08:25:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50966 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fpurY-0008Pg-9j
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 08:25:20 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1534258018-22859-1-git-send-email-thuth@redhat.com>
	<1534258018-22859-7-git-send-email-thuth@redhat.com>
Date: Wed, 15 Aug 2018 14:25:16 +0200
In-Reply-To: <1534258018-22859-7-git-send-email-thuth@redhat.com> (Thomas
	Huth's message of "Tue, 14 Aug 2018 16:46:58 +0200")
Message-ID: <871sazlsur.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 6/6] tests/device-introspect: Test with all
 machines, not only with "none"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Juan Quintela <quintela@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Thomas Huth <thuth@redhat.com> writes:

> Certain device introspection crashes used to only happen if you were
> using a certain machine, e.g. if the machine was using serial_hd() or
> nd_table[], and a device was trying to use these in its instance_init
> function, too.
>
> To be able to catch these problems, let's extend the device-introspect
> test to check the devices on all machine types. Since this is a rather
> slow operation, and most of the problems are already handled by testing
> with the "none" machine only, the test with all machines is only run
> in the "make check SPEED=slow" mode.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/device-introspect-test.c | 32 +++++++++++++++++++++++++++++---
>  1 file changed, 29 insertions(+), 3 deletions(-)
>
> diff --git a/tests/device-introspect-test.c b/tests/device-introspect-test.c
> index 5b7ec05..902153c 100644
> --- a/tests/device-introspect-test.c
> +++ b/tests/device-introspect-test.c
> @@ -221,13 +221,13 @@ static void test_device_intro_abstract(void)
>      qtest_end();
>  }
>  
> -static void test_device_intro_concrete(void)
> +static void test_device_intro_concrete(const void *args)
>  {
>      QList *types;
>      QListEntry *entry;
>      const char *type;
>  
> -    qtest_start(common_args);
> +    qtest_start(args);
>      types = device_type_list(false);
>  
>      QLIST_FOREACH_ENTRY(types, entry) {
> @@ -239,6 +239,7 @@ static void test_device_intro_concrete(void)
>  
>      qobject_unref(types);
>      qtest_end();
> +    g_free((void *)args);
>  }
>  
>  static void test_abstract_interfaces(void)
> @@ -275,6 +276,26 @@ static void test_abstract_interfaces(void)
>      qtest_end();
>  }
>  
> +static void add_machine_test_case(const char *mname)
> +{
> +    char *path, *args;
> +
> +    /* Ignore blacklisted machines */
> +    if (g_str_equal("xenfv", mname) || g_str_equal("xenpv", mname)) {
> +        return;
> +    }
> +
> +    path = g_strdup_printf("device/introspect/concrete/defaults/%s", mname);
> +    args = g_strdup_printf("-M %s", mname);
> +    qtest_add_data_func(path, args, test_device_intro_concrete);
> +    g_free(path);
> +
> +    path = g_strdup_printf("device/introspect/concrete/nodefaults/%s", mname);
> +    args = g_strdup_printf("-nodefaults -M %s", mname);
> +    qtest_add_data_func(path, args, test_device_intro_concrete);
> +    g_free(path);
> +}

If !g_test_quick(), we test each machine type (mentioned in commit
message) with and without -nodefaults (not mentioned).  Please explain
that more completely in your commit message.

You allocate @path and @args here, and free @path here, but @args in
test_device_intro_concrete() is slightly awkward.  I'd be tempted to try
using fixtures.  Not a demand; what you got works.

Hmm, can we pass just @mname to the GTestDataFunc, then allocate and
free @args there?  Nope, @mname doesn't stay alive until that function
runs.

> +
>  int main(int argc, char **argv)
>  {
>      g_test_init(&argc, &argv, NULL);
> @@ -283,8 +304,13 @@ int main(int argc, char **argv)
>      qtest_add_func("device/introspect/list-fields", test_qom_list_fields);
>      qtest_add_func("device/introspect/none", test_device_intro_none);
>      qtest_add_func("device/introspect/abstract", test_device_intro_abstract);
> -    qtest_add_func("device/introspect/concrete", test_device_intro_concrete);
>      qtest_add_func("device/introspect/abstract-interfaces", test_abstract_interfaces);
> +    if (g_test_quick()) {
> +        qtest_add_data_func("device/introspect/concrete/defaults/none",
> +                            g_strdup(common_args), test_device_intro_concrete);

Suggest to break this line at the comma.

> +    } else {
> +        qtest_cb_for_every_machine(add_machine_test_case);
> +    }
>  
>      return g_test_run();
>  }

With at least the commit message improved:
Reviewed-by: Markus Armbruster <armbru@redhat.com>
