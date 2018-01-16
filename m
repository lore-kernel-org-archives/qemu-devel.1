Received: from eggs.gnu.org ([2001:4830:134:3::10]:59940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ebR7t-0004W5-6A
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:18:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ebR7n-0008Tg-EH
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:18:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ebR7n-0008Sz-8L
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:17:59 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5D80C5AFED
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 13:17:58 +0000 (UTC)
Date: Tue, 16 Jan 2018 14:17:54 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180116141754.106c8eaf@redhat.com>
In-Reply-To: <20180116061242-mutt-send-email-mst@kernel.org>
References: <1514560602-280058-1-git-send-email-imammedo@redhat.com>
	<1514560602-280058-6-git-send-email-imammedo@redhat.com>
	<20180116061242-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

On Tue, 16 Jan 2018 06:16:34 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Fri, Dec 29, 2017 at 04:16:42PM +0100, Igor Mammedov wrote:
> > It turns out that FADT isn't actually tested for changes
> > against reference table, since it happens to be the 1st
> > table in RSDT which is currently ignored.
> > Fix it by making sure that all tables from RSDT are added
> > to test list.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>  
> 
> This was intentional, wasn't it?
> The reason IIRC was that FADT includes things like the DSDT
> address which can change at any time.
> 
> So I think we'll have to tweak the FADT to compare it.
> 
> E.g. replace any non-zero pointer with a known pattern,
> and fix up the checksum.
> 
> What do you think?
allocated pointers seem to be stable within a BIOS,
but bios update might change that, so you are right.

Perhaps we can just zero out pointers and checksum
in the table when comparing/dumping it
(if isal is fine with it).

So, pls take the rest of the series modulo this
patch which I'll fix/respin to handle pointers.

> 
> > ---
> >  tests/bios-tables-test.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> > index 81c558e..c5dccdb 100644
> > --- a/tests/bios-tables-test.c
> > +++ b/tests/bios-tables-test.c
> > @@ -248,14 +248,14 @@ static void test_acpi_dsdt_table(test_data *data)
> >  /* Load all tables and add to test list directly RSDT referenced tables */
> >  static void fetch_rsdt_referenced_tables(test_data *data)
> >  {
> > -    int tables_nr = data->rsdt_tables_nr - 1; /* fadt is first */
> > +    int tables_nr = data->rsdt_tables_nr;
> >      int i;
> >  
> >      for (i = 0; i < tables_nr; i++) {
> >          AcpiSdtTable ssdt_table;
> >          uint32_t addr;
> >  
> > -        addr = le32_to_cpu(data->rsdt_tables_addr[i + 1]); /* fadt is first */
> > +        addr = le32_to_cpu(data->rsdt_tables_addr[i]);
> >          fetch_table(&ssdt_table, addr);
> >  
> >          /* Add table to ASL test tables list */
> > -- 
> > 2.7.4  
> 
