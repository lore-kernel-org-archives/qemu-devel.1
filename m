Received: from eggs.gnu.org ([2001:4830:134:3::10]:35397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1erRlP-0003cr-D0
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 12:13:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1erRlM-0003db-Nc
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 12:13:03 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:50808)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1erRlM-0003ce-Gv
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 12:13:00 -0500
Received: by mail-wm0-x244.google.com with SMTP id w128so13629568wmw.0
	for <qemu-devel@nongnu.org>; Thu, 01 Mar 2018 09:13:00 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20180301084438.13594-1-peterx@redhat.com>
	<20180301084438.13594-7-peterx@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9d61e6c0-8439-23d6-761b-ef3d993e9ac0@redhat.com>
Date: Thu, 1 Mar 2018 18:12:57 +0100
MIME-Version: 1.0
In-Reply-To: <20180301084438.13594-7-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 06/15] qio: store gsources for net
 listeners
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
> Originally we were storing the GSources tag IDs.  That'll be not enough
> if we are going to support non-default gcontext for QIO code.  Switch to
> GSources without changing anything real.  Now we still always pass in
> NULL, which means the default gcontext.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/io/net-listener.h | 21 ++++++++++++++--
>  io/net-listener.c         | 62 +++++++++++++++++++++++++++++------------------
>  2 files changed, 58 insertions(+), 25 deletions(-)
> 
> diff --git a/include/io/net-listener.h b/include/io/net-listener.h
> index 56d6da7a76..566be283b3 100644
> --- a/include/io/net-listener.h
> +++ b/include/io/net-listener.h
> @@ -53,7 +53,7 @@ struct QIONetListener {
>  
>      char *name;
>      QIOChannelSocket **sioc;
> -    gulong *io_tag;
> +    GSource **io_source;
>      size_t nsioc;
>  
>      bool connected;
> @@ -120,17 +120,34 @@ void qio_net_listener_add(QIONetListener *listener,
>                            QIOChannelSocket *sioc);
>  
>  /**
> - * qio_net_listener_set_client_func:
> + * qio_net_listener_set_client_func_full:
>   * @listener: the network listener object
>   * @func: the callback function
>   * @data: opaque data to pass to @func
>   * @notify: callback to free @data
> + * @context: the context that the sources will be bound to

Please add a note like "if %NULL, the default context will be used".

Paolo
