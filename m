Received: from eggs.gnu.org ([209.51.188.92]:56962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwCXu-0008QJ-7g
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 16:03:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwCXt-0004K8-7Y
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 16:03:18 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44799)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gwCXt-0004JL-1K
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 16:03:17 -0500
Received: by mail-wr1-f66.google.com with SMTP id w2so8920836wrt.11
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 13:03:16 -0800 (PST)
References: <1550603704-22474-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<d935f740-e792-1b7b-80ed-eb400ee14a3d@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a0214921-e873-9611-6bdb-966e4065e9dd@redhat.com>
Date: Tue, 19 Feb 2019 22:03:13 +0100
MIME-Version: 1.0
In-Reply-To: <d935f740-e792-1b7b-80ed-eb400ee14a3d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] target/mips: implement QMP
 query-cpu-definitions command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: natalia.fursova@ispras.ru, arikalo@wavecomp.com, armbru@redhat.com, mdroth@linux.vnet.ibm.com, dovgaluk@ispras.ru, amarkovic@wavecomp.com, marcandre.lureau@redhat.com, aurelien@aurel32.net

Hi Eric,

On 2/19/19 9:12 PM, Eric Blake wrote:
> On 2/19/19 1:15 PM, Aleksandar Markovic wrote:
>> From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
>>
>> This patch enables QMP-based querying of the available CPU types for
>> MIPS and MIPS64 platforms.
>>
>> Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
>> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
> 
>> +++ b/qapi/target.json
>> @@ -499,7 +499,7 @@
>>              'static': 'bool',
>>              '*unavailable-features': [ 'str' ],
>>              'typename': 'str' },
>> -  'if': 'defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I386) || defined(TARGET_S390X)' }
>> +  'if': 'defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I386) || defined(TARGET_S390X) || defined(TARGET_MIPS)' }
> 
> Hmm. Long line; however, the argument to 'if' is pasted literally to an
> #if directive, which would break if we added newlines in the middle.
> And we can't use literal newlines in the middle of a JSON string.  About
> the only thing I could think of that might allow for more manageable
> line lengths would be permitting:
> 
> 'if': [ 'defined(TARGET_PPC)',
>         'defined(TARGET_ARM)' ...]

Can this be:

'if': [
        'defined(TARGET_PPC)',
        'defined(TARGET_ARM)',
        ...
      ]

?

> where the QAPI generator would in turn form the disjunction of supplying
> the || between each term when the 'if' is an array of strings. But that
> feels like a lot of effort for little gain compared to just living with
> the long lines.

Single line looks easier thus less bug prone.

Multiline improves git diff/blame.

The former looks safer.
