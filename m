Received: from eggs.gnu.org ([2001:4830:134:3::10]:52615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gRiSZ-0001of-D5
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 13:51:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gRiQ8-0006mk-9x
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 13:49:19 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46567)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gRiQ8-0006mU-4Z
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 13:49:16 -0500
Received: by mail-qt1-f196.google.com with SMTP id y20so22951139qtm.13
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 10:49:16 -0800 (PST)
MIME-Version: 1.0
References: <1543343726-53531-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543343726-53531-1-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 27 Nov 2018 22:49:03 +0400
Message-ID: <CAMxuvawT9NgS6N769gmZ+kzSzefBcp1eYpa_h_OWJ2S12b_O=g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] glib-compat: work around g_test_message
 bug with subprocess tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Bonzini, Paolo" <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Tue, Nov 27, 2018 at 10:35 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Subprocesses are created by glib without leaving the file descriptors
> open.  Therefore, g_test_message (and assertion failures, but those
> trigger when things are going bad anyway) will think that it is writing
> to the log file descriptor, but while actually stomping on the QMP
> file descriptor or similar.  This causes spurious failures, which are
> as nice to debug as the reader can imagine.  While I have opened a
> pull request on GLib, this will probably take a while to propagate
> to distros.
>
> I found this while working on qgraph, but the fix is generic.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

good catch! makes me wonder if g_test_message() is supposed to be
usable in a subprocess.. Let see the review comments on upstream bug.
At least, documentation should be updated.

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  include/glib-compat.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/include/glib-compat.h b/include/glib-compat.h
> index fdf95a2..989b9ef 100644
> --- a/include/glib-compat.h
> +++ b/include/glib-compat.h
> @@ -113,4 +113,10 @@ gint g_poll_fixed(GPollFD *fds, guint nfds, gint tim=
eout);
>
>  #pragma GCC diagnostic pop
>
> +/* See https://gitlab.gnome.org/GNOME/glib/merge_requests/501 */
> +#define g_test_message(...)                                             =
       \
> +       do {                                                             =
       \
> +               if (!g_test_subprocess()) g_test_message(__VA_ARGS__);   =
       \
> +       } while (0)
> +
>  #endif
> --
> 1.8.3.1
>
