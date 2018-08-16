Received: from eggs.gnu.org ([2001:4830:134:3::10]:48114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fqDXx-0000m3-KE
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:22:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fqDXo-0007Qp-12
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:22:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57110 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fqDXn-0007Oq-DR
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:22:11 -0400
Date: Thu, 16 Aug 2018 09:22:00 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180816082200.GD8612@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <CAB3eZfsv+JDr+C=BaKEmZvW9meTwNub2HfwXO5DX7mf+BJqO0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAB3eZfsv+JDr+C=BaKEmZvW9meTwNub2HfwXO5DX7mf+BJqO0A@mail.gmail.com>
Subject: Re: [Qemu-devel] How do you do when write more than 16TB data to
 qcow2 on ext4?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: lampahome <pahome.chen@mirlab.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Thu, Aug 16, 2018 at 09:35:52AM +0800, lampahome wrote:
> We all know there's a file size limit 16TB in ext4 and other fs has their
> limit,too.
> 
> If I create an qcow2 20TB on ext4 and write to it more than 16TB. Data more
> than 16TB can't be written to qcow2.
> 
> So, is there any better ways to solve this situation?

I'd really just recommend using a different filesystem, in particular XFS
has massively higher file size limit - tested to 500 TB in RHEL-7, with a
theoretical max size of 8 EB. It is a very mature filesystem & the default
in RHEL-7.

> What I thought is to create new qcow2 called qcow2-new and setup the
> backing file be the previous qcow2.

A bit of a hack but it could work, albeit with the extra pain for managing
your VMs. If you create the qcow2 layer and the guest rewrites existing
written blocks you're going to end up storing data twice (used original
data in the backing file, and new active data in the top layer). So your
20 TB disk may end up storing waaay more than 20 TB.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
