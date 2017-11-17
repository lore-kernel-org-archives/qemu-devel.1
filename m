Received: from eggs.gnu.org ([2001:4830:134:3::10]:49595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <darren.kenny@oracle.com>) id 1eFizs-0006Ni-1e
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 10:56:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <darren.kenny@oracle.com>) id 1eFizn-0002P8-6u
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 10:56:04 -0500
Received: from userp1040.oracle.com ([156.151.31.81]:18752)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <darren.kenny@oracle.com>)
	id 1eFizm-0002NX-TM
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 10:55:59 -0500
Date: Fri, 17 Nov 2017 15:55:50 +0000
From: Darren Kenny <darren.kenny@oracle.com>
Message-ID: <20171117155550.buxjpgumxx4cu3du@starbug-vm.ie.oracle.com>
References: <20171117103046.15943-1-kraxel@redhat.com>
	<20171117103046.15943-20-kraxel@redhat.com>
	<20171117125535.dhyvy5qwnh6d6e7d@starbug-vm.ie.oracle.com>
	<20171117132454.33pngiqu7vcdbmm5@sirius.home.kraxel.org>
	<20171117141650.bhvfbzbibo7trmv4@starbug-vm.ie.oracle.com>
	<20171117150328.dfqke3kb3axdg2n2@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20171117150328.dfqke3kb3axdg2n2@sirius.home.kraxel.org>
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
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Fri, Nov 17, 2017 at 04:03:28PM +0100, Gerd Hoffmann wrote:
>  Hi,
>
>> OK, so the odd thing then is the check for !remote_display earlier
>> on in the function (missing from the quote above) which seems to end
>> up initializing VNC (albeit with localhost) when CONFIG_VNC is
>> defined, but no other local display type has been selected.
>
>remote_display is set in case either -vnc or -spice was given on the
>command line, and qemu will not start a local user display in that case
>(unless you explicitly ask for it via -display).

Makes sense.

>
>> OK, so neither SPICE or VNC really fit into this patchset because
>> they are seen as additional to the display type, not the actual
>> display type - SPICE is even more special too given the dependency
>> on a guest VM driver to really function correctly.
>
>Hmm?  spice works just fine with any display.

Sorry, mixed that up with EGL I think.

>
>> I wonder should there be a, similar, qemu_display_find_remote_default()
>> which would be used when no local display is defined. And that would
>> use a similar mechanism to permit selecting VNC or SPICE via
>> registration mechanisms over rather than the #ifdef style for remote
>> displays that will remain ever after this patchset (certainly could
>> be another patchset beyond this one).
>
>Well, historically qemu tried to do alot of stuff (like picking a
>display to use) automatically for the user.  And we did stick to that
>for backward compatibility reasons.  But this automagic causes quite
>some headache now and then, when changing things and the autmagic logic
>gets into the way.  So I don't feel like adding more of this.  Also vnc

Agree, there are times when automagic works - but unfortunately for
more consistent usage, you are better being explicit.

>is in pretty much any qemu build, because it is enabled by default and
>doesn't need any external dependencies, so falling back to spice would
>be quite rare ...

Understood - definitely VNC is a pretty good fall-back for most
people.

Thanks for outlining your thoughts on this, very helpful in
understanding the UI code and why somethings are how they are.

Thanks,

Darren.
