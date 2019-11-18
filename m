Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B110C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 07:36:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E1EB206F4
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 07:36:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E1EB206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWbaT-0007K2-4g
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 02:36:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44672)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1iWbZl-0006sh-6Y
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 02:35:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1iWbZj-000062-1X
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 02:35:56 -0500
Received: from mga11.intel.com ([192.55.52.93]:9494)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1iWbZi-00005W-QC
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 02:35:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Nov 2019 23:35:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,319,1569308400"; d="scan'208";a="405999870"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.197.13])
 ([10.239.197.13])
 by fmsmga005.fm.intel.com with ESMTP; 17 Nov 2019 23:35:47 -0800
Subject: Re: [PATCH v16 03/14] util/cutils: refactor do_strtosz() to support
 suffixes list
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>
References: <20191115075352.17734-1-tao3.xu@intel.com>
 <20191115075352.17734-4-tao3.xu@intel.com>
 <f523361e-1aec-1bf7-2985-f6619adf3d95@redhat.com>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <510118cb-1d44-3dec-9b64-6dea7a5096e9@intel.com>
Date: Mon, 18 Nov 2019 15:35:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <f523361e-1aec-1bf7-2985-f6619adf3d95@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.93
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "lvivier@redhat.com" <lvivier@redhat.com>,
 "thuth@redhat.com" <thuth@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 Stefan Weil <sw@weilnetz.de>, "Du, Fan" <fan.du@intel.com>,
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Liu,
 Jingqi" <jingqi.liu@intel.com>, "imammedo@redhat.com" <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/15/2019 8:11 PM, Philippe Mathieu-Daudé wrote:
