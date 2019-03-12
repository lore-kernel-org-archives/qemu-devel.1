Received: from eggs.gnu.org ([209.51.188.92]:52928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yan.y.zhao@intel.com>) id 1h3XhD-0002kO-T7
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 23:03:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yan.y.zhao@intel.com>) id 1h3XhD-0008TR-5B
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 23:03:15 -0400
Received: from mga09.intel.com ([134.134.136.24]:20425)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
	id 1h3XhC-0008Sc-RV
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 23:03:15 -0400
Date: Mon, 11 Mar 2019 22:57:47 -0400
From: Zhao Yan <yan.y.zhao@intel.com>
Message-ID: <20190312025747.GI21353@joy-OptiPlex-7040>
References: <1550566254-3545-1-git-send-email-yan.y.zhao@intel.com>
	<20190221134051.2c28893e@w520.home>
	<20190225022255.GP16456@joy-OptiPlex-7040>
	<20190307104421.534ea56f@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307104421.534ea56f@w520.home>
Subject: Re: [Qemu-devel] [PATCH 0/5] QEMU VFIO live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "intel-gvt-dev@lists.freedesktop.org" <intel-gvt-dev@lists.freedesktop.org>, "Zhengxiao.zx@Alibaba-inc.com" <Zhengxiao.zx@Alibaba-inc.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "eskultet@redhat.com" <eskultet@redhat.com>, "Yang, Ziye" <ziye.yang@intel.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "Wang, Zhi A" <zhi.a.wang@intel.com>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "aik@ozlabs.ru" <aik@ozlabs.ru>, "eauger@redhat.com" <eauger@redhat.com>, "felipe@nutanix.com" <felipe@nutanix.com>, "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>, "Liu, Changpeng" <changpeng.liu@intel.com>, "Ken.Xue@amd.com" <Ken.Xue@amd.com>, "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>, "cjia@nvidia.com" <cjia@nvidia.com>, "arei.gonglei@huawei.com" <arei.gonglei@huawei.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>

hi Alex
thanks for your reply.

So, if we choose migration data to be userspace opaque, do you think below
sequence is the right behavior for vendor driver to follow:

1. initially LOGGING state is not set. If userspace calls GET_BUFFER to
vendor driver,  vendor driver should reject and return 0.

2. then LOGGING state is set, if userspace calls GET_BUFFER to vendor
driver,
   a. vendor driver shoud first query a whole snapshot of device memory
   (let's use this term to represent device's standalone memory for now),
   b. vendor driver returns a chunk of data just queried to userspace,
   while recording current pos in data.
   c. vendor driver finds all data just queried is finished transmitting to
   userspace, and queries only dirty data in device memory now.
   d. vendor driver returns a chunk of data just quered (this time is dirty
   data )to userspace while recording current pos in data
   e. if all data is transmited to usespace and still GET_BUFFERs come from
   userspace, vendor driver starts another round of dirty data query.

3. if LOGGING state is unset then, and userpace calls GET_BUFFER to vendor
driver,
   a. if vendor driver finds there's previously untransmitted data, returns
   them until all transmitted.
   b. vendor driver then queries dirty data again and transmits them.
   c. at last, vendor driver queris device config data (which has to be
   queried at last and sent once) and transmits them.


for the 1 bullet, if LOGGING state is firstly set and migration aborts
then,  vendor driver has to be able to detect that condition. so seemingly,
vendor driver has to know more qemu's migration state, like migration
called and failed. Do you think that's acceptable?


Thanks
Yan
