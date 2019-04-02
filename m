Received: from eggs.gnu.org ([209.51.188.92]:38351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hBKnp-0001sP-RT
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 10:54:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hBKno-0000Md-Qk
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 10:54:17 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33939)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hBKno-0000Ka-Ic
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 10:54:16 -0400
Received: by mail-wm1-f65.google.com with SMTP id r186so2596943wmf.1
	for <qemu-devel@nongnu.org>; Tue, 02 Apr 2019 07:54:16 -0700 (PDT)
References: <20190402073018.17747-1-kraxel@redhat.com>
	<ccd76d0f-19f4-9a66-8f64-4f9498d95ea1@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f4b0dabc-948d-3003-1efd-f7acfa2b91ec@redhat.com>
Date: Tue, 2 Apr 2019 16:54:08 +0200
MIME-Version: 1.0
In-Reply-To: <ccd76d0f-19f4-9a66-8f64-4f9498d95ea1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] curses: fix wchar_t printf warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On 4/2/19 2:57 PM, Eric Blake wrote:
> On 4/2/19 2:30 AM, Gerd Hoffmann wrote:
>> On some systems wchar_t is "long int", on others just "int".
> 
> And elsewhere, it's 'short'.
> 
>> So go cast to "long int" and adjust the printf format accordingly.
>>
>> Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>> ---
>>  ui/curses.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/ui/curses.c b/ui/curses.c
>> index cc6d6da68463..fb63945188b2 100644
>> --- a/ui/curses.c
>> +++ b/ui/curses.c
>> @@ -453,8 +453,8 @@ static uint16_t get_ucs(wchar_t wch, iconv_t conv)
>>      swch = sizeof(wch);
>>  
>>      if (iconv(conv, &pwch, &swch, &pch, &sch) == (size_t) -1) {
>> -        fprintf(stderr, "Could not convert 0x%02x from WCHAR_T to UCS-2: %s\n",
>> -                        wch, strerror(errno));
>> +        fprintf(stderr, "Could not convert 0x%02lx from WCHAR_T to UCS-2: %s\n",
>> +                (unsigned long)wch, strerror(errno));
> 
> Sadly, I think you are right that a cast is necessary; there is no
> reserved printf character for printing wchar_t as an integer, and the
> width of wchar_t is unspecified (on 32-bit systems where it is 'long
> int', it does not promote to 'int').
> 
> You could have also stuck with %02x and (int)wch, for less typing, but
> it's not worth the respin.
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
