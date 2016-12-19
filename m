Received: from eggs.gnu.org ([2001:4830:134:3::10]:58783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cJ53V-0006s5-N0
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 16:01:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cJ53S-0002K8-M4
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 16:01:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56264)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cJ53S-0002IH-Gl
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 16:01:06 -0500
Date: Mon, 19 Dec 2016 19:01:02 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20161219210102.GD3808@thinpad.lan.raisama.net>
References: <1481805124-16242-1-git-send-email-vlad.lungu@windriver.com>
	<20161218202527.GZ3808@thinpad.lan.raisama.net>
	<8ae3da37-2b4c-3a3f-5adc-d657112979b6@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ae3da37-2b4c-3a3f-5adc-d657112979b6@windriver.com>
Subject: Re: [Qemu-devel] [PATCHv3] multiboot: copy the cmdline verbatim,
 unescape module strings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vlad Lungu <vlad.lungu@windriver.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net

On Mon, Dec 19, 2016 at 11:35:34AM +0200, Vlad Lungu wrote:
> On 12/18/2016 10:25 PM, Eduardo Habkost wrote:
> > On Thu, Dec 15, 2016 at 02:32:04PM +0200, Vlad Lungu wrote:
> >> get_opt_value() truncates the value at the first comma
> >> Use memcpy() instead
> >> Unescape the module filename and parameters with get_opt_value()
> >> before calling mb_add_cmdline()
> >>
> >> Signed-off-by: Vlad Lungu <vlad.lungu@windriver.com>
> >> ---
> >>  hw/i386/multiboot.c | 19 +++++++++----------
> >>  1 file changed, 9 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
> >> index 387caa6..6b7b5a9 100644
> >> --- a/hw/i386/multiboot.c
> >> +++ b/hw/i386/multiboot.c
> >> @@ -109,7 +109,7 @@ static uint32_t mb_add_cmdline(MultibootState *s, const char *cmdline)
> >>      hwaddr p = s->offset_cmdlines;
> >>      char *b = (char *)s->mb_buf + p;
> >>  
> >> -    get_opt_value(b, strlen(cmdline) + 1, cmdline);
> >> +    memcpy(b, cmdline, strlen(cmdline) + 1);
> >>      s->offset_cmdlines += strlen(b) + 1;
> >>      return s->mb_buf_phys + p;
> >>  }
> >> @@ -287,7 +287,7 @@ int load_multiboot(FWCfgState *fw_cfg,
> >>      mbs.offset_bootloader = mbs.offset_cmdlines + cmdline_len;
> >>  
> >>      if (initrd_filename) {
> >> -        char *next_initrd, not_last;
> >> +        char *next_initrd, not_last, tmpbuf[strlen(initrd_filename) + 1];
> >>  
> >>          mbs.offset_mods = mbs.mb_buf_size;
> >>  
> >> @@ -296,25 +296,24 @@ int load_multiboot(FWCfgState *fw_cfg,
> >>              int mb_mod_length;
> >>              uint32_t offs = mbs.mb_buf_size;
> >>  
> >> -            next_initrd = (char *)get_opt_value(NULL, 0, initrd_filename);
> >> +            next_initrd = (char *)get_opt_value(tmpbuf, strlen(initrd_filename) + 1, initrd_filename);
> > I would prefer to use sizeof(initrd_filename) like Paolo
> > suggested.
> sizeof(initrd_filename) is 8 (on my machine, x86_64). Maybe sizeof(tmpbuf) would be a better idea :-)

Oops, yes. I meant sizeof(tmpbuf).  :)

-- 
Eduardo
