Received: from eggs.gnu.org ([2001:4830:134:3::10]:37621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gU8Kt-0000T9-JM
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 05:53:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gU8Kp-00071I-Hx
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 05:53:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42312)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1gU8Kp-00070V-CS
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 05:53:47 -0500
Date: Tue, 4 Dec 2018 11:53:33 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181204115333.6d33c6a9.cohuck@redhat.com>
In-Reply-To: <20181127125248.01ef3e86@x1.home>
References: <1542746383-18288-1-git-send-email-kwankhede@nvidia.com>
	<1542746383-18288-2-git-send-email-kwankhede@nvidia.com>
	<20181127125248.01ef3e86@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/5] VFIO KABI for migration interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Kirti Wankhede <kwankhede@nvidia.com>, cjia@nvidia.com, kevin.tian@intel.com, ziye.yang@intel.com, changpeng.liu@intel.com, yi.l.liu@intel.com, mlevitsk@redhat.com, eskultet@redhat.com, dgilbert@redhat.com, jonathan.davies@nutanix.com, eauger@redhat.com, aik@ozlabs.ru, pasic@linux.ibm.com, felipe@nutanix.com, Zhengxiao.zx@Alibaba-inc.com, shuangtai.tst@alibaba-inc.com, Ken.Xue@amd.com, zhi.a.wang@intel.com, qemu-devel@nongnu.org

On Tue, 27 Nov 2018 12:52:48 -0700
Alex Williamson <alex.williamson@redhat.com> wrote:

> Actually I'm wondering if we can distill everything down to two bits,
> STOPPED and LOGGING.
> 
> We start at RUNNING, the user can optionally enable LOGGING when
> supported by the device to cover the SETUP and PRECOPY states
> proposed.  The device stays running, but activates any sort of
> dirtly page tracking that's necessary to activate those interfaces.
> LOGGING can also be cleared to handle the CANCELLED state.  The user
> would set STOPPED which should quiesce the device and make the full
> device state available through the device data section.  Clearing
> STOPPED and LOGGING would handle the FAILED state below.  Likewise on
> the migration target, QEMU would set the device top STOPPED in order to
> write the incoming data via the data section and clear STOPPED to
> indicate the device returns to RUNNING (aka RESUME/RESUME_COMPLETED).

This idea sounds like something that can be more easily adapted to
other device types as well. The LOGGING bit is probably more flexible
if you reframe it as a PREPARATION bit: That would also cover devices
or device types that don't do dirty logging, but need some other kind
of preparation prior to moving over.

This model would also be simple enough to allow e.g. a vendor driver
for mdev to implement its own, specialized backend while still fitting
into the general framework. Non-pci mdevs are probably different enough
from pci devices so that many of the states proposed don't really match
their needs.
