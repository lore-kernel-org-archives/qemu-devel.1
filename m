Received: from eggs.gnu.org ([2001:4830:134:3::10]:51178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cqFg6-00014I-OU
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 05:02:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cqFg3-0001pL-Nw
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 05:02:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46260)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1cqFg3-0001ot-HB
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 05:02:03 -0400
References: <20170321031705.22291-1-eblake@redhat.com>
	<20170321031705.22291-2-eblake@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <fb42e59d-f196-84a3-420f-dc488ef62c53@redhat.com>
Date: Tue, 21 Mar 2017 10:01:59 +0100
MIME-Version: 1.0
In-Reply-To: <20170321031705.22291-2-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] tests: Expose regression in QemuOpts
 visitor
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

On 21/03/2017 04:17, Eric Blake wrote:
> Commit 15c2f669e broke the ability of the QemuOpts visitor to
> flag extra input parameters, but the regression went unnoticed
> because of missing testsuite coverage.  Add a test to cover this.

I don't know where I'm wrong, but when I run this test without the fix
it never fails.

Laurent

> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/test-opts-visitor.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/tests/test-opts-visitor.c b/tests/test-opts-visitor.c
> index 2238f8e..a47c344 100644
> --- a/tests/test-opts-visitor.c
> +++ b/tests/test-opts-visitor.c
> @@ -247,6 +247,24 @@ test_opts_range_beyond(void)
>      qemu_opts_del(opts);
>  }
> 
> +static void
> +test_opts_dict_unvisited(void)
> +{
> +    QemuOpts *opts;
> +    Visitor *v;
> +    UserDefOptions *userdef;
> +
> +    opts = qemu_opts_parse(qemu_find_opts("userdef"), "i64x=0,bogus=1", false,
> +                           &error_abort);
> +
> +    v = opts_visitor_new(opts);
> +    /* FIXME: bogus should be diagnosed */
> +    visit_type_UserDefOptions(v, NULL, &userdef, &error_abort);
> +    visit_free(v);
> +    qemu_opts_del(opts);
> +    qapi_free_UserDefOptions(userdef);
> +}
> +
>  int
>  main(int argc, char **argv)
>  {
> @@ -343,6 +361,8 @@ main(int argc, char **argv)
>      g_test_add_func("/visitor/opts/range/beyond",
>                      test_opts_range_beyond);
> 
> +    g_test_add_func("/visitor/opts/dict/unvisited", test_opts_dict_unvisited);
> +
>      g_test_run();
>      return 0;
>  }
> 
