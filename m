Received: from eggs.gnu.org ([2001:4830:134:3::10]:52676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nia.alarie@gmail.com>) id 1exwHf-0000wC-Gc
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 11:01:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nia.alarie@gmail.com>) id 1exwHe-00079Y-Po
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 11:01:11 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:39284)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nia.alarie@gmail.com>)
	id 1exwHe-00076U-In
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 11:01:10 -0400
Received: by mail-lf0-x243.google.com with SMTP id p142-v6so3236511lfd.6
	for <qemu-devel@nongnu.org>; Mon, 19 Mar 2018 08:01:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <a89c0265-53a0-a708-11fd-1096b565776b@redhat.com>
References: <20180316144047.30904-1-nia.alarie@gmail.com>
	<a89c0265-53a0-a708-11fd-1096b565776b@redhat.com>
From: nee <nia.alarie@gmail.com>
Date: Mon, 19 Mar 2018 15:01:08 +0000
Message-ID: <CA+k8WDrcRro0ifJC1AEKeyapMGL4VUbD05D4wGN6T9ySy0Wh7Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] audio: Convert use of atoi to qemu_strtoi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>, Jim Mussared <jim@groklearning.com>, Joel Stanley <joel@jms.id.au>, kraxel@redhat.com

On Mon, Mar 19, 2018 at 2:47 PM, Eric Blake <eblake@redhat.com> wrote:
> On 03/16/2018 09:40 AM, Nia Alarie wrote:
>>
>> If qemu_strtoi indicates an error, return the default value.
>
>
> Would it be better to diagnose the error instead of silently returning a
> default value?
>
>>
>> Signed-off-by: Nia Alarie <nia.alarie@gmail.com>
>> ---
>>   audio/audio.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/audio/audio.c b/audio/audio.c
>> index 6eccdb17ee..d6e91901aa 100644
>> --- a/audio/audio.c
>> +++ b/audio/audio.c
>> @@ -335,9 +335,8 @@ static int audio_get_conf_int (const char *key, int
>> defval, int *defaultp)
>>       char *strval;
>>         strval = getenv (key);
>> -    if (strval) {
>> +    if (strval && !qemu_strtoi(strval, NULL, 10, &val)) {
>>           *defaultp = 0;
>> -        val = atoi (strval);
>>           return val;
>>       }
>>       else {
>>
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org

Possibly, while writing these patches I was just going by what was
already there. I can see how that would be good.

Should the code provide a warning to the user and continue with the
default, or provide the warning and exit? And is it more correct to
use dolog() or AUD_log() in this context?
