Received: from eggs.gnu.org ([2001:4830:134:3::10]:44713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ross.zwisler@linux.intel.com>) id 1fRJOx-0005J2-Pu
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 11:34:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ross.zwisler@linux.intel.com>) id 1fRJOu-0002XS-Ml
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 11:34:07 -0400
Received: from mga05.intel.com ([192.55.52.43]:24566)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ross.zwisler@linux.intel.com>)
	id 1fRJOu-0002Wu-E5
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 11:34:04 -0400
Date: Fri, 8 Jun 2018 09:34:02 -0600
From: Ross Zwisler <ross.zwisler@linux.intel.com>
Message-ID: <20180608153402.GA27156@linux.intel.com>
References: <20180607223111.27792-1-ross.zwisler@linux.intel.com>
	<20180607223111.27792-2-ross.zwisler@linux.intel.com>
	<20180608020724-mutt-send-email-mst@kernel.org>
	<5352d2fb-9244-78b0-4f4b-2818359a4425@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5352d2fb-9244-78b0-4f4b-2818359a4425@redhat.com>
Subject: Re: [Qemu-devel] [qemu PATCH 2/5] acpi: "make check" should fail on
 asl mismatch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ross Zwisler <ross.zwisler@linux.intel.com>, Eduardo Habkost <ehabkost@redhat.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Qemu Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Dan Williams <dan.j.williams@intel.com>

On Fri, Jun 08, 2018 at 07:17:51AM +0200, Thomas Huth wrote:
> On 08.06.2018 01:09, Michael S. Tsirkin wrote:
> > On Thu, Jun 07, 2018 at 04:31:08PM -0600, Ross Zwisler wrote:
> >> Currently if "make check" detects a mismatch in the ASL generated during
> >> testing, we print an error such as:
> >>
> >>   acpi-test: Warning! SSDT mismatch. Actual [asl:/tmp/asl-QZDWJZ.dsl,
> >>   aml:/tmp/aml-T8JYJZ], Expected [asl:/tmp/asl-DTWVJZ.dsl,
> >>   aml:tests/acpi-test-data/q35/SSDT.dimmpxm].
> >>
> >> but the testing still exits with good shell status.  This is wrong, and
> >> makes bisecting such a failure difficult.
> >>
> >> Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
> > 
> > Failing would also mean that any change must update the expected files
> > at the same time.  And that in turn is problematic because expected
> > files are binary and can't be merged.
> > 
> > In other words the way we devel ACPI right now means that bisect will
> > periodically produce a diff, it's not an error.
> 
> But apparently the current way also allows that real bug go unnoticed
> for a while, until somebody accidentially spots the warning in the
> output of "make check". Wouldn't it be better to fail at CI time
> already? If a merge of the file is required, you can still resolve that
> manually (i.e. by rebasing one of the pull requests).

I share this point of view.  The unit tests only add value if we keep them up
to date and passing as we modify the source.  The ACPI tables in this case
were broken in an innocuous way and just needed to be updated to match again,
but it means that the tests for them are now basically turned off.  Someone
else could come along and break the ACPI table in a real and harmful way, and
nobody would notice because the and result would still just be an ACPI table
mismatch that is non-fatal and ignored.
