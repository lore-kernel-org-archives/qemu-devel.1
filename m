Received: from eggs.gnu.org ([2001:4830:134:3::10]:35683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <msuchanek@suse.de>) id 1cO4Ms-0000K8-DT
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 10:17:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <msuchanek@suse.de>) id 1cO4Mp-0008Nq-8v
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 10:17:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:46703)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <msuchanek@suse.de>) id 1cO4Mp-0008Mp-1u
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 10:17:43 -0500
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 3F963AAB7
	for <qemu-devel@nongnu.org>; Mon,  2 Jan 2017 15:17:41 +0000 (UTC)
Date: Mon, 2 Jan 2017 16:17:40 +0100
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Message-ID: <20170102161740.08079f53@kitsune.suse.cz>
In-Reply-To: <81f6aacf-018f-254a-5b85-6d8d9e93adbd@redhat.com>
References: <20161223151253.21338-1-msuchanek@suse.de>
	<81f6aacf-018f-254a-5b85-6d8d9e93adbd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: qemu-devel@nongnu.org

Hello,

On Fri, 23 Dec 2016 17:29:28 +0100
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 23/12/2016 16:12, Michal Suchanek wrote:
> > This copies the timer hack from ui/console.c kbd_send_chars to
> > ui/gtk.c gd_vc_in.
> > 
> > There is no fd-like object to peek repatedly so the paste data is
> > saved in a free-floating buffer only submitted to gtk_timeout_add.
> > Multiple pastes can potentially interleave if qemu blocks for long
> > or the user pastes fast.  
> 
> Do not use a timer, instead set chr->chr_accept_input in
> gd_vc_handler. The callback can do basically what you are doing in
> gd_vc_in_timer.  The buffer can be just a GString plus a "head"
> pointer, in VirtualConsole. Once the head catches up with the tail,
> you can free the GString.

How do you propose to use that callback? I did not find a
documentation for it. It takes no argument (except the chr object self)
so there is no way to pass in the buffer. It cannot be replaced -
it is set in non-ui code in multiple places and never in ui code.

Thanks

Michal
