Received: from eggs.gnu.org ([209.51.188.92]:36423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1grqFW-0001WJ-Cq
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 15:26:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1grqFL-00006Y-Dr
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 15:26:10 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42169)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1grqFK-0008Ve-Qd
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 15:26:07 -0500
Received: by mail-wr1-x443.google.com with SMTP id q18so1249062wrx.9
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 12:26:06 -0800 (PST)
From: "=?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?=" <dirty.ice.hu@gmail.com>
References: <cover.1548714862.git.DirtY.iCE.hu@gmail.com>
	<2ea7c5fe169dc201b4f3276f02d93e65aa9780fe.1548714862.git.DirtY.iCE.hu@gmail.com>
	<87lg33h9lo.fsf@dusky.pond.sub.org>
Message-ID: <2dd27326-e491-9460-5fae-5706449d004e@gmail.com>
Date: Thu, 7 Feb 2019 21:26:02 +0100
MIME-Version: 1.0
In-Reply-To: <87lg33h9lo.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 01/14] qapi: qapi for audio backends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

On 2019-01-29 14:33, Markus Armbruster wrote:
> "Kővágó, Zoltán" <dirty.ice.hu@gmail.com> writes:
[...]
>> +
>> +##
>> +# @AudiodevPaOptions:
>> +#
>> +# Options of the pa (PulseAudio) audio backend.
>> +#
>> +# @server: PulseAudio server address (default: let PulseAudio choose)
>> +#
>> +# @sink: name of the sink to use
>> +#
>> +# @source: name of the source to use
>> +#
>> +# Since: 4.0
>> +##
>> +{ 'struct': 'AudiodevPaOptions',
>> +  'data': {
>> +    '*server': 'str',
>> +    '*sink':   'AudiodevPaPerDirectionOptions',
>> +    '*source': 'AudiodevPaPerDirectionOptions' } }
>> +
>> +##
>> +# @AudiodevWavOptions:
>> +#
>> +# Options of the wav audio backend.
>> +#
>> +# @path: name of the wav file to record (default 'qemu.wav')
>> +#
>> +# Since: 4.0
>> +##
>> +{ 'struct': 'AudiodevWavOptions',
>> +  'data': {
>> +    '*path': 'str' } }
> 
> Pattern so far:
> 
> * AudiodevFooOptions 
> 
>   Foo           direction options       other options
>   Alsa          alsa-in, alsa-out       threshold
>   Dsound                                latency
>   Oss           oss-in, oss-out         try-map, exclusive, dsp-policy
>   Pa            sink, source            server
>   Wav                                   path
> 
> Any particular reason for naming the direction options differently?

I probably chose that name because in PulseAudio parlance you have
sources and sinks, and the current environment variable based setting of
pa doesn't use ADC/DAC to refer to source/sink, but now that you mention
it it probably makes sense to rename them to pa-in and pa-out, it's more
uniform that way.

[...]
>> +##
>> +# @Audiodev:
>> +#
>> +# Options of an audio backend.
>> +#
>> +# @id: identifier of the backend
>> +#
>> +# @driver: the backend driver to use
>> +#
>> +# @in: options of the capture stream
>> +#
>> +# @out: options of the playback stream
>> +#
>> +# @timer-period: timer period (in microseconds, 0: use lowest possible)
>> +#
>> +# Since: 4.0
>> +##
>> +{ 'union': 'Audiodev',
>> +  'base': {
>> +    'id':            'str',
>> +    'driver':        'AudiodevDriver',
>> +    '*in':           'AudiodevPerDirectionOptions',
>> +    '*out':          'AudiodevPerDirectionOptions',
>> +    '*timer-period': 'uint32' },
>> +  'discriminator': 'driver',
>> +  'data': {
>> +    'alsa':      'AudiodevAlsaOptions',
>> +    'dsound':    'AudiodevDsoundOptions',
>> +    'oss':       'AudiodevOssOptions',
>> +    'pa':        'AudiodevPaOptions',
>> +    'wav':       'AudiodevWavOptions' } }
> 
> 'none', 'coreaudio', 'sdl' and 'spice' have no driver-specific options.
> 
> Do all the generic options apply to all drivers?  Even 'none'?

'fixed-settings', 'frequency', 'channels', 'voices' and 'format' are
used by the mixeng thus they apply to all backends, even 'none'.
(Whether it makes any sense to set them is a different story.)

'buffer-len' and 'buffer-count' was introduced as a means to give a more
uniform interface to setting buffer sizes, because currently to set
buffer size:

* in case of alsa: you set microseconds or frames depending on a second
environment variable
* in case of coreaudio: you set it in frames
* in case of dsound, oss: you set it in milliseconds
* in case of pa, sdl: you set it in samples
* in case of spice, wav: you can't set it

I added 'buffer-len' and 'buffer-count' because they seemed like a
generic option that *most* backends would support, and I didn't want to
create extra backend specific options for them.  But if I combine it
with your inheritance-like proposal, it's probably not that bad.

> Do @in and @out apply to drivers 'dsound' and 'wav'?

@out applies to every driver.  @in shouldn't apply to drivers without
input support, but currently the base of mixeng is created for the input
too, it'll just fail if the sound card tries to create a capture stream...

> 
> Per-direction options are split between generic ones in @in and @out,
> and driver-specific ones in @alsa-in and @alsa-out / @oss-in and
> @oss-out / @sink and @source.
> 
> Perhaps the following would be tidier: make the generic per-direction
> options AudiodevPerDirectionOptions the base of driver-specific ones
> AudiodevAlsaPerDirectionOptions, AudiodevOssPerDirectionOptions,
> AudiodevPaPerDirectionOptions, and then
> 
>    { 'struct': 'AudiodevGenericOptions',
>      'data': {
>        '*in':     'AudiodevPerDirectionOptions',
>        '*out':    'AudiodevPerDirectionOptions' } }
> 
>    { 'union': 'Audiodev',
>      'base': {
>        'id':            'str',
>        'driver':        'AudiodevDriver',
>        '*timer-period': 'uint32' },
>      'discriminator': 'driver',
>      'data': {
>        'none':      'AudiodevGenericOptions',
>        'alsa':      'AudiodevAlsaOptions',
>        'coreaudio:  'AudiodevGenericOptions',
>        'dsound':    'AudiodevDsoundOptions',
>        'oss':       'AudiodevOssOptions',
>        'pa':        'AudiodevPaOptions',
>        'sdl:        'AudiodevGenericOptions',
>        'spice':     'AudiodevGenericOptions',
>        'wav':       'AudiodevWavOptions' } }

Neat, I'll play around with this a bit.

>> diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
>> index 3bbdfcee84..d5f9856be7 100644
>> --- a/qapi/qapi-schema.json
>> +++ b/qapi/qapi-schema.json
>> @@ -95,3 +95,4 @@
>>  { 'include': 'trace.json' }
>>  { 'include': 'introspect.json' }
>>  { 'include': 'misc.json' }
>> +{ 'include': 'audio.json' }
> 
> Looks pretty good.
> 

Regards,
Zoltan
