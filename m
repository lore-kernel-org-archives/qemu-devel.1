Received: from eggs.gnu.org ([2001:4830:134:3::10]:54948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dkUE7-0007Ze-6u
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 07:53:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dkUE2-00046t-Bm
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 07:53:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58828)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dkUE2-000463-5F
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 07:53:34 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0B44081DEC
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 11:53:33 +0000 (UTC)
Date: Wed, 23 Aug 2017 12:53:27 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170823115327.GC2648@work-vm>
References: <20170823083901.852-1-quintela@redhat.com>
	<20170823083901.852-3-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170823083901.852-3-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] tests: Make acpid test compile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com, pbonzini@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> Compiler gets confused with the size of the struct, so move form
> g_new0() to g_malloc0().
> 
> I *think* that the problem is in gcc (or glib for that matter), but
> the documentation of the g_new0 states that 1sts first argument is an
> struct type, and uint32_t is not an struct type.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  tests/vmgenid-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/vmgenid-test.c b/tests/vmgenid-test.c
> index 3d5c1c3615..032e1d465a 100644
> --- a/tests/vmgenid-test.c
> +++ b/tests/vmgenid-test.c
> @@ -67,7 +67,7 @@ static uint32_t acpi_find_vgia(void)
>      g_assert_cmpint(tables_nr, >, 0);
>  
>      /* get the addresses of the tables pointed by rsdt */
> -    tables = g_new0(uint32_t, tables_nr);
> +    tables = g_malloc0(sizeof(uint32_t) * tables_nr);

I think there's an easier fix for this I think;
try:

-    g_assert_cmpint(tables_nr, >, 0);
+    g_assert(tables_nr > 0);

Dave

>      ACPI_READ_ARRAY_PTR(tables, tables_nr, rsdt);
>  
>      for (i = 0; i < tables_nr; i++) {
> -- 
> 2.13.5
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
