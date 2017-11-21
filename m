Received: from eggs.gnu.org ([2001:4830:134:3::10]:54951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eH8Zh-00036i-FP
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 08:26:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eH8Zd-0006bK-Gj
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 08:26:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39786)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eH8Zd-0006aj-7H
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 08:26:49 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 42D683A251
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 13:26:48 +0000 (UTC)
Date: Tue, 21 Nov 2017 14:26:39 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171121142639.3e6d2e79@redhat.com>
In-Reply-To: <20171120223048-mutt-send-email-mst@kernel.org>
References: <1510834622-28800-1-git-send-email-thuth@redhat.com>
	<20171120175522.76bf71c3@redhat.com>
	<20171120223048-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] tests/bios-tables-test: Fix endianess
 problems when passing data to iasl
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

On Mon, 20 Nov 2017 22:32:29 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Nov 20, 2017 at 05:55:22PM +0100, Igor Mammedov wrote:
> > On Thu, 16 Nov 2017 13:17:02 +0100
> > Thomas Huth <thuth@redhat.com> wrote:
> >   
> > > The bios-tables-test was writing out files that we pass to iasl in
> > > with the wrong endianness in the header when running on a big endian
> > > host. So instead of storing mixed endian information in our structures,
> > > let's keep everything in little endian and byte-swap it only when we
> > > need a value in the code.
> > > 
> > > Reported-by: Daniel P. Berrange <berrange@redhat.com>
> > > Buglink: https://bugs.launchpad.net/qemu/+bug/1724570
> > > Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> > > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > > ---
> > >  v2: Fixed vmgenid-test which was accidentially broken in v1
> > > 
> > >  tests/acpi-utils.h       | 27 +++++----------------------
> > >  tests/bios-tables-test.c | 42 ++++++++++++++++++++++--------------------
> > >  tests/vmgenid-test.c     | 22 ++++++++++++----------
> > >  3 files changed, 39 insertions(+), 52 deletions(-)
> > > 
> > > diff --git a/tests/acpi-utils.h b/tests/acpi-utils.h
> > > index f8d8723..d5ca5b6 100644
> > > --- a/tests/acpi-utils.h
> > > +++ b/tests/acpi-utils.h
> > > @@ -28,24 +28,9 @@ typedef struct {
> > >      bool tmp_files_retain;   /* do not delete the temp asl/aml */
> > >  } AcpiSdtTable;
> > >  
> > > -#define ACPI_READ_FIELD(field, addr)           \
> > > -    do {                                       \
> > > -        switch (sizeof(field)) {               \
> > > -        case 1:                                \
> > > -            field = readb(addr);               \
> > > -            break;                             \
> > > -        case 2:                                \
> > > -            field = readw(addr);               \
> > > -            break;                             \
> > > -        case 4:                                \
> > > -            field = readl(addr);               \
> > > -            break;                             \
> > > -        case 8:                                \
> > > -            field = readq(addr);               \
> > > -            break;                             \
> > > -        default:                               \
> > > -            g_assert(false);                   \
> > > -        }                                      \  
> > probably it's been discussed but, why not do
> >  leXX_to_cpu()
> > here, instead of making each place that access read field
> > to do leXX_to_cpu() manually.?
> > 
> > Beside of keeping access to structure in natural host order,
> > it should also be less error-prone as field users don't
> > have to worry about endianness.  
> 
> Yes, I suggested that.
> The issue is that we don't byte-swap all of the tables
> (we can't, that would require a full ACPI parser).
> So when byte-swapping we end up with a mixed host/LE
> structures.
Agreed that having mixed endianness structures is hard to deal with.
Unfortunately switching away from host endianness for some structures
doesn't make code less confused as we still have mixed
structures in use (internal vs acpi ones).

That's why I'd rather make ACPI_FOO accessors take in/return data
in host byte order so that test case won't have to worry about it
as far as LE blobs are accessed via ACPI_FOO(). It'd be a lot less
fragile.

What tables/use-cases do you have in mind where we'd need full
ACPI parser /whatever it is/?


> Keeping it all LE seems cleaner.
> 
> 
