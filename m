Received: from eggs.gnu.org ([2001:4830:134:3::10]:52961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gRiSx-0002Fo-TO
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 13:52:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gRiLU-0004Iu-2V
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 13:44:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54114)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gRiLT-0004Ik-TF
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 13:44:28 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5D0B54ACD6
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 18:44:27 +0000 (UTC)
References: <1543343726-53531-1-git-send-email-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a7634330-8c47-459b-5aaa-1c4519a90dd6@redhat.com>
Date: Tue, 27 Nov 2018 12:44:23 -0600
MIME-Version: 1.0
In-Reply-To: <1543343726-53531-1-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 11/27/18 12:35 PM, Paolo Bonzini wrote:
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
> ---
>   include/glib-compat.h | 6 ++++++
>   1 file changed, 6 insertions(+)

Wow. I don't envy the debug session that you went through to finally 
realize this problem.

Reviewed-by: Eric Blake <eblake@redhat.com>

I think this is safe for 3.1-rc3 if you want it there, as minimizing 
spurious test failures is a good thing.

> diff --git a/include/glib-compat.h b/include/glib-compat.h
> index fdf95a2..989b9ef 100644
> --- a/include/glib-compat.h
> +++ b/include/glib-compat.h
> @@ -113,4 +113,10 @@ gint g_poll_fixed(GPollFD *fds, guint nfds, gint timeout);
>   
>   #pragma GCC diagnostic pop
>   
> +/* See https://gitlab.gnome.org/GNOME/glib/merge_requests/501 */
> +#define g_test_message(...)							\
> +	do {									\
> +		if (!g_test_subprocess()) g_test_message(__VA_ARGS__);		\

I'm surprised checkpatch.pl doesn't complain about missing {} in this 
macro expansion, but doing it right would mean 2 more lines, so I'm fine 
overlooking the style.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
