Received: from eggs.gnu.org ([2001:4830:134:3::10]:55809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dqOSx-0005DD-IU
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 14:57:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dqOSu-0006tk-GG
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 14:57:23 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:33885)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dqOSu-0006se-AR
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 14:57:20 -0400
Received: by mail-qk0-x244.google.com with SMTP id d70so2030368qkc.1
	for <qemu-devel@nongnu.org>; Fri, 08 Sep 2017 11:57:18 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170908155359.27952-1-dgilbert@redhat.com>
	<26a00723-027c-4445-0590-d50739dec557@amsat.org>
	<20170908162201.GC2836@work-vm>
	<7c4ca224-2577-0ef6-6e19-9760dd58c723@amsat.org>
	<20170908183643.GI2836@work-vm>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f7f49bcb-3728-5943-9ccd-c82456a6cf42@amsat.org>
Date: Fri, 8 Sep 2017 15:57:15 -0300
MIME-Version: 1.0
In-Reply-To: <20170908183643.GI2836@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] slirp: Add explanation for hostfwd parsing
 failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: samuel.thibault@ens-lyon.org, qemu-devel@nongnu.org, jan.kiszka@siemens.com

On 09/08/2017 03:36 PM, Dr. David Alan Gilbert wrote:
> * Philippe Mathieu-Daudé (f4bug@amsat.org) wrote:
>> On 09/08/2017 01:22 PM, Dr. David Alan Gilbert wrote:
>>> * Philippe Mathieu-Daudé (f4bug@amsat.org) wrote:
>>>> Hi David,
>>>>
>>>> On 09/08/2017 12:53 PM, Dr. David Alan Gilbert (git) wrote:
>>>>> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>>>>>
>>>>> e.g.
>>>>> ./x86_64-softmmu/qemu-system-x86_64 -nographic -netdev 'user,id=vnet,hostfwd=:555.0.0.0:0-:22'
>>>>> qemu-system-x86_64: -netdev user,id=vnet,hostfwd=:555.0.0.0:0-:22: Invalid host forwarding rule ':555.0.0.0:0-:22' (Bad host address)
>>>>>
>>>>> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>>>>> ---
>>>>>     net/slirp.c | 13 ++++++++++++-
>>>>>     1 file changed, 12 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/net/slirp.c b/net/slirp.c
>>>>> index 01ed21c006..d87664d42e 100644
>>>>> --- a/net/slirp.c
>>>>> +++ b/net/slirp.c
>>>>> @@ -496,9 +496,11 @@ static int slirp_hostfwd(SlirpState *s, const char *redir_str,
>>>>>         char buf[256];
>>>>>         int is_udp;
>>>>>         char *end;
>>>>> +    const char *fail_reason = "";
>>>>
>>>> Isn't it better not initialize this? So if one add a new failed syntax case
>>>> the build with abort with -Werror=uninitialized
>>>
>>> I never quite trust compilers to spot it or not-moan even though
>>> every route to failure will have set it.
>>
>> I see, what about:
>>
>> const char *fail_reason = "Unknown reason";
> 
> I could, but you're right that I shouldn't miss any, and
> 'Unknown Reason' doesn't tell the user any more than no message.

It's not you I'm worried about ;) but if someone adds a new forward 
layer tomorrow (sctp, udplite, rudp...)
