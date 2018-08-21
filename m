Received: from eggs.gnu.org ([2001:4830:134:3::10]:48218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fs3E9-00034s-01
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 05:45:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fs3E3-000715-UH
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 05:45:28 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:39409)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fs3E3-00070g-Ni
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 05:45:23 -0400
Received: by mail-wr1-f46.google.com with SMTP id o37-v6so6412900wrf.6
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 02:45:23 -0700 (PDT)
References: <20180821074509.22688-1-kraxel@redhat.com>
	<20180821074509.22688-9-kraxel@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <685ad9d2-bf48-2dec-1e69-c1d4a5e2b41c@redhat.com>
Date: Tue, 21 Aug 2018 11:45:20 +0200
MIME-Version: 1.0
In-Reply-To: <20180821074509.22688-9-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 08/12] spice-display: fix
 qemu_spice_cursor_refresh_bh locking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: libvir-list@redhat.com

On 21/08/2018 09:45, Gerd Hoffmann wrote:
> +    qemu_mutex_lock(&ssd->lock);
>      if (ssd->cursor) {
> +        QEMUCursor *c = ssd->cursor;
>          assert(ssd->dcl.con);
> +        cursor_get(c);
> +        qemu_mutex_unlock(&ssd->lock);
>          dpy_cursor_define(ssd->dcl.con, ssd->cursor);

Gerd,

this ssd->cursor should be "c" in the call to dpy_cursor_define.  My
apologies; please tell me if you'd like me to send a follow-up fix.

Paolo

> +        qemu_mutex_lock(&ssd->lock);
> +        cursor_put(c);
>      }
