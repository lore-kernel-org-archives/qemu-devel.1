Received: from eggs.gnu.org ([2001:4830:134:3::10]:53745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dzieq-0000gJ-FY
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 08:20:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dzieg-0007la-A6
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 08:20:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59238)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dzieg-0007hi-3i
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 08:20:02 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B132B935A3
	for <qemu-devel@nongnu.org>; Wed,  4 Oct 2017 12:20:00 +0000 (UTC)
Date: Wed, 4 Oct 2017 13:19:54 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171004121954.GI17517@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171004114008.14849-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171004114008.14849-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 0/2] Reporting of rotation rate for disks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>

On Wed, Oct 04, 2017 at 12:40:06PM +0100, Daniel P. Berrange wrote:
> While looking at libvirt tagged questions on serverfault I saw
> someone ask how to indicate that a virtual disk is an SSD rather
> than rotating rust.
> 
> https://serverfault.com/questions/876467/how-to-add-virtual-storage-as-ssd-in-kvm
> 
> IIUC, IDE / SCSI don't really have an explicit concept of a
> disk being SSD vs HDD, but they do have a means of reporting
> the disk rotation rate and both specify that SSDs should
> report RPM==1.
> 
> Linux uses this to determine whether to set the 'rotational'
> property to 0 for the I/O queue, and also whether to allow
> the disk to contribute random entropy (only HDDs contribute).
> 
> This felt like something QEMU ought to allow the mgmt application
> to set based on the storage it is using to back the virtual block
> devices. So this series adds a 'rotation_rate' property to the
> SCSI and IDE disks, taking an RPM value per their respective
> specifications.

BTW, to verify these patches there's two ways:

  # smartctl -a /dev/sda | grep Rotation
  Rotation Rate:        15000 rpm

  # smartctl -a /dev/sdb | grep Rotation
  Rotation Rate:        Solid State Device

Before these patches, 'Rotation rate' is not reported by smartctl
at all. With these patches the default value of '0' means nothing
will be reported too. Only if set to a non-zero value will it
be reported.

Or look at kernel queue:

  # cat /sys/block/sda/queue/rotational 
  1

  # cat /sys/block/sdb/queue/rotational 
  0



Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
