Received: from eggs.gnu.org ([2001:4830:134:3::10]:48641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXcPK-0003Js-E5
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 20:00:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXcPH-0005FJ-B2
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 20:00:02 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:35320)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXcPH-0005Ee-59
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 19:59:59 -0400
Received: by mail-qk0-x241.google.com with SMTP id t186so2793340qkf.2
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 16:59:58 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170407143847.GM2138@work-vm>
	<1573e08f-9805-eaf4-3fe1-c1172b6ef6e4@amsat.org>
	<1c55bc6d-7ef7-dcf5-81e8-22712f575691@amsat.org>
	<6e4fb953-17b4-a11b-4f98-8ddfd5ff12f8@redhat.com>
	<39dc6b92-dd56-fe33-cd85-92c03d69f133@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <d47138bd-1257-19c0-418e-4a4addf7fd8a@twiddle.net>
Date: Tue, 18 Jul 2017 13:59:52 -1000
MIME-Version: 1.0
In-Reply-To: <39dc6b92-dd56-fe33-cd85-92c03d69f133@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Hacks for building on gcc 7 / Fedora 26
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

On 07/17/2017 03:48 AM, Eric Blake wrote:
> On 07/17/2017 08:42 AM, Eric Blake wrote:
>> On 07/13/2017 08:07 AM, Philippe Mathieu-Daudé wrote:
>>> On 04/07/2017 04:21 PM, Philippe Mathieu-Daudé wrote:
>>>> Hi Dave,
>>>>
>>>> On 04/07/2017 11:38 AM, Dr. David Alan Gilbert wrote:
>>>>> Hi,
>>>>>     Fedora 26 has gcc 7.0.1 which has the normal compliment
>>>>> of new fussy warnings; so far I've posted :
>>>>>
>>>>> tests/check-qdict: Fix missing brackets
>>>>> slirp/smb: Replace constant strings by glib string
>>>>>
>>>>> that fix one actual mistake and work around something it's being
>>>>> fussy over.
>>>>>
>>>>> But I've also got a pile of hacks, attached below that I'm
>>>>> not too sure what I'll do with them yet, but they're attached
>>>
>>> ping ... What do we do with them?
>>
>> Well, now that I've upgraded to the just-released Fedora 26, it is now
>> mainline gcc and affecting my builds.  So we should really try and find
>> patches that silence the warnings (although it counts as bug fixes, so
>> it won't hurt if it doesn't make tomorrow's freeze deadline).
> 
> FWIW, most of these have been fixed in the meantime; the only remaining
> hack I had to add was:
> 
> diff --git i/hw/usb/bus.c w/hw/usb/bus.c
> index 5939b273b9..bce011058b 100644
> --- i/hw/usb/bus.c
> +++ w/hw/usb/bus.c
> @@ -407,8 +407,9 @@ void usb_register_companion(const char *masterbus,
> USBPort *ports[],
>   void usb_port_location(USBPort *downstream, USBPort *upstream, int portnr)
>   {
>       if (upstream) {
> -        snprintf(downstream->path, sizeof(downstream->path), "%s.%d",
> -                 upstream->path, portnr);
> +        int l = snprintf(downstream->path, sizeof(downstream->path),
> "%s.%d",
> +                         upstream->path, portnr);
> +        assert(l < sizeof(downstream->path));

Do you really need an assert there, or will

	(void)l; /* "used" */

work as well?  You didn't mention what the reported error is, so I'm guessing.


r~
