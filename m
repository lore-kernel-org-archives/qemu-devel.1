Received: from eggs.gnu.org ([2001:4830:134:3::10]:48859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fDM4n-0004SZ-SZ
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 23:35:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fDM4i-00082W-UZ
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 23:35:37 -0400
Received: from mail-qk0-x232.google.com ([2607:f8b0:400d:c09::232]:36116)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fDM4i-00082A-NQ
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 23:35:32 -0400
Received: by mail-qk0-x232.google.com with SMTP id a202so8181828qkg.3
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 20:35:32 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180213040809.26021-1-f4bug@amsat.org>
	<20180213040809.26021-21-f4bug@amsat.org>
	<CAFEAcA_r2WNVEkE5-p+VuH8f1XnDzHMkUNgNSMrV1ZTkHv4=AQ@mail.gmail.com>
	<20180430134929.edf3vsx4csvsydxi@toto>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9a5497c5-555e-c556-f14c-570fb385ae17@amsat.org>
Date: Tue, 1 May 2018 00:35:13 -0300
MIME-Version: 1.0
In-Reply-To: <20180430134929.edf3vsx4csvsydxi@toto>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v13 20/30] sdbus: add trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Fam Zheng <famz@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 04/30/2018 10:49 AM, Edgar E. Iglesias wrote:
> On Fri, Apr 27, 2018 at 12:55:21PM +0100, Peter Maydell wrote:
>> On 13 February 2018 at 04:07, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>> Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
>>
>>> @@ -39,6 +45,7 @@ int sdbus_do_command(SDBus *sdbus, SDRequest *req, uint8_t *response)
>>>  {
>>>      SDState *card = get_card(sdbus);
>>>
>>> +    trace_sdbus_command(sdbus_name(sdbus), req->cmd, req->arg, req->crc);
>>>      if (card) {
>>>          SDCardClass *sc = SD_CARD_GET_CLASS(card);
>>
>> Hi -- as a result of this trace event being added, we now get
>> warnings from Coverity that it might use uninitialized data
>> (CID1386074, CID1390571, CID1386072, CID1386076). This is because not
>> all of our SD
>> controllers bother to initialize req->crc, because up til now
>> nothing in the SD code looks at it. (I think at least bcm2835_sdhost.c
>> sdhci.c and ssi-sd.c do this).

I was pretty sure we ran Coverity before the stable release :|
Maybe they added new 'uninitialized data' checks recently.

>>
>> Could you have a look at this, please? I think there are
>> three plausible lines of approach:
>>
>> (1) just don't bother to trace the CRC field
>> (2) make bcm2835_sdhost.c, sdhci.c, ssi-sd.c set crc to 0 like
>> omap and pxa2xx already do
> 
> Hi,
> 
> Philippe, any opinion here?
> 
> Otherwise I suggest we do #2 right away to avoid the warnings
> until someone cares enough to implement #3...

I prefer to start with #3 directly, else we'll keep this forever.

> 
> Cheers,
> Edgar
> 
> 
> 
>> (3) "proper" implementation of CRC, so that an sd controller
>> can either (a) mark the SDRequest as "no CRC" and have
>> sd_req_crc_validate() always pass, or (b) mark the SDRequest
>> as having a CRC and have sd_req_crc_validate() actually
>> do the check which it currently stubs out with "return 0"
>>
>> (3 is because it doesn't seem very sensible to spend time
>> calculating a CRC just to test it against a CRC calculated
>> a little bit later on; but we don't really want to drop the
>> CRC stuff entirely because on some controllers like
>> milkymist-memcard.c the CRC byte comes from the guest and
>> we'd ideally like to check it.)
>>
>> I don't have a strong preference for which of 1/2/3 we do.
>>
>> PS: CID1005332 is the coverity issue for "sd_req_crc_validate
>> stubs out its check code with 'return 0' leaving a line of
>> unreachable code".
>>
>> thanks
>> -- PMM
> 
