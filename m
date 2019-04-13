Received: from eggs.gnu.org ([209.51.188.92]:51150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hFCOi-0006A0-LW
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 02:44:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hFCOh-0008Ik-RM
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 02:44:20 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:36377)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hFCOh-0008I7-As
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 02:44:19 -0400
Received: by mail-pl1-x644.google.com with SMTP id ck15so6156454plb.3
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 23:44:18 -0700 (PDT)
References: <20190315032629.21234-1-richard.henderson@linaro.org>
	<20190315032629.21234-13-richard.henderson@linaro.org>
	<6ea1d95e-f5c7-7b14-04c7-07699e9d564a@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <66f73b23-11cc-b5b3-e4ca-34776a4faf32@linaro.org>
Date: Fri, 12 Apr 2019 20:44:12 -1000
MIME-Version: 1.0
In-Reply-To: <6ea1d95e-f5c7-7b14-04c7-07699e9d564a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 12/23] linux-user: Call qcrypto_init if
 not using -seed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Thomas Huth <thuth@redhat.com>

On 4/10/19 11:49 PM, Philippe Mathieu-Daudé wrote:
>> -    if (seed_optarg != NULL) {
>> -        qemu_guest_random_seed_main(seed_optarg, &error_fatal);
>> +    {
> Since 7be41675f7c we use gnu99 C, so this extra block indentation can be
> removed.
> 
>> +        Error *err = NULL;
>> +        if (seed_optarg != NULL) {
>> +            qemu_guest_random_seed_main(seed_optarg, &err);
>> +        } else {
>> +            /* ??? Assumes qcrypto is only used by qemu_guest_getrandom.  */
>> +            qcrypto_init(&err);
>> +        }
>> +        if (err) {
>> +            error_reportf_err(err, "cannot initialize crypto: ");
>> +            exit(1);
>> +        }
>>      }

I could, but it also limits the scope, which is of more importance to variables
who have their address taken.  It means that their storage could (in theory) be
shared with objects not overlapping in scope.


r~
