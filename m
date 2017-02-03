Received: from eggs.gnu.org ([2001:4830:134:3::10]:48766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1cZXxn-0001nY-P2
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 02:07:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1cZXxk-0004Yr-K0
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 02:07:19 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37489
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1cZXxk-0004Yg-Dk
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 02:07:16 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1370rXZ189134
	for <qemu-devel@nongnu.org>; Fri, 3 Feb 2017 02:07:15 -0500
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28c8yw0wq6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 03 Feb 2017 02:07:15 -0500
Received: from localhost
	by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Fri, 3 Feb 2017 12:37:11 +0530
Date: Fri, 3 Feb 2017 12:37:06 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Reply-To: bharata@linux.vnet.ibm.com
References: <1486047755-93584-1-git-send-email-imammedo@redhat.com>
	<1486047755-93584-4-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1486047755-93584-4-git-send-email-imammedo@redhat.com>
Message-Id: <20170203070706.GC12744@in.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] spapr: make cpu core unplug follow
 expected hotunplug call flow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org

On Thu, Feb 02, 2017 at 04:02:35PM +0100, Igor Mammedov wrote:
> spapr_core_unplug() were essentially spapr_core_unplug_request()
> handler that requested CPU removal and registered callback
> which did actual cpu core removali but it was called from
> spapr_machine_device_unplug() which is intended for actual object
> removal. Commit (cf632463 spapr: Memory hot-unplug support)
> sort of fixed it introducing spapr_machine_device_unplug_request()
> and calling spapr_core_unplug() but it hasn't renamed callback and
> by mistake calls it from spapr_machine_device_unplug().
> 
> However spapr_machine_device_unplug() isn't ever called for
> cpu core since spapr_core_release() doesn't follow expected
> hotunplug call flow which is:
>  1: device_del() ->
>         hotplug_handler_unplug_request() ->
>             set destroy_cb()
>  2: destroy_cb() ->
>         hotplug_handler_unplug() ->
>             object_unparent // actual device removal
> 
> Fix it by renaming spapr_core_unplug() to spapr_core_unplug_request()
> which is called from spapr_machine_device_unplug_request() and
> making spapr_core_release() call hotplug_handler_unplug() which
> will call spapr_machine_device_unplug() -> spapr_core_unplug()
> to remove cpu core.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/ppc/spapr.c | 18 ++++++++++++++----

Reveiwed-by: Bharata B Rao <bharata@linux.vnet.ibm.com>

Regards,
Bharata.
