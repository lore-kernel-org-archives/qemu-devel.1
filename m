Received: from eggs.gnu.org ([2001:4830:134:3::10]:45729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fqgJj-0002Zx-H1
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:05:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fqgJU-0001BB-Gb
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:05:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56992 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fqgJR-00014K-WE
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:05:18 -0400
Date: Fri, 17 Aug 2018 16:05:13 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180817150513.GT11124@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <bf97cfed-ca7f-8670-0aad-da1b847eb609@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bf97cfed-ca7f-8670-0aad-da1b847eb609@ubuntu.com>
Subject: Re: [Qemu-devel] Pipe key broken on US keyboards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Phillip Susi <psusi@ubuntu.com>
Cc: qemu-devel@nongnu.org

On Thu, Aug 16, 2018 at 01:11:05PM -0400, Phillip Susi wrote:
> Hello, I recently upgraded my Xen server from Ubuntu 16.04 to 18.04 and
> am no longer able to type a | over vnc to the xen vms.  When I press \
> it works, but when I hold down shift and press \ which should generate a
> |, the vm sees the scan code for some key that the keymap thinks should
> sit between left shift and Z, but does not exist on US keyboards, and
> that scan code produces a > when combined with shift.  I'm betting it
> was this commit that broke it:
> 
> commit ab8f9d49d62c82a12409475547e4420a46da56ed
> Author: Daniel P. Berrange <berrange@redhat.com>
> Date:   Wed Jan 17 16:41:15 2018 +0000
> 
>     hw: convert ps2 device to keycodemapdb
> 
>     Replace the qcode_to_keycode_set1, qcode_to_keycode_set2,
>     and qcode_to_keycode_set3 tables with automatically
>     generated tables.
> 
> Any ideas?
> 
> According to xev in the vm, they scan code for \ is 51, and when I hold
> down shift, it changes to scan code 94.

Reading again, this is a bit odd. On most keyboards, holding down shift
key generally would NOT change the scan code that is reported (there are a
few keys which are exceptions - sysrq/printscr). The scancode is associated
with the physical key location, and holding down shift doesn't change that.
The intepretation of the shift should (mostly) only take place when the
scancode is changed to a key symbol by the kernel/xorg.


Scancode 94 from xev, once the offset is removed, this corresponds
to scancdoe 0x56 in XT and key 86 in Linux key codes.

Scancode 51 from xev, once the offset is removed, this corresponds
to scancdoe 0x2b in XT and key 43 in Linux key codes.

On my US layout keyboard the '\' key will emit XT scancode 86 regardless
of whether the shift key is held or not

On my UK layout keyboard the '\' key will emit XT scancode 43 regardless
of whether the shift key is held or not


The QEMU guest I tested will correctly interpret this *if* I load the
correct matching keymap in the guest.

ie if using my US layout keyboard I must

  loadkeys /lib/kbd/keymaps/kegacy/i386/qwerty/us.map.gz

while for my UK layout keyboard I must use

  loadkeys /lib/kbd/keymaps/kegacy/i386/qwerty/uk.map.gz

NB, I'm using QEMU 2.12.0 which has the complete rewrite of the key
handling, while it looks like you have 2.11.0 from Ubuntu. 


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
