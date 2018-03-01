Received: from eggs.gnu.org ([2001:4830:134:3::10]:42136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1erS9R-0008IK-My
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 12:37:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1erS9O-0002ot-EG
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 12:37:53 -0500
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:39499)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1erS9O-0002oY-6s
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 12:37:50 -0500
Received: by mail-wm0-x22e.google.com with SMTP id i3so12285870wmi.4
	for <qemu-devel@nongnu.org>; Thu, 01 Mar 2018 09:37:50 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20180301084438.13594-1-peterx@redhat.com>
	<20180301084438.13594-16-peterx@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <814dcb27-0d79-9193-d6af-332ced804770@redhat.com>
Date: Thu, 1 Mar 2018 18:37:47 +0100
MIME-Version: 1.0
In-Reply-To: <20180301084438.13594-16-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 15/15] chardev: tcp: postpone TLS work
 until machine done
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On 01/03/2018 09:44, Peter Xu wrote:
> +static bool tcp_chr_machine_done;
> +
>  static void tcp_chr_reconn_timer_cancel(SocketChardev *s)
>  {
>      if (s->reconnect_timer) {
> @@ -719,6 +721,11 @@ static void tcp_chr_tls_init(Chardev *chr)
>      Error *err = NULL;
>      gchar *name;
>  
> +    if (!tcp_chr_machine_done) {
> +        /* This will be postponed to machine_done notifier */
> +        return;
> +    }
> +

Can you instead add a global machine_init_done bool to vl.c and
include/sysemu/sysemu.h (and make it always true in
stubs/machine-init-done.c)?

Then muxes_realized can go away too.

Thanks,

Paolo
