Received: from eggs.gnu.org ([2001:4830:134:3::10]:60363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eFiB4-0003In-43
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 10:03:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eFiB1-0005jf-20
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 10:03:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55168)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eFiB0-0005ik-Sn
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 10:03:30 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1D945C051674
	for <qemu-devel@nongnu.org>; Fri, 17 Nov 2017 15:03:30 +0000 (UTC)
Date: Fri, 17 Nov 2017 16:03:28 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20171117150328.dfqke3kb3axdg2n2@sirius.home.kraxel.org>
References: <20171117103046.15943-1-kraxel@redhat.com>
	<20171117103046.15943-20-kraxel@redhat.com>
	<20171117125535.dhyvy5qwnh6d6e7d@starbug-vm.ie.oracle.com>
	<20171117132454.33pngiqu7vcdbmm5@sirius.home.kraxel.org>
	<20171117141650.bhvfbzbibo7trmv4@starbug-vm.ie.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171117141650.bhvfbzbibo7trmv4@starbug-vm.ie.oracle.com>
Subject: Re: [Qemu-devel] [PATCH 19/24] console: add and use
 qemu_display_find_default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

  Hi,

> OK, so the odd thing then is the check for !remote_display earlier
> on in the function (missing from the quote above) which seems to end
> up initializing VNC (albeit with localhost) when CONFIG_VNC is
> defined, but no other local display type has been selected.

remote_display is set in case either -vnc or -spice was given on the
command line, and qemu will not start a local user display in that case
(unless you explicitly ask for it via -display).

> OK, so neither SPICE or VNC really fit into this patchset because
> they are seen as additional to the display type, not the actual
> display type - SPICE is even more special too given the dependency
> on a guest VM driver to really function correctly.

Hmm?  spice works just fine with any display.

> I wonder should there be a, similar, qemu_display_find_remote_default()
> which would be used when no local display is defined. And that would
> use a similar mechanism to permit selecting VNC or SPICE via
> registration mechanisms over rather than the #ifdef style for remote
> displays that will remain ever after this patchset (certainly could
> be another patchset beyond this one).

Well, historically qemu tried to do alot of stuff (like picking a
display to use) automatically for the user.  And we did stick to that
for backward compatibility reasons.  But this automagic causes quite
some headache now and then, when changing things and the autmagic logic
gets into the way.  So I don't feel like adding more of this.  Also vnc
is in pretty much any qemu build, because it is enabled by default and
doesn't need any external dependencies, so falling back to spice would
be quite rare ...

cheers,
  Gerd
