Received: from eggs.gnu.org ([2001:4830:134:3::10]:60850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cHHFc-0007BV-5C
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 16:38:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cHHFZ-00077z-3B
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 16:38:12 -0500
Received: from mx5-phx2.redhat.com ([209.132.183.37]:50852)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cHHFY-00077b-Pw
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 16:38:09 -0500
Date: Wed, 14 Dec 2016 16:38:07 -0500 (EST)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1509132582.4065072.1481751487408.JavaMail.zimbra@redhat.com>
In-Reply-To: <20161214175144.GN3808@thinpad.lan.raisama.net>
References: <1481732391-882-1-git-send-email-vlad.lungu@windriver.com>
	<ef1f3b2a-d206-7082-3227-423e0d9d9619@redhat.com>
	<20161214170058.GJ3808@thinpad.lan.raisama.net>
	<abea10db-9da8-d6eb-c6eb-67817b1fadda@redhat.com>
	<20161214175144.GN3808@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] multiboot: copy the cmdline verbatim
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Vlad Lungu <vlad.lungu@windriver.com>, qemu-devel@nongnu.org, rth@twiddle.net



----- Original Message -----
> From: "Eduardo Habkost" <ehabkost@redhat.com>
> To: "Paolo Bonzini" <pbonzini@redhat.com>
> Cc: "Vlad Lungu" <vlad.lungu@windriver.com>, qemu-devel@nongnu.org, rth@twiddle.net
> Sent: Wednesday, December 14, 2016 6:51:44 PM
> Subject: Re: [PATCH] multiboot: copy the cmdline verbatim
> 
> On Wed, Dec 14, 2016 at 06:20:46PM +0100, Paolo Bonzini wrote:
> > On 14/12/2016 18:00, Eduardo Habkost wrote:
> > > On Wed, Dec 14, 2016 at 05:55:07PM +0100, Paolo Bonzini wrote:
> > >>
> > >>
> > >> On 14/12/2016 17:19, Vlad Lungu wrote:
> > >>> get_opt_value() truncates the value at the first comma.
> > >>> Use memcpy() instead.
> > >>
> > >> Looks good since get_opt_value is already used by the caller.  Have you
> > >> tested this with multiple initrd modules too?
> > > 
> > > get_opt_value() is used by the caller, but with NULL buf
> > > argument. This means the caller doesn't handle ",," escaping.
> > > (See my reply to the previous submission of this patch)
> > 
> > Hmm, wait.  When NULL is passed, ",," escaping is handled correctly in
> > that next_initrd points to the next lone comma.  The lone comma is
> > replaced with a '\0' by the caller.
> 
> It is handled correctly when splitting the string, but not when opening the
> file.
> 
> > 
> > So you need to use get_opt_value again in mb_add_cmdline to do the
> > unescaping, because mb_add_cmdline only receives double commas.
> > 
> > This was actually my first reaction to the patch, and it was correct.
> > Then I overthought it. :)
> > 
> > So the patch is wrong.
> 
> Except that the caller is already broken when using ",," for a
> different reason: it calls get_image_size(initrd_filename) and
> load_image(initrd_filename, ...) directly. So comma-escaping
> never worked anyway:
> 
>   $ qemu-system-x86_64 -kernel ~/Downloads/gnumach -initrd
>   /tmp/one,,file,/tmp/another,,file
>   Failed to open file '/tmp/one,,file'
> 
> The right fix for comma-escaping would require calling
> get_opt_value() with non-NULL buf outside mb_add_cmdline(),
> because the mb_add_cmdline(&mbs, kcmdline) call do NOT need
> get_opt_value() to be called.

For filenames containing commas you're right, but...

> In other words: this fixes the mb_add_cmdline(kcmdline) case, and
> doesn't break comma escaping on the initrd case (because it was
> already broken). I don't see a problem with this patch.

... there is one case of comma escaping that wasn't broken:

    $ qemu-system-x86_64 -kernel foo -initrd '/tmp/one arg,,with,,commas,/tmp/another arg,,with,,commas'

And presumably this is what Vlad was trying to do.

Paolo
