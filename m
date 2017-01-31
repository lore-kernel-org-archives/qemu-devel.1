Received: from eggs.gnu.org ([2001:4830:134:3::10]:43374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cYUQO-0002PE-ES
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 04:08:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cYUQN-0006Q5-I9
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 04:08:28 -0500
Received: from mail-yb0-x242.google.com ([2607:f8b0:4002:c09::242]:35733)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cYUQN-0006Pw-Cm
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 04:08:27 -0500
Received: by mail-yb0-x242.google.com with SMTP id j82so23202682ybg.2
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 01:08:27 -0800 (PST)
MIME-Version: 1.0
References: <20170130133954.31353-1-marcandre.lureau@redhat.com>
	<20170130133954.31353-20-marcandre.lureau@redhat.com>
	<68c0ebae-7559-80eb-23fc-f8acc218a6d3@redhat.com>
In-Reply-To: <68c0ebae-7559-80eb-23fc-f8acc218a6d3@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 31 Jan 2017 09:08:15 +0000
Message-ID: <CAJ+F1CL1reqXTC+qvhcjKbNt2YSFd=R37A7ZidiVJdFXv7nhdQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 19/41] char: remove class kind field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

Hi

On Tue, Jan 31, 2017 at 12:08 AM Paolo Bonzini <pbonzini@redhat.com> wrote:

>
>
> On 30/01/2017 08:39, Marc-Andr=C3=A9 Lureau wrote:
> > The class kind is necessary to lookup the chardev name in
> > qmp_chardev_add() after calling qemu_chr_new_from_opts() and to set
> > the appropriate ChardevBackend (mainly to free the right
> > fields).
> >
> > qemu_chr_new_from_opts() can be changed to use a non-qmp function
> > using the chardev class typename. Introduce qemu_chardev_add() to be
> > called from qemu_chr_new_from_opts() and remove the class chardev kind
> > field. Set the backend->type in the parse callback (when non-common
> > fields are added).
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  include/sysemu/char.h |  1 -
> >  backends/baum.c       |  1 -
> >  backends/msmouse.c    |  1 -
> >  backends/testdev.c    |  1 -
> >  qemu-char.c           | 99
> +++++++++++++++++++++++++--------------------------
> >  spice-qemu-char.c     |  4 +--
> >  ui/console.c          |  2 +-
> >  ui/gtk.c              |  1 -
> >  8 files changed, 51 insertions(+), 59 deletions(-)
>
> I am not sure about this patch.  Why not remove backend->type
> altogether, and instead look at ChardevClass with object_dynamic_cast?
>
>
For the reason I gave in the patch summary: qapi_free_ChardevBackend()
dispatch based on ChardevBackendKind enum, not on Chardev object type.

--=20
Marc-Andr=C3=A9 Lureau
