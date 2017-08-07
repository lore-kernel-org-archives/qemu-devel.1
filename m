Received: from eggs.gnu.org ([2001:4830:134:3::10]:42535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dekiW-0001MG-8U
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 12:17:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dekiR-0003j1-B6
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 12:17:20 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1502117160-24655-16-git-send-email-armbru@redhat.com> (Markus
	Armbruster's message of "Mon, 7 Aug 2017 16:45:19 +0200")
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
	<1502117160-24655-16-git-send-email-armbru@redhat.com>
Reply-To: quintela@redhat.com
Date: Mon, 07 Aug 2017 18:10:14 +0200
Message-ID: <87lgmve4ux.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC PATCH 15/56] migration: Make XBZRLE cache
 size unsigned in QAPI/QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, dgilbert@redhat.com, berrange@redhat.com, qemu-block@nongnu.org

Markus Armbruster <armbru@redhat.com> wrote:
> Sizes should use QAPI type 'size' (uint64_t).  migrate-set-cache-size
> parameter @value is 'int' (int64_t).  qmp_migrate_set_cache_size()
> ensures it fits into size_t.  page_cache.c implicitly converts the
> signed size to unsigned types (it can't quite decide whether to use
> uint64_t or size_t for cache offsets, but that's not something I can
> tackle now).
>
> XBZRLECacheStats member @cache-size and query-migrate-cache-size's
> result are also 'int'.
>
> Change the migrate-set-cache-size parameter and the XBZRLECacheStats
> members to 'size', fix up hmp_migrate_set_cache_size(), and tweak a
> few variable types to reduce implicit conversions.
>
> migrate-set-cache-size now accepts size values between 2^63 and
> 2^64-1.  It accepts negative values as before, because that's how the
> QObject input visitor works for backward compatibility.
>
> So does HMP's migrate_set_cache_size.
>
> query-migrate and query-migrate-cache-size now report cache sizes
> above 2^63-1 correctly instead of their (negative) two's complement.
>
> So does HMP's "info migrate_cache_size".  HMP's "info migrate" already
> reported the cache size correctly, because it printed the signed
> integer with PRIu32.
>

Reviewed-by: Juan Quintela <quintela@redhat.com>


> diff --git a/qapi-schema.json b/qapi-schema.json
> index c8cceb9..ecabff6 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -646,7 +646,7 @@
>  # Since: 1.2
>  ##
>  { 'struct': 'XBZRLECacheStats',
> -  'data': {'cache-size': 'int', 'bytes': 'int', 'pages': 'int',
> +  'data': {'cache-size': 'size', 'bytes': 'int', 'pages': 'int',
>             'cache-miss': 'int', 'cache-miss-rate': 'number',
>             'overflow': 'int' } }
>  
> @@ -2875,7 +2875,7 @@
>  # <- { "return": {} }
>  #
>  ##
> -{ 'command': 'migrate-set-cache-size', 'data': {'value': 'int'} }
> +{ 'command': 'migrate-set-cache-size', 'data': {'value': 'size'} }
>  
>  ##
>  # @query-migrate-cache-size:
> @@ -2892,7 +2892,7 @@
>  # <- { "return": 67108864 }
>  #
>  ##
> -{ 'command': 'query-migrate-cache-size', 'returns': 'int' }
> +{ 'command': 'query-migrate-cache-size', 'returns': 'size' }
>  
>  ##
>  # @ObjectPropertyInfo:

I am ussming this bits are backward compatible (I don't understand QMP
to assure this)
