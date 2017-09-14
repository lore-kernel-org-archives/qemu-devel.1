Received: from eggs.gnu.org ([2001:4830:134:3::10]:39098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dsTav-000614-AY
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 08:50:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dsTas-00063Y-6p
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 08:50:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49966)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dsTar-00060n-U0
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 08:50:10 -0400
Date: Thu, 14 Sep 2017 14:49:59 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170914144959.1568da20@nial.brq.redhat.com>
In-Reply-To: <671fbddb-c201-75d2-249b-00d53a609d57@redhat.com>
References: <20170913135418.GA14243@stefanha-x1.localdomain>
	<dbd4caa3-71e2-5ea0-c7b1-8aee774eec30@redhat.com>
	<20170914003341.h4t7swxcgkum7twi@hz-desktop>
	<671fbddb-c201-75d2-249b-00d53a609d57@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [libvirt] QEMU -M nvdimm=on and hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michal Privoznik <mprivozn@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, libvir-list@redhat.com, qemu-devel@nongnu.org, Haozhong Zhang <haozhong.zhang@intel.com>

On Thu, 14 Sep 2017 13:51:45 +0200
Michal Privoznik <mprivozn@redhat.com> wrote:

> On 09/14/2017 02:33 AM, Haozhong Zhang wrote:
> > On 09/13/17 17:28 +0200, Michal Privoznik wrote:  
> >>
> >> BTW: I ran a migration from no nvdimm qemu to one that had -M nvdimm=on
> >> and guest migrated happily. So looks like guest ABI is stable (or at
> >> least stable enough not to crash). But since ACPI table is changed I
> >> doubt that.  
> > 
> > One example that may cause trouble is that
> > 1/ Guest OS got a pointer to an ACPI table A on the source host (w/o nvdimm=on)
> > 2/ After migrating to the destination host (w/ nvdimm=on), the
> >    location of ACPI table A is occupied by NFIT. If guest OS tries to
> >    access ACPI table A via the pointer in step 1/, then it will access
> >    the wrong table.
> >   
> 
> Ah, you're right. So it a guest ABI breakage to add nvdimm=on. IOW,
> libvirt can't safely add that onto command line. Well we could for
> freshly started guest and not those which are just being migrated. But
> that increases attack surface so it's not safe either. Okay, I'll stick
> with the latest proposal (expose this in domain XML and let users turn
> it on if they want to).
also note that it depends on memory hotplug being enabled '-m xxx,slots+maxmem'
