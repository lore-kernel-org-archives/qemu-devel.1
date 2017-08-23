Received: from eggs.gnu.org ([2001:4830:134:3::10]:54969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dkUEF-0007gV-Hp
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 07:53:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dkUEA-00047w-Ns
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 07:53:47 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <87efs21q92.fsf@dusky.pond.sub.org>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
	<20170822132255.23945-12-marcandre.lureau@redhat.com>
	<87efs21q92.fsf@dusky.pond.sub.org>
Date: Wed, 23 Aug 2017 13:53:39 +0200
Message-ID: <w51378iijp8.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 11/54] quorum: use qapi_enum_parse() in
 quorum_open
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, "open list:Quorum" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

On Wed 23 Aug 2017 01:24:09 PM CEST, Markus Armbruster wrote:
>>  static int quorum_open(BlockDriverState *bs, QDict *options, int flags,
>>                         Error **errp)
>>  {
>> @@ -925,7 +908,13 @@ static int quorum_open(BlockDriverState *bs, QDict *options, int flags,
>>          goto exit;
>>      }
>>  
>> -    ret = parse_read_pattern(qemu_opt_get(opts, QUORUM_OPT_READ_PATTERN));
>> +    if (!qemu_opt_get(opts, QUORUM_OPT_READ_PATTERN)) {
>> +        ret = QUORUM_READ_PATTERN_QUORUM;
>> +    } else {
>> +        ret = qapi_enum_parse(QuorumReadPattern_lookup,
>> +                              qemu_opt_get(opts, QUORUM_OPT_READ_PATTERN),
>> +                              QUORUM_READ_PATTERN__MAX, -EINVAL, NULL);
>> +    }
>>      if (ret < 0) {
>>          error_setg(&local_err, "Please set read-pattern as fifo or quorum");
>>          goto exit;
>
> qapi_enum_parse() copes with null input: it returns its fourth argument
> then.  I don't like that also returns it on error, but that shouldn't be
> a problem here.
>
> If we can live with qapi_enum_parse()'s sub-par error message, then this
> should do:
>
>        ret = qapi_enum_parse(QuorumReadPattern_lookup,
>                              qemu_opt_get(opts, QUORUM_OPT_READ_PATTERN),
>                              QUORUM_READ_PATTERN__MAX,
>                              QUORUM_READ_PATTERN_QUORUM, &local_err);
>        if (local_err) {
>            goto exit;
>        }

That actually doesn't sound so bad.

> If not, we'd have to replace @local_err:
>
>        if (local_err) {
>            error_free(local_err);
>            error_setg(&local_err, "Please set read-pattern as fifo or quorum");
>            goto exit;
>        }

Instead of replacing @local_err I'd rather have an intermediate variable
like this:

    pattern_str = qemu_opt_get(opts, QUORUM_OPT_READ_PATTERN); 
    if (!pattern_str) {
        ret = QUORUM_READ_PATTERN_QUORUM;
    } else {
        ret = qapi_enum_parse(QuorumReadPattern_lookup, pattern_str,
                              QUORUM_READ_PATTERN__MAX, -EINVAL, NULL);
    }

I think I prefer this last one the best, but using the default error
message is also ok. With either solution,

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
