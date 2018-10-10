Received: from eggs.gnu.org ([2001:4830:134:3::10]:51913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAANL-0005EH-Sz
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 05:01:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAANC-0001SO-5y
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 05:01:51 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52134)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gAANA-0001Qa-9w
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 05:01:42 -0400
Received: by mail-wm1-f65.google.com with SMTP id 143-v6so4553315wmf.1
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 02:01:38 -0700 (PDT)
References: <20181009181612.10633-1-peter.maydell@linaro.org>
	<a7f3a1b3-7c06-b82b-3201-4db1175ee8f0@redhat.com>
	<CAFEAcA9kHphNZcXOVLWgDH=_VFDZ1jDLa3KNN_UWhxfK_dH5bw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5dd15e46-7a0d-6a39-7b05-97b5bd9c1b9c@redhat.com>
Date: Wed, 10 Oct 2018 11:01:30 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9kHphNZcXOVLWgDH=_VFDZ1jDLa3KNN_UWhxfK_dH5bw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] coccinelle: new inplace-byteswaps.cocci to
 remove inplace-byteswapping calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 09/10/2018 20:35, Peter Maydell wrote:
> On 9 October 2018 at 19:23, Eric Blake <eblake@redhat.com> wrote:
>> On 10/9/18 1:16 PM, Peter Maydell wrote:
>>>
>>> Add a new Coccinelle script which replaces uses of the inplace
>>> byteswapping functions *_to_cpus() and cpu_to_*s() with their
>>> not-in-place equivalents. This is useful for where the swapping
>>> is done on members of a packed struct -- taking the address
>>> of the member to pass it to an inplace function is undefined
>>> behaviour in C.
>>>
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>> ---
>>> Richard asked for a coccinelle script in the scripts/coccinelle
>>> directory, so here's a patch to add it.
>>>
>>>   scripts/coccinelle/inplace-byteswaps.cocci | 65 ++++++++++++++++++++++
>>>   1 file changed, 65 insertions(+)
>>>   create mode 100644 scripts/coccinelle/inplace-byteswaps.cocci
>>>
>>> diff --git a/scripts/coccinelle/inplace-byteswaps.cocci
>>> b/scripts/coccinelle/inplace-byteswaps.cocci
>>> new file mode 100644
>>> index 00000000000..a869a90cbfd
>>> --- /dev/null
>>> +++ b/scripts/coccinelle/inplace-byteswaps.cocci
>>> @@ -0,0 +1,65 @@
>>> +// Replace uses of in-place byteswapping functions with calls to the
>>> +// equivalent not-in-place functions.  This is necessary to avoid
>>> +// undefined behaviour if the expression being swapped is a field in a
>>> +// packed struct.
>>> +
>>> +@@
>>> +expression E;
>>> +@@
>>> +-be16_to_cpus(&E);
>>> ++E = be16_to_cpu(E);
>>> +@@
>>> +expression E;
>>> +@@
>>> +-be32_to_cpus(&E);
>>> ++E = be32_to_cpu(E);
>>
>>
>> It's probably possible to shorten this as:
> 
> This is kind of why I didn't post it as a patch to go in
> scripts/ initially :-)  I suspected it was possible to
> shorten it (maybe there's even coccinelle syntax to allow the
> function names to be substituted to be specified with
> a regex?), but the dumb-and-simple cut-and-paste for every
> function being replaced worked and it didn't seem worth
> spending even ten minutes messing around trying to improve
> what is fundamentally a throwaway script...

Julia Lawall once [*] said:

Even for 6 functions, I would suggest to write out the function names in
the pattern matching code rather than using regular expressions.  If the
names are explicit, then Coccinelle can do some filtering, either based
on an index made with idutils or glimpse (see the coccinelle scripts
directory for tools for making these indices) or based on grep, to drop
without parsing files that are not relevant.  It doesn't do this for
regular expressions.  So you will get a faster result if the names are
explicit in the pattern code.

[*] https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg03004.html
