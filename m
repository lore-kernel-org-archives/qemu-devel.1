Received: from eggs.gnu.org ([2001:4830:134:3::10]:53535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1cFOIW-0005cs-6E
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 11:45:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1cFOIS-00046n-4Y
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 11:45:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1cFOIR-000461-Sd
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 11:45:20 -0500
References: <20161011173526-mutt-send-email-mst@kernel.org>
	<20161117082902.GM5048@yliu-dev.sh.intel.com>
	<b9e55320-f53d-d7d3-978f-ec696f3c1d93@redhat.com>
	<20161117094936.GN5048@yliu-dev.sh.intel.com>
	<20161117192445-mutt-send-email-mst@kernel.org>
	<20161122130223.GW5048@yliu-dev.sh.intel.com>
	<20161122164143-mutt-send-email-mst@kernel.org>
	<20161124063129.GE5048@yliu-dev.sh.intel.com>
	<9b73a012-fb7a-4b7c-0dfe-6ef4b8cb48d2@redhat.com>
	<20161209144229.GC24165@redhat.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <d182d88c-219a-c4ed-4119-a071f1926192@redhat.com>
Date: Fri, 9 Dec 2016 17:45:13 +0100
MIME-Version: 1.0
In-Reply-To: <20161209144229.GC24165@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] dpdk/vpp and cross-version migration for vhost
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Yuanhan Liu <yuanhan.liu@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>, qemu-devel@nongnu.org, libvir-list@redhat.com, vpp-dev@lists.fd.io, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Flavio Leitner <fbl@redhat.com>, Aaron Conole <aconole@redhat.com>



On 12/09/2016 03:42 PM, Daniel P. Berrange wrote:
> On Fri, Dec 09, 2016 at 02:35:58PM +0100, Maxime Coquelin wrote:
>> ++Daniel for libvirt
>>
>> On 11/24/2016 07:31 AM, Yuanhan Liu wrote:
>>>>>>>>>> As version here is an opaque string for libvirt and qemu,
>>>>>>>>>>>>>>>>> anything can be used - but I suggest either a list
>>>>>>>>>>>>>>>>> of values defining the interface, e.g.
>>>>>>>>>>>>>>>>> any_layout=on,max_ring=256
>>>>>>>>>>>>>>>>> or a version including the name and vendor of the backend,
>>>>>>>>>>>>>>>>> e.g. "org.dpdk.v4.5.6".
>>>>>>>
>>>>>>> The version scheme may not be ideal here. Assume a QEMU is supposed
>>>>>>> to work with a specific DPDK version, however, user may disable some
>>>>>>> newer features through qemu command line, that it also could work with
>>>>>>> an elder DPDK version. Using the version scheme will not allow us doing
>>>>>>> such migration to an elder DPDK version. The MTU is a lively example
>>>>>>> here? (when MTU feature is provided by QEMU but is actually disabled
>>>>>>> by user, that it could also work with an elder DPDK without MTU support).
>>>>>>>
>>>>>>> 	--yliu
>>>>>
>>>>> OK, so does a list of values look better to you then?
>>> Yes, if there are no better way.
>>>
>>> And I think it may be better to not list all those features, literally.
>>> But instead, using the number should be better, say, features=0xdeadbeef.
>>>
>>> Listing the feature names means we have to come to an agreement in all
>>> components involved here (QEMU, libvirt, DPDK, VPP, and maybe more
>>> backends), that we have to use the exact same feature names. Though it
>>> may not be a big deal, it lacks some flexibility.
>>>
>>> A feature bits will not have this issue.
>>
>> I initially thought having key/value pairs would be more flexible, and
>> could allow migrating to another application if compatible (i.e. from
>> OVS to VPP, and vice versa...) without needing synchronization between
>> the applications.
>>
>> But Daniel pointed me out that it would add a lot of complexity on
>> management tool side, as it would need to know how to interpret these
>> key/value pairs. I think his argument is very valid.
>>
>> So maybe the best way would be the version string, letting the
>> application (OVS-DPDK/VPP/...) specify which version it is
>> compatible with.
>> For the downsides, as soon as a new feature is supported in vhost-user
>> application, the new version will not be advertised as compatible with
>> the previous one, even if the user disables the feature in Qemu (as
>> pointed out by Yuanhan).
>
> We need two distinct capabilities in order to make this work properly.
>
> First, libvirt needs to be able to query the list of (one or more)
> supported versions strings for a given host.

Shouldn't be the role of OpenStack/Neutron? IIUC, libvirt knows nothing
about OVS.

> Second, when launching QEMU we need to be able to specify the desired
> version against the NIC backend.
>
> So, consider host A, initially supporting "ovsdpdk-v1". When libvirt
> launches the VM it will specify 'ovsdpgk-v1' as the desired version
> string to use.
>
> Now some time later you add features X, Y & Z to a new release of
> DPDK and install this on host B.  Host B is able to support two
> versions 'ovsdppk-v1' and 'ovsdpdk-v2'.  When libvirt launches
> a VM on host B, it'll pick 'ovsdpgk-v2' by default, since that's
> the newest.   When libvirt migrates a VM from host A, however,
> it will request the old version 'ovsdpdk-v1' in order to ensure
> compatibility.  Similarly when launching a new VM on host B,
> libvirt could choose to use 'ovsdpdk-v1' as the version, in
> order to enable migration to the olver host A, if desired.
>
> This is exactly the way QEMU machine types work, hiding the
> existance of 100's low level settings / default values, that
> a mgmt app would otherwise have to worry about.

I agree on the principle. I need to check what is missing for OVS to
support different versions on different vhost-user ports.

Thanks,
Maxime
>
> Regards,
> Daniel
>
