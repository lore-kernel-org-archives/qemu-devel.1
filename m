Received: from eggs.gnu.org ([2001:4830:134:3::10]:41959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cVdq8-0006g8-6K
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 07:35:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cVdq7-0006ut-Bb
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 07:35:16 -0500
Received: from mail-yw0-x243.google.com ([2607:f8b0:4002:c05::243]:34009)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cVdq7-0006ug-5p
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 07:35:15 -0500
Received: by mail-yw0-x243.google.com with SMTP id v73so16827505ywg.1
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 04:35:15 -0800 (PST)
MIME-Version: 1.0
References: <20170118160332.13390-1-marcandre.lureau@redhat.com>
	<20170118160332.13390-24-marcandre.lureau@redhat.com>
	<1484814026.15364.15.camel@redhat.com>
	<CAJ+F1CLeTaXgja-g_00LmxxiVSDZK5DeHStXPfgpcMNeLYX7Pw@mail.gmail.com>
	<1485173068.2149.20.camel@redhat.com>
In-Reply-To: <1485173068.2149.20.camel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 23 Jan 2017 12:35:03 +0000
Message-ID: <CAJ+F1CLCj2TqihB6Q9pOTvzZpx9qOKDFpywFKkU64CbV1cqJig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 23/25] console: make screendump async
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Hi

On Mon, Jan 23, 2017 at 4:04 PM Gerd Hoffmann <kraxel@redhat.com> wrote:

>   Hi,
> >
> > If you only ref, you could have the image being modified while it is
> > being saved asynchronously, this could result in tearing artefacts,
> > no?
>
> Yes, but you have that problem _anyway_.  screendump qmp command can run
> in parallel to guest vcpu, so it can race with guest display updates
> today.  Assuming they happen as simple framebuffer writes and therefore
> don't involve vmexit + grabbing big qemu lock.
>

Agreed, fwiw, I implemented a coroutine-based ppm_save in the qapi-async
branch:
https://github.com/elmarco/qemu/commit/6f45a28ce737eab1d0ce4639f7b015a51a43=
674c

btw, is it supported to reenter the main_loop in hmp_screendump_sync()
(Paolo)?

(the alternative is probably to block hmp until the async command is
finished. This would eventually be interesting if more qmp commands used
from hmp are converted to be async)
--=20
Marc-Andr=C3=A9 Lureau
