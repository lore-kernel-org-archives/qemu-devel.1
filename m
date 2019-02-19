Received: from eggs.gnu.org ([209.51.188.92]:33715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gw3b6-0005YF-Dv
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 06:30:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gw3b2-0004jM-3F
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 06:29:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58396)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gw3az-0004ht-FF
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 06:29:54 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 14318637E5
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 11:29:47 +0000 (UTC)
References: <20190219101510.9356-1-kraxel@redhat.com>
	<a7050f62-b56f-cc1a-7600-5197b83a27ac@redhat.com>
	<20190219111755.GE7154@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <3493d414-d1a7-9db7-90f8-ef70dfa2c4d9@redhat.com>
Date: Tue, 19 Feb 2019 12:29:43 +0100
MIME-Version: 1.0
In-Reply-To: <20190219111755.GE7154@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] audio: don't use alsa by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On 19.02.19 12:17, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Feb 19, 2019 at 11:39:49AM +0100, David Hildenbrand wrote:
>> On 19.02.19 11:15, Gerd Hoffmann wrote:
>>> ardware is present the driver initializes
>>> successfully and throws errors later on, i.e. effectively the
>>> automatic probing doesn't work.  So the driver should not be
>>> used by default (until that is fixed).  Drop the can_be_default
>>> flag.
>>>
>>> Explicitly picking the alsa driver (using QEMU_AUDIO_DRV=3Dalsa
>>> environment variable) will continue to work.
>>
>> Just pointing out that with this patch, audio initialization still
>> hinders me from starting guests on my Fedora 29 when running under roo=
t
>> (I don't think this patch was also intended to fix that, just pointing
>> out for me the problem still exists).
>>
>>
>> ALSA lib pulse.c:243:(pulse_connect) PulseAudio: Unable to connect:
>> Connection refused
>>
>> sdl: SDL_OpenAudio failed
>> sdl: Reason: ALSA: Couldn't open audio device: Connection refused
>> ALSA lib pulse.c:243:(pulse_connect) PulseAudio: Unable to connect:
>> Connection refused
>>
>> sdl: SDL_OpenAudio failed
>> sdl: Reason: ALSA: Couldn't open audio device: Connection refused
>> audio: Failed to create voice `pcspk'
>> qemu-system-x86_64: Initialization of device isa-pcspk failed:
>> Initializing audio voice failed
>>
>>
>> For whatever reason, on my Fedora29 root cannot access alsa devices.
>> Maybe it is a Fedora 29 problem, maybe only my setup is messed up (e.g=
.
>> because of an upgrade). The workaround for me is to not run QEMU as
>> root. (I don't have time to look into the details)
>=20
> Does your machine actually have any sound card in it ?  ie does
> /dev/snd/ report any pcm*  devices ?

Well, I can listen to audio, so I assume yes ;) Let's check

t460s: ~  $ ls -la /dev/snd/
insgesamt 0
drwxr-xr-x   4 root root      360 19. Feb 08:39 .
drwxr-xr-x  22 root root     4400 19. Feb 08:40 ..
drwxr-xr-x   2 root root       60 19. Feb 08:39 by-id
drwxr-xr-x   2 root root       80 19. Feb 08:39 by-path
crw-rw----+  1 root audio 116,  3 19. Feb 08:39 controlC0
crw-rw----+  1 root audio 116, 13 19. Feb 08:39 controlC1
crw-rw----+  1 root audio 116, 11 19. Feb 08:39 hwC1D0
crw-rw----+  1 root audio 116, 12 19. Feb 08:39 hwC1D2
crw-rw----+  1 root audio 116,  2 19. Feb 08:40 pcmC0D0c
crw-rw----+  1 root audio 116,  5 19. Feb 08:40 pcmC1D0c
crw-rw----+  1 root audio 116,  4 19. Feb 11:40 pcmC1D0p
crw-rw----+  1 root audio 116, 10 19. Feb 08:40 pcmC1D10p
crw-rw----+  1 root audio 116,  6 19. Feb 08:40 pcmC1D3p
crw-rw----+  1 root audio 116,  7 19. Feb 08:40 pcmC1D7p
crw-rw----+  1 root audio 116,  8 19. Feb 08:40 pcmC1D8p
crw-rw----+  1 root audio 116,  9 19. Feb 08:40 pcmC1D9p

>=20
> Based on your logs here, I suspect it has no sound card. The reason
> it will work as non-root, is that QEMU will activate the pulseaudio
> backend that works fine [1] even if no sound card is present.

The thing is, I can play audio as normal user, but not as root

t460s: ~  $ LANG=3DC speaker-test -d default

speaker-test 1.1.6

Playback device is default
Stream parameters are 48000Hz, S16_LE, 1 channels
Using 16 octaves of pink noise
Rate set to 48000Hz (requested 48000Hz)
Buffer size range from 192 to 2097152
Period size range from 64 to 699051
Using max buffer size 2097152
Periods =3D 4
was set period_size =3D 524288
was set buffer_size =3D 2097152
ALSA <-> PulseAudio PCM I/O Plugin

t460s: ~  $ LANG=3DC sudo speaker-test -d default

speaker-test 1.1.6

Playback device is default
Stream parameters are 48000Hz, S16_LE, 1 channels
Using 16 octaves of pink noise
ALSA lib pulse.c:243:(pulse_connect) PulseAudio: Unable to connect:
Connection refused


Again, this might be an issue on my system. But as I never touched any
of the configuration it either is broken on all Fedora 29 installations
or only on mine due to system upgrades. I already tried downgrading
pulse audio without luck.

--=20

Thanks,

David / dhildenb
