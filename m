Received: from eggs.gnu.org ([209.51.188.92]:53043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gmOuB-0008ER-A9
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 15:13:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gmOuA-0005Xv-Dy
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 15:13:47 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41261)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1gmOu8-0005Eo-EJ
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 15:13:44 -0500
Received: by mail-wr1-x443.google.com with SMTP id x10so3990586wrs.8
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 12:13:21 -0800 (PST)
From: "=?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?=" <dirty.ice.hu@gmail.com>
References: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
	<82a755097c6aaa16363348599110f9af3bb07583.1547681517.git.DirtY.iCE.hu@gmail.com>
	<20190117100334.vh3nbg4pjfwo4eye@sirius.home.kraxel.org>
Message-ID: <23779539-c590-3910-7cf3-8e2de29ab9b9@gmail.com>
Date: Wed, 23 Jan 2019 21:13:17 +0100
MIME-Version: 1.0
In-Reply-To: <20190117100334.vh3nbg4pjfwo4eye@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 47/50] paaudio: channel-map option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 2019-01-17 11:03, Gerd Hoffmann wrote:
> On Thu, Jan 17, 2019 at 12:37:20AM +0100, Kővágó, Zoltán wrote:
>> Add an option to change the channel map used by pulseaudio.  If not
>> specified, falls back to an OSS compatible channel map.
>>
>> Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
>> ---
>>  qapi/audio.json |  5 ++++-
>>  audio/paaudio.c | 18 ++++++++++++++----
>>  qemu-options.hx |  9 +++++++++
>>  3 files changed, 27 insertions(+), 5 deletions(-)
>>
>> diff --git a/qapi/audio.json b/qapi/audio.json
>> index 7bcea6240f..86078039dc 100644
>> --- a/qapi/audio.json
>> +++ b/qapi/audio.json
>> @@ -107,11 +107,14 @@
>>  #
>>  # @name: name of the sink/source to use
>>  #
>> +# @channel-map: channel map to use (default: OSS compatible map)
>> +#
>>  # Since: 4.0
>>  ##
>>  { 'struct': 'AudiodevPaPerDirectionOptions',
>>    'data': {
>> -    '*name': 'str' } }
>> +    '*name':        'str',
>> +    '*channel-map': 'str' } }
> 
> Ah, I see.  Thats why patch #1 creates a AudiodevPaPerDirectionOptions
> struct with just one field ...

Yes, I was bitten by it too during a refactor, probably I should write a
few words about it in the commit message.

However, this is the exact reason I'd recommend nested structs instead
of randomly flattening it when we can.  This way, if we later have to
add an extra option, we don't end up in a problematic situation, since
we can't easily change things like 'dev-in' to a structure without
breaking backward compatibility.

Regards,
Zoltan
