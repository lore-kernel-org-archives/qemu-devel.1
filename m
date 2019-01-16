Received: from eggs.gnu.org ([209.51.188.92]:46808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gjrmr-0001OV-Jo
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 15:27:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gjrmm-0000fJ-QC
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 15:27:43 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53039)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1gjrmm-0000VS-Hh
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 15:27:40 -0500
Received: by mail-wm1-x344.google.com with SMTP id m1so3469417wml.2
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 12:27:37 -0800 (PST)
From: "=?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?=" <dirty.ice.hu@gmail.com>
References: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
	<c374ab1ece7bfc933669d8807a54bf362d715a23.1545598229.git.DirtY.iCE.hu@gmail.com>
	<65a00798-9a26-b0bb-b70a-cfd292169123@redhat.com>
Message-ID: <6198f566-623f-7af7-a337-46173001eada@gmail.com>
Date: Wed, 16 Jan 2019 21:27:34 +0100
MIME-Version: 1.0
In-Reply-To: <65a00798-9a26-b0bb-b70a-cfd292169123@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 43/52] audio: add mixeng option
 (documentation)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 2019-01-10 02:43, Eric Blake wrote:
> On 12/23/18 2:52 PM, Kővágó, Zoltán wrote:
>> This will allow us to disable mixeng when we use a decent backend.
>>
>> Disabling mixeng have a few advantages:
>> * we no longer convert the audio output from one format to another, when
>>   the underlying audio system would just convert it to a third format.
>>   We no longer convert, only the underlying system, when needed.
>> * the underlying system probably has better resampling and sample format
>>   converting methods anyway...
>> * we may support formats that the mixeng currently does not support (S24
>>   or float samples, more than two channels)
>> * when using an audio server (like pulseaudio) different sound card
>>   outputs will show up as separate streams, even if we use only one
>>   backend
>>
>> Disadvantages:
>> * audio capturing no longer works (wavcapture, and vnc audio extension)
>> * some backends only support a single playback stream or very picky
>>   about the audio format.  In this case we can't disable mixeng.
>>
>> However mixeng is not removed, only made optional, so this shouldn't be
>> a big concern.
>>
>> Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
>> ---
>>  qapi/audio.json | 5 +++++
>>  qemu-options.hx | 6 ++++++
>>  2 files changed, 11 insertions(+)
>>
>> diff --git a/qapi/audio.json b/qapi/audio.json
>> index 56d8ce439f..180bf207a8 100644
>> --- a/qapi/audio.json
>> +++ b/qapi/audio.json
>> @@ -184,6 +184,10 @@
>>  #
>>  # General audio backend options that are used for both playback and recording.
>>  #
>> +# @mixeng: #optional use QEMU's mixing engine to mix all streams inside QEMU.
> 
> The #optional tag is no longer necessary (the docs generator figures it
> out from the '*mixeng' name below).

Ok.

>> +#          When set to off, fixed-settings must be also off.  Not every backend
>> +#          compatible with the off setting (default on)
> 
> Missing a '(since 4.0)' tag.

The whole AudiodevPerDirectionOptions struct is marked with 'Since:
4.0', so I don't think it's necessary.

> 
>> +#
>>  # @fixed-settings: #optional use fixed settings for host input/output.  When
>>  #                  off, frequency, channels and format must not be specified
>>  #                  (default on)
>> @@ -207,6 +211,7 @@
>>  ##
>>  { 'struct': 'AudiodevPerDirectionOptions',
>>    'data': {
>> +    '*mixeng':         'bool',
>>      '*fixed-settings': 'bool',
>>      '*frequency':      'int',
>>      '*channels':       'int',
> 
> 
