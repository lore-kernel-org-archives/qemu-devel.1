Received: from eggs.gnu.org ([2001:4830:134:3::10]:43692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eFMS2-0006gO-Jv
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 10:51:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eFMRx-0002Hn-P7
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 10:51:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eFMRx-0002H0-Ip
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 10:51:33 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 924975F176
	for <qemu-devel@nongnu.org>; Thu, 16 Nov 2017 15:51:32 +0000 (UTC)
Date: Thu, 16 Nov 2017 17:51:31 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171116174858-mutt-send-email-mst@kernel.org>
References: <20171018131456.17536-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171018131456.17536-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] test: fix detection of errors from iasl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org

On Wed, Oct 18, 2017 at 02:14:56PM +0100, Daniel P. Berrange wrote:
> The conditional looking for errors while loading asl files would ignore
> errors from loading the expected data, if the actual data succeeded.
> 
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Problem is, some systems have a broken iasl.  If we can't load expected
data, qemu isn't broken, iasl is, so the test should pass.

I applied this in error, I've reverted this patch now.

> ---
>  tests/bios-tables-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index ee441f1e17..be05e8bcc2 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -458,7 +458,7 @@ static void test_acpi_asl(test_data *data)
>          exp_asl = normalize_asl(exp_sdt->asl);
>  
>          /* TODO: check for warnings */
> -        g_assert(!err || exp_err);
> +        g_assert(!err && !exp_err);
>  
>          if (g_strcmp0(asl->str, exp_asl->str)) {
>              if (exp_err) {
> -- 
> 2.13.6
