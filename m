Received: from eggs.gnu.org ([2001:4830:134:3::10]:46503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1df6sr-0002hP-GE
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:57:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1df6sq-0006xq-Cj
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:57:29 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
	<1502117160-24655-16-git-send-email-armbru@redhat.com>
	<87lgmve4ux.fsf@secure.mitica>
Date: Tue, 08 Aug 2017 17:57:12 +0200
In-Reply-To: <87lgmve4ux.fsf@secure.mitica> (Juan Quintela's message of "Mon,
	07 Aug 2017 18:10:14 +0200")
Message-ID: <87a83a6oiv.fsf@dusky.pond.sub.org>
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
To: Juan Quintela <quintela@redhat.com>
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, jsnow@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com, dgilbert@redhat.com

Juan Quintela <quintela@redhat.com> writes:

> Markus Armbruster <armbru@redhat.com> wrote:
>> Sizes should use QAPI type 'size' (uint64_t).  migrate-set-cache-size
>> parameter @value is 'int' (int64_t).  qmp_migrate_set_cache_size()
>> ensures it fits into size_t.  page_cache.c implicitly converts the
>> signed size to unsigned types (it can't quite decide whether to use
>> uint64_t or size_t for cache offsets, but that's not something I can
>> tackle now).
>>
>> XBZRLECacheStats member @cache-size and query-migrate-cache-size's
>> result are also 'int'.
>>
>> Change the migrate-set-cache-size parameter and the XBZRLECacheStats
>> members to 'size', fix up hmp_migrate_set_cache_size(), and tweak a
>> few variable types to reduce implicit conversions.
>>
>> migrate-set-cache-size now accepts size values between 2^63 and
>> 2^64-1.  It accepts negative values as before, because that's how the
>> QObject input visitor works for backward compatibility.
>>
>> So does HMP's migrate_set_cache_size.
>>
>> query-migrate and query-migrate-cache-size now report cache sizes
>> above 2^63-1 correctly instead of their (negative) two's complement.
>>
>> So does HMP's "info migrate_cache_size".  HMP's "info migrate" already
>> reported the cache size correctly, because it printed the signed
>> integer with PRIu32.
>>
>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
>
>
>> diff --git a/qapi-schema.json b/qapi-schema.json
>> index c8cceb9..ecabff6 100644
>> --- a/qapi-schema.json
>> +++ b/qapi-schema.json
>> @@ -646,7 +646,7 @@
>>  # Since: 1.2
>>  ##
>>  { 'struct': 'XBZRLECacheStats',
>> -  'data': {'cache-size': 'int', 'bytes': 'int', 'pages': 'int',
>> +  'data': {'cache-size': 'size', 'bytes': 'int', 'pages': 'int',
>>             'cache-miss': 'int', 'cache-miss-rate': 'number',
>>             'overflow': 'int' } }
>>  
>> @@ -2875,7 +2875,7 @@
>>  # <- { "return": {} }
>>  #
>>  ##
>> -{ 'command': 'migrate-set-cache-size', 'data': {'value': 'int'} }
>> +{ 'command': 'migrate-set-cache-size', 'data': {'value': 'size'} }
>>  
>>  ##
>>  # @query-migrate-cache-size:
>> @@ -2892,7 +2892,7 @@
>>  # <- { "return": 67108864 }
>>  #
>>  ##
>> -{ 'command': 'query-migrate-cache-size', 'returns': 'int' }
>> +{ 'command': 'query-migrate-cache-size', 'returns': 'size' }
>>  
>>  ##
>>  # @ObjectPropertyInfo:
>
> I am ussming this bits are backward compatible (I don't understand QMP
> to assure this)

I guess I should've explained this in the cover letter.

Until recent commit 5923f85, integers between INT64_MAX+1 and UINT64_MAX
did not work in QMP.  QEMU sent and accepted integers between INT64_MIN
and -1 instead.

The fix maintains strict compatibility for QMP input: negative integers
are accepted as before for backward compatibility.  Perhaps we can get
rid of this wart some day.

It does not maintain strict compatibility for QMP output: we now output
the correct integer.  We figure that's tolerable, because the obvious
way to parse the old output is strtoull(), and that does the right thing
for the new output when it does the right thing for the old output.

Fixing a QAPI type from 'int' to 'size' has the same compatibility
impact.

Questions?
