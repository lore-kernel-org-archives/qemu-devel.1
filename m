Received: from eggs.gnu.org ([2001:4830:134:3::10]:54538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHXxr-0001oo-0q
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 13:38:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHXxl-00013x-RQ
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 13:38:02 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53192)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gHXxl-0000nZ-Gy
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 13:37:57 -0400
Received: by mail-wm1-f68.google.com with SMTP id 189-v6so12652250wmw.2
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 10:37:46 -0700 (PDT)
References: <20181030111348.14713-1-kraxel@redhat.com>
	<20181030111348.14713-2-kraxel@redhat.com>
	<8c224534-c929-7c7f-a126-a9390bbdb77f@redhat.com>
	<20181030140030.gh5aa7jcgszrfajs@sirius.home.kraxel.org>
	<6fd9e9f8-838a-a13c-e957-a8e6bcb74c42@redhat.com>
	<20181030164633.2c8f21d3.cohuck@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <74a8ecef-18c0-d55d-4b29-7ed6c6b57537@redhat.com>
Date: Tue, 30 Oct 2018 18:37:42 +0100
MIME-Version: 1.0
In-Reply-To: <20181030164633.2c8f21d3.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/4] add QemuSupportState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>

On 30/10/18 16:46, Cornelia Huck wrote:
> On Tue, 30 Oct 2018 15:13:45 +0100
> Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
> 
>> On 30/10/18 15:00, Gerd Hoffmann wrote:
>>> On Tue, Oct 30, 2018 at 02:32:40PM +0100, Philippe Mathieu-Daudé wrote:
>>>>> +##
>>>>> +# @SupportState:
>>>>> +#
>>>>> +# Indicate Support level of qemu devices, backends, subsystems, ...
>>>>> +#
>>>>> +# Since: 3.2
>>>>> +##
>>>>> +{ 'enum': 'SupportState',
>>>>> +  'data': [ 'unknown',
>>>>
>>>> 'unknown' is scary and should be fixed.
>>>
>>> 'unknown' maps to "0" due to being first in list, so this is what you
>>> get when it isn't explicitly set to something else.  Which make sense
>>> IMHO.
>>
>> Yes, I understand in your next patch, this case won't display warning to
>> the user.
>>
>> I wanted to say "we should fix those entries in the MAINTAINERS file".
> 
> I think that has been an ongoing quest for years :)
> 
>>
>>>    
>>>>> +            'supported',
>>>>> +            'maintained',
>>>>> +            'odd-fixes',
>>>>
>>>> All those fit in 'supported'
>>>>   
>>>>> +            'orphan',
>>>>> +            'obsolete',
>>>>> +            'deprecated' ] }
>>>>
>>>> And all those should appear as 'deprecated' IMHO.
>>>
>>> See minutes on deprecation discussion.  Seems there is agreement we
>>> need something more finegrained than "supported" and "deprecated".
>>
>> I read again the "Minutes of KVM Forum BoF on deprecating stuff" thread
>> and don't find details on finegrains, can you point it to me?
>>
>> I think these are fine in the MAINTAINERS entries, but don't give useful
>> information to a QEMU user that is not custom to MAINTAINERS.
> 
> We might squash 'supported' and 'maintained' together (as their only
> real difference is whether someone gets paid for it), but 'odd fixes'
> is different IMO (you have someone to talk to, but they don't dedicate
> much of their time to it.)
> 
>>
>> As a user I'd expect anything not "supported" to be eventually "deprecated".
> 
> But there are differences:
> - 'orphan' - nobody is looking after it; should become 'deprecated' if
>    nobody steps up, but may move to one of the 'someone looks after it'
>    states
> - 'obsolete' - don't use this; should move to 'deprecated' once a
>    replacement is ready (or it is not needed anymore)
> - 'deprecated' - on the removal schedule; has not necessarily been in
>    'orphan' or 'obsolete' before

OK!

If I understand correctly, we have this 'state machine':

    Supported            Unsupported          Deprecated

(someone to talk)     (nobody to talk)  (scheduled for removal)
+--------------+       +------------+      +--------------+
| S:Maintained |       | S:Unknown  |      |              |
|              |       |            |      |              |
| S:Supported  + <---> | S:Orphan   +----> | S:Deprecated +----> Removed
|              |       |            |      |              |
| S:Odd Fixes  |       | S:Obsolete |      |              |
+------+-------+       +------------+      +--------------+
        |                                           ^
        |                                           |
        +-------------------------------------------+

So we have 3 distinct states.

Note:
- Maintainers can deprecate stuffs
- Orphan code can become Supported
- Once scheduled for removal, there is no way back
- 'Unknown' seems pretty similar to 'Orphan'.

> 
>>
>> Should we continue this discussion on the "Minutes of KVM Forum BoF on
>> deprecating stuff" thread?
>>
>> Thanks,
>>
>> Phil.
>>
>>>
>>> cheers,
>>>     Gerd
>>>
>>>    
>>
> 
