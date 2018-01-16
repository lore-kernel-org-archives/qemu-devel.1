Received: from eggs.gnu.org ([2001:4830:134:3::10]:41366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ebIfv-0006V2-Dg
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 23:16:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ebIfs-0001Vy-9I
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 23:16:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43213)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ebIfs-0001Vs-2Z
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 23:16:36 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 25F791662
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 04:16:35 +0000 (UTC)
Date: Tue, 16 Jan 2018 06:16:34 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180116061242-mutt-send-email-mst@kernel.org>
References: <1514560602-280058-1-git-send-email-imammedo@redhat.com>
	<1514560602-280058-6-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1514560602-280058-6-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/5] tests: acpi: fix FADT not being
 compared to reference table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>

On Fri, Dec 29, 2017 at 04:16:42PM +0100, Igor Mammedov wrote:
> It turns out that FADT isn't actually tested for changes
> against reference table, since it happens to be the 1st
> table in RSDT which is currently ignored.
> Fix it by making sure that all tables from RSDT are added
> to test list.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

This was intentional, wasn't it?
The reason IIRC was that FADT includes things like the DSDT
address which can change at any time.

So I think we'll have to tweak the FADT to compare it.

E.g. replace any non-zero pointer with a known pattern,
and fix up the checksum.

What do you think?

> ---
>  tests/bios-tables-test.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index 81c558e..c5dccdb 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -248,14 +248,14 @@ static void test_acpi_dsdt_table(test_data *data)
>  /* Load all tables and add to test list directly RSDT referenced tables */
>  static void fetch_rsdt_referenced_tables(test_data *data)
>  {
> -    int tables_nr = data->rsdt_tables_nr - 1; /* fadt is first */
> +    int tables_nr = data->rsdt_tables_nr;
>      int i;
>  
>      for (i = 0; i < tables_nr; i++) {
>          AcpiSdtTable ssdt_table;
>          uint32_t addr;
>  
> -        addr = le32_to_cpu(data->rsdt_tables_addr[i + 1]); /* fadt is first */
> +        addr = le32_to_cpu(data->rsdt_tables_addr[i]);
>          fetch_table(&ssdt_table, addr);
>  
>          /* Add table to ASL test tables list */
> -- 
> 2.7.4
