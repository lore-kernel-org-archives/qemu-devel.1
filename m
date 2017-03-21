Received: from eggs.gnu.org ([2001:4830:134:3::10]:54309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cqBdQ-0005Il-27
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 00:43:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cqBdM-0001dO-0c
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 00:43:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50563)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cqBdL-0001cm-Mf
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 00:42:59 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2L4gsil022521
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 00:42:58 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29ajjrced3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 00:42:57 -0400
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 20 Mar 2017 22:42:57 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170321031705.22291-2-eblake@redhat.com>
References: <20170321031705.22291-1-eblake@redhat.com>
	<20170321031705.22291-2-eblake@redhat.com>
Date: Mon, 20 Mar 2017 23:41:17 -0500
Message-Id: <149007127725.3910.239772564194924569@loki>
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
Cc: armbru@redhat.com, lvivier@redhat.com

Quoting Eric Blake (2017-03-20 22:17:04)
> Commit 15c2f669e broke the ability of the QemuOpts visitor to
> flag extra input parameters, but the regression went unnoticed
> because of missing testsuite coverage.  Add a test to cover this.
> =

> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>

> ---
>  tests/test-opts-visitor.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> =

> diff --git a/tests/test-opts-visitor.c b/tests/test-opts-visitor.c
> index 2238f8e..a47c344 100644
> --- a/tests/test-opts-visitor.c
> +++ b/tests/test-opts-visitor.c
> @@ -247,6 +247,24 @@ test_opts_range_beyond(void)
>      qemu_opts_del(opts);
>  }
> =

> +static void
> +test_opts_dict_unvisited(void)
> +{
> +    QemuOpts *opts;
> +    Visitor *v;
> +    UserDefOptions *userdef;
> +
> +    opts =3D qemu_opts_parse(qemu_find_opts("userdef"), "i64x=3D0,bogus=
=3D1", false,
> +                           &error_abort);
> +
> +    v =3D opts_visitor_new(opts);
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
> =

> +    g_test_add_func("/visitor/opts/dict/unvisited", test_opts_dict_unvis=
ited);
> +
>      g_test_run();
>      return 0;
>  }
> -- =

> 2.9.3
>=20
