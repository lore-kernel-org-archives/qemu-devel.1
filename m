Received: from eggs.gnu.org ([2001:4830:134:3::10]:52848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7HJ2-0000mD-34
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 05:49:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7HJ0-0003qj-4p
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 05:49:28 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:42929)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g7HIy-0003ji-L0
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 05:49:26 -0400
Received: by mail-oi1-x244.google.com with SMTP id w81-v6so984574oiw.9
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 02:49:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87ftxwij0f.fsf@dusky.pond.sub.org>
References: <20180926090029.25178-1-armbru@redhat.com>
	<3cc739b5-68fa-b0b5-c272-2dc7bc344711@redhat.com>
	<87ftxwij0f.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Oct 2018 10:48:55 +0100
Message-ID: <CAFEAcA_GvwFOSgefBB32p+S7o_UYAFMbPpkruAKe1HhLLFYNNw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC PATCH] ssi-sd: Make devices picking up
 backends unavailable with -device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 26 September 2018 at 12:40, Markus Armbruster <armbru@redhat.com> wrote:
> Thomas Huth <thuth@redhat.com> writes:
>
>> On 2018-09-26 11:00, Markus Armbruster wrote:
>>> Device models aren't supposed to go on fishing expeditions for
>>> backends.  They should expose suitable properties for the user to set.
>>> For onboard devices, board code sets them.
>>>
>>> Device ssi-sd picks up its block backend in its init() method with
>>> drive_get_next() instead.  This mistake is already marked FIXME since
>>> commit af9e40a.
>>>
>>> Unset user_creatable to remove the mistake from our external
>>> interface.  Since the SSI bus doesn't support hotplug, only -device
>>> can be affected.  Only certain ARM machines provide an SSI bus.
>>>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>> Are there valid uses of -device ssi-sd?  If no, this patch is fine.
>>> If yes, this patch breaks them.  But fixing the FIXME will also break
>>> them.  What should we do?
>>>
>>>  hw/sd/ssi-sd.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
>>> index 95a143bfba..ec7c7e6dbf 100644
>>> --- a/hw/sd/ssi-sd.c
>>> +++ b/hw/sd/ssi-sd.c
>>> @@ -284,6 +284,8 @@ static void ssi_sd_class_init(ObjectClass *klass, void *data)
>>>      k->cs_polarity = SSI_CS_LOW;
>>>      dc->vmsd = &vmstate_ssi_sd;
>>>      dc->reset = ssi_sd_reset;
>>> +    /* Reason: init() method uses drive_get_next() */
>>> +    dc->cannot_instantiate_with_device_add_yet = true;
>>
>> s/cannot_instantiate_with_device_add_yet = true/user_creatable = false/
>
> Whoops, sent the pre-rebase patch instead of the post-rebase patch.
>
>> Sounds like a good idea to me, if somebody then still needs this for
>> "-device", they should fix the FIXME first.
>
> Peter, what do you think?

Seems fine to me.

thanks
-- PMM
