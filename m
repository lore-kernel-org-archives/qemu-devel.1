Received: from eggs.gnu.org ([209.51.188.92]:47217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1hKRZb-0007R7-Po
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 13:57:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1hKRZa-000630-QL
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 13:57:15 -0400
Received: from hera.aquilenet.fr ([2a0c:e300::1]:48320)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1hKRZa-0005zx-Ix
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 13:57:14 -0400
Date: Sat, 27 Apr 2019 19:57:08 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20190427175708.76nq4w2mdexb4gkp@function>
References: <20190427163007.5113-1-samuel.thibault@ens-lyon.org>
	<20190427163007.5113-3-samuel.thibault@ens-lyon.org>
	<73079d95-cf99-e0e3-c464-4568622f0008@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73079d95-cf99-e0e3-c464-4568622f0008@gmx.com>
Subject: Re: [Qemu-devel] [PATCHv3 1/2] ui/curses: Do not assume wchar_t
 contains unicode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, kamil@netbsd.org

Kamil Rytarowski, le sam. 27 avril 2019 19:36:40 +0200, a ecrit:
> On 27.04.2019 18:30, Samuel Thibault wrote:
> > E.g. BSD and Solaris even use locale-specific encoding there.
> > 
> > We thus have to go through the native multibyte representation and use
> > mbtowc/wctomb to make a proper conversion.
> > 
> > Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> 
> Both patches work for me on NetBSD/amd64 8.99.37 for qemu-system-x86_64.
> Borders are printed correctly.
> 
> Regarding the patch I'm not sure whether to use MB_LEN_MAX or MB_CUR_MAX?

I don't know if qemu can afford VLA?

> I'm also unsure whether to reset conversion state between a multibyte
> character and wide character, with: `mbtowc(NULL, 0, 0);`. It's
> recommended to use in code examples examples. I think it doesn't make
> any harm to use it.

Mmm, better yet, we should actually use mbrtowc and wcrtomb. I have
fixed this in my tree.

> I'm not sure if this is related, but "qemu-system-hppa -curses" is
> broken for me. I didn't use it in the past as it just recently acquired
> NetBSD guest support.
> 
> (lldb) bt
> libcurses.so.7`mvwadd_wchnstr(win=0x0000000000000000, y=<unavailable>,
> x=<unavailable>, wchstr=0x00007f7fffffe020, n=0) at add_wchstr.c:123
>   * frame #2: 0x000000000078629e
> qemu-system-hppa`curses_update(dcl=0x00007f7ff7bd8bc0, x=0, y=0, w=79,
> h=24) at curses.c:86:9
>     frame #3: 0x0000000000753dae
> qemu-system-hppa`dpy_text_update(con=0x00007f7ff7bae580, x=0, y=0, w=79,

> (lldb) p screenpad
> (WINDOW *) $2 = 0x0000000000000000

I don't think this is related at all, screenpad management is another
matter.

Samuel
