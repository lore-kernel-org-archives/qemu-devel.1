Received: from eggs.gnu.org ([209.51.188.92]:58192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1h2dtf-0003sD-2i
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 10:28:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1h2dte-0001Jh-36
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 10:28:23 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39950)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1h2dtd-0001IF-Ro
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 10:28:22 -0500
Received: by mail-wm1-x342.google.com with SMTP id g20so433868wmh.5
	for <qemu-devel@nongnu.org>; Sat, 09 Mar 2019 07:28:21 -0800 (PST)
From: "=?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?=" <dirty.ice.hu@gmail.com>
References: <cover.1552083282.git.DirtY.iCE.hu@gmail.com>
	<5461b514dbf3e0bc31b0abb6498a9b3a008c271e.1552083282.git.DirtY.iCE.hu@gmail.com>
	<87tvgc5re2.fsf@dusky.pond.sub.org>
Message-ID: <24cb64c4-7f00-5389-c0c6-6b8ba0e2ae28@gmail.com>
Date: Sat, 9 Mar 2019 16:28:15 +0100
MIME-Version: 1.0
In-Reply-To: <87tvgc5re2.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v6 01/14] qapi: qapi for audio backends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>

On 2019-03-09 10:27, Markus Armbruster wrote:
> "Kővágó, Zoltán" <dirty.ice.hu@gmail.com> writes:
> 
>> This patch adds structures into qapi to replace the existing
>> configuration structures used by audio backends currently. This qapi
>> will be the base of the -audiodev command line parameter (that replaces
>> the old environment variables based config).
>>
>> This is not a 1:1 translation of the old options, I've tried to make
>> them much more consistent (e.g. almost every backend had an option to
>> specify buffer size, but the name was different for every backend, and
>> some backends required usecs, while some other required frames, samples
>> or bytes). Also tried to reduce the number of abbreviations used by the
>> config keys.
>>
>> Some of the more important changes:
>> * use `in` and `out` instead of `ADC` and `DAC`, as the former is more
>>   user friendly imho
>> * moved buffer settings into the global setting area (so it's the same
>>   for all backends that support it. Backends that can't change buffer
>>   size will simply ignore them). Also using usecs, as it's probably more
>>   user friendly than samples or bytes.
>> * try-poll is now an alsa backend specific option (as all other backends
>>   currently ignore it)
>>
>> Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>
>> Notes:
>>     Changes from v5:
>>     
>>     * documentation fixes
>>     * renamed buffer-len to buffer-length and period-len to period-length
>>     
>>     Changes from v4:
>>     
>>     * documentation fixes
>>     * renamed pa's source/sink to pa-in/pa-out
>>     * per-direction options changed per Markus Armbruster's comments
>>     
>>     Changes from v2:
>>     
>>     * update copyright, version numbers
>>     * remove #optional
>>     * per-direction options are now optional (needed for qobject_object_visitor_new_str)
>>     * removed unnecessary AudiodevNoOptions
>>     * changed integers to unsigned
>>
>>  qapi/audio.json       | 304 ++++++++++++++++++++++++++++++++++++++++++
>>  qapi/qapi-schema.json |   1 +
>>  qapi/Makefile.objs    |   6 +-
>>  3 files changed, 308 insertions(+), 3 deletions(-)
>>  create mode 100644 qapi/audio.json
>>
>> diff --git a/qapi/audio.json b/qapi/audio.json
>> new file mode 100644
>> index 0000000000..97aee37288
>> --- /dev/null
>> +++ b/qapi/audio.json
>> @@ -0,0 +1,304 @@
>> +# -*- mode: python -*-
>> +#
>> +# Copyright (C) 2015-2019 Zoltán Kővágó <DirtY.iCE.hu@gmail.com>
>> +#
>> +# This work is licensed under the terms of the GNU GPL, version 2 or later.
>> +# See the COPYING file in the top-level directory.
>> +
>> +##
>> +# @AudiodevPerDirectionOptions:
>> +#
>> +# General audio backend options that are used for both playback and
>> +# recording.
>> +#
>> +# @fixed-settings: use fixed settings for host input/output. When off,
>> +#                  frequency, channels and format must not be
>> +#                  specified (default true)
>> +#
>> +# @frequency: frequency to use when using fixed settings
>> +#             (default 44100)
>> +#
>> +# @channels: number of channels when using fixed settings (default 2)
>> +#
>> +# @voices: number of voices to use (default 1)
>> +#
>> +# @format: sample format to use when using fixed settings
>> +#          (default s16)
>> +#
>> +# @buffer-length: the buffer length in microseconds
> 
> The name buffer-length suggests bytes rather than microseconds.  That's
> why I suggested @buffer-capacity.  Matter of taste, up to you and Gerd.

@period-length has the same issue.  For me @buffer-capacity and
@period-capacity feels a bit weird.  I'm not 100% familiar with qapi
conventions, but for me 'size' is what's usually in bytes, and 'length'
can be something else (number of characters in a string, length of a
sound file, ...).

> 
>> +#
>> +# Since: 4.0
>> +##
>> +{ 'struct': 'AudiodevPerDirectionOptions',
>> +  'data': {
>> +    '*fixed-settings': 'bool',
>> +    '*frequency':      'uint32',
>> +    '*channels':       'uint32',
>> +    '*voices':         'uint32',
>> +    '*format':         'AudioFormat',
>> +    '*buffer-length':  'uint32' } }
> [...]
> 
> Regardless:
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> 

Regards,
Zoltan
