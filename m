Received: from eggs.gnu.org ([2001:4830:134:3::10]:55186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dwiOo-0004lU-QH
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 01:27:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dwiOj-0007Kk-Sc
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 01:27:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36922)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1dwiOj-0007KO-Er
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 01:27:09 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8Q5P86o062294
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 01:27:04 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d7btk8r45-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 01:27:04 -0400
Received: from localhost
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Tue, 26 Sep 2017 15:27:02 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v8Q5QxZH40370194
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 15:26:59 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v8Q5R1KN029659
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 15:27:02 +1000
Date: Tue, 26 Sep 2017 10:56:50 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Reply-To: bharata@linux.vnet.ibm.com
References: <1506071794-4373-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1506071794-4373-1-git-send-email-thuth@redhat.com>
Message-Id: <20170926052650.GA10768@in.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2] qdev: Mark devices as non-hotpluggable
 by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, David Hildenbrand <david@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Amit Shah <amit@kernel.org>

On Fri, Sep 22, 2017 at 11:16:34AM +0200, Thomas Huth wrote:
> Historically we've marked all devices as hotpluggable by default. However,
> most devices are not hotpluggable, and you also need a HotplugHandler to
> support these devices. So if the user tries to "device_add" or "device_del"
> such a non-hotpluggable device during runtime, either nothing really usable
> happens, or QEMU even crashes/aborts unexpectedly (see for example commit
> 84ebd3e8c7d4fe955b - "Mark diag288 watchdog as non-hotpluggable").
> So let's change this dangerous default behaviour and mark the devices as
> non-hotpluggable by default. Certain parent devices classes which are known
> as hotpluggable (e.g. PCI, USB, etc.) are marked with "hotpluggable = true",
> so that devices that are derived from these classes continue to work as
> expected.

I see that the discussion has moved on, but want to note here that
CPU hotplug on pseries breaks with this patch.

(qemu) device_add host-spapr-cpu-core,core-id=8,id=core8
Device 'host-powerpc64-cpu' does not support hotplugging

(qemu) device_add POWER8E_v2.1-spapr-cpu-core,id=core8,core-id=8
Device 'POWER8E_v2.1-powerpc64-cpu' does not support hotplugging

Hope I am not missing anything.

Regards,
Bharata.