> Cc'ing Markus & Stefan.
> 
> On 11/15/19 8:53 AM, Tao Xu wrote:
>> Add do_strtomul() to convert string according to different suffixes.
>>
>> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
>> ---
>>
>> No changes in v16.
>>
>> Changes in v15:
>>       - Add a new patch to refactor do_strtosz() (Eduardo)
>> ---
>>    util/cutils.c | 72 ++++++++++++++++++++++++++++++---------------------
>>    1 file changed, 42 insertions(+), 30 deletions(-)
>>
>> diff --git a/util/cutils.c b/util/cutils.c
>> index d94a468954..ffef92338a 100644
>> --- a/util/cutils.c
>> +++ b/util/cutils.c
>> @@ -181,41 +181,37 @@ int fcntl_setfl(int fd, int flag)
>>    }
>>    #endif
>>    
>> -static int64_t suffix_mul(char suffix, int64_t unit)
>> +static int64_t suffix_mul(const char *suffixes[], int num_suffix,
>> +                          const char *endptr, int *offset, int64_t unit)
>>    {
>> -    switch (qemu_toupper(suffix)) {
>> -    case 'B':
>> -        return 1;
>> -    case 'K':
>> -        return unit;
>> -    case 'M':
>> -        return unit * unit;
>> -    case 'G':
>> -        return unit * unit * unit;
>> -    case 'T':
>> -        return unit * unit * unit * unit;
>> -    case 'P':
>> -        return unit * unit * unit * unit * unit;
>> -    case 'E':
>> -        return unit * unit * unit * unit * unit * unit;
>> +    int i, suffix_len;
>> +    int64_t mul = 1;
>> +
>> +    for (i = 0; i < num_suffix; i++) {
>> +        suffix_len = strlen(suffixes[i]);
>> +        if (g_ascii_strncasecmp(suffixes[i], endptr, suffix_len) == 0) {
>> +            *offset = suffix_len;
> 
> So now we can parse "8kB" and "8Kb", and this might be confusing when
> parsing bit units.
> 
>     https://en.wikipedia.org/wiki/Kilobyte#Definitions_and_usage:
> 
>     IEC 80000-13 standard uses the term 'byte' to mean
>     eight bits (1 B = 8 bit).
> 
> At some point we'll need to add the IEC suffix parsing to this function.
> 
>     https://en.wikipedia.org/wiki/Kibibyte#Definition
> 
> Meanwhile, can you keep it to upper case suffix only?

Here I use g_ascii_strncasecmp() because qemu originally
use qemu_toupper(). This will not cause compatibility issue, because 
qemu use B/b for bytes, K/k for KB, M/m for MB, G/g for GB or T/t for TB 
for a long time.

I am wondering if we can add a new do_strtosz_iec() for upper case 
suffix only.
> 
>> +            return mul;
>> +    }
>> +        mul *= unit;
>>        }
>> +
>>        return -1;
>>    }
>>    
>>    /*
>> - * Convert string to bytes, allowing either B/b for bytes, K/k for KB,
>> - * M/m for MB, G/g for GB or T/t for TB. End pointer will be returned
>> - * in *end, if not NULL. Return -ERANGE on overflow, and -EINVAL on
>> - * other error.
>> + * Convert string according to different suffixes. End pointer will be returned
>> + * in *end, if not NULL. Return -ERANGE on overflow, and -EINVAL on other error.
>>     */
>> -static int do_strtosz(const char *nptr, const char **end,
>> -                      const char default_suffix, int64_t unit,
>> +static int do_strtomul(const char *nptr, const char **end,
>> +                       const char *suffixes[], int num_suffix,
>> +                       const char *default_suffix, int64_t unit,
>>                          uint64_t *result)
>>    {
>>        int retval;
>>        const char *endptr;
>> -    unsigned char c;
>>        int mul_required = 0;
>> +    int offset = 0;
>>        long double val, mul, integral, fraction;
>>    
>>        retval = qemu_strtold_finite(nptr, &endptr, &val);
>> @@ -226,12 +222,12 @@ static int do_strtosz(const char *nptr, const char **end,
>>        if (fraction != 0) {
>>            mul_required = 1;
>>        }
>> -    c = *endptr;
>> -    mul = suffix_mul(c, unit);
>> +
>> +    mul = suffix_mul(suffixes, num_suffix, endptr, &offset, unit);
>>        if (mul >= 0) {
>> -        endptr++;
>> +        endptr += offset;
>>        } else {
>> -        mul = suffix_mul(default_suffix, unit);
>> +        mul = suffix_mul(suffixes, num_suffix, default_suffix, &offset, unit);
>>            assert(mul >= 0);
>>        }
>>        if (mul == 1 && mul_required) {
>> @@ -256,19 +252,35 @@ out:
>>        return retval;
>>    }
>>    
>> +/*
>> + * Convert string to bytes, allowing either B/b for bytes, K/k for KB,
> 
> Then also fix here "B/b for bytes".
> 
>> + * M/m for MB, G/g for GB or T/t for TB. End pointer will be returned
> 
> Shouldn't we refuse m/g/t? (m is the 'milli' suffix)
> 
> Thanks,
> 
> Phil.
> 
>> + * in *end, if not NULL. Return -ERANGE on overflow, and -EINVAL on
>> + * other error.
>> + */
>> +static int do_strtosz(const char *nptr, const char **end,
>> +                      const char *default_suffix, int64_t unit,
>> +                      uint64_t *result)
>> +{
>> +    static const char *suffixes[] = { "B", "K", "M", "G", "T", "P", "E" };
>> +
>> +    return do_strtomul(nptr, end, suffixes, ARRAY_SIZE(suffixes),
>> +                       default_suffix, unit, result);
>> +}
>> +
>>    int qemu_strtosz(const char *nptr, const char **end, uint64_t *result)
>>    {
>> -    return do_strtosz(nptr, end, 'B', 1024, result);
>> +    return do_strtosz(nptr, end, "B", 1024, result);
>>    }
>>    
>>    int qemu_strtosz_MiB(const char *nptr, const char **end, uint64_t *result)
>>    {
>> -    return do_strtosz(nptr, end, 'M', 1024, result);
>> +    return do_strtosz(nptr, end, "M", 1024, result);
>>    }
>>    
>>    int qemu_strtosz_metric(const char *nptr, const char **end, uint64_t *result)
>>    {
>> -    return do_strtosz(nptr, end, 'B', 1000, result);
>> +    return do_strtosz(nptr, end, "B", 1000, result);
>>    }
>>    
>>    /**
>>
> 


