Received: from eggs.gnu.org ([2001:4830:134:3::10]:46714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ebl0f-0004Xr-Q2
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 05:31:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ebl0b-0003y9-SY
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 05:31:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36706)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ebl0b-0003xK-ME
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 05:31:53 -0500
Date: Wed, 17 Jan 2018 10:31:48 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20180117103148.GE19227@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20180116231824.27114-1-shaun.reitan@ndchost.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180116231824.27114-1-shaun.reitan@ndchost.com>
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
To: Shaun Reitan <shaun.reitan@ndchost.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Tue, Jan 16, 2018 at 03:18:24PM -0800, Shaun Reitan wrote:
> This patch replaces the patch I sent yesturday. This one fixes
> a bug in my original code as well as corrects a few styling
> issues. Hopfully this one comes out correct!  Sorry for the
> inconvienece.
>  
> When currently using -netdev bridge or -netdev tap with a helper
> you are unable to set an ifname. This patch adds that ability so
> that you can now specify an ifname.

I really don't think users should be allowed to override the
ifname when using the setuid bridge helper. This allows an
unprivileged users to create tap devices that may confuse the
sysadmin, and/or network mgmt scripts.

eg consider the user asks for a tap device called  eth1. To the
sysadmin the user's tap device now looks like a physical NIC.
This can be even worse if the host does physical NIC hotplug,
or uses SRIOV. eg consider the host as eth0 -> eth7 for SRIOV
NICs, and eth3 is given to a guest. Now a user uses the setuid
helper to ask for a TAP called eth3. When the SRIOV device is
later released by the guest it will end up called eth8, as the
TAP device occupies eth3. In bad cases this could even cause
the host mgmt layer to configure bogus addresses on the eth3
TAP device instead of the SRIOV device.

If we want to allow ifname to be set via the setuid helper, then IMHO,
the config file for the helper *must* whitelist the various permitted
naming patterns.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
