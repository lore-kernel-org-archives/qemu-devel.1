Received: from eggs.gnu.org ([2001:4830:134:3::10]:42742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gSWRq-0000DL-Sq
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 19:14:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gSWMD-0005vU-1m
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 19:08:38 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33498)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gSWMC-0005un-QZ
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 19:08:32 -0500
Received: by mail-wr1-f67.google.com with SMTP id c14so3644060wrr.0
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 16:08:32 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
References: <20181129180050.17797-1-pbonzini@redhat.com>
Message-ID: <8fcdeb08-d87c-a236-de94-f5129aa3b99b@redhat.com>
Date: Fri, 30 Nov 2018 01:08:29 +0100
MIME-Version: 1.0
In-Reply-To: <20181129180050.17797-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] glib-compat: work around g_test_message
 bug with subprocess tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

On 29/11/18 19:00, Paolo Bonzini wrote:
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

This is not a problem anymore if we switch from gtester to tap.  Do we
want it fixed anyway or not?

Paolo

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Message-Id: <1543343726-53531-1-git-send-email-pbonzini@redhat.com>
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/glib-compat.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/include/glib-compat.h b/include/glib-compat.h
> index fdf95a255d..f675c7328f 100644
> --- a/include/glib-compat.h
> +++ b/include/glib-compat.h
> @@ -113,4 +113,12 @@ gint g_poll_fixed(GPollFD *fds, guint nfds, gint timeout);
>  
>  #pragma GCC diagnostic pop
>  
> +/* See https://gitlab.gnome.org/GNOME/glib/merge_requests/501 */
> +#define g_test_message(...)                                     \
> +    do {                                                        \
> +        if (!g_test_subprocess()) {                             \
> +            g_test_message(__VA_ARGS__);                        \
> +        }                                                       \
> +    } while (0)
> +
>  #endif
> 
