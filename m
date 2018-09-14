Received: from eggs.gnu.org ([2001:4830:134:3::10]:45711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g0nbt-0006YR-Vv
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 08:54:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g0nbq-0003Co-0K
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 08:54:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59206)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1g0nbp-0003B6-Qh
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 08:54:05 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6E32C307D90F
	for <qemu-devel@nongnu.org>; Fri, 14 Sep 2018 12:54:04 +0000 (UTC)
Date: Fri, 14 Sep 2018 14:54:00 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180914125400.nvq5t3pjh326pvr4@sirius.home.kraxel.org>
References: <20180914104835.26019-1-kraxel@redhat.com>
	<20180914113407.GB3081@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914113407.GB3081@work-vm>
Subject: Re: [Qemu-devel] [PATCH v2] usb: assign unique serial numbers to
 hid devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org

  Hi,

> OK, so now I've found the bit about the magic 42; commit 7b074a22 of
> yours; recommended checking for 42 for knowing we had autosuspend;
> what's actually in the current fedora hid rules is serial!=1 - I wonder
> what others have.

Whatever upstream systemd/udev has I guess ...

A bit of history ...

 * First there was nothing.
 * Then I added a rule to udev checking for serial == 42
   (this is in rhel-6).
 * Then systemd + udev merged.
 * Then I changed the rule to check for serial != 1 instead, so we can
   use any serial but "1" which is the one the old broken devices had
   (this is in rhel-7).  March 2014 in upstream systemd.
 * Then all usb power management rules where dropped from systemd (June
   2015).  Which I figured today, after wondering that the rules are
   gone in fedora 28.

So, three years ago the serial number check was dropped upstream, yet I
hav't seen a single report about autosuspend issues (or cpu usage for
usb emulation going up, which is the typical symtom).

So I figured I can stop worring that changing the serial number will
break things and just do it.

And even if it turns out autosuspend is still an issue:  I think
meanwhile we can really stop worrying about guests running in old qemu
versions with broken usb suspend (fixed in 0.13 !).  If needed we can
enable autosuspend unconditionally in guests.

cheers,
  Gerd
