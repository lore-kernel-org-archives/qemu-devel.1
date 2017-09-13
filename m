Received: from eggs.gnu.org ([2001:4830:134:3::10]:33254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1ds9bB-00065r-Jt
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 11:29:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1ds9b6-0002Ca-Mk
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 11:29:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58470)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1ds9b6-0002Bu-GV
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 11:29:04 -0400
References: <20170913135418.GA14243@stefanha-x1.localdomain>
From: Michal Privoznik <mprivozn@redhat.com>
Message-ID: <dbd4caa3-71e2-5ea0-c7b1-8aee774eec30@redhat.com>
Date: Wed, 13 Sep 2017 17:28:56 +0200
MIME-Version: 1.0
In-Reply-To: <20170913135418.GA14243@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
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
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: libvir-list@redhat.com, Haozhong Zhang <haozhong.zhang@intel.com>, qemu-devel@nongnu.org

On 09/13/2017 03:54 PM, Stefan Hajnoczi wrote:
> Hi Michal,
> You asked how NVDIMM hotplug should work if the domain was launched
> without -M nvdimm=on.  I'm not very familiar with ACPI so this may be
> incorrect.
> 
> Hotplug relies on the presence of ACPI tables (SSDT Device=NVDR
> _HID=ACPI0012) added by -M nvdimm=on.  The ACPI tables contain the
> interface needed to handle hotplug events.
> 
> The device_add command fails with the following message if -M nvdimm=on
> is missing:
> 
>   nvdimm is not enabled: missing 'nvdimm' in '-M'

Right.

> 
> I'm not sure if ACPI allows SSDT tables to be dynamically added but in
> any case the current QEMU code doesn't support that.
> 
> Options for libvirt:
> 
> 1. Rely on QEMU's device_add error.
>    Pro: If QEMU behavior ever changes then libvirt will also start
>         working without code changes.

Well, this sounds scary :-)

>    Cons: Does libvirt interpret QMP error strings?

No.

> 
> 2. Only allow NVDIMM hotplug if the domain was started with -M
>    nvdimm=on.
> 
> I think QEMU will not add -M nvdimm=on to the "pc" machine type by
> default since it adds the NVDIMM DSM hardware interface that increases
> the security attack surface.

So this is the downside. Well, I think all that we are left with is
option 2 then. Or, we can expose nvdimm=on the domain XML (and enable it
by default for any domain that already has a nvdimm device configured).

BTW: I ran a migration from no nvdimm qemu to one that had -M nvdimm=on
and guest migrated happily. So looks like guest ABI is stable (or at
least stable enough not to crash). But since ACPI table is changed I
doubt that.

Also, I found that hotunplug is not implemented yet?

error: internal error: unable to execute QEMU command 'device_del':
nvdimm device hot unplug is not supported yet.

Michal
