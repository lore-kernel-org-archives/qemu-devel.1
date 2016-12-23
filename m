Received: from eggs.gnu.org ([2001:4830:134:3::10]:53540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cKSit-0007ZG-Ca
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 11:29:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cKSip-0005EZ-FV
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 11:29:35 -0500
Received: from mail-wj0-x242.google.com ([2a00:1450:400c:c01::242]:35402)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cKSip-0005EB-9c
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 11:29:31 -0500
Received: by mail-wj0-x242.google.com with SMTP id hb5so7719929wjc.2
	for <qemu-devel@nongnu.org>; Fri, 23 Dec 2016 08:29:31 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20161223151253.21338-1-msuchanek@suse.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <81f6aacf-018f-254a-5b85-6d8d9e93adbd@redhat.com>
Date: Fri, 23 Dec 2016 17:29:28 +0100
MIME-Version: 1.0
In-Reply-To: <20161223151253.21338-1-msuchanek@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH] Fix pasting into serial console in GTK
 ui
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michal Suchanek <msuchanek@suse.de>, qemu-devel@nongnu.org



On 23/12/2016 16:12, Michal Suchanek wrote:
> This copies the timer hack from ui/console.c kbd_send_chars to ui/gtk.c
> gd_vc_in.
> 
> There is no fd-like object to peek repatedly so the paste data is saved
> in a free-floating buffer only submitted to gtk_timeout_add. Multiple
> pastes can potentially interleave if qemu blocks for long or the user
> pastes fast.

Do not use a timer, instead set chr->chr_accept_input in gd_vc_handler.
The callback can do basically what you are doing in gd_vc_in_timer.  The
buffer can be just a GString plus a "head" pointer, in VirtualConsole.
Once the head catches up with the tail, you can free the GString.

Paolo
