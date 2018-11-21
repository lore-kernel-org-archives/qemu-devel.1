Received: from eggs.gnu.org ([2001:4830:134:3::10]:57120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gPQrH-0006Qp-CA
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 06:39:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gPQrB-0006oE-Ha
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 06:39:49 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56156)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gPQrB-0006n9-BH
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 06:39:45 -0500
Received: by mail-wm1-f67.google.com with SMTP id y139so5139921wmc.5
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 03:39:45 -0800 (PST)
References: <20181120203628.2367003-1-eblake@redhat.com>
	<cb5fbd50-0629-8afb-e1d4-cc3d1a94e057@redhat.com>
	<1671d82c-da21-de1e-58c4-dd22696f9a62@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8987fde5-a0f3-ea00-e19b-ab512a81ae39@redhat.com>
Date: Wed, 21 Nov 2018 12:39:38 +0100
MIME-Version: 1.0
In-Reply-To: <1671d82c-da21-de1e-58c4-dd22696f9a62@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] misc: Avoid UTF-8 in error messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>

On 20/11/18 23:01, Eric Blake wrote:
> [adding Markus in CC, since git didn't do it automatically from the 
> 'Reported-by']
> 
> On 11/20/18 3:28 PM, John Snow wrote:
>>
>>
>> On 11/20/18 3:36 PM, Eric Blake wrote:
>>> While most developers are now using UTF-8 environments, it's
>>> harder to guarantee that error messages will be output to
>>> a multibyte locale. Rather than risking error messages that
>>> get corrupted into mojibake when the user runs qemu in a
>>> non-multibyte locale, let's stick to straight ASCII error
>>> messages, rather than assuming that our use of UTF-8 in source
>>> code string constants will work unchanged in other locales.
>>>
>>> Reported-by: Markus Armbruster <armbru@redhat.com>
>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>> ---
>>>   hw/misc/tmp105.c | 2 +-
>>>   hw/misc/tmp421.c | 2 +-
>>>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
>>
>> Do we have any policy in place to prohibit this in the future?
>> (Presumably a policy that is automatic and won't interfere with QEMU
>> localization efforts which may rightly attempt to use UTF-8 for those
>> locales.)
> 
> Not that I know of.
> 
>>
>> Do you have a script or trick to find utf-8 containing strings in our
>> source?
> 
> Markus found these two, probably by reading over a list resulting from 
> his claim of finding 217 out of 6455 files (53 of them binary, which 
> don't count):
> https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg04017.html
> 
> My quick and dirty attempt, which does not quite reproduce his numbers:
> 
> $ LC_ALL=C git grep -l $'[\x80-\xff]' | wc
>      279     279    7490
> 
> Thus, by forcing a unibyte locale (where encoding errors are impossible) 
> with sane range expressions (POSIX says only the C locale is required to 
> interpret regex ranges according to byte value - all bets are off in 
> other locales) and using $'' to type non-UTF-8 bytes into my search, I 
> found 279 files with at least one byte outside of ASCII.  But the use of 
> -l has no easy way to filter which of those files are binary; while 
> dropping -l claims 2138 "lines" with non-ASCII, which gets tedious to 
> scroll through, especially considering there ARE binary files in the mix.
> 
> Narrowing the search to a more specific pattern:
> 
> $ LC_ALL=C git grep $'".*[\x80-\xff].*"' | grep -v 'Binary file' | wc
>      129     685    8808
> 
> is a bit more manageable, with MOST of the hits in pc-bios/qemu.rsrc 
> (false positive hits, due to interesting? comments), in po/ (which 
> doesn't count), or in scripts/ for python.  And the proof for THIS patch:
> 
> $ LC_ALL=C git grep -l $'".*[\x80-\xff].*"' origin -- '**/*.[ch]' | cat
> origin:hw/misc/tmp105.c
> origin:hw/misc/tmp421.c

Can we add the last 3 lines in the commit message?

> 
>>
>> Only curious, don't hold this patch up on my account. I'm not raising a
>> challenge.
> 
> Maybe checkpatch.pl could be taught to do a similar check?

It looks easier in shell than perl...

We could add a checkpatch.sh which finally call 'exec -l checkpatch.pl 
$@' or similar?

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
