Received: from eggs.gnu.org ([2001:4830:134:3::10]:42243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <darren.kenny@oracle.com>) id 1eFhS2-0003mo-Ci
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 09:17:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <darren.kenny@oracle.com>) id 1eFhRy-0007Vx-Vv
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 09:17:02 -0500
Received: from aserp1040.oracle.com ([141.146.126.69]:29636)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <darren.kenny@oracle.com>)
	id 1eFhRy-0007So-Ls
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 09:16:58 -0500
Date: Fri, 17 Nov 2017 14:16:50 +0000
From: Darren Kenny <darren.kenny@oracle.com>
Message-ID: <20171117141650.bhvfbzbibo7trmv4@starbug-vm.ie.oracle.com>
References: <20171117103046.15943-1-kraxel@redhat.com>
	<20171117103046.15943-20-kraxel@redhat.com>
	<20171117125535.dhyvy5qwnh6d6e7d@starbug-vm.ie.oracle.com>
	<20171117132454.33pngiqu7vcdbmm5@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20171117132454.33pngiqu7vcdbmm5@sirius.home.kraxel.org>
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

Hi Gerd,

Thanks for clarifying things for me.

On Fri, Nov 17, 2017 at 02:24:54PM +0100, Gerd Hoffmann wrote:
>  Hi,
>
>> > -        dpy.type = DISPLAY_TYPE_NONE;
>> > +        if (!qemu_display_find_default(&dpy)) {
>> > +            dpy.type = DISPLAY_TYPE_NONE;
>> > +#if defined(CONFIG_VNC)
>> > +            vnc_parse("localhost:0,to=99,id=default", &error_abort);
>> > #endif
>>
>> Mostly some questions on this:
>>
>> - I'm curious, why is VNC not just one of the ones searched for in
>>  qemu_display_find_default()?
>
>vnc is a bit different.  It's a remote display protocol, not a (local)
>user interface.  There is no DISPLAY_TYPE_VNC for that reason (without
>this series too).  And IMO it was a bad idea to add -display vnc=$config
>(same as -vnc $config) in the first place.
>
>There can be only one user interface instance, i.e. you can't have gtk
>and sdl at the same time.  With vnc (and spice) that works though, i.e.
>you can start qemu with some local user interface and enable vnc or
>spice (even both) remote access at the same time.

Ah, wasn't sure about being able to do both a local UI and VNC -
I've only ever used one or the other :)

OK, so the odd thing then is the check for !remote_display earlier
on in the function (missing from the quote above) which seems to end
up initializing VNC (albeit with localhost) when CONFIG_VNC is
defined, but no other local display type has been selected.

But, I suppose it's not strictly incorrect with the 'localhost' :)

>
>> - What if there is another display type added? Would it be added to
>>  qemu_display_find_default() or in this if statement?
>
>qemu_display_find_default() most likely,
>but depends on what exactly it is.

OK, so neither SPICE or VNC really fit into this patchset because
they are seen as additional to the display type, not the actual
display type - SPICE is even more special too given the dependency
on a guest VM driver to really function correctly.

I wonder should there be a, similar, qemu_display_find_remote_default()
which would be used when no local display is defined. And that would
use a similar mechanism to permit selecting VNC or SPICE via
registration mechanisms over rather than the #ifdef style for remote
displays that will remain ever after this patchset (certainly could
be another patchset beyond this one).

Maybe it's not worth it, given that VNC is really he only remote UI
module you can use.

>
>> - Is there a reason that VNC doesn't follow the same registration
>>  mechanism you're proposing here (as in you've no changes to that
>>  module in this patch set).
>
>See above ;)
>
>> - In the spirit of encapsulation, would it not make sense for the
>>  vnc_parse() to be in the VNC code itself as a fall back if no
>>  specific options are given to the -vnc option?
>
>It's not that simple.  The default vnc server is started only in case
>no (graphical) local user interface is available, so it's not something
>the vnc code can figure purely on its own.

Fair enough.

Just a thought, but maybe the specific string could be defined in
vnc.h instead of a string here at least? (e.g.
VNC_DEFAULT_LOCALHOST_OPTIONS, or similar).

Thanks,

Darren.
