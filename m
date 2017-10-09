Received: from eggs.gnu.org ([2001:4830:134:3::10]:42099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e1V5m-0003B9-2m
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 06:15:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e1V5h-0005eG-VE
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 06:15:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54160)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e1V5h-0005c8-CM
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 06:15:17 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 59088356E1
	for <qemu-devel@nongnu.org>; Mon,  9 Oct 2017 10:15:16 +0000 (UTC)
Date: Mon, 9 Oct 2017 11:15:04 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171009101504.GF2954@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171004104636.7963-1-quintela@redhat.com>
	<20171004104636.7963-5-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171004104636.7963-5-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v9 04/12] migration: Start of multiple fd
 work
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

On Wed, Oct 04, 2017 at 12:46:28PM +0200, Juan Quintela wrote:
> We create new channels for each new thread created. We send through
> them a string containing <uuid> multifd <channel number> so we are
> sure that we connect the right channels in both sides.

This message needs updating now that we send a struct.


> diff --git a/migration/ram.c b/migration/ram.c
> index b83f8977c5..b57006594b 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -414,9 +425,27 @@ int multifd_save_cleanup(Error **errp)
>      return ret;
>  }
>  
> +typedef struct {
> +    uint32_t version;
> +    uint8_t id;
> +    char uuid[UUID_FMT_LEN];
> +} MigrateMultiFDInit_t;

We add an __attribute__((packed)) here since we send it directly
on the wire. Perhaps put 'uuid' field before 'id' when doing that
so 'uuid' gets a more natural alignment.

If we use 'unsigned char uuid[16]' then you don't need to convert
from string format either...

>  static void *multifd_send_thread(void *opaque)
>  {
>      MultiFDSendParams *p = opaque;
> +    MigrateMultiFDInit_t msg;
> +    Error *local_err = NULL;
> +    size_t ret;
> +
> +    msg.version = 1;
> +    msg.id = p->id;
> +    qemu_uuid_unparse(&qemu_uuid, (char *)&msg.uuid);

eg this could be   memcpy(msg.uuid, qemu_uuid.data, sizeof(msg.uuid))

> +    ret = qio_channel_write_all(p->c, (char *)&msg, sizeof(msg), &local_err);
> +    if (ret != 0) {
> +        terminate_multifd_send_threads(local_err);
> +        return NULL;
> +    }
>  
>      while (true) {
>          qemu_mutex_lock(&p->mutex);
> @@ -431,6 +460,27 @@ static void *multifd_send_thread(void *opaque)
>      return NULL;
>  }

> +void multifd_new_channel(QIOChannel *ioc)
> +{
> +    MultiFDRecvParams *p;
> +    MigrateMultiFDInit_t msg;
> +    Error *local_err = NULL;
> +    char *uuid;
> +    size_t ret;
> +
> +    ret = qio_channel_read_all(ioc, (char *)&msg, sizeof(msg), &local_err);
> +    if (ret != 0) {
> +        terminate_multifd_recv_threads(local_err);
> +        return;
> +    }
> +
> +    uuid = qemu_uuid_unparse_strdup(&qemu_uuid);

...and here we would avoid need to unparse, instead..

> +
> +    if (strcmp(msg.uuid, uuid)) {

  memcmp(msg.uuid, qemu_uuid.data, sizeof(msg.uuid) != 0

> +        g_free(uuid);
> +        error_setg(&local_err, "multifd: received uuid '%s' and expected "
> +                   "uuid '%s' for channel %hhd", msg.uuid, uuid, msg.id);
> +        terminate_multifd_recv_threads(local_err);
> +        return;
> +    }
> +    g_free(uuid);
> +

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
