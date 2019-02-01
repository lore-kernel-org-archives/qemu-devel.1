Received: from eggs.gnu.org ([209.51.188.92]:37874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gpa5t-0007No-5R
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 09:47:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gpa5r-0002j2-4C
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 09:47:01 -0500
Date: Fri, 1 Feb 2019 14:46:32 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190201144632.GT12005@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1548942405-760115-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1548942405-760115-2-git-send-email-andrey.shinkevich@virtuozzo.com>
	<a0fe9357-7128-21cb-f5b5-ef766baaccbd@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a0fe9357-7128-21cb-f5b5-ef766baaccbd@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v11 1/3] bdrv_query_image_info Error
 parameter added
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "eblake@redhat.com" <eblake@redhat.com>, "fam@euphon.net" <fam@euphon.net>, "armbru@redhat.com" <armbru@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, Denis Lunev <den@virtuozzo.com>

On Fri, Feb 01, 2019 at 02:42:10PM +0000, Vladimir Sementsov-Ogievskiy wrote:
> 31.01.2019 16:46, Andrey Shinkevich wrote:
> > Inform a user in case qcow2_get_specific_info fails to obtain
> > QCOW2 image specific information. This patch is preliminary to
> > the print of bitmap information in the 'qemu-img info' output.
> > 
> > Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> > ---
> 
> 
> [...]
> 
> > --- a/block/crypto.c
> > +++ b/block/crypto.c
> > @@ -594,13 +594,13 @@ static int block_crypto_get_info_luks(BlockDriverState *bs,
> >   }
> >   
> >   static ImageInfoSpecific *
> > -block_crypto_get_specific_info_luks(BlockDriverState *bs)
> > +block_crypto_get_specific_info_luks(BlockDriverState *bs, Error **errp)
> >   {
> >       BlockCrypto *crypto = bs->opaque;
> >       ImageInfoSpecific *spec_info;
> >       QCryptoBlockInfo *info;
> >   
> > -    info = qcrypto_block_get_info(crypto->block, NULL);
> > +    info = qcrypto_block_get_info(crypto->block, errp);
> >       if (!info) {
> >           return NULL;
> >       }
> 
> more context:
> 
>        if (info->format != Q_CRYPTO_BLOCK_FORMAT_LUKS) {
>            qapi_free_QCryptoBlockInfo(info);
>            return NULL;
>        }
> 
> for a fast look, I think it should be assertion, not if, Daniel, am I right?

Sure, it could be an assertion. In practice it should never trigger
eitherway.

> Also, I think we don't have block/crypto.c in Cryptography section of MAINTAINERS
> by mistake, so you were not CC'ed.

I tend to let the block maintainers merge patches under block/,
since that's largely block layer integration. The guts of the
block crypto stuff is under crypto/


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
