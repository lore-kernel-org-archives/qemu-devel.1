Received: from eggs.gnu.org ([2001:4830:134:3::10]:34304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e9nv5-0004rp-PZ
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 03:58:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e9nv2-0007QL-Lf
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 03:58:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e9nv2-0007PX-El
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 03:58:36 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E38CD81DF1
	for <qemu-devel@nongnu.org>; Wed,  1 Nov 2017 07:58:33 +0000 (UTC)
Message-ID: <1509523112.3856.3.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 01 Nov 2017 08:58:32 +0100
In-Reply-To: <20171027072934.GA30999@redhat.com>
References: <20171023091947.20771-1-kraxel@redhat.com>
	<20171023091947.20771-5-kraxel@redhat.com>
	<20171027072934.GA30999@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 4/9] ps2: fix scancodes sent for Alt-Print
 key combination (aka SysRq)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org

  Hi,

> No one confirmed whether or not this new field needs to be added to
> the
> VMSTATE sections, and if so, how todo this in a back compatible
> manner....

Good question.  Sky isn't falling if we don't send this over, worst
case is a minor keyboard glitch, affecting only the SysRq key, right?

Annoying things like sticky modifier keys should not happen.  So I'd
tend to simply leave things as-is.

When sending it over we need a subsection for it.  Simplest way would
be to only send over the section in the unlikely case that the field is
non-zero.  But this might fail migration to older qemu versions in case
someone hits a modifier key the wrong moment.  Alternatively send the
sibsection only on new machine types using a compat property, but that
needs a bit more boilerplate.

cheers,
  Gerd
