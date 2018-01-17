Received: from eggs.gnu.org ([2001:4830:134:3::10]:58891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eblM4-0005CL-Ee
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 05:54:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eblM1-0003hJ-Cu
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 05:54:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39214)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eblM1-0003Yi-69
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 05:54:01 -0500
References: <20180116231824.27114-1-shaun.reitan@ndchost.com>
	<20180117103148.GE19227@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <05429a58-4013-c6ad-853c-73037086366d@redhat.com>
Date: Wed, 17 Jan 2018 18:53:30 +0800
MIME-Version: 1.0
In-Reply-To: <20180117103148.GE19227@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Add ability to provide ifname when using
 netdev bridge or tap helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Shaun Reitan <shaun.reitan@ndchost.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>



On 2018=E5=B9=B401=E6=9C=8817=E6=97=A5 18:31, Daniel P. Berrange wrote:
> On Tue, Jan 16, 2018 at 03:18:24PM -0800, Shaun Reitan wrote:
>> This patch replaces the patch I sent yesturday. This one fixes
>> a bug in my original code as well as corrects a few styling
>> issues. Hopfully this one comes out correct!  Sorry for the
>> inconvienece.
>>  =20
>> When currently using -netdev bridge or -netdev tap with a helper
>> you are unable to set an ifname. This patch adds that ability so
>> that you can now specify an ifname.
> I really don't think users should be allowed to override the
> ifname when using the setuid bridge helper. This allows an
> unprivileged users to create tap devices that may confuse the
> sysadmin, and/or network mgmt scripts.

Ok, I drop it from my queue.

>
> eg consider the user asks for a tap device called  eth1. To the
> sysadmin the user's tap device now looks like a physical NIC.
> This can be even worse if the host does physical NIC hotplug,
> or uses SRIOV. eg consider the host as eth0 -> eth7 for SRIOV
> NICs, and eth3 is given to a guest. Now a user uses the setuid
> helper to ask for a TAP called eth3. When the SRIOV device is
> later released by the guest it will end up called eth8, as the
> TAP device occupies eth3. In bad cases this could even cause
> the host mgmt layer to configure bogus addresses on the eth3
> TAP device instead of the SRIOV device.

It looks to me that mgmt should not assume the type or location of=20
device just from its name. Ethtool should be used to do this.

>
> If we want to allow ifname to be set via the setuid helper, then IMHO,
> the config file for the helper *must* whitelist the various permitted
> naming patterns.

Good point but this only work for e.g default helper. Qemu allows 3rd=20
helper which can do anything they want.

Thanks

>
>
> Regards,
> Daniel
