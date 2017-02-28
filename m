Received: from eggs.gnu.org ([2001:4830:134:3::10]:57832)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1cieZH-0004LN-H3
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 04:59:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1cieZE-0002GU-HN
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 04:59:39 -0500
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:54821 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1cieZE-0002Fh-8H
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 04:59:36 -0500
References: <1488193394-28453-1-git-send-email-pl@kamp.de>
	<07ef9e24-a17b-536b-8ef3-9a105cfe6bc6@redhat.com>
From: Peter Lieven <pl@kamp.de>
Message-ID: <11860d28-91e1-3858-e5f6-4176e9f72816@kamp.de>
Date: Tue, 28 Feb 2017 10:59:31 +0100
MIME-Version: 1.0
In-Reply-To: <07ef9e24-a17b-536b-8ef3-9a105cfe6bc6@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V2] qemu-img: make convert async
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, stefanha@gmail.com, ct@flyingcircus.io, mreitz@redhat.com, famz@redhat.com

Am 27.02.2017 um 22:09 schrieb Eric Blake:
> On 02/27/2017 05:03 AM, Peter Lieven wrote:
>> the convert process is currently completely implemented with sync operations.
>> That means it reads one buffer and then writes it. No parallelism and each sync
>> request takes as long as it takes until it is completed.
>>
>> This patches introduces 2 new cmdline parameters. The -m parameter to specify
>> the number of coroutines running in parallel (defaults to 8). And the -W paremeter to
> s/paremeter/parameter/
>
>> allow qemu-img to write to the target out of order rather than sequential. This improves
>> performance as the writes do not have to wait for each other to complete.
>>
>> Signed-off-by: Peter Lieven <pl@kamp.de>
>> ---
>> @@ -1798,7 +1908,7 @@ static int img_convert(int argc, char **argv)
>>               {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
>>               {0, 0, 0, 0}
>>           };
>> -        c = getopt_long(argc, argv, "hf:O:B:ce6o:s:l:S:pt:T:qn",
>> +        c = getopt_long(argc, argv, "hf:O:B:ce6o:s:l:S:pt:T:qnm:W",
>>                           long_options, NULL);
>>           if (c == -1) {
>>               break;
>> @@ -1890,6 +2000,18 @@ static int img_convert(int argc, char **argv)
>>           case 'n':
>>               skip_create = 1;
>>               break;
>> +        case 'm':
>> +            num_coroutines = atoi(optarg);
> atoi() should be avoided. It has no error checking, so it treats '-m 1'
> and '-m 1k' identically.  You are a bit justified in that '-m junk' gets
> treated like '-m 0' and rejected, but it's still a poor error message in
> that case.

would you use qemu_strtoul or parse_uint instead?

Kevin, shall I send a V3?

Peter
