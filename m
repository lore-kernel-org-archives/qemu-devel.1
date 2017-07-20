Received: from eggs.gnu.org ([2001:4830:134:3::10]:52332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dYEYn-0002Yb-7S
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 12:44:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dYEYm-0004eo-4t
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 12:44:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dYEYl-0004eH-Uw
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 12:44:20 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DA89A12B6
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 16:44:18 +0000 (UTC)
Date: Thu, 20 Jul 2017 17:44:10 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170720164410.GO21566@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170720163536.26183-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170720163536.26183-1-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] tests/bios-tables-test: Compiler warning
 fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, imammedo@redhat.com

On Thu, Jul 20, 2017 at 05:35:36PM +0100, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> gcc 7.1.1 in fedora 26 moans about the:
>    tables = g_new0(uint32_t, tables_nr)
> 
> because it can't convince itself that tables_nr is positive.
> This is fallout from g_assert_cmpint no longer necessarily being
> no-return;  replace it with a plain g_assert.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  tests/bios-tables-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index 63da978f0b..564da45f65 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -108,7 +108,7 @@ static void test_acpi_rsdt_table(test_data *data)
>      /* compute the table entries in rsdt */
>      tables_nr = (rsdt_table->length - sizeof(AcpiRsdtDescriptorRev1)) /
>                  sizeof(uint32_t);
> -    g_assert_cmpint(tables_nr, >, 0);
> +    g_assert(tables_nr > 0);

IMHO your original patch was better - rsdt_table->length is an
uint32_t, and sizeof() evaluates to size_t, but we're assigning
to a local  tables_nr that is a signed int. So tables_nr would
be better declared as size_t.  That would mean the assert can
just be removed entirely, or replaced by an assert that
rsdt_table->length > sizeof(AcpiRsdtDescriptorRev1) if we're
concerned about that


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
