Received: from eggs.gnu.org ([2001:4830:134:3::10]:33717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eRHl5-0000RO-6a
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 08:16:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eRHkx-0000Nd-LI
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 08:16:31 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:58466)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eRHkx-0000MK-BL
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 08:16:27 -0500
References: <20171219101122.31711-1-ybettan@redhat.com>
	<639add7d-ba36-8058-cc11-b8577ef38b04@vivier.eu>
	<45de6d56-dee6-98aa-65a4-2a8baa652cb3@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <4d0f3eb6-375c-7776-555b-a47355e9dc9e@vivier.eu>
Date: Tue, 19 Dec 2017 14:16:12 +0100
MIME-Version: 1.0
In-Reply-To: <45de6d56-dee6-98aa-65a4-2a8baa652cb3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH V3] vl.c && linux-user/main.c : removed
 **envp from main() arguments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yoni Bettan <ybettan@redhat.com>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Le 19/12/2017 à 14:05, Yoni Bettan a écrit :
> 
> 
> On 12/19/2017 12:21 PM, Laurent Vivier wrote:
>> Le 19/12/2017 à 11:11, Yoni Bettan a écrit :
>>> it was added on 2008 902b3d5c39 when introduced cache-utils.[ch]
>>>
>>> since then cache-utils.[ch] were removed but **envp was left
>>> behind.
>>>
>>> By the way "to be portable it is best to write main to take two
>>> arguments, and use the value of environ" according to
>>> https://www.gnu.org/software/libc/manual/html_node/Program-\
>>>        Arguments.html#Program-Arguments
>>>
>>> Signed-off-by: Yoni Bettan <ybettan@redhat.com>
>>> ---
>>>
>>> V2 -> V3:
>>>           since ui/cocoa.c rename main() is using qemu_main()
>>> ,because it uses it
>>>      inside its main() function, the function qemu_main() can't be
>>> removed
>>>   
>>> V1 -> V2:
>>>
>>>      removed the ui/cocoa.c renaming of main() function since i
>>> thought that we
>>>      no longer need qemu_main()
>>>
>>>
>>>   include/qemu-common.h | 2 +-
>>>   linux-user/main.c     | 2 +-
>>>   ui/cocoa.m            | 5 ++---
>>>   vl.c                  | 7 +++----
>>>   4 files changed, 7 insertions(+), 9 deletions(-)
>>>
>> ...
>>> diff --git a/vl.c b/vl.c
>>> index fc8bd9372f..ea17cc34f6 100644
>>> --- a/vl.c
>>> +++ b/vl.c
>>> @@ -35,10 +35,10 @@
>>>   #ifdef CONFIG_SDL
>>>   #if defined(__APPLE__) || defined(main)
>>>   #include <SDL.h>
>>> -int qemu_main(int argc, char **argv, char **envp);
>>> +int qemu_main(int argc, char **argv);
>>>   int main(int argc, char **argv)
>>>   {
>>> -    return qemu_main(argc, argv, NULL);
>>> +    return qemu_main(argc, argv);
>>>   }
>>>   #undef main
>>>   #define main qemu_main
>>
>> I'm really sorry, but I really think we can remove this part.
> 
> Can you please show what exact lines you think can be removed?
> If you meant that the entire part can be removed then how can
> we rename main to qemu_main (in the CONFIG_COCA part) if qemu_main is
> not defined?

Yes, the entire part can be removed.

The following lines will declare the qemu_main for COCOA:
>>
>>       48 #ifdef CONFIG_COCOA
>>       49 #undef main
>>       50 #define main qemu_main
>>       51 #endif /* CONFIG_COCOA */

The C preprocessor will replace:

int main(int argc, char **argv, char **envp)
{
...

by

int qemu_main(int argc, char **argv, char **envp)
{
...

To check, you can try:

-----8<---------------- main.c
#define main qemu_main

int main(void)
{
    return 0;
}
-----8<---------------- main.c

then: cc -E main.c

# 1 "main.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 31 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 32 "<command-line>" 2
# 1 "main.c"


int qemu_main(void)
{
    return 0;
}


Thanks,
Laurent
