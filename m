Received: from eggs.gnu.org ([2001:4830:134:3::10]:60956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dg5zm-0004fe-Fm
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 05:12:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dg5zj-0003aO-Ak
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 05:12:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53562)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dg5zj-0003Zz-2G
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 05:12:39 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0CB8540251
	for <qemu-devel@nongnu.org>; Fri, 11 Aug 2017 09:12:38 +0000 (UTC)
Date: Fri, 11 Aug 2017 10:12:32 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170811091232.GC2554@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170810155522.31099-1-berrange@redhat.com>
	<20170810155522.31099-3-berrange@redhat.com>
	<5e2768ee-17e6-b33d-2787-ab9fb940615f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5e2768ee-17e6-b33d-2787-ab9fb940615f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 02/15] ui: convert common input code to
 keycodemapdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

On Thu, Aug 10, 2017 at 01:59:09PM -0500, Eric Blake wrote:
> On 08/10/2017 10:55 AM, Daniel P. Berrange wrote:
> > Replace the number_to_qcode, qcode_to_number and linux_to_qcode
> > tables with automatically generated tables.
> > 
> > Missing entries in linux_to_qcode now fixed:
> 
> > In additionsome fixes:
> 
> s/additionsome/addition, some/
> 
> > 
> >  - KEY_PLAYPAUSE now maps to Q_KEY_CODE_AUDIOPLAY, instead of
> >    KEY_PLAYCD. KEY_PLAYPAUSE is defined across almost all scancodes
> >    sets, while KEY_PLAYCD only appears in AT set1, so the former is
> >    a more useful mapping.
> > 
> > Missing entries in qcode_to_number now fixed:
> > 
> >   Q_KEY_CODE_AGAIN -> 0x85
> 
> I didn't research that these mappings are correct in relation to an
> official documentation, but trust that you have done due diligence.

As mentioned in the cover letter, I compared the original mapping
tables in QEMU to the new auto-generated ones. That is how I
identified these newly added entries. I also discovered certain
bugs in doing that, which I fixed in the keycodemapdb. 

> 
> > In addition some fixes:
> > 
> >  - Q_KEY_CODE_MENU was incorrectly mapped to the compose
> >    scancode (0xdd) and is now mapped to 0x9e
> >  - Q_KEY_CODE_FIND was mapped to 0xe065 (Search) instead
> >    of to 0xe041 (Find)
> >  - Q_KEY_CODE_HIRAGANA was mapped to 0x70 (Katakanahiragana)
> >    instead of of 0x77 (Hirigana)
> >  - Q_KEY_CODE_PRINT was mapped to 0xb7 which is not a defined
> >    scan code in AT set 1, it is now mapped to 0x54 (sysrq)
> > 
> 
> Are any of these fixes something we need in 2.10 (more likely, as manual
> fixes rather than via the git submodule)?  At this point, though, I'm
> inclined to say we're deep enough in freeze that if it is not a
> regression over 2.9 behavior, it's not worth rushing in the fix to 2.10.

These bugs have been present for several relesaes, so I'm not sure
its worth the effort to manually update the existing tables with
bug fixes.


> >  KEYCODEMAP_FILES = \
> > +		 ui/input-keymap-linux2qcode.c \
> > +		 ui/input-keymap-qcode2qnum.c \
> > +		 ui/input-keymap-qnum2qcode.c \
> 
> My comment on patch 1 complained about regex of [a-zA-Z0-9] - do any of
> the keycode names have digits, or can you shorten the regex to [a-zA-Z]?

Several ends with digits.

> 
> > -
> > -static int number_to_qcode[0x100];
> > +#include "ui/input-keymap-linux2qcode.c"
> > +#include "ui/input-keymap-qcode2qnum.c"
> > +#include "ui/input-keymap-qnum2qcode.c"
> >  
> >  int qemu_input_linux_to_qcode(unsigned int lnx)
> >  {
> > -    assert(lnx < KEY_CNT);
> > -    return linux_to_qcode[lnx];
> 
> The old code asserted on an out-of-range input,
> 
> > +    if (lnx >= qemu_input_map_linux2qcode_len) {
> > +        return 0;
> > +    }
> > +    return qemu_input_map_linux2qcode[lnx];
> 
> the new code returns 0.  I guess that's okay, though, since the
> generated table uses 0 for invalid entries, and there's no implicit
> reason why out-of-range input has to assert.

Using assert() for these mappings is really dangerous and could lead to
denial of service security bugs. I had kept asserts originally but then
found I was able to trigger asserts from VNC keyboard events, or monitor
send-key command by sending out of range scancodes. IOW VNC client could
crash QEMU. Fortunately the original code was not vulnerable to that,
only my patches, but I think it is better not to take that risk at all.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
