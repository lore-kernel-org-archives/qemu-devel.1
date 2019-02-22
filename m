Received: from eggs.gnu.org ([209.51.188.92]:53207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gxB9T-0005mb-66
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:46:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gxB4d-0007yP-4f
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:41:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46062)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gxB4c-0007bQ-L2
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:41:06 -0500
Date: Fri, 22 Feb 2019 13:40:42 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190222134042.GV25234@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <cover.1550698466.git.DirtY.iCE.hu@gmail.com>
	<f262ecd7436fade16c88533f52c5ca4a08bc396d.1550698466.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f262ecd7436fade16c88533f52c5ca4a08bc396d.1550698466.git.DirtY.iCE.hu@gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [libvirt] [PATCH v5 03/14] audio: -audiodev
 command line option: documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <dirty.ice.hu@gmail.com>
Cc: qemu-devel@nongnu.org, "reviewer:Incompatible changes" <libvir-list@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On Wed, Feb 20, 2019 at 10:37:32PM +0100, K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1=
n wrote:
> This patch adds documentation of an -audiodev command line option, that
> deprecates the old QEMU_* environment variables for audio backend
> configuration.  It's syntax is similar to existing options (-netdev,
> -device, etc):
>=20
>   -audiodev driver_name,property=3Dvalue,...
>=20
> Although now it's possible to specify multiple -audiodev options on
> command line, multiple audio backends are not supported yet.

So happy to see the audio backends come into the modern world at last !

>=20
> Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.c=
om>
> ---
>=20
> Notes:
>     Changes from v4:
>    =20
>     * deprecated QEMU_AUDIO_ env vars

Libvirt does currently use these, so we'll need to update libvirt
code to use the new cli args

