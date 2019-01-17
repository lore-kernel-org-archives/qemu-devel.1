Received: from eggs.gnu.org ([209.51.188.92]:34122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gk3RI-0007bO-Ep
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 03:54:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gk3RH-0003M6-HL
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 03:54:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46708)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gk3RF-0003Hh-F3
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 03:54:13 -0500
Date: Thu, 17 Jan 2019 09:54:08 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190117085408.zaextr333snnpbv5@sirius.home.kraxel.org>
References: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
	<0d2685bb2c3f9a7182aa99b8218f3e4bb223522d.1547681517.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d2685bb2c3f9a7182aa99b8218f3e4bb223522d.1547681517.git.DirtY.iCE.hu@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3 01/50] qapi: qapi for audio backends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <dirty.ice.hu@gmail.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

  Hi,

> +##
> +# @AudiodevAlsaPerDirectionOptions:
> +#
> +# Options of the alsa backend that are used for both playback and recording.
> +#
> +# @dev: the name of the alsa device to use (default 'default')
> +#
> +# @try-poll: attempt to use poll mode, falling back to non polling access on
> +#            failure (default on)
> +#
> +# Since: 4.0
> +##
> +{ 'struct': 'AudiodevAlsaPerDirectionOptions',
> +  'data': {
> +    '*dev':      'str',
> +    '*try-poll': 'bool' } }
> +
> +##
> +# @AudiodevAlsaOptions:
> +#
> +# Options of the alsa audio backend.
> +#
> +# @alsa-in: options of the capture stream
> +#
> +# @alsa-out: options of the playback stream
> +#
> +# @threshold: set the threshold (in microseconds) when playback starts
> +#
> +# Since: 4.0
> +##
> +{ 'struct': 'AudiodevAlsaOptions',
> +  'data': {
> +    '*alsa-in':   'AudiodevAlsaPerDirectionOptions',
> +    '*alsa-out':  'AudiodevAlsaPerDirectionOptions',
> +    '*threshold': 'uint32' } }

Hmm, do we need try-poll as per-direction option?  If not we could
simplify AudiodevAlsaOptions this way ...

{ 'struct': 'AudiodevAlsaOptions',
  'data': {
    '*dev-in':    'str',
    '*dev-out':   'str',
    '*threshold': 'uint32'
    '*try-poll':  'bool' } }

... eliminating some nesting.

> +##
> +# @AudiodevOssPerDirectionOptions:
> +#
> +# Options of the oss backend that are used for both playback and recording.
> +#
> +# @dev: file name of the oss device (default '/dev/dsp')
> +#
> +# @try-poll: attempt to use poll mode, falling back to non polling access on
> +#            failure (default on)
> +#
> +# Since: 4.0
> +##
> +{ 'struct': 'AudiodevOssPerDirectionOptions',
> +  'data': {
> +    '*dev':      'str',
> +    '*try-poll': 'bool' } }

Same here.

> +##
> +# @AudiodevPaOptions:
> +#
> +# Options of the pa (PulseAudio) audio backend.
> +#
> +# @server: PulseAudio server address (default: let PulseAudio choose)
> +#
> +# @sink: name of the sink to use
> +#
> +# @source: name of the source to use
> +#
> +# Since: 4.0
> +##
> +{ 'struct': 'AudiodevPaOptions',
> +  'data': {
> +    '*server': 'str',
> +    '*sink':   'AudiodevPaPerDirectionOptions',
> +    '*source': 'AudiodevPaPerDirectionOptions' } }

AudiodevPaPerDirectionOptions has only the name field, so we can drop
the struct and just use '*sink' : 'str' ...

cheers,
  Gerd
