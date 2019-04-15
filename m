Received: from eggs.gnu.org ([209.51.188.92]:36918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hFylo-00035H-Vs
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 06:23:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hFylo-0000Au-4g
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 06:23:24 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40604)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hFyln-00005e-Th
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 06:23:24 -0400
Received: by mail-wm1-f66.google.com with SMTP id z24so19794067wmi.5
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 03:23:22 -0700 (PDT)
References: <20190315032629.21234-1-richard.henderson@linaro.org>
	<20190315032629.21234-13-richard.henderson@linaro.org>
	<6ea1d95e-f5c7-7b14-04c7-07699e9d564a@redhat.com>
	<66f73b23-11cc-b5b3-e4ca-34776a4faf32@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bed878ef-0ce1-1081-a4cb-88b7775d1433@redhat.com>
Date: Mon, 15 Apr 2019 12:23:18 +0200
MIME-Version: 1.0
In-Reply-To: <66f73b23-11cc-b5b3-e4ca-34776a4faf32@linaro.org>
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
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Thomas Huth <thuth@redhat.com>

On 4/13/19 8:44 AM, Richard Henderson wrote:
> On 4/10/19 11:49 PM, Philippe Mathieu-Daudé wrote:
>>> -    if (seed_optarg != NULL) {
>>> -        qemu_guest_random_seed_main(seed_optarg, &error_fatal);
>>> +    {
>> Since 7be41675f7c we use gnu99 C, so this extra block indentation can be
>> removed.
>>
>>> +        Error *err = NULL;
>>> +        if (seed_optarg != NULL) {
>>> +            qemu_guest_random_seed_main(seed_optarg, &err);
>>> +        } else {
>>> +            /* ??? Assumes qcrypto is only used by qemu_guest_getrandom.  */
>>> +            qcrypto_init(&err);
>>> +        }
>>> +        if (err) {
>>> +            error_reportf_err(err, "cannot initialize crypto: ");
>>> +            exit(1);
>>> +        }
>>>      }
> 
> I could, but it also limits the scope, which is of more importance to variables
> who have their address taken.  It means that their storage could (in theory) be
> shared with objects not overlapping in scope.

Fine then.

I think your '???' comment is appropriate but I'd rather let Daniel
opinate. Except that comment, for the rest:

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
