Received: from eggs.gnu.org ([2001:4830:134:3::10]:39156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gRg7T-0002bp-Qy
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 11:21:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gRg7S-0007ag-3j
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 11:21:51 -0500
Date: Tue, 27 Nov 2018 16:21:37 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181127162137.GL18381@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181123165511.416480-1-vsementsov@virtuozzo.com>
	<20181123165511.416480-8-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181123165511.416480-8-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 07/11] qcow2-threads: add encryption
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, kwolf@redhat.com, berto@igalia.com, den@openvz.org

On Fri, Nov 23, 2018 at 07:55:07PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Add thread-based encrypt/decrypt. QCrypto don't support parallel
> operations with one block, so we need QCryptoBlock for each thread.



> +static int qcow2_crypto_blocks_open(BDRVQcow2State *s,
> +                                    const char *optprefix,
> +                                    QCryptoBlockReadFunc readfunc,
> +                                    void *opaque,
> +                                    unsigned int flags,
> +                                    Error **errp)
> +{
> +    int i;
> +
> +    s->crypto = qcrypto_block_open(s->crypto_opts, optprefix,
> +                                   readfunc, opaque, flags, errp);
> +    if (!s->crypto) {
> +        qcrypto_block_free(s->crypto);
> +        return -EINVAL;
> +    }
> +
> +    for (i = 0; i < QCOW2_MAX_THREADS; i++) {
> +        s->threads.per_thread[i].crypto =
> +                qcrypto_block_open(s->crypto_opts, optprefix,
> +                                   readfunc, opaque, flags, errp);

We really don't want to be doing this.  LUKS has an intentional time
penalty for opening devices. Each time you open a disk, we expect to
burn 1-2 seconds in CPU time. So this is multiplying that burn by
QCOW2_MAX_THREADS.

What we need todo is modify QCryptoBlock so that it can (optionally)
create many QCryptoCipher instances, allowing each thread to have its
own instance. We'll also need locking around the iv generator calls.

> +        if (!s->threads.per_thread[i].crypto) {
> +            qcow2_crypto_blocks_free(s);
> +            return -EINVAL;
> +        }
> +    }
> +
> +    return 0;
> +}

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