>     * updated to reflect qapi changes
>     * added info to qemu-deprecated.texi
>=20
>  qemu-deprecated.texi |   7 ++
>  qemu-options.hx      | 236 ++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 240 insertions(+), 3 deletions(-)
>=20
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index 45c57952da..5c07ad4acb 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -60,6 +60,13 @@ Support for invalid topologies will be removed, the =
user must ensure
>  topologies described with -smp include all possible cpus, i.e.
>    @math{@var{sockets} * @var{cores} * @var{threads} =3D @var{maxcpus}}=
.
> =20
> +@subsection QEMU_AUDIO_ environment variables and -audio-help (since 4=
.0)
> +
> +The ``-audiodev'' argument is now the preferred way to specify audio
> +backend settings instead of environment variables.  To ease migration =
to
> +the new format, the ``-audiodev-help'' option can be used to convert
> +the current values of the environment variables to ``-audiodev'' optio=
ns.
> +
>  @section QEMU Machine Protocol (QMP) commands
> =20
>  @subsection block-dirty-bitmap-add "autoload" parameter (since 2.12.0)
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 77bd98e20b..f77f4d89a7 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -416,14 +416,244 @@ The default is @code{en-us}.
>  ETEXI
> =20
> =20
> +HXCOMM Deprecated by -audiodev
>  DEF("audio-help", 0, QEMU_OPTION_audio_help,
> -    "-audio-help     print list of audio drivers and their options\n",
> +    "-audio-help     show -audiodev equivalent of the currently specif=
ied audio settings\n",
>      QEMU_ARCH_ALL)
>  STEXI
>  @item -audio-help
>  @findex -audio-help
> -Will show the audio subsystem help: list of drivers, tunable
> -parameters.
> +Will show the -audiodev equivalent of the currently specified
> +(deprecated) environment variables.
> +ETEXI
> +
> +DEF("audiodev", HAS_ARG, QEMU_OPTION_audiodev,
> +    "-audiodev [driver=3D]driver,id=3Did[,prop[=3Dvalue][,...]]\n"
> +    "                specifies the audio backend to use\n"
> +    "                id=3D identifier of the backend\n"
> +    "                timer-period=3D timer period in microseconds\n"
> +    "                in|out.fixed-settings=3D use fixed settings for h=
ost audio\n"
> +    "                in|out.frequency=3D frequency to use with fixed s=
ettings\n"
> +    "                in|out.channels=3D number of channels to use with=
 fixed settings\n"
> +    "                in|out.format=3D sample format to use with fixed =
settings\n"
> +    "                valid values: s8, s16, s32, u8, u16, u32\n"
> +    "                in|out.voices=3D number of voices to use\n"
> +    "                in|out.buffer-len=3D length of buffer in microsec=
onds\n"
> +    "-audiodev none,id=3Did,[,prop[=3Dvalue][,...]]\n"
> +    "                dummy driver that discards all output\n"
> +#ifdef CONFIG_ALSA
> +    "-audiodev alsa,id=3Did[,prop[=3Dvalue][,...]]\n"
> +    "                in|out.dev=3D name of the audio device to use\n"
> +    "                in|out.period-len=3D length of period in microsec=
onds\n"
> +    "                in|out.try-poll=3D attempt to use poll mode\n"
> +    "                threshold=3D threshold (in microseconds) when pla=
yback starts\n"
> +#endif
> +#ifdef CONFIG_COREAUDIO
> +    "-audiodev coreaudio,id=3Did[,prop[=3Dvalue][,...]]\n"
> +    "                in|out.buffer-count=3D number of buffers\n"
> +#endif
> +#ifdef CONFIG_DSOUND
> +    "-audiodev dsound,id=3Did[,prop[=3Dvalue][,...]]\n"
> +    "                latency=3D add extra latency to playback in micro=
seconds\n"
> +#endif
> +#ifdef CONFIG_OSS
> +    "-audiodev oss,id=3Did[,prop[=3Dvalue][,...]]\n"
> +    "                in|out.dev=3D path of the audio device to use\n"
> +    "                in|out.buffer-count=3D number of buffers\n"
> +    "                in|out.try-poll=3D attempt to use poll mode\n"
> +    "                try-mmap=3D try using memory mapped access\n"
> +    "                exclusive=3D open device in exclusive mode\n"
> +    "                dsp-policy=3D set timing policy (0..10), -1 to us=
e fragment mode\n"
> +#endif
> +#ifdef CONFIG_PA
> +    "-audiodev pa,id=3Did[,prop[=3Dvalue][,...]]\n"
> +    "                server=3D PulseAudio server address\n"
> +    "                in|out.name=3D source/sink device name\n"
> +#endif
> +#ifdef CONFIG_SDL
> +    "-audiodev sdl,id=3Did[,prop[=3Dvalue][,...]]\n"
> +#endif
> +#ifdef CONFIG_SPICE
> +    "-audiodev spice,id=3Did[,prop[=3Dvalue][,...]]\n"
> +#endif
> +    "-audiodev wav,id=3Did[,prop[=3Dvalue][,...]]\n"
> +    "                path=3D path of wav file to record\n",
> +    QEMU_ARCH_ALL)
> +STEXI
> +@item -audiodev [driver=3D]@var{driver},id=3D@var{id}[,@var{prop}[=3D@=
var{value}][,...]]
> +@findex -audiodev
> +Adds a new audio backend @var{driver} identified by @var{id}.  There a=
re
> +global and driver specific properties.  Some values can be set
> +differently for input and output, they're marked with @code{in|out.}.
> +You can set the input's property with @code{in.@var{prop}} and the
> +output's property with @code{out.@var{prop}}. For example:
> +@example
> +-audiodev alsa,id=3Dexample,in.frequency=3D44110,out.frequency=3D8000
> +-audiodev alsa,id=3Dexample,out.channels=3D1 # leaves in.channels unsp=
ecified
> +@end example
> +
> +Valid global options are:
> +
> +@table @option
> +@item id=3D@var{identifier}
> +Identifies the audio backend.
> +
> +@item timer-period=3D@var{period}
> +Sets the timer @var{period} used by the audio subsystem in microsecond=
s.
> +Default is 10000 (10 ms).
> +
> +@item in|out.fixed-settings=3Don|off
> +Use fixed settings for host audio.  When off, it will change based on
> +how the guest opens the sound card.  In this case you must not specify
> +@var{frequency}, @var{channels} or @var{format}.  Default is on.
> +
> +@item in|out.frequency=3D@var{frequency}
> +Specify the @var{frequency} to use when using @var{fixed-settings}.
> +Default is 44100Hz.
> +
> +@item in|out.channels=3D@var{channels}
> +Specify the number of @var{channels} to use when using
> +@var{fixed-settings}. Default is 2 (stereo).
> +
> +@item in|out.format=3D@var{format}
> +Specify the sample @var{format} to use when using @var{fixed-settings}=
.
> +Valid values are: @code{s8}, @code{s16}, @code{s32}, @code{u8},
> +@code{u16}, @code{u32}. Default is @code{s16}.
> +
> +@item in|out.voices=3D@var{voices}
> +Specify the number of @var{voices} to use.  Default is 1.
> +
> +@item in|out.buffer=3D@var{usecs}
> +Sets the size of the buffer in microseconds.
> +
> +@end table
> +
> +@item -audiodev none,id=3D@var{id}[,@var{prop}[=3D@var{value}][,...]]
> +Creates a dummy backend that discards all outputs.  This backend has n=
o
> +backend specific properties.
> +
> +@item -audiodev alsa,id=3D@var{id}[,@var{prop}[=3D@var{value}][,...]]
> +Creates backend using the ALSA.  This backend is only available on
> +Linux.
> +
> +ALSA specific options are:
> +
> +@table @option
> +
> +@item in|out.dev=3D@var{device}
> +Specify the ALSA @var{device} to use for input and/or output.  Default
> +is @code{default}.
> +
> +@item in|out.period-len=3D@var{usecs}
> +Sets the period length in microseconds.
> +
> +@item in|out.try-poll=3Don|off
> +Attempt to use poll mode with the device.  Default is on.
> +
> +@item threshold=3D@var{threshold}
> +Threshold (in microseconds) when playback starts.  Default is 0.
> +
> +@end table
> +
> +@item -audiodev coreaudio,id=3D@var{id}[,@var{prop}[=3D@var{value}][,.=
..]]
> +Creates a backend using Apple's Core Audio.  This backend is only
> +available on Mac OS and only supports playback.
> +
> +Core Audio specific options are:
> +
> +@table @option
> +
> +@item in|out.buffer-count=3D@var{count}
> +Sets the @var{count} of the buffers.
> +
> +@end table
> +
> +@item -audiodev dsound,id=3D@var{id}[,@var{prop}[=3D@var{value}][,...]=
]
> +Creates a backend using Microsoft's DirectSound.  This backend is only
> +available on Windows and only supports playback.
> +
> +DirectSound specific options are:
> +
> +@table @option
> +
> +@item latency=3D@var{usecs}
> +Add extra @var{usecs} microseconds latency to playback.  Default is
> +10000 (10 ms).
> +
> +@end table
> +
> +@item -audiodev oss,id=3D@var{id}[,@var{prop}[=3D@var{value}][,...]]
> +Creates a backend using OSS.  This backend is available on most
> +Unix-like systems.
> +
> +OSS specific options are:
> +
> +@table @option
> +
> +@item in|out.dev=3D@var{device}
> +Specify the file name of the OSS @var{device} to use.  Default is
> +@code{/dev/dsp}.
> +
> +@item in|out.buffer-count=3D@var{count}
> +Sets the @var{count} of the buffers.
> +
> +@item in|out.try-poll=3Don|of
> +Attempt to use poll mode with the device.  Default is on.
> +
> +@item try-mmap=3Don|off
> +Try using memory mapped device access.  Default is off.
> +
> +@item exclusive=3Don|off
> +Open the device in exclusive mode (vmix won't work in this case).
> +Default is off.
> +
> +@item dsp-policy=3D@var{policy}
> +Sets the timing policy (between 0 and 10, where smaller number means
> +smaller latency but higher CPU usage).  Use -1 to use buffer sizes
> +specified by @code{buffer} and @code{buffer-count}.  This option is
> +ignored if you do not have OSS 4. Default is 5.
> +
> +@end table
> +
> +@item -audiodev pa,id=3D@var{id}[,@var{prop}[=3D@var{value}][,...]]
> +Creates a backend using PulseAudio.  This backend is available on most
> +systems.
> +
> +PulseAudio specific options are:
> +
> +@table @option
> +
> +@item server=3D@var{server}
> +Sets the PulseAudio @var{server} to connect to.
> +
> +@item in|out.name=3D@var{sink}
> +Use the specified source/sink for recording/playback.
> +
> +@end table
> +
> +@item -audiodev sdl,id=3D@var{id}[,@var{prop}[=3D@var{value}][,...]]
> +Creates a backend using SDL.  This backend is available on most system=
s,
> +but you should use your platform's native backend if possible.  This
> +backend has no backend specific properties.
> +
> +@item -audiodev spice,id=3D@var{id}[,@var{prop}[=3D@var{value}][,...]]
> +Creates a backend that sends audio through SPICE.  This backend requir=
es
> +@code{-spice} and automatically selected in that case, so usually you
> +can ignore this option.  This backend has no backend specific
> +properties.
> +
> +@item -audiodev wav,id=3D@var{id}[,@var{prop}[=3D@var{value}][,...]]
> +Creates a backend that writes audio to a WAV file.
> +
> +Backend specific options are:
> +
> +@table @option
> +
> +@item path=3D@var{path}
> +Write recorded audio into the specified file.  Default is
> +@code{qemu.wav}.
> +
> +@end table
>  ETEXI
> =20
>  DEF("soundhw", HAS_ARG, QEMU_OPTION_soundhw,
> --=20
> 2.20.1
>=20
> --
> libvir-list mailing list
> libvir-list@redhat.com
> https://www.redhat.com/mailman/listinfo/libvir-list

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
